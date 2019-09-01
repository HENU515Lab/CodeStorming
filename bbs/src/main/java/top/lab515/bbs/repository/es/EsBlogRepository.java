package top.lab515.bbs.repository.es;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;
import top.lab515.bbs.domain.es.EsBlog;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/9/1 14:36
 * @description：EsBlog Repository接口
 */
public interface EsBlogRepository extends ElasticsearchRepository<EsBlog, String> {

    /**
     * 模糊查询(去重)
     * @param title
     * @param summary
     * @param content
     * @param tags
     * @param pageable
     * @return
     */
    Page<EsBlog> findByTitleContainingOrSummaryContainingOrContentContainingOrTagsContaining(
            String title, String summary, String content, String tags, Pageable pageable);

    /**
     * 根据 Blog 的id 查询 EsBlog
     * @param blogId
     * @return
     */
    EsBlog findByBlogId(Long blogId);
}
