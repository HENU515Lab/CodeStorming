package com.seriouszyx.bbs.base.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {

    @RequestMapping("index")
    public String index(Model model) {
        model.addAttribute("currentNav", "index");
        return "redirect:https://515.seriouszyx.com";
    }

    @RequestMapping("about")
    public String about(Model model) {
        String content = "## 515lab 是个什么样的社区\n" +
                "\n" +
                "\n" +
                "欢迎来到 515 lab，这里是河南大学计算机与信息工程学院**互联网系统创新开发实验室**的线上论坛，用于实验室技术/资源分享、问题讨论、活动发布等。\n" +
                "\n" +
                "### 愿景\n" +
                "\n" +
                "我们正在构建一个小众社区，大家在这里相互信任，以平等 • 自由 • 奔放的价值观进行分享交流。最终，希望大家能够找到与自己志同道合的伙伴，共同成长。\n" +
                "\n" +
                "### 行为准则\n" +
                "\n" +
                "这里不欢迎冷嘲热讽、阴阳怪气的言论，无论何时**友善都是第一要则**，即使在别人犯错时也请多一些包容。其他方面请参考[《参与者公约》](https://www.contributor-covenant.org/zh-cn/version/1/4/code-of-conduct)。\n" +
                "\n" +
                "### 内容协议\n" +
                "\n" +
                "- 禁止在头像、内容（即使是“干货”）中使用二维码，如果要推广公众号或者拉群请发文本文案\n" +
                "- 宣传自己创建的开源项目不要带推广标签，带上和项目尽量相关的标签就好，宣传自己的开源项目在这里是非常受欢迎的行为\n" +
                "- 请不要过度推广，同一个产品或者服务发布一帖就好，如果是版本更新再发布新帖\n" +
                "\n" +
                "### 源码开放\n" +
                "\n" +
                "本站由实验室最菜的菜鸡 [seriouszyx](https://github.com/seriouszyx) 编写，开源于 [GitHub](https://github.com/HENU515Lab/bbs)，目前仍在开发中。\n" +
                "\n" +
                "如果在使用中发现了任何 bug，欢迎通过下方的联系方式反馈。\n" +
                "\n" +
                "欢迎提出有建设性的 pull request 或 issue，如果在实验室招新结束之前你的 pull request 可以 merge 到主仓库中，那么考核任务对于你来说应该有些多余了。\n" +
                "\n" +
                "### 联系我们\n" +
                "\n" +
                "如有重要问题或网站紧急事件，请以 674965440@qq.com 联系我们。\n" +
                "\n";
        model.addAttribute("content", content);
        return "common/about";
    }

}
