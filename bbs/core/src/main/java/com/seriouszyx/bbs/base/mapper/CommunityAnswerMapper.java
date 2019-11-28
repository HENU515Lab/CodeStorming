package com.seriouszyx.bbs.base.mapper;

import com.seriouszyx.bbs.base.domain.CommunityAnswer;
import java.util.List;

public interface CommunityAnswerMapper {
    int deleteByPrimaryKey(Long id);

    int insert(CommunityAnswer record);

    CommunityAnswer selectByPrimaryKey(Long id);

    List<CommunityAnswer> selectAll();

    int updateByPrimaryKey(CommunityAnswer record);

    List<CommunityAnswer> selectByCommunityId(Long id);
}