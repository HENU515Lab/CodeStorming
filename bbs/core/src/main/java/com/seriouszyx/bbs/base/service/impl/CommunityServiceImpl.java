package com.seriouszyx.bbs.base.service.impl;

import com.seriouszyx.bbs.base.domain.Community;
import com.seriouszyx.bbs.base.mapper.CommunityMapper;
import com.seriouszyx.bbs.base.service.ICommunityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommunityServiceImpl implements ICommunityService {

    @Autowired
    private CommunityMapper communityMapper;

    @Override
    public List<Community> listAll() {
        return communityMapper.selectAll();
    }

    @Override
    public Community listById(Long id) {
        return communityMapper.selectByPrimaryKey(id);
    }

}
