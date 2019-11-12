package com.seriouszyx.bbs.base.domain;

import lombok.Data;

@Data
public class User {
    private Long id;

    private String truename;

    private String avatar;

    private String grade;

    private String introduce;

    private String username;

    private String email;

    private int visitors;

}