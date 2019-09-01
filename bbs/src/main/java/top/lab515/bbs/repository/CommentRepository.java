package top.lab515.bbs.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import top.lab515.bbs.domain.Comment;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/9/1 14:32
 * @description：评论仓库
 */
public interface CommentRepository extends JpaRepository<Comment, Long> {

}
