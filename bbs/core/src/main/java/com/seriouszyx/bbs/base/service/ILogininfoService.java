package com.seriouszyx.bbs.base.service;

import com.seriouszyx.bbs.base.domain.Logininfo;

/**
 * 登陆相关服务
 *
 * 
 */
public interface ILogininfoService {

	/**
	 * 用户注册
	 * 
	 * @param username
	 * @param password
	 */
	void register(String username, String password, String email, String activeCode);

	/**
	 * 检查用户名是否存在 如果存在,返回true 如果不存在,返回false
	 * 
	 * @param username
	 * @return
	 */
	boolean checkUsername(String username);

	/**
	 * 用户登陆
	 * 
	 * @param username
	 * @param password
	 * @return
	 */
	Logininfo login(String username, String password);

	/**
	 * 检查当前用户与所给密码是否一致
	 * @param password
	 * @return
	 */
	boolean checkPassword(String password);

	/**
	 * 更新密码
	 * @param password
	 */
	void updatePassword(String password);

}
