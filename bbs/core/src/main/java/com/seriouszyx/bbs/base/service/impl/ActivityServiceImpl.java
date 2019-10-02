package com.seriouszyx.bbs.base.service.impl;

import com.seriouszyx.bbs.base.domain.Activity;
import com.seriouszyx.bbs.base.mapper.ActivityMapper;
import com.seriouszyx.bbs.base.service.IActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ActivityServiceImpl implements IActivityService {

    @Autowired
    private ActivityMapper activityMapper;

    @Override
    public List<Activity> listAll() {
        return activityMapper.selectAll();
    }

    @Override
    public Activity selectById(Long id) {
        return activityMapper.selectByPrimaryKey(id);
    }

    @Override
    public Activity selectWithContent(Long id) {
        return activityMapper.selectWithContent(id);
    }
}
