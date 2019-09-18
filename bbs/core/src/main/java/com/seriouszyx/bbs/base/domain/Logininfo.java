package com.seriouszyx.bbs.base.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

/**
 * 用户登陆信息
 *
 * 
 */
@Data
public class Logininfo extends BaseDomain {

	public static final int STATE_NORMAL = 0;// 正常
	public static final int STATE_LOCK = 1;// 锁定

	public static final int USER_MANAGER = 0;// 后台用户
	public static final int USER_CLIENT = 1;// 前台用户

	private Long id;
	private String username;
	private String password;
	private String email;
	private int state;
	private int userType;
}
