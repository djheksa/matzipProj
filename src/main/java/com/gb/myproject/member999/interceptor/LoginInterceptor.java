package com.gb.myproject.member999.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		if(session.getAttribute("member")==null) {
			session.invalidate();
			System.out.println("인터셉터 조건식들어옴");
			response.sendRedirect(request.getContextPath()+ "/index?login=do");
			return false;
		}else {
			return true;
		}
	}
}
