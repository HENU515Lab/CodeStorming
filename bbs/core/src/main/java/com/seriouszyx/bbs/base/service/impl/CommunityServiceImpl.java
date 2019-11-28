package com.seriouszyx.bbs.base.service.impl;

import com.seriouszyx.bbs.base.domain.Community;
import com.seriouszyx.bbs.base.domain.CommunityAnswer;
import com.seriouszyx.bbs.base.domain.CommunityComment;
import com.seriouszyx.bbs.base.domain.User;
import com.seriouszyx.bbs.base.mapper.CommunityAnswerMapper;
import com.seriouszyx.bbs.base.mapper.CommunityCommentMapper;
import com.seriouszyx.bbs.base.mapper.CommunityMapper;
import com.seriouszyx.bbs.base.mapper.UserMapper;
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

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private CommunityAnswerMapper communityAnswerMapper;

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

    @Override
    public void saveCommunity(Community community) {
        boolean isNew = (community.getId() == null);
        if (isNew) {
            User user = userMapper.selectByPrimaryKey(UserContext.getCurrentUser().getId());
            community.setAsker(user);
            community.setCreateTime(new Date());
            community.setAnswerSize(0);
            community.setReadSize(0);
            community.setVoteSize(0);
            community.setSolve(0);
            communityMapper.insert(community);
        } else {
            communityMapper.updateByPrimaryKey(community);
        }
    }

    @Override
    public void saveAnswer(CommunityAnswer communityAnswer) {
        boolean isNew = (communityAnswer.getId() == null);
        if (isNew) {
            User user = userMapper.selectByPrimaryKey(UserContext.getCurrentUser().getId());
            communityAnswer.setAnswerUser(user);
            communityAnswer.setCreateTime(new Date());
            communityAnswer.setVoteSize(0);
            communityAnswerMapper.insert(communityAnswer);

            communityMapper.addAnswerSizeByPrimaryId(communityAnswer.getCommunityId());
        } else {
            communityAnswerMapper.updateByPrimaryKey(communityAnswer);
        }
    }

}
