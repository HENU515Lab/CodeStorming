package com.seriouszyx.bbs.base.domain.mgr;

import com.seriouszyx.bbs.base.domain.Blog;
import com.seriouszyx.bbs.base.domain.User;
import lombok.Data;

import java.util.Date;

@Data
public class MgrBlogComment {

    private Long id;

    private User user;

    private String commentContent;

    private Date createTime;

    private Blog blog;

}
