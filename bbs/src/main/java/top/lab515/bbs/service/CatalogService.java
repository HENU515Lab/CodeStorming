package top.lab515.bbs.service;

import top.lab515.bbs.domain.Catalog;
import top.lab515.bbs.domain.User;

import java.util.List;
import java.util.Optional;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/9/1 14:40
 * @description：分类服务接口
 */
public interface CatalogService {
    /**
     * 保存Catalog
     *
     * @param catalog
     * @return
     */
    Catalog saveCatalog(Catalog catalog);

    /**
     * 删除Catalog
     *
     * @param id
     * @return
     */
    void removeCatalog(Long id);

    /**
     * 根据id获取Catalog
     *
     * @param id
     * @return
     */
    Optional<Catalog> getCatalogById(Long id);

    /**
     * 获取Catalog列表
     *
     * @return
     */
    List<Catalog> listCatalogs();
}