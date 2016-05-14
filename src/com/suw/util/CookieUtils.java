package com.suw.util;  
  
import javax.servlet.http.Cookie;  
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;  
  
  
  
/** 
 * cookie的增加、删除、查询 
 */  
public class CookieUtils {  
    public static final String USER_COOKIE = "user.cookie";  
  
    // 添加一个cookie  
    public static Cookie addCookie(String displayName) {  
        Cookie cookie = new Cookie(USER_COOKIE, displayName);  
        cookie.setMaxAge(60 * 60 * 24 * 7);// cookie保存两周  
        return cookie;  
    }  
  
    // 得到cookie  
    public static String getUserNameFromCookie(HttpServletRequest request) {
    	String name = null;
        Cookie[] cookies = request.getCookies();  
        if (cookies != null) {  
            for (Cookie cookie : cookies) {  
                if (CookieUtils.USER_COOKIE.equals(cookie.getName())) {  
                    	name = cookie.getValue();  
                    }  
                }  
            }  
        return name;  
    }  
  
    // 删除cookie  
    public static void delCookie(HttpServletRequest request,HttpServletResponse response) {  
        Cookie[] cookies = request.getCookies();  
        if (cookies != null) {  
            for (Cookie cookie : cookies) {  
                if (USER_COOKIE.equals(cookie.getName())) {  
                    cookie.setValue("");  
                    cookie.setMaxAge(0);  
                    response.addCookie(cookie);
                }  
            }  
        }  
    }  
}