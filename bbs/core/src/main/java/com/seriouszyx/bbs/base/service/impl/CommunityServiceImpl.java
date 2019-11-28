package com.seriouszyx.bbs.base.service.impl;

import com.seriouszyx.bbs.base.domain.Community;
import com.seriouszyx.bbs.base.domain.CommunityComment;
import com.seriouszyx.bbs.base.mapper.CommunityCommentMapper;
import com.seriouszyx.bbs.base.mapper.CommunityMapper;
import com.seriouszyx.bbs.base.service.ICommunityService;
import com.seriouszyx.bbs.base.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class CommunityServiceImpl implements ICommunityService {

    @Autowired
    private CommunityMapper communityMapper;

    @Autowired
    private CommunityCommentMapper communityCommentMapper;

    @Override
    public List<Community> listAll() {
        return communityMapper.selectAll();
    }

    @Override
    public Community listById(Long id) {
        return communityMapper.selectByPrimaryKey(id);
    }

    @Override
    public void addCommunityComment(Long communityId, String content) {
        CommunityComment communityComment = new CommunityComment();
        communityComment.setCommunityId(communityId);
        communityComment.setContent(content);
        communityComment.setCreateTime(new Date());
        communityComment.setUserId(UserContext.getCurrentUser().getId());
        communityCommentMapper.insert(communityComment);
    }

    @Override
    public void addCommunityAnswerComment(Long communityId, Long communityAnswerId, String content) {
        CommunityComment communityComment = new CommunityComment();
        communityComment.setCommunityId(communityId);
        communityComment.setContent(content);
        communityComment.setCreateTime(new Date());
        communityComment.setUserId(UserContext.getCurrentUser().getId());
        communityComment.setCommunityAnswerId(communityAnswerId);
        communityCommentMapper.insert(communityComment);
    }

}
