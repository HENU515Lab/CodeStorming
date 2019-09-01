package top.lab515.bbs.vo;

import top.lab515.bbs.domain.Catalog;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/9/1 16:30
 * @description：
 */
public class CatalogVO {

    private String username;
    private Catalog catalog;

    public CatalogVO() {
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Catalog getCatalog() {
        return catalog;
    }

    public void setCatalog(Catalog catalog) {
        this.catalog = catalog;
    }

}
