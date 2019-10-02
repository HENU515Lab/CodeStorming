package com.seriouszyx.bbs.base.domain;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class Activity {

    private Long id;

    private String title;

    private String surface;

    private String activityAbstract;

    private Integer joinNum;

    private Date startTime;

    private Date endTime;

    private String detail;

    private List<ActivityContent> activityContent;
}