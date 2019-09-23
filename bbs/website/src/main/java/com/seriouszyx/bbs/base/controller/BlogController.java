package com.seriouszyx.bbs.base.controller;

import com.seriouszyx.bbs.base.domain.Blog;
import com.seriouszyx.bbs.base.domain.Logininfo;
import com.seriouszyx.bbs.base.service.IBlogService;
import com.seriouszyx.bbs.base.util.RequireLogin;
import com.seriouszyx.bbs.base.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BlogController {

    @Autowired
    public IBlogService blogService;

    @RequestMapping("blog")
    public String blog(Model model) {
        model.addAttribute("blogList", blogService.listAll());
        model.addAttribute("currentNav", "blog");
        return "blog/index";
    }

    @RequireLogin
    @RequestMapping("addBlog")
    public String addBlog(String id) {
        return "blog/addBlog";
    }

    @RequireLogin
    @RequestMapping("submitBlog")
    public String submitBlog(Blog blog, Model model) {
        if (isNullOrEmpty(blog.getTitle()) || isNullOrEmpty(blog.getContent())) {
            model.addAttribute("error_message", "发表文章失败！标题或内容不能为空");
        } else {
            try {
                blogService.saveBlog(blog);
            } catch (RuntimeException e) {
                model.addAttribute("error_message", "发表文章失败！");
            }
        }
        return "redirect:/blog.do";
    }

    @RequestMapping("content")
    public String blogContent(Long id, Model model) {
        Blog blog = blogService.listById(id);
        if (blog.getBlogType() == 0) {
            Logininfo current = UserContext.getCurrent();
            if (current == null || current.getUserType() != Logininfo.USER_MANAGER) {
                return "blog/error";
            }
        }
        blog.setReadSize(blog.getReadSize() + 1);
        blogService.saveBlog(blog);
        model.addAttribute("blog", blog);
        return "blog/content";
    }

    @RequireLogin
    @RequestMapping("submitBlogComment")
    public String submitBlogComment(String content, Long blogId) {
        blogService.comment(content, blogId);
        return "redirect:content.do?id=" + blogId;
    }

    private boolean isNullOrEmpty(String s) {
        return s == null || s.trim().equals("");
    }


}
