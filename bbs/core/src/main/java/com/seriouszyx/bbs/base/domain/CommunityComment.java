package com.seriouszyx.bbs.base.domain;

import lombok.Data;

import java.util.Date;

@Data
public class CommunityComment {

    private Long id;

    private String content;

    private Long userId;
    private User user;

    private Date createTime;

    private Long communityId;

    private Long communityAnswerId;

}