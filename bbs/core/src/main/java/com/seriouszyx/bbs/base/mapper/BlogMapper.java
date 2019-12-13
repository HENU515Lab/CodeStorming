package com.seriouszyx.bbs.base.mapper;

import com.seriouszyx.bbs.base.domain.Blog;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BlogMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Blog record);

    Blog selectByPrimaryKey(Long id);

    List<Blog> selectAll();

    int updateByPrimaryKey(Blog record);

    List<Blog> selectByAuthorId(Long authorId);

    int updateVoteSizeByPrimaryKey(@Param("id") Long id,
                                   @Param("offset") int offset);

    int selectVoteSizeByPrimaryKey(Long id);

    Blog selectSimpleInfoByPrimaryKey(Long id);

    void addReadSize(Long id);

    void updateTitleAndContentByPrimarykey(Blog blog);
}