package top.lab515.bbs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/8/27 14:50
 * @description：Blog 控制器
 */
@Controller
@RequestMapping("/blogs")
public class BlogController {

    /**
     *
     * @param order
     * @param tag
     * @return
     */
    @GetMapping
    public String listBlogs(@RequestParam(value = "order", required = false, defaultValue = "new") String order,
                            @RequestParam(value = "tag", required = false) Long tag) {
        System.out.print("order:" + order + ";tag:" + tag);
        return "redirect:/index?order=" + order + "&tag=" + tag;
    }

}
