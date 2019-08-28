package top.lab515.bbs.vo;

import java.io.Serializable;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/8/27 16:12
 * @description：菜单值 对象
 */
public class Menu implements Serializable {

    private static final long serialVersionUID = 1L;

    private String name;
    private String url;

    public Menu(String name, String url) {
        this.name = name;
        this.url = url;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getUrl() {
        return url;
    }
    public void setUrl(String url) {
        this.url = url;
    }
}
