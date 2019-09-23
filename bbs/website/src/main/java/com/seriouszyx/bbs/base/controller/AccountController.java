package com.seriouszyx.bbs.base.controller;

import com.seriouszyx.bbs.base.domain.Logininfo;
import com.seriouszyx.bbs.base.service.ILogininfoService;
import com.seriouszyx.bbs.base.util.MD5;
import com.seriouszyx.bbs.base.util.RequireLogin;
import com.seriouszyx.bbs.base.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class AccountController {

    @Autowired
    public ILogininfoService logininfoService;

    @RequestMapping("register")
    @ResponseBody
    public Map<String, String> register(String username, String password, String email, String activeCode) {
        Map<String, String> result = new HashMap<>();
        result.put("error_message", "success");
        try {
            logininfoService.register(username, password, email, activeCode);
        } catch (RuntimeException re) {
            System.out.println(re.getMessage());
            result.put("error_message", re.getMessage());
        }
        return result;
    }

    @RequestMapping("login")
    @ResponseBody
    public Map<String, String> login(String username, String password) {
        Map<String, String> result = new HashMap<>();
        result.put("error_message", "success");
        Logininfo current = logininfoService.login(username, password);
        if (current == null)
            result.put("error_message", "用户名或密码错误!");
        return result;
    }

    @RequestMapping("logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:index.do";
    }

    @RequestMapping("toChangePassword")
    @RequireLogin
    public String toChangePassword() {
        return "user/changePassword";
    }

    @RequestMapping("changepassword")
    @RequireLogin
    public String changePassword(String currentpassword,
                                 String newpassword1,
                                 String newpassword2,
                                 Model model) {
        if(isNullOrEmpty(newpassword1) || isNullOrEmpty(newpassword2) ||
                !newpassword1.equals(newpassword2)) {
            model.addAttribute("error_message", "两次输入的密码不一致！");
            return "/user/changePassword";
        }
        if (!logininfoService.checkPassword(MD5.encode(currentpassword))) {
            model.addAttribute("error_message", "原密码输入错误！");
            return "/user/changePassword";
        }
        logininfoService.updatePassword(MD5.encode(newpassword1));
        model.addAttribute("success_message", "密码修改成功!");
        return "/user/changePassword";
    }


    private boolean isNullOrEmpty(String s) {
        return s == null || s.trim().equals("");
    }
    

}
