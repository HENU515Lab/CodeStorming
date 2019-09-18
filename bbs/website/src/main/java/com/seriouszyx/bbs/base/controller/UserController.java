package com.seriouszyx.bbs.base.controller;

import com.seriouszyx.bbs.base.domain.Blog;
import com.seriouszyx.bbs.base.domain.Logininfo;
import com.seriouszyx.bbs.base.domain.User;
import com.seriouszyx.bbs.base.service.IBlogService;
import com.seriouszyx.bbs.base.service.ILogininfoService;
import com.seriouszyx.bbs.base.service.IUserService;
import com.seriouszyx.bbs.base.util.RequireLogin;
import com.seriouszyx.bbs.base.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class UserController {

    @Autowired
    private ILogininfoService logininfoService;

    @Autowired
    private IUserService userService;

    @Autowired
    private IBlogService blogService;


    @RequestMapping("userspace")
    public String userspace(Long id, Model model) {
        Logininfo current = UserContext.getCurrent();
        List<Blog> blogs = blogService.listByAuthorId(id);
        model.addAttribute("blogList", blogs);
        if (current == null || current.getId() != id) {
            // 访问其他人的空间
            User user = userService.getUserById(id);
            model.addAttribute("userspace", user);
        } else {
            model.addAttribute("userspace", UserContext.getCurrentUser());
        }
        return "user/space";
    }

    @RequireLogin
    @RequestMapping("profile")
    public String profile() {
        return "user/profile";
    }

    @RequireLogin
    @RequestMapping("updateProfile")
    public String updateProfile(User user) {
        userService.updateUser(user);
        return "redirect:logout.do";
    }

}
