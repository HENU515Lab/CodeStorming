package com.seriouszyx.bbs.base.mapper;

import com.seriouszyx.bbs.base.domain.Community;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CommunityMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Community record);

    Community selectByPrimaryKey(Long id);

    List<Community> selectAll();

    int updateByPrimaryKey(Community record);

    void addAnswerSizeByPrimaryId(Long communityId);

    void plusReadSizeByPrimaryKey(Long id);

    void updateVoteSizeByPrimaryKey(@Param("communityId") Long communityId,
                                    @Param("offset") int offset);

    Integer selectVoteSizeByPrimaryKey(Long communityId);

    void updateSolveByPrimaryKey(Long id);

}