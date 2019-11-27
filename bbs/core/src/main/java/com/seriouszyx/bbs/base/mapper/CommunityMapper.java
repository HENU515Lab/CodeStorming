package com.seriouszyx.bbs.base.mapper;

import com.seriouszyx.bbs.base.domain.Community;
import java.util.List;

public interface CommunityMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Community record);

    Community selectByPrimaryKey(Long id);

    List<Community> selectAll();

    int updateByPrimaryKey(Community record);
}