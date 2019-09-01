package top.lab515.bbs.service;

import top.lab515.bbs.domain.Comment;

import java.util.Optional;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/9/1 14:47
 * @description：评论服务接口
 */
public interface CommentService {

    /**
     * 根据id获取 Comment
     *
     * @param id
     * @return
     */
    Optional<Comment> getCommentById(Long id);

    /**
     * 删除评论
     *
     * @param id
     * @return
     */
    void removeComment(Long id);
}
