package top.lab515.bbs.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import top.lab515.bbs.domain.User;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/8/27 16:04
 * @description：用户服务接口
 */
public interface UserService {
    /**
     * 新增、编辑、保存用户
     *
     * @param user
     * @return
     */
    User saveOrUpateUser(User user);

    /**
     * 注册用户
     *
     * @param user
     * @return
     */
    User registerUser(User user);

    /**
     * 删除用户
     *
     * @param id
     */
    void removeUser(Long id);

    /**
     * 根据id获取用户
     *
     * @param id
     * @return
     */
    Optional<User> getUserById(Long id);

    /**
     * 根据用户名进行分页模糊查询
     *
     * @param name
     * @param pageable
     * @return
     */
    Page<User> listUsersByNameLike(String name, Pageable pageable);

    /**
     * 根据用户名集合，查询用户详细信息列表
     *
     * @param usernames
     * @return
     */
    List<User> listUsersByUsernames(Collection<String> usernames);
}
