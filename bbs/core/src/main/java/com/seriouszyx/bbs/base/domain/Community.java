package com.seriouszyx.bbs.base.domain;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class Community {
    private Long id;

    private String title;

    private Integer voteSize;

    private Integer answerSize;

    private Integer readSize;

    private User asker;

    private Date createTime;

    private String labels;

    private Integer solve;

    private String content;

    private List<CommunityAnswer> answers;

    private List<CommunityComment> communityCommentList;
}