package top.lab515.bbs.service;

import top.lab515.bbs.domain.Authority;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/8/27 16:41
 * @description：Authority 服务接口
 */
public interface AuthorityService {

    /**
     * 根据id获取 Authority
     * @param id
     * @return
     */
    Authority getAuthorityById(Long id);

}
