package com.seriouszyx.bbs.base.service.impl;

import com.seriouszyx.bbs.base.domain.Blog;
import com.seriouszyx.bbs.base.domain.BlogComment;
import com.seriouszyx.bbs.base.domain.User;
import com.seriouszyx.bbs.base.mapper.BlogCommentMapper;
import com.seriouszyx.bbs.base.mapper.BlogMapper;
import com.seriouszyx.bbs.base.mapper.UserMapper;
import com.seriouszyx.bbs.base.service.IBlogService;
import com.seriouszyx.bbs.base.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class BlogServiceImpl implements IBlogService {

    @Autowired
    private BlogMapper blogMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private BlogCommentMapper blogCommentMapper;

    @Override
    public void saveBlog(Blog blog) throws RuntimeException {
        boolean isNew = (blog.getId() == null);
        if (isNew) {
            User user = userMapper.selectByPrimaryKey(UserContext.getCurrentUser().getId());
            blog.setAuthor(user);
            blog.setCreateTime(new Date());
            blog.setBlogType(1);
            blogMapper.insert(blog);
        } else {
            blogMapper.updateByPrimaryKey(blog);
        }
    }

    @Override
    public List<Blog> listAll() {
        return blogMapper.selectAll();
    }

    @Override
    public Blog listById(Long id) {
        return blogMapper.selectByPrimaryKey(id);
    }

    @Override
    public void comment(String content, Long blogId) {
        BlogComment comment = new BlogComment();
        comment.setCommentContent(content);
        comment.setCreateTime(new Date());
        comment.setUser(UserContext.getCurrentUser());
        comment.setBid(blogId);
        blogCommentMapper.insert(comment);
    }

    @Override
    public List<Blog> listByAuthorId(Long authorId) {
        return blogMapper.selectByAuthorId(authorId);
    }

}
