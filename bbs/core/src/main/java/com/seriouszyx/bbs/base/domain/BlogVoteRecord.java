package com.seriouszyx.bbs.base.domain;

import lombok.Data;

@Data
public class BlogVoteRecord {
    private Long id;

    private Long bid;

    private Long uid;

    private int offset;

}