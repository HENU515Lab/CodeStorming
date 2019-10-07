package com.seriouszyx.bbs.base.controller;

import com.seriouszyx.bbs.base.domain.Activity;
import com.seriouszyx.bbs.base.domain.Logininfo;
import com.seriouszyx.bbs.base.service.IActivityService;
import com.seriouszyx.bbs.base.util.RequireLogin;
import com.seriouszyx.bbs.base.util.UserContext;
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
        Logininfo current = UserContext.getCurrent();
        if (current != null) {
            int result = activityService.selectApplyInfo(current.getId(), id);
            model.addAttribute("apply", result);
        }
        model.addAttribute("activity", activity);
        return "activity/detail";
    }

    @RequestMapping("activityContent")
    @RequireLogin
    public String activityContent(Long id, Model model) {
        Activity activity = activityService.selectWithContent(id);
        model.addAttribute("activity", activity);
        int result = activityService.selectApplyInfo(UserContext.getCurrent().getId(), id);

        if (result == 0) {
            // 未报名
            model.addAttribute("error_message", "您未报名该活动！");
            return "redirect:/activityDetail.do?id=" + id;
        } else {
            model.addAttribute("apply", result);
            return "activity/content";
        }

    }

    @RequestMapping("activityApply")
    @RequireLogin
    public String activityApply(Long id) {
        Long userId = UserContext.getCurrent().getId();
        int result = activityService.selectApplyInfo(userId, id);
        if (result == 0) {
            activityService.applyActivity(userId, id);
        }
        return "redirect:/activityDetail.do?id=" + id;
    }

}
