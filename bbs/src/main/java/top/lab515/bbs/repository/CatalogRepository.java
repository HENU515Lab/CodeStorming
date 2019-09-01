package top.lab515.bbs.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import top.lab515.bbs.domain.Catalog;
import top.lab515.bbs.domain.User;

import java.util.List;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/9/1 14:30
 * @description：分类仓库
 */
public interface CatalogRepository extends JpaRepository<Catalog, Long> {
    /**
     * 根据用户查询
     *
     * @param user
     * @return
     */
    List<Catalog> findByUser(User user);

    /**
     * 根据用户、分类名称查询
     *
     * @param user
     * @param name
     * @return
     */
    List<Catalog> findByUserAndName(User user, String name);
}