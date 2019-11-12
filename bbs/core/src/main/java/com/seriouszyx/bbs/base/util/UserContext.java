package com.seriouszyx.bbs.base.util;

import com.seriouszyx.bbs.base.domain.Logininfo;
import com.seriouszyx.bbs.base.domain.User;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;

/**
 * 用于存放当前用户的上下文
 * 
 * @author Administrator
 * 
 */
public class UserContext {

	public static final String USER_IN_SESSION = "logininfo";
	public static final String USER_DETAIL_IN_SESSION = "user";
	public static final String VERIFYCODE_IN_SESSION = "verifycode_in_session";

	/**
	 * 反向获取request的方法,请查看RequestContextListener.requestInitialized打包过程
	 * 
	 * @return
	 */
	private static HttpSession getSession() {
		return ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest().getSession();
	}

	public static void putCurrent(Logininfo current) {
		// 得到session,并把current放到session中
		getSession().setAttribute(USER_IN_SESSION, current);
	}

	public static void putCurrentUser(User user) {
		getSession().setAttribute(USER_DETAIL_IN_SESSION, user);
	}

	public static Logininfo getCurrent() {
		return (Logininfo) getSession().getAttribute(USER_IN_SESSION);
	}

	public static User getCurrentUser() {
		return (User) getSession().getAttribute(USER_DETAIL_IN_SESSION);
	}
}
