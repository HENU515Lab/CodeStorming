package com.seriouszyx.bbs.base.domain;

import lombok.Data;

@Data
public class CommunityVoteRecord {
    private Long id;

    private Long cid;

    private Long caid;

    private Long uid;

    private int offset;
}