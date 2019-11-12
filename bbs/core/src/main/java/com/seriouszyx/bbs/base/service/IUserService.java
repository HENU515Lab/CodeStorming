package com.seriouszyx.bbs.base.service;

import com.seriouszyx.bbs.base.domain.User;

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
}
