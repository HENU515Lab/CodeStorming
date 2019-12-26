package com.seriouszyx.bbs.back.controller;

import com.seriouszyx.bbs.back.util.JsonResult;
import com.seriouszyx.bbs.base.domain.Logininfo;
import com.seriouszyx.bbs.base.domain.User;
import com.seriouszyx.bbs.base.service.ILogininfoService;
import com.seriouszyx.bbs.base.service.IUserService;
import com.seriouszyx.bbs.base.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;

@Controller
public class SettingController {

    @Autowired
    private IUserService userService;

    @RequestMapping("info")
    public String info(String id) {
        User currentUser = userService.getUserById(Long.valueOf(id));
        UserContext.putCurrentUser(currentUser);
        return "set/user/info";
    }

    @RequestMapping("updateSetting")
    @ResponseBody
    public JsonResult updateSetting(User user) {
        // 更新数据库信息
        user.setId(UserContext.getCurrentUser().getId());
        userService.updateUser(user);

        // 更新 session 信息
        Long id = UserContext.getCurrentUser().getId();
        UserContext.putCurrentUser(userService.getUserById(id));
        Logininfo current = UserContext.getCurrent();
        current.setEmail(user.getEmail());
        current.setUsername(user.getUsername());
        UserContext.putCurrent(current);

        // 返回结果
        HashMap<String, String> map = new HashMap<>();
        JsonResult jsonResult = new JsonResult(map);
        jsonResult.setMsg("修改成功");
        return jsonResult;
    }

}
