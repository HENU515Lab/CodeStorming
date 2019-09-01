package top.lab515.bbs.service.impl;

import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.action.search.SearchType;
import org.elasticsearch.search.SearchParseException;
import org.elasticsearch.search.aggregations.Aggregations;
import org.elasticsearch.search.aggregations.BucketOrder;
import org.elasticsearch.search.aggregations.bucket.terms.StringTerms;
import org.elasticsearch.search.aggregations.bucket.terms.Terms.Bucket;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.data.elasticsearch.core.query.SearchQuery;
import org.springframework.stereotype.Service;
import top.lab515.bbs.domain.User;
import top.lab515.bbs.domain.es.EsBlog;
import top.lab515.bbs.repository.es.EsBlogRepository;
import top.lab515.bbs.service.EsBlogService;
import top.lab515.bbs.service.UserService;
import top.lab515.bbs.vo.TagVO;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import static org.elasticsearch.index.query.QueryBuilders.matchAllQuery;
import static org.elasticsearch.search.aggregations.AggregationBuilders.terms;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/9/1 16:06
 * @description：
 */
@Service
public class EsBlogServiceImpl implements EsBlogService {
    @Autowired
    private EsBlogRepository esBlogRepository;
    @Autowired
    private ElasticsearchTemplate elasticsearchTemplate;
    @Autowired
    private UserService userService;

    private static final Pageable TOP_5_PAGEABLE = PageRequest.of(0, 5);
    private static final String EMPTY_KEYWORD = "";

    @Autowired
    public EsBlogServiceImpl(EsBlogRepository esBlogRepository, ElasticsearchTemplate elasticsearchTemplate, UserService userService) {
        this.esBlogRepository = esBlogRepository;
        this.elasticsearchTemplate = elasticsearchTemplate;
        this.userService = userService;
    }

    @Override
    public void removeEsBlog(String id) {
        esBlogRepository.deleteById(id);
    }

    @Override
    public EsBlog updateEsBlog(EsBlog esBlog) {
        return esBlogRepository.save(esBlog);
    }

    @Override
    public EsBlog getEsBlogByBlogId(Long blogId) {
        return esBlogRepository.findByBlogId(blogId);
    }

    @Override
    public Page<EsBlog> listNewestEsBlogs(String keyword, Pageable pageable) throws SearchParseException {
        Page<EsBlog> pages = null;
        Sort sort = new Sort(Sort.Direction.DESC, "createTime");
        if (pageable.getSort().isUnsorted()) {
            pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        }

        pages = esBlogRepository.findByTitleContainingOrSummaryContainingOrContentContainingOrTagsContaining(
                keyword, keyword, keyword, keyword, pageable);

        return pages;
    }

    @Override
    public Page<EsBlog> listHotestEsBlogs(String keyword, Pageable pageable) throws SearchParseException {

        Sort sort = new Sort(Sort.Direction.DESC, "readSize", "commentSize", "voteSize", "createTime");
        if (pageable.getSort().isUnsorted()) {
            pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        }

        return esBlogRepository.findByTitleContainingOrSummaryContainingOrContentContainingOrTagsContaining(
                keyword, keyword, keyword, keyword, pageable);
    }


    @Override
    public Page<EsBlog> listEsBlogs(Pageable pageable) {
        return esBlogRepository.findAll(pageable);
    }


    /**
     * 最新前5
     */
    @Override
    public List<EsBlog> listTop5NewestEsBlogs() {
        Page<EsBlog> page = this.listNewestEsBlogs(EMPTY_KEYWORD, TOP_5_PAGEABLE);
        return page.getContent();
    }

    /**
     * 最热前5
     */
    @Override
    public List<EsBlog> listTop5HotestEsBlogs() {
        Page<EsBlog> page = this.listHotestEsBlogs(EMPTY_KEYWORD, TOP_5_PAGEABLE);
        return page.getContent();
    }

    @Override
    public List<TagVO> listTop30Tags() {

        List<TagVO> list = new ArrayList<>();
        // given
        SearchQuery searchQuery = new NativeSearchQueryBuilder()
                //将搜索条件设置到构建中
                .withQuery(matchAllQuery())
                //设置搜索类型
                .withSearchType(SearchType.QUERY_THEN_FETCH)
                //指定索引库和文档类型
                .withIndices("blog").withTypes("blog")
                .addAggregation(terms("tags").field("tags.keyword").order(BucketOrder.count(false)).size(30))
                .build();
        // when
        Aggregations aggregations = elasticsearchTemplate.query(searchQuery, SearchResponse::getAggregations);

        StringTerms modelTerms = (StringTerms) aggregations.asMap().get("tags");

//        for (Bucket actiontypeBucket : modelTerms.getBuckets()) {
//            list.add(new TagVO(actiontypeBucket.getKey().toString(),
//                    actiontypeBucket.getDocCount()));
//        }
        Iterator<StringTerms.Bucket> modelBucketIt = modelTerms.getBuckets().iterator();
		while (modelBucketIt.hasNext()) {
			Bucket actiontypeBucket = modelBucketIt.next();

			list.add(new TagVO(actiontypeBucket.getKey().toString(), actiontypeBucket.getDocCount()));
		}
        return list;
    }

    /**
     * 最热前12用户
     */
    @Override
    public List<User> listTop12Users() {

        List<String> usernamelist = new ArrayList<>();
        // given
        SearchQuery searchQuery = new NativeSearchQueryBuilder()
                .withQuery(matchAllQuery())
                .withSearchType(SearchType.QUERY_THEN_FETCH)
                .withIndices("blog").withTypes("blog")
                .addAggregation(terms("users").field("username.keyword").order(BucketOrder.count(false)).size(12))
                .build();
        // when
        Aggregations aggregations = elasticsearchTemplate.query(searchQuery, SearchResponse::getAggregations);
        StringTerms modelTerms = (StringTerms) aggregations.asMap().get("users");

//        for (Bucket actiontypeBucket : modelTerms.getBuckets()) {
//            String username = actiontypeBucket.getKey().toString();
//            usernamelist.add(username);
//        }
        Iterator<StringTerms.Bucket> modelBucketIt = modelTerms.getBuckets().iterator();
		while (modelBucketIt.hasNext()) {
			Bucket actiontypeBucket = modelBucketIt.next();
			String username = actiontypeBucket.getKey().toString();
			usernamelist.add(username);
		}
        return userService.listUsersByUsernames(usernamelist);
    }
}