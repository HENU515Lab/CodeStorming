package com.seriouszyx.bbs.base.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.seriouszyx.bbs.base.domain.Activity;
import com.seriouszyx.bbs.base.domain.ActivityContent;
import com.seriouszyx.bbs.base.domain.ActivityContentRecord;
import com.seriouszyx.bbs.base.mapper.ActivityContentMapper;
import com.seriouszyx.bbs.base.mapper.ActivityContentRecordMapper;
import com.seriouszyx.bbs.base.mapper.ActivityMapper;
import com.seriouszyx.bbs.base.service.IActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ActivityServiceImpl implements IActivityService {

    @Autowired
    private ActivityMapper activityMapper;

    @Autowired
    private ActivityContentMapper activityContentMapper;
    @Autowired
    private ActivityContentRecordMapper activityContentRecordMapper;

    @Override
    public PageInfo<Activity> listAll(Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        return new PageInfo<>(activityMapper.selectAll());
    }

    @Override
    public Activity selectById(Long id) {
        return activityMapper.selectByPrimaryKey(id);
    }

    @Override
    public Activity selectWithContent(Long id) {
        return activityMapper.selectWithContent(id);
    }

    @Override
    public int selectApplyInfo(Long userId, Long activityId) {
        return activityMapper.selectApplyInfo(userId, activityId);
    }

    @Override
    public void applyActivity(Long userId, Long id) {
        activityMapper.applyActivity(userId, id);
        activityMapper.addJoinNum(id);
    }

    public ActivityContent selectActivityContent(Long id) {
        return this.activityContentMapper.selectByPrimaryKey(id);
    }


    public ActivityContentRecord selectActivityContentRecord(Long userId, Long activityContentId) {
        return this.activityContentRecordMapper.selectActivityContentRecord(userId, activityContentId);
    }


    public void insertActivityContentRecord(Long userId, Long activityContentId, String filePath) {
        this.activityContentMapper.addFinishNum(activityContentId);

        this.activityContentRecordMapper.insertRecord(userId, activityContentId, filePath, new Date());
    }


    public void updateActivityContentRecord(Long userId, Long activityContentId, String filePath) {
        this.activityContentRecordMapper.updateRecord(userId, activityContentId, filePath);
    }


    public PageInfo<ActivityContentRecord> selectRecordList(Long activityId, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        return new PageInfo<>(this.activityContentRecordMapper.selectRecordList(activityId));
    }
}

