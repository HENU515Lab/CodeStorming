package com.seriouszyx.bbs.base.util;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 专门用于登陆检查的拦截器
 *
 * @author Administrator
 */
public class LoginCheckInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {
        // 判断登陆逻辑
        if (handler instanceof HandlerMethod) {
            HandlerMethod hm = (HandlerMethod) handler;
            RequireLogin rl = hm.getMethodAnnotation(RequireLogin.class);
            if (rl != null && UserContext.getCurrent() == null) {
                response.sendRedirect("/index.do");
                return false;
            }
        }
        return super.preHandle(request, response, handler);
    }

}
