package com.seriouszyx.bbs.base.service.impl;

import com.seriouszyx.bbs.base.domain.Logininfo;
import com.seriouszyx.bbs.base.domain.User;
import com.seriouszyx.bbs.base.mapper.LogininfoMapper;
import com.seriouszyx.bbs.base.mapper.UserMapper;
import com.seriouszyx.bbs.base.service.ILogininfoService;
import com.seriouszyx.bbs.base.util.BidConst;
import com.seriouszyx.bbs.base.util.MD5;
import com.seriouszyx.bbs.base.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LogininfoServiceImpl implements ILogininfoService {

    @Autowired
    private LogininfoMapper logininfoMapper;

    @Autowired
    private UserMapper userMapper;


    @Override
    public void register(String username, String password, String email) {
        // 判断用户名是否存在
        int count = this.logininfoMapper.getCountByUsername(username);
        // 如果不存在,设值并保存这个对象
        if (count <= 0) {
            Logininfo li = new Logininfo();
            li.setUsername(username);
            li.setPassword(MD5.encode(password));
            li.setState(Logininfo.STATE_NORMAL);
            li.setUserType(Logininfo.USER_CLIENT);
            li.setEmail(email);
            this.logininfoMapper.insert(li);
//            UserContext.putCurrent(li);
        } else {
            // 如果存在,直接抛错
            throw new RuntimeException("用户名已经存在!");
        }
    }

    @Override
    public boolean checkUsername(String username) {
        return this.logininfoMapper.getCountByUsername(username) > 0;
    }

    @Override
    public Logininfo login(String username, String password, int userType) {
        Logininfo current = this.logininfoMapper.login(username,
                MD5.encode(password), userType);

        if (current != null) {
            // 放到UserContext
            UserContext.putCurrent(current);

            User user = userMapper.selectByPrimaryKey(current.getId());
            if (user == null) {
                User user1 = new User();
                user1.setId(current.getId());
                user1.setUsername(current.getUsername());
                user1.setAvatar("static/web/img/default-avatar.jpg");
                user1.setEmail(current.getEmail());
                user1.setGrade("");
                user1.setTruename("");
                userMapper.insert(user1);
                UserContext.putCurrentUser(user1);
            } else {
                UserContext.putCurrentUser(user);
            }
        } else {

        }
        return current;
    }


}
