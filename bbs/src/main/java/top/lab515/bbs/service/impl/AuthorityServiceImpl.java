package top.lab515.bbs.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.lab515.bbs.domain.Authority;
import top.lab515.bbs.repository.AuthorityRepository;
import top.lab515.bbs.service.AuthorityService;

import java.util.Optional;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/8/27 16:42
 * @description：Authority 服务
 */
@Service
public class AuthorityServiceImpl implements AuthorityService {

    @Autowired
    private AuthorityRepository authorityRepository;

    @Override
    public Optional<Authority> getAuthorityById(Long id) {
        return authorityRepository.findById(id);
    }
}

