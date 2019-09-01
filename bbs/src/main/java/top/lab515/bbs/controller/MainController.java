package top.lab515.bbs.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import top.lab515.bbs.domain.Authority;
import top.lab515.bbs.domain.User;
import top.lab515.bbs.service.AuthorityService;
import top.lab515.bbs.service.UserService;

import java.util.ArrayList;
import java.util.List;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/8/27 14:50
 * @description：主页控制器
 */
@Controller
public class MainController {

    private static final Long ROLE_USER_AUTHORITY_ID = 2L; // 用户权限（博主）

    @Autowired
    private UserService userService;

    @Autowired
    private AuthorityService authorityService;

    @GetMapping("/")
    public String root() {
        return "redirect:/index";
    }

    @GetMapping("/index")
    public String index() {
        return "redirect:/blogs";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/login-error")
    public String loginError(Model model) {
        model.addAttribute("loginError", true);
        model.addAttribute("errorMsg", "登录失败，用户名或者密码错误！");
        return "login";
    }

    @GetMapping("/register")
    public String register() {
        return "register";
    }

    /**
     * 注册用户
     *
     * @param user
     * @return
     */
    @PostMapping("/register")
    public String registerUser(User user) {
        List<Authority> authorities = new ArrayList<>();
        authorities.add(authorityService.getAuthorityById(ROLE_USER_AUTHORITY_ID).get());
        user.setAuthorities(authorities);
        userService.registerUser(user);
        return "redirect:/login";
    }

}

