package com.seriouszyx.bbs.base.mapper;

import com.seriouszyx.bbs.base.domain.BlogComment;
import com.seriouszyx.bbs.base.domain.mgr.MgrBlogComment;

import java.util.List;

public interface BlogCommentMapper {
    int deleteByPrimaryKey(Long id);

    int insert(BlogComment record);

    BlogComment selectByPrimaryKey(Long id);

    int updateByPrimaryKey(BlogComment record);

    List<BlogComment> selectByBid(Long bid);

    void deleteByBlogId(Long id);

    List<MgrBlogComment> selectAll();

}