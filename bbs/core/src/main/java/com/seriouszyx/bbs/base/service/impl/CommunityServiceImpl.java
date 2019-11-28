package com.seriouszyx.bbs.base.service.impl;

import com.seriouszyx.bbs.base.domain.*;
import com.seriouszyx.bbs.base.mapper.*;
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

    @Autowired
    private CommunityVoteRecordMapper communityVoteRecordMapper;

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

    @Override
    public void plusCommunityReadSize(Long id) {
        communityMapper.plusReadSizeByPrimaryKey(id);
    }

    @Override
    public Integer addCommunityVote(Long communityId) {
        CommunityVoteRecord record = new CommunityVoteRecord();

        Integer offset = selectCommunityVoteRecord(communityId);
        if (offset == 0) {
            // 没有记录
            record.setUid(UserContext.getCurrent().getId());
            record.setCid(communityId);
            record.setOffset(1);
            communityVoteRecordMapper.insert(record);
            communityMapper.updateVoteSizeByPrimaryKey(communityId, 1);
        } else if (offset == -1) {
            // 记录为vote down
            communityVoteRecordMapper.updateVoteSizeByUserIdAndCommunityId(
                    UserContext.getCurrent().getId(),
                    communityId,
                    1
            );
            communityMapper.updateVoteSizeByPrimaryKey(communityId, 2);
        }
        return communityMapper.selectVoteSizeByPrimaryKey(communityId);
    }

    @Override
    public Integer removeCommunityVote(Long communityId) {
        CommunityVoteRecord record = new CommunityVoteRecord();

        Integer offset = selectCommunityVoteRecord(communityId);
        if (offset == 0) {
            // 没有记录
            record.setUid(UserContext.getCurrent().getId());
            record.setCid(communityId);
            record.setOffset(-1);
            communityVoteRecordMapper.insert(record);
            communityMapper.updateVoteSizeByPrimaryKey(communityId, -1);
        } else if (offset == 1) {
            // 记录为vote up
            communityVoteRecordMapper.updateVoteSizeByUserIdAndCommunityId(
                    UserContext.getCurrent().getId(),
                    communityId,
                    -1
            );
            communityMapper.updateVoteSizeByPrimaryKey(communityId, -2);
        }
        return communityMapper.selectVoteSizeByPrimaryKey(communityId);
    }

    @Override
    public Integer selectCommunityVoteRecord(Long communityId) {
        if (UserContext.getCurrent() == null)
            return 0;
        Integer offset = communityVoteRecordMapper
                .selectOffestByUserIdAndCommunityId(
                        UserContext.getCurrent().getId(),
                        communityId
                );
        if (offset == null)
            return 0;
        return offset;
    }

}
