package top.lab515.bbs.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import top.lab515.bbs.domain.Authority;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/8/27 16:40
 * @description：Authority 仓库
 */
public interface AuthorityRepository extends JpaRepository<Authority, Long> {
}
