package top.lab515.bbs.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import top.lab515.bbs.domain.User;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/8/27 10:20
 * @description：用户仓库
 */
public interface UserRepository extends JpaRepository<User, Long> {

    /**
     * 根据用户姓名分页查询用户列表
     * @param name
     * @param pageable
     * @return
     */
    Page<User> findByNameLike(String name, Pageable pageable);

    /**
     * 根据用户账号查询用户
     * @param username
     * @return
     */
    User findByUsername(String username);

}
