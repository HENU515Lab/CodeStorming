package com.seriouszyx.bbs.base.domain;

import lombok.Data;

import java.util.Date;

@Data
public class CommunityAnswer {

    private Long id;

    private User answerUser;
//    private Long auid;
    private Long communityId;

    private Date createTime;

    private Integer voteSize;

    private String content;

}