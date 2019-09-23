package com.seriouszyx.bbs.base.service.impl;

import com.seriouszyx.bbs.base.domain.Logininfo;
import com.seriouszyx.bbs.base.domain.User;
import com.seriouszyx.bbs.base.mapper.LogininfoMapper;
import com.seriouszyx.bbs.base.mapper.UserMapper;
import com.seriouszyx.bbs.base.service.IUserService;
import com.seriouszyx.bbs.base.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements IUserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private LogininfoMapper logininfoMapper;

    @Override
    public User getUserById(Long id) {
        return userMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updateUser(User user) {
        User currentUser = userMapper.selectByPrimaryKey(user.getId());
        currentUser.setUsername(user.getUsername());
        currentUser.setTruename(user.getTruename());
        currentUser.setGrade(user.getGrade());
        currentUser.setEmail(user.getEmail());
        currentUser.setIntroduce(user.getIntroduce());
        if (user.getAvatar() != null)
            currentUser.setAvatar(user.getAvatar());
        currentUser.setVisitors(user.getVisitors());
        userMapper.updateByPrimaryKey(currentUser);
        Logininfo current = UserContext.getCurrent();
        if (current != null && current.getId() == user.getId()) {
            current.setEmail(user.getEmail());
            current.setUsername(user.getUsername());
            logininfoMapper.updateByPrimaryKey(current);
        }
    }

}
