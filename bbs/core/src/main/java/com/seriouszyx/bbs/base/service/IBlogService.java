package com.seriouszyx.bbs.base.service;

import com.github.pagehelper.PageInfo;
import com.seriouszyx.bbs.base.domain.Blog;
import com.seriouszyx.bbs.base.domain.BlogComment;
import com.seriouszyx.bbs.base.domain.mgr.MgrBlogComment;

import java.util.List;

/**
 * 分享文章相关服务
 */
public interface IBlogService {

    /**
     * 新增一篇文章
     * @param blog
     */
    void saveBlog(Blog blog);

    /**
     * 分页查询所有文章
     * @param pageNum 当前页数
     * @return
     */
    PageInfo<Blog> listAll(int pageNum, int pageSize);

    /**
     * 不分页查询所有文章
     * @return
     */
    List<Blog> listAll();

    /**
     * 根据主键查询文章
     * @param id
     * @return
     */
    Blog listById(Long id);

    /**
     * 评论文章
     * @param content
     */
    void comment(String content, Long blogId);


    /**
     * 列出authorId的所有文章
     * @param authorId
     * @return
     */
    PageInfo<Blog> listByAuthorId(Long authorId, Integer pageNum, Integer pageSize);

    /**
     * 为指定文章点赞
     * @param blogId
     * @return 当前文章的点赞数
     */
    Integer addBlogVote(Long blogId);

    /**
     * 为指定文章取消点赞
     * @param blogId
     * @return 当前文章的点赞数
     */
    Integer removeBlogVote(Long blogId);

    /**
     * 根据文章id和用户id查询文章投票信息
     * @param blogId
     */
    int selectBlogVoteRecord(Long blogId);

    /**
     * 根据文章id更新文章
     * @param blog
     */
    int updateBlog(Blog blog);

    /**
     * 删除置顶文章及相关评论、投票
     * @param id
     */
    void removeBlogByPrimaryKey(Long id);

    /**
     * 查询所有评论
     * @return
     */
    List<MgrBlogComment> listComments();

    /**
     * 根据评论id查询评论信息
     * @param id
     * @return
     */
    BlogComment listByCommentId(Long id);

    /**
     * 更新评论信息
     * @param blogComment
     */
    void updateBlogComment(BlogComment blogComment);

    /**
     * 删除评论信息
     * @param id
     */
    void deleteBlogComment(Long id);

    /**
     * 增加文章浏览数
     * @param id
     */
    void addBlogReadSize(Long id);
}
