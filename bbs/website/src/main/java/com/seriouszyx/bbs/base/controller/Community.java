package com.seriouszyx.bbs.base.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Community {

    @RequestMapping("community.do")
    public String community() {
        return "community/index";
    }

}
