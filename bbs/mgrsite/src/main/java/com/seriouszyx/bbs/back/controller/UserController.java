package com.seriouszyx.bbs.back.controller;

import com.seriouszyx.bbs.back.util.JsonResult;
import com.seriouszyx.bbs.base.domain.User;
import com.seriouszyx.bbs.base.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;

@Controller
public class UserController {

    private final int DEFAULT_PAGE_SIZE = 10;
    private final int FIRST_PAGE_NUM = 1;

    @Autowired
    private IUserService userService;

    @RequestMapping("toUserMgr")
    public String toUserMgr(Model model) {
        List<User> users = userService.listAll();
        model.addAttribute("userList", users);
        return "user/list";
    }

    @RequestMapping("toUserForm")
    public String toUserForm() {
        return "user/user/userform";
    }

    @RequestMapping("listWebUser")
    @ResponseBody
    public JsonResult listWebUser(Integer page, Integer limit) {
        JsonResult jsonResult = new JsonResult();
        return jsonResult;
    }

}
