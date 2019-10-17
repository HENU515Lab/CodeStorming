package com.seriouszyx.bbs.base.controller;

import com.seriouszyx.bbs.base.domain.Activity;
import com.seriouszyx.bbs.base.domain.ActivityContent;
import com.seriouszyx.bbs.base.domain.ActivityContentRecord;
import com.seriouszyx.bbs.base.domain.Logininfo;
import com.seriouszyx.bbs.base.domain.User;
import com.seriouszyx.bbs.base.service.IActivityService;
import com.seriouszyx.bbs.base.util.RequireLogin;
import com.seriouszyx.bbs.base.util.UploadUtil;
import com.seriouszyx.bbs.base.util.UserContext;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class ActivityController {
    @Autowired
    private IActivityService activityService;
    @Autowired
    private ServletContext servletContext;

    public ActivityController() {
    }

    @RequestMapping({"activity"})
    public String activity(Model model) {
        List<Activity> activities = this.activityService.listAll();
        model.addAttribute("activityList", activities);
        return "activity/index";
    }

    @RequestMapping({"activityDetail"})
    public String activityDetail(Long id, Model model) {
        Activity activity = this.activityService.selectById(id);
        Logininfo current = UserContext.getCurrent();
        if (current != null) {
            int result = this.activityService.selectApplyInfo(current.getId(), id);
            model.addAttribute("apply", result);
        }

        model.addAttribute("activity", activity);
        return "activity/detail";
    }

    @RequestMapping({"activityContent"})
    @RequireLogin
    public String activityContent(Long id, Model model) {
        Activity activity = this.activityService.selectWithContent(id);
        model.addAttribute("activity", activity);
        int result = this.activityService.selectApplyInfo(UserContext.getCurrent().getId(), id);
        if (result == 0) {
            model.addAttribute("error_message", "您未报名该活动！");
            return "redirect:/activityDetail.do?id=" + id;
        } else {
            model.addAttribute("apply", result);
            return "activity/content";
        }
    }

    @RequestMapping({"activityApply"})
    @RequireLogin
    public String activityApply(Long id) {
        Long userId = UserContext.getCurrent().getId();
        int result = this.activityService.selectApplyInfo(userId, id);
        if (result == 0) {
            this.activityService.applyActivity(userId, id);
        }

        return "redirect:/activityDetail.do?id=" + id;
    }

    @RequestMapping({"toUploadActivity"})
    @RequireLogin
    public String upload(Long id, Model model) {
        ActivityContent activityContent = this.activityService.selectActivityContent(id);
        model.addAttribute("activityContent", activityContent);
        return "activity/upload";
    }

    @RequestMapping({"/uploadActivityFile"})
    @ResponseBody
    public Map<String, String> uploadActivityFile(HttpServletRequest request, HttpServletResponse response, @RequestParam("file") MultipartFile file, Long id) throws IOException {
        Map<String, String> result = new HashMap();
        result.put("error_message", "success");
        User currentUser = UserContext.getCurrentUser();
        String basePath = this.servletContext.getRealPath("/upload");
        ActivityContentRecord activityContentRecord = this.activityService.selectActivityContentRecord(currentUser.getId(), id);
        String fileName;
        if (activityContentRecord == null) {
            fileName = UploadUtil.upload(file, basePath);
            fileName = "/upload/" + fileName;
            result.put("path", fileName);
            this.activityService.insertActivityContentRecord(currentUser.getId(), id, fileName);
        } else {
            UploadUtil.delete(activityContentRecord.getFilePath(), this.servletContext.getRealPath("/upload"));
            fileName = UploadUtil.upload(file, basePath);
            fileName = "/upload/" + fileName;
            result.put("path", fileName);
            this.activityService.updateActivityContentRecord(currentUser.getId(), id, fileName);
        }

        return result;
    }

    @RequestMapping({"activityRecord"})
    public String activityRecord(Long id, Model model) {
        Logininfo current = UserContext.getCurrent();
        if (current != null) {
            int result = this.activityService.selectApplyInfo(current.getId(), id);
            model.addAttribute("apply", result);
        }

        Activity activity = this.activityService.selectById(id);
        List<ActivityContentRecord> activityContentRecords = this.activityService.selectRecordList(id);
        model.addAttribute("activityContentRecordList", activityContentRecords);
        model.addAttribute("activity", activity);
        return "activity/record";
    }
}
