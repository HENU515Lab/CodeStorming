package com.seriouszyx.bbs.base.domain;

import lombok.Data;

@Data
public class ActivityContent {

    private Long id;

    private String title;

    private String activityContentAbstract;

    private Integer finish;

    private Long activityId;

    private String problem;

}