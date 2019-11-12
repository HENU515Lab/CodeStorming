package com.seriouszyx.bbs.base.mapper;

import com.seriouszyx.bbs.base.domain.Blog;
import java.util.List;

public interface BlogMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Blog record);

    Blog selectByPrimaryKey(Long id);

    List<Blog> selectAll();

    int updateByPrimaryKey(Blog record);

    List<Blog> selectByAuthorId(Long authorId);
}