package com.seriouszyx.bbs.base.service;

import com.seriouszyx.bbs.base.domain.Blog;

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
     * 查询所有文章
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
    List<Blog> listByAuthorId(Long authorId);

}
