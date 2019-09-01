package top.lab515.bbs.service;

import top.lab515.bbs.domain.Vote;

import java.util.Optional;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/9/1 14:43
 * @description：vote服务接口
 */
public interface VoteService {
    /**
     * 根据id获取 Vote
     *
     * @param id
     * @return
     */
    Optional<Vote> getVoteById(Long id);

    /**
     * 删除Vote
     *
     * @param id
     * @return
     */
    void removeVote(Long id);
}
