package top.lab515.bbs.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.lab515.bbs.domain.Comment;
import top.lab515.bbs.repository.CommentRepository;
import top.lab515.bbs.service.CommentService;

import java.util.Optional;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/9/1 14:48
 * @description：
 */
@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentRepository commentRepository;

    @Override
    public Optional<Comment> getCommentById(Long id) {
        return commentRepository.findById(id);
    }

    @Override
    public void removeComment(Long id) {
        commentRepository.deleteById(id);
    }

}