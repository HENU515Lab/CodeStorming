package com.seriouszyx.bbs.base.controller;

import com.github.pagehelper.PageInfo;
import com.seriouszyx.bbs.base.domain.Blog;
import com.seriouszyx.bbs.base.domain.Logininfo;
import com.seriouszyx.bbs.base.service.IBlogService;
import com.seriouszyx.bbs.base.util.RequireLogin;
import com.seriouszyx.bbs.base.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class BlogController {

    private final int DEFAULT_PAGE_SIZE = 10;
    private final int FIRST_PAGE_NUM = 1;

    @Autowired
    public IBlogService blogService;

    @RequestMapping("blog")
    public String blog(Model model, Integer pageNum) {
        if (pageNum == null) {
            PageInfo<Blog> pageInfo = blogService.listAll(FIRST_PAGE_NUM, DEFAULT_PAGE_SIZE);
            model.addAttribute("blogList", pageInfo);
        } else {
            PageInfo<Blog> pageInfo = blogService.listAll(pageNum, DEFAULT_PAGE_SIZE);
            model.addAttribute("blogList", pageInfo);
        }
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
        int voteOffset = blogService.selectBlogVoteRecord(id);
        model.addAttribute("voteOffset", voteOffset);
        model.addAttribute("blog", blog);
        return "blog/content";
    }

    @RequireLogin
    @RequestMapping("submitBlogComment")
    public String submitBlogComment(String content, Long blogId) {
        blogService.comment(content, blogId);
        return "redirect:content.do?id=" + blogId;
    }

    @RequestMapping("blogVoteUp")
    @ResponseBody
    public Map<String, Object> blogVoteUp(@RequestParam("blogId") String blogId) {
        Map<String, Object> result = new HashMap<>();
        result.put("error_message", "add_success");
        result.put("votecnt", blogService.addBlogVote(Long.valueOf(blogId)));
        return result;
    }

    @RequestMapping("blogVoteDown")
    @ResponseBody
    public Map<String, Object> blogVoteDown(@RequestParam("blogId") String blogId) {
        Map<String, Object> result = new HashMap<>();
        result.put("error_message", "remove_success");
        result.put("votecnt", blogService.removeBlogVote(Long.valueOf(blogId)));
        return result;
    }

    private boolean isNullOrEmpty(String s) {
        return s == null || s.trim().equals("");
    }


}
