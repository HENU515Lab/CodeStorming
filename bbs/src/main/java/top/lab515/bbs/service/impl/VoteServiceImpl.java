package top.lab515.bbs.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.lab515.bbs.domain.Vote;
import top.lab515.bbs.repository.VoteRepository;
import top.lab515.bbs.service.VoteService;

import java.util.Optional;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/9/1 14:43
 * @description：
 */
@Service
public class VoteServiceImpl implements VoteService {

    @Autowired
    private VoteRepository voteRepository;

    @Override
    public Optional<Vote> getVoteById(Long id) {
        return voteRepository.findById(id);
    }

    @Override
    public void removeVote(Long id) {
        voteRepository.deleteById(id);
    }
}
