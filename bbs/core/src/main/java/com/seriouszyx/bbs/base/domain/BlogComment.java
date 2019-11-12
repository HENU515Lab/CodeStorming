package com.seriouszyx.bbs.base.domain;

import lombok.Data;

import java.util.Date;

@Data
public class BlogComment {
    private Long id;

    private User user;

    private String commentContent;

    private Date createTime;

    private Long bid;

}