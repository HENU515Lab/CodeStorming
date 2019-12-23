package com.seriouszyx.bbs.back.controller;

import com.seriouszyx.bbs.base.domain.Activity;
import com.seriouszyx.bbs.base.service.IActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class ActivityController {

    @Autowired
    private IActivityService activityService;

    @RequestMapping("toActivityMgr")
    public String toActivityMgr(Model model) {
        List<Activity> activities = activityService.listAll();
        model.addAttribute("activityList", activities);
        return "activity/list";
    }

}
