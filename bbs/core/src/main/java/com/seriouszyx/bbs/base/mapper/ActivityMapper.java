package com.seriouszyx.bbs.base.mapper;

import com.seriouszyx.bbs.base.domain.Activity;
import org.apache.ibatis.annotations.Param;

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

    /**
     * 查询用户是否报名该活动
     * @param userId
     * @param activityId
     * @return
     */
    int selectApplyInfo(@Param("userId") Long userId, @Param("activityId") Long activityId);

    /**
     * 报名活动
     * @param userId
     * @param id
     */
    void applyActivity(@Param("userId") Long userId, @Param("activityId") Long id);

    /**
     * 参与人数 +1
     * @param id
     */
    void addJoinNum(@Param("id") Long id);
}