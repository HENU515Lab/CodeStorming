package com.seriouszyx.bbs.base.service;

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
    List<Community> listAll();

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

}
