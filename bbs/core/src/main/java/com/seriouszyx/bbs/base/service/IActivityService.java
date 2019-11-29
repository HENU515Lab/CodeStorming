package com.seriouszyx.bbs.base.service;

import com.github.pagehelper.PageInfo;
import com.seriouszyx.bbs.base.domain.Activity;
import com.seriouszyx.bbs.base.domain.ActivityContent;
import com.seriouszyx.bbs.base.domain.ActivityContentRecord;

import java.util.List;

public interface IActivityService {

    /**
     * 按时间倒序查询所有活动
     * @return
     */
    PageInfo<Activity> listAll(Integer pageNum, Integer pageSize);

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

    /**
     * 查询活动内容
     * @param activityId
     * @return
     */
    ActivityContent selectActivityContent(Long activityId);

    /**
     * 查询用户是否已提交
     * @param userId
     * @param activityId
     * @return
     */
    ActivityContentRecord selectActivityContentRecord(Long userId, Long activityId);


    void insertActivityContentRecord(Long userId, Long activityId, String filePath);

    void updateActivityContentRecord(Long userId, Long activityId, String filePath);

    /**
     * 查询指定活动的提交记录
     * @param id
     * @param pageNum
     * @param pageSize
     * @return
     */
    PageInfo<ActivityContentRecord> selectRecordList(Long id, Integer pageNum, Integer pageSize);
}
