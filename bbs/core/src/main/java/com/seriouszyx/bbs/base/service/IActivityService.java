package com.seriouszyx.bbs.base.service;

import com.seriouszyx.bbs.base.domain.Activity;

import java.util.List;

public interface IActivityService {

    /**
     * 按时间倒序查询所有活动
     * @return
     */
    List<Activity> listAll();

    Activity selectById(Long id);

    /**
     * 查询带有内容的活动
     * @param id
     * @return
     */
    Activity selectWithContent(Long id);

    /**
     * 查询用户是否报名活动
     * @param userId
     * @param activityId
     */
    int selectApplyInfo(Long userId, Long activityId);

    /**
     * 报名活动
     * @param userId
     * @param id
     */
    void applyActivity(Long userId, Long id);
}
