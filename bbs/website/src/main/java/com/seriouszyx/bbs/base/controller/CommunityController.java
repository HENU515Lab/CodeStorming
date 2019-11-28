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

    @RequireLogin
    @RequestMapping("addCommunity")
    public String addCommunity(String id) {
        return "community/addCommunity";
    }

    @RequestMapping("communityContent")
    public String communityContent(Long id, Model model) {
        Community community = communityService.listById(id);
        community.setContent(community.getContent().trim());
        model.addAttribute("community", community);
        return "community/content";
    }

}
