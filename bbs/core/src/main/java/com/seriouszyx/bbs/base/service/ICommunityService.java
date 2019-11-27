package com.seriouszyx.bbs.base.service;

import com.seriouszyx.bbs.base.domain.Community;

import java.util.List;

/**
 * 问答相关服务
 */
public interface ICommunityService {

    /**
     * 按创建时间列出所有问答
     * @return
     */
    List<Community> listAll();

}
