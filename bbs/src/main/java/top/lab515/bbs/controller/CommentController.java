package top.lab515.bbs.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import top.lab515.bbs.domain.Blog;
import top.lab515.bbs.domain.Comment;
import top.lab515.bbs.domain.User;
import top.lab515.bbs.service.BlogService;
import top.lab515.bbs.service.CommentService;
import top.lab515.bbs.utils.ConstraintViolationExceptionHandler;
import top.lab515.bbs.vo.Response;

import javax.validation.ConstraintViolationException;
import java.util.List;
import java.util.Optional;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/9/1 16:42
 * @description：评论控制器
 */
@Controller
@RequestMapping("/comments")
public class CommentController {

    @Autowired
    private BlogService blogService;

    @Autowired
    private CommentService commentService;

    /**
     * 获取评论列表
     *
     * @param blogId
     * @param model
     * @return
     */
    @GetMapping
    public String listComments(@RequestParam(value = "blogId", required = true) Long blogId, Model model) {
        Optional<Blog> optionalblog = blogService.getBlogById(blogId);
        List<Comment> comments = null;

        if (optionalblog.isPresent()) {
            comments = optionalblog.get().getComments();
        }

        // 判断操作用户是否是评论的所有者
        String commentOwner = "";
        if (SecurityContextHolder.getContext().getAuthentication() != null
                && SecurityContextHolder.getContext().getAuthentication().isAuthenticated()
                && !SecurityContextHolder
                .getContext().getAuthentication().getPrincipal().toString().equals("anonymousUser")) {
            User principal = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            if (principal != null) {
                commentOwner = principal.getUsername();
            }
        }

        model.addAttribute("commentOwner", commentOwner);
        model.addAttribute("comments", comments);
        return "/userspace/blog :: #mainContainerRepleace";
    }

    /**
     * 发表评论
     *
     * @param blogId
     * @param commentContent
     * @return
     */
    @PostMapping
    @PreAuthorize("hasAnyAuthority('ROLE_ADMIN','ROLE_USER')") // 指定角色权限才能操作方法
    public ResponseEntity<Response> createComment(Long blogId, String commentContent) {

        try {
            blogService.createComment(blogId, commentContent);
        } catch (ConstraintViolationException e) {
            return ResponseEntity.ok().body(new Response(false, ConstraintViolationExceptionHandler.getMessage(e)));
        } catch (Exception e) {
            return ResponseEntity.ok().body(new Response(false, e.getMessage()));
        }

        return ResponseEntity.ok().body(new Response(true, "处理成功", null));
    }

    /**
     * 删除评论
     *
     * @return
     */
    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyAuthority('ROLE_ADMIN','ROLE_USER')") // 指定角色权限才能操作方法
    public ResponseEntity<Response> delete(@PathVariable("id") Long id, Long blogId) {

        boolean isOwner = false;
        Optional<Comment> optionalComment = commentService.getCommentById(id);
        User user = null;

        if (optionalComment.isPresent()) {
            user = optionalComment.get().getUser();
        } else {
            return ResponseEntity.ok().body(new Response(false, "不存在该评论！"));
        }

        // 判断操作用户是否是评论的所有者
        if (SecurityContextHolder.getContext().getAuthentication() != null
                && SecurityContextHolder.getContext().getAuthentication().isAuthenticated()
                && !SecurityContextHolder
                .getContext().getAuthentication().getPrincipal().toString().equals("anonymousUser")) {
            User principal = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            if (principal != null && user.getUsername().equals(principal.getUsername())) {
                isOwner = true;
            }
        }

        if (!isOwner) {
            return ResponseEntity.ok().body(new Response(false, "没有操作权限"));
        }

        try {
            blogService.removeComment(blogId, id);
            commentService.removeComment(id);
        } catch (ConstraintViolationException e) {
            return ResponseEntity.ok().body(new Response(false, ConstraintViolationExceptionHandler.getMessage(e)));
        } catch (Exception e) {
            return ResponseEntity.ok().body(new Response(false, e.getMessage()));
        }

        return ResponseEntity.ok().body(new Response(true, "处理成功", null));
    }
}