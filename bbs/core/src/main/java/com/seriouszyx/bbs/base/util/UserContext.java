package com.seriouszyx.bbs.base.util;

import com.seriouszyx.bbs.base.domain.Logininfo;
import com.seriouszyx.bbs.base.domain.User;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.request.ServletWebRequest;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
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
	public static final String USER_IN_COOKIE = "logininfo";
	public static final String USER_DETAIL_IN_COOKIE = "user";

	/**
	 * 反向获取request的方法,请查看RequestContextListener.requestInitialized打包过程
	 * 
	 * @return
	 */
	private static HttpSession getSession() {
		return ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest().getSession();
	}

	private static Cookie[] getCookies() {
		return ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest().getCookies();
	}

	/**
	 * 反向获取response并设置cookie
	 * @param cookie
	 */
	private static void setCookie(Cookie cookie) {
		HttpServletResponse resp =
				((ServletWebRequest)RequestContextHolder.getRequestAttributes()).getResponse();
		resp.addCookie(cookie);
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
