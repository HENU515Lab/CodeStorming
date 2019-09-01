package top.lab515.bbs.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import top.lab515.bbs.domain.Vote;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/9/1 14:35
 * @description：vote仓库
 */
public interface VoteRepository extends JpaRepository<Vote, Long> {

}