package com.seriouszyx.bbs.base.mapper;

import com.seriouszyx.bbs.base.domain.CommunityComment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CommunityCommentMapper {
    int deleteByPrimaryKey(Long id);

    int insert(CommunityComment record);

    CommunityComment selectByPrimaryKey(Long id);

    List<CommunityComment> selectAll();

    int updateByPrimaryKey(CommunityComment record);

    List<CommunityComment> selectByCommunityAnswerId(Long communityAnswerId);

    List<CommunityComment> selectByCommunityIdWithNullCommunityAnswerId(Long communityId);
}