package com.seriouszyx.bbs.base.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.seriouszyx.bbs.base.domain.*;
import com.seriouszyx.bbs.base.domain.mgr.MgrBlogComment;
import com.seriouszyx.bbs.base.mapper.BlogCommentMapper;
import com.seriouszyx.bbs.base.mapper.BlogMapper;
import com.seriouszyx.bbs.base.mapper.BlogVoteRecordMapper;
import com.seriouszyx.bbs.base.mapper.UserMapper;
import com.seriouszyx.bbs.base.service.IBlogService;
import com.seriouszyx.bbs.base.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class BlogServiceImpl implements IBlogService {

    @Autowired
    private BlogMapper blogMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private BlogCommentMapper blogCommentMapper;

    @Autowired
    private BlogVoteRecordMapper blogVoteRecordMapper;

    @Override
    public void saveBlog(Blog blog) throws RuntimeException {
        boolean isNew = (blog.getId() == null);
        if (isNew) {
            User user = userMapper.selectByPrimaryKey(UserContext.getCurrentUser().getId());
            blog.setAuthor(user);
            blog.setCreateTime(new Date());
            blog.setBlogType(1);
            blogMapper.insert(blog);
        } else {
            blogMapper.updateTitleAndContentByPrimarykey(blog);
        }
    }

    @Override
    public PageInfo<Blog> listAll(int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        PageInfo<Blog> pageInfo = new PageInfo<>(blogMapper.selectAll());
        return pageInfo;
    }

    @Override
    public List<Blog> listAll() {
        return blogMapper.selectAll();
    }

    @Override
    public Blog listById(Long id) {
        return blogMapper.selectByPrimaryKey(id);
    }

    @Override
    public void comment(String content, Long blogId) {
        BlogComment comment = new BlogComment();
        comment.setCommentContent(content);
        comment.setCreateTime(new Date());
        comment.setUser(UserContext.getCurrentUser());
        comment.setBid(blogId);
        blogCommentMapper.insert(comment);
    }

    @Override
    public PageInfo<Blog> listByAuthorId(Long authorId, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        return new PageInfo<>(blogMapper.selectByAuthorId(authorId));
    }

    @Override
    @Transactional
    public Integer addBlogVote(Long blogId) {
        BlogVoteRecord record = new BlogVoteRecord();

        int offset = selectBlogVoteRecord(blogId);
        if (offset == 0) {
            // 没有记录
            record.setUid(UserContext.getCurrent().getId());
            record.setBid(blogId);
            record.setOffset(1);
            blogVoteRecordMapper.insert(record);
            blogMapper.updateVoteSizeByPrimaryKey(blogId, 1);
        } else if (offset == -1) {
            // 记录为vote down
            blogVoteRecordMapper.updateVoteSizeByUserIdAndBlogId(
                    UserContext.getCurrent().getId(),
                    blogId,
                    1
            );
            blogMapper.updateVoteSizeByPrimaryKey(blogId, 2);
        }
        return blogMapper.selectVoteSizeByPrimaryKey(blogId);
    }

    @Override
    @Transactional
    public Integer removeBlogVote(Long blogId) {
        BlogVoteRecord record = new BlogVoteRecord();

        int offset = selectBlogVoteRecord(blogId);
        if (offset == 0) {
            // 没有记录
            record.setUid(UserContext.getCurrent().getId());
            record.setBid(blogId);
            record.setOffset(-1);
            blogVoteRecordMapper.insert(record);
            blogMapper.updateVoteSizeByPrimaryKey(blogId, -1);
        } else if (offset == 1) {
            // 记录为vote up
            blogVoteRecordMapper.updateVoteSizeByUserIdAndBlogId(
                    UserContext.getCurrent().getId(),
                    blogId,
                    -1
            );
            blogMapper.updateVoteSizeByPrimaryKey(blogId, -2);
        }

        return blogMapper.selectVoteSizeByPrimaryKey(blogId);
    }

    @Override
    public int selectBlogVoteRecord(Long blogId) {
        if (UserContext.getCurrent() == null)
            return 0;
        Integer offset = blogVoteRecordMapper
                .selectOffestByUserIdAndBlogId(UserContext.getCurrent().getId(), blogId);
        if (offset == null)
            return 0;
        return offset;
    }

    @Override
    public int updateBlog(Blog blog) {
        return blogMapper.updateByPrimaryKey(blog);
    }

    @Override
    @Transactional
    public void removeBlogByPrimaryKey(Long id) {
        blogVoteRecordMapper.deleteByBlogId(id);
        blogCommentMapper.deleteByBlogId(id);
        blogMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<MgrBlogComment> listComments() {
        return blogCommentMapper.selectAll();
    }

    @Override
    public BlogComment listByCommentId(Long id) {
        return blogCommentMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updateBlogComment(BlogComment blogComment) {
        blogCommentMapper.updateByPrimaryKey(blogComment);
    }

    @Override
    public void deleteBlogComment(Long id) {
        blogCommentMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void addBlogReadSize(Long id) {
        blogMapper.addReadSize(id);
    }


}
