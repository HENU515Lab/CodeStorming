package com.seriouszyx.bbs.base.mapper;

import com.seriouszyx.bbs.base.domain.CommunityVoteRecord;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CommunityVoteRecordMapper {
    int deleteByPrimaryKey(Long id);

    int insert(CommunityVoteRecord record);

    CommunityVoteRecord selectByPrimaryKey(Long id);

    List<CommunityVoteRecord> selectAll();

    int updateByPrimaryKey(CommunityVoteRecord record);

    Integer selectOffestByUserIdAndCommunityId(@Param("userId") Long userId,
                                               @Param("communityId") Long communityId);

    void updateVoteSizeByUserIdAndCommunityId(@Param("userId") Long userId,
                                              @Param("communityId") Long communityId,
                                              @Param("offset") int offset);

    Integer selectOffsetByUserIdAndCommunityIdAndCommunityAnswerId(
            @Param("userId") Long userId,
            @Param("communityId") Long communityId,
            @Param("answerId") Long answerId);

    void updateVoteSizeByUserIdAndCommunityIdAndCommunityAnswerId(
            @Param("userId") Long userId,
            @Param("communityId") Long communityId,
            @Param("communityAnswerId") Long communityAnswerId,
            @Param("offset") int offset);

}