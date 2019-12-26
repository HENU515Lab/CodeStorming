package com.seriouszyx.bbs.base.domain;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class Blog {
    private Long id;
    private String title;
    private String keywords;
    private String content;
//    private Long authorId;
    private int commentSize;
    private Date createTime;
    private int readSize;
    private int voteSize;
    private int weight;
    private int blogType;

    private User author;

    private List<BlogComment> comments;


}
