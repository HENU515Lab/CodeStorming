package com.seriouszyx.bbs.base.mapper;

import com.seriouszyx.bbs.base.domain.BlogVoteRecord;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BlogVoteRecordMapper {
    int deleteByPrimaryKey(Long id);

    int insert(BlogVoteRecord record);

    BlogVoteRecord selectByPrimaryKey(Long id);

    List<BlogVoteRecord> selectAll();

    int updateByPrimaryKey(BlogVoteRecord record);

    Integer selectOffestByUserIdAndBlogId(@Param("userId") Long userId,
                                      @Param("blogId") Long blogId);

    void updateVoteSizeByUserIdAndBlogId(@Param("userId") Long userId,
                                         @Param("blogId") Long blogId,
                                         @Param("offset") int offset);
}