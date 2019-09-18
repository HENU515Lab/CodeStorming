package com.seriouszyx.bbs.base.controller;

import com.seriouszyx.bbs.base.domain.Logininfo;
import com.seriouszyx.bbs.base.service.ILogininfoService;
import com.seriouszyx.bbs.base.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
    public Map<String, String> register(String username, String password, String email) {
        Map<String, String> result = new HashMap<>();
        result.put("error_message", "success");
        try {
            logininfoService.register(username, password, email);
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
        Logininfo current = logininfoService.login(username, password, Logininfo.USER_CLIENT);
        if (current == null)
            result.put("error_message", "用户名或密码错误!");
        return result;
    }

    @RequestMapping("logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:index.do";
    }

}
