package com.seriouszyx.bbs.back.controller;

import com.seriouszyx.bbs.back.util.JsonResult;
import com.seriouszyx.bbs.base.domain.Logininfo;
import com.seriouszyx.bbs.base.domain.User;
import com.seriouszyx.bbs.base.service.ILogininfoService;
import com.seriouszyx.bbs.base.util.MD5;
import com.wf.captcha.utils.CaptchaUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;

@Controller
public class AdminController {

    @Autowired
    private ILogininfoService logininfoService;

    @RequestMapping("toLogin")
    public String toLogin() {
        return "admin/login";
    }

    @RequestMapping("toRegister")
    public String toRegister() {
        return "user/reg";
    }

    @RequestMapping("captcha")
    public void captcha(HttpServletRequest request, HttpServletResponse response) throws Exception {
        CaptchaUtil.out(request, response);
    }

    @RequestMapping("login")
    @ResponseBody
    public JsonResult login(String username,String password, String vercode, HttpServletRequest request){
        if (!CaptchaUtil.ver(vercode, request)) {
            CaptchaUtil.clear(request);  // 清除session中的验证码
            return new JsonResult("验证码不正确");
        }
        HashMap<String, String> map = new HashMap<>();
        // 执行登陆操作
        Logininfo current = logininfoService.login(username, password);
        if (current != null && current.getUserType() == Logininfo.USER_MANAGER) {
            // 登陆成功
            String accessToken = MD5.encode(current.getUsername() + System.currentTimeMillis());
            map.put("access_token", accessToken);
            JsonResult jsonResult = new JsonResult(map);
            jsonResult.setMsg("登入成功");
            return jsonResult;
        } else {
            return new JsonResult("用户名或密码错误");
        }

    }

}
