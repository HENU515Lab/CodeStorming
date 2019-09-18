package com.seriouszyx.bbs.base.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Activity {

    @RequestMapping("activity")
    public String activity() {
        return "activity/index";
    }

}
