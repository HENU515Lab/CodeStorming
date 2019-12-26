package com.seriouszyx.bbs.base.controller;

import com.github.pagehelper.PageInfo;
import com.seriouszyx.bbs.base.domain.Blog;
import com.seriouszyx.bbs.base.domain.Logininfo;
import com.seriouszyx.bbs.base.domain.User;
import com.seriouszyx.bbs.base.service.IBlogService;
import com.seriouszyx.bbs.base.service.ILogininfoService;
import com.seriouszyx.bbs.base.service.IUserService;
import com.seriouszyx.bbs.base.util.BidConst;
import com.seriouszyx.bbs.base.util.RequireLogin;
import com.seriouszyx.bbs.base.util.UploadUtil;
import com.seriouszyx.bbs.base.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {


    private final int DEFAULT_PAGE_SIZE = 10;
    private final int FIRST_PAGE_NUM = 1;

    @Autowired
    private ILogininfoService logininfoService;

    @Autowired
    private IUserService userService;

    @Autowired
    private IBlogService blogService;

    @Autowired
    private ServletContext servletContext;


    @RequestMapping("userspace")
    public String userspace(@RequestParam("id") Long otherId, Model model, Integer pageNum) {
        Logininfo current = UserContext.getCurrent();

        if (pageNum == null) {
            PageInfo<Blog> blogs = blogService.listByAuthorId(otherId, FIRST_PAGE_NUM, DEFAULT_PAGE_SIZE);
            model.addAttribute("blogList", blogs);
        } else {
            PageInfo<Blog> blogs = blogService.listByAuthorId(otherId, pageNum, DEFAULT_PAGE_SIZE);
            model.addAttribute("blogList", blogs);
        }

        if (current == null || current.getId() != otherId) {
            // 访问其他人的空间
            User otherUser = userService.getUserById(otherId);
            otherUser.setVisitors(otherUser.getVisitors() + 1);
            userService.updateUser(otherUser);
            model.addAttribute("userspace", otherUser);
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
    @ResponseBody
    public Map<String, String> updateProfile(User user) {
        Map<String, String> result = new HashMap<>();
        result.put("error_message", "success");
        try {
            userService.updateUser(user);
            result.put("username", user.getUsername());
            UserContext.putCurrentUser(userService.getUserById(user.getId()));
        } catch (RuntimeException e) {
            result.put("error_message", e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "uploadAvatar")
    @ResponseBody
    public Map<String, String> uploadAvatar(@RequestParam("photo") MultipartFile file,
                                            @RequestParam("photo_name") String name) throws IOException {
        Map<String, String> result = new HashMap<>();
        result.put("error_message", "success");
        String basePath = servletContext.getRealPath("/upload");
        String fileName = UploadUtil.replace(file, name, basePath);
        User currentUser = UserContext.getCurrentUser();
        currentUser.setAvatar(fileName);
        userService.updateUser(currentUser);
        UserContext.putCurrentUser(currentUser);

        result.put("photo_url", fileName);
        return result;
    }

    @RequestMapping(value = "getAvatarUrl")
    @ResponseBody
    public Map<String, String> getAvatarUrl(@RequestParam MultipartFile photo) {
        Map<String, String> result = new HashMap<>();
        result.put("error_message", "success");
        String basePath = servletContext.getRealPath("/upload");
        String fileName = UploadUtil.upload(photo, basePath);
        fileName = "/upload/" + fileName;
        result.put("photo_url", fileName);
        return result;
    }

}
