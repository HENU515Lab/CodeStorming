package com.seriouszyx.bbs.base.mapper;

import com.seriouszyx.bbs.base.domain.ActivityContent;
import java.util.List;

public interface ActivityContentMapper {
    int deleteByPrimaryKey(Long id);

    int insert(ActivityContent record);

    ActivityContent selectByPrimaryKey(Long id);

    List<ActivityContent> selectAll();

    int updateByPrimaryKey(ActivityContent record);

    List<ActivityContent> selectByActivityId(Long id);

    /**
     * 增加活动内容完成数
     * @param id
     */
    void addFinishNum(Long id);
}