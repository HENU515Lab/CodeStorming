package com.seriouszyx.bbs.base.mapper;

import com.seriouszyx.bbs.base.domain.BlogComment;
import java.util.List;

public interface BlogCommentMapper {
    int deleteByPrimaryKey(Long id);

    int insert(BlogComment record);

    BlogComment selectByPrimaryKey(Long id);

    List<BlogComment> selectAll();

    int updateByPrimaryKey(BlogComment record);

    List<BlogComment> selectByBid(Long bid);

}