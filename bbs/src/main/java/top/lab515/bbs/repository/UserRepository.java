package top.lab515.bbs.repository;

import org.springframework.data.repository.CrudRepository;
import top.lab515.bbs.domain.User;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/8/27 10:20
 * @description：用户仓库
 */
public interface UserRepository extends CrudRepository<User, Long> {
}
