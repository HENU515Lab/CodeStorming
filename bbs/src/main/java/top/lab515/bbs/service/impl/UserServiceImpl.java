package top.lab515.bbs.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import top.lab515.bbs.domain.User;
import top.lab515.bbs.repository.UserRepository;
import top.lab515.bbs.service.UserService;

import javax.transaction.Transactional;
import java.util.List;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/8/27 16:06
 * @description：用户服务接口实现
 */
@Service
public class UserServiceImpl implements UserService, UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Transactional
    @Override
    public User saveUser(User user) {
        return userRepository.save(user);
    }

    @Transactional
    @Override
    public void removeUser(Long id) {
        userRepository.deleteById(id);
    }

    @Transactional
    @Override
    public void removeUsersInBatch(List<User> users) {
        userRepository.deleteInBatch(users);
    }

    @Transactional
    @Override
    public User updateUser(User user) {
        return userRepository.save(user);
    }

    @Override
    public User getUserById(Long id) {
        return userRepository.getOne(id);
    }

    @Override
    public List<User> listUsers() {
        return userRepository.findAll();
    }

    @Override
    public Page<User> listUsersByNameLike(String name, Pageable pageable) {
        // 模糊查询
        name = "%" + name + "%";
        Page<User> users = userRepository.findByNameLike(name, pageable);
        return users;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository.findByUsername(username);
    }

}

