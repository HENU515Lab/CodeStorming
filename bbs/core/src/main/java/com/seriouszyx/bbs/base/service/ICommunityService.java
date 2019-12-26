package com.seriouszyx.bbs.base.service;

import com.github.pagehelper.PageInfo;
import com.seriouszyx.bbs.base.domain.Community;
import com.seriouszyx.bbs.base.domain.CommunityAnswer;

import java.util.List;

/**
 * 问答相关服务
 */
public interface ICommunityService {

    /**
     * 按创建时间列出所有问答
     * @return
     */
    PageInfo<Community> listAll(Integer pageNum, Integer pageSize);

    /**
     * 根据问题id查询问题详细内容
     * @param id
     * @return
     */
    Community listById(Long id);

    /**
     * 为指定问题添加评论
     * @param communityId
     * @param content
     */
    void addCommunityComment(Long communityId, String content);

    /**
     * 为指定问题的指定回答添加评论
     * @param communityId
     * @param communityAnswerId
     * @param content
     */
    void addCommunityAnswerComment(Long communityId, Long communityAnswerId, String content);

    /**
     * 添加问题
     * @param community
     * @return 添加后的新问题
     */
    void saveCommunity(Community community);

    /**
     * 为指定问题添加回答
     * @param communityAnswer
     */
    void saveAnswer(CommunityAnswer communityAnswer);

    /**
     * 指定的问题浏览量+1
     * @param id
     */
    void plusCommunityReadSize(Long id);

    /**
     * 为指定问题点赞
     * @param communityId
     * @return
     */
    Integer addCommunityVote(Long communityId);

    /**
     * 为置顶问题取消点赞
     * @param communityId
     * @return
     */
    Integer removeCommunityVote(Long communityId);

    /**
     * 根据问题id和用户id查询投票记录
     * @param communityId
     * @return
     */
    Integer selectCommunityVoteRecord(Long communityId);

    /**
     * 为指定问题的指定回答点赞
     * @param communityId
     * @param communityAnswerId
     * @return
     */
    Integer addCommunityAnswerVote(Long communityId, Long communityAnswerId);

    /**
     * 为指定问题的指定回答取消点赞
     * @param communityId
     * @param communityAnswerId
     * @return
     */
    Integer removeCommunityAnswerVote(Long communityId, Long communityAnswerId);

    /**
     * 根据问题id和用户id和问题回答id查询投票记录
     * @param communityId
     * @return
     */
    Integer selectCommunityAnswerVoteRecord(Long communityId, Long communityAnswerId);

    /**
     * 将指定问题答案设成通过
     * @param communityAnswerId
     * @param communityId
     */
    void setCommunityAnswerOk(Long communityAnswerId, Long communityId);
}
