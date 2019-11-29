package com.seriouszyx.bbs.base.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ApplicationController {

    @RequestMapping("application")
    public String toApplicationIndex() {
        return "application/index";
    }

    @RequestMapping("training")
    public String training() {
        return "application/training";
    }

    @RequestMapping("application-intro")
    public String applicationIntroduction() {
        return "application/application-intro";
    }

}
