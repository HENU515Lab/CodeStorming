package com.seriouszyx.bbs.base.mapper;

import com.seriouszyx.bbs.base.domain.Activity;

import java.util.List;

public interface ActivityMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Activity record);

    Activity selectByPrimaryKey(Long id);

    List<Activity> selectAll();

    int updateByPrimaryKey(Activity record);

    /**
     * 查询包含活动内容的活动实体
     * @param id
     * @return
     */
    Activity selectWithContent(Long id);
}