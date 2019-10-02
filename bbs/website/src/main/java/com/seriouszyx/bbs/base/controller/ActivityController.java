package com.seriouszyx.bbs.base.controller;

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

    @RequestMapping("activity")
    public String activity(Model model) {
        List<Activity> activities = activityService.listAll();
        model.addAttribute("activityList", activities);

        return "activity/index";
    }

    @RequestMapping("activityDetail")
    public String activityDetail(Long id, Model model) {
        Activity activity = activityService.selectById(id);
        model.addAttribute("activity", activity);
        return "activity/detail";
    }

    @RequestMapping("activityContent")
    public String activityContent(Long id, Model model) {
        Activity activity = activityService.selectWithContent(id);
        model.addAttribute("activity", activity);
        return "activity/content";
    }

}
