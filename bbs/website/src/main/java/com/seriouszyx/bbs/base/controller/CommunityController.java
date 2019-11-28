package com.seriouszyx.bbs.base.controller;

import com.seriouszyx.bbs.base.domain.Community;
import com.seriouszyx.bbs.base.domain.CommunityAnswer;
import com.seriouszyx.bbs.base.service.ICommunityService;
import com.seriouszyx.bbs.base.util.RequireLogin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class CommunityController {

    @Autowired
    private ICommunityService communityService;


    @RequestMapping("community")
    public String community(Model model) {
        List<Community> communityList = communityService.listAll();
        model.addAttribute("communityList", communityList);
        return "community/index";
    }


    @RequestMapping("communityContent")
    public String communityContent(Long id, Model model) {
        Community community = communityService.listById(id);
        model.addAttribute("community", community);
        return "community/content";
    }

    @RequireLogin
    @RequestMapping("addCommunityComment")
    public String addCommunityComment(Long communityId, String content) {
        communityService.
                addCommunityComment(communityId, content);
        return "redirect:communityContent.do?id=" + communityId;
    }

    @RequireLogin
    @RequestMapping("addCommunityAnswerComment")
    public String addCommunityAnswerComment(Long communityId, Long communityAnswerId, String content) {
        communityService.addCommunityAnswerComment(communityId, communityAnswerId, content);
        return "redirect:communityContent.do?id=" + communityId;
    }


    @RequireLogin
    @RequestMapping("addCommunity")
    public String addCommunity(String id) {
        return "community/addCommunity";
    }

    @RequireLogin
    @RequestMapping("submitCommunity")
    public String submitCommunity(Community community, Model model) {
        if (isNullOrEmpty(community.getTitle()) || isNullOrEmpty(community.getContent())) {
            model.addAttribute("error_message", "发起提问失败！标题或内容不能为空");
        } else {
            try {
                communityService.saveCommunity(community);
            } catch (RuntimeException e) {
                model.addAttribute("error_message", "发起提问失败！");
            }
            return "redirect:community.do";
        }
        return "redirect:addCommunity.do";
    }

    @RequireLogin
    @RequestMapping("addAnswer")
    public String addAnswer(Long id, Model model) {
        Community community = communityService.listById(id);
        model.addAttribute("community", community);
        return "community/answerCommunity";
    }

    @RequireLogin
    @RequestMapping("submitAnswer")
    public String submitAnswer(CommunityAnswer communityAnswer) {
        communityService.saveAnswer(communityAnswer);
        return "redirect:communityContent.do?id=" + communityAnswer.getCommunityId();
    }

    private boolean isNullOrEmpty(String s) {
        return s == null || s.trim().equals("");
    }

}
