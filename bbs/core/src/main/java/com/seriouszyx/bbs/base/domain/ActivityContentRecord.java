package com.seriouszyx.bbs.base.domain;

import lombok.Data;

import java.util.Date;

@Data
public class ActivityContentRecord {
    private Long id;

    private ActivityContent activityContent;

    private User user;

    private Date createTime;

    private String filePath;






}
