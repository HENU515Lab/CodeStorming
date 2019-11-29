package com.seriouszyx.bbs.base.service;

import com.github.pagehelper.PageInfo;
import com.seriouszyx.bbs.base.domain.User;

import java.util.List;

/**
 * 用户相关服务
 */
public interface IUserService {

    /**
     * 根据主键获取用户
     * @param id
     * @return
     */
    User getUserById(Long id);

    /**
     * 更新用户信息
     * @param user
     */
    void updateUser(User user);

    /**
     * 获取所有用户信息
     * @return
     */
    List<User> listAll();
}
