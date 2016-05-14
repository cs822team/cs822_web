package com.suw.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.suw.entity.User;
import com.suw.service.UserService;
import com.suw.util.CookieUtils;
import com.suw.util.Util;

@Controller
public class UserAction{
	@Resource
	private UserService userService;
	@Autowired
	private User user;
	
	private int remember;
	private String returnPath;
	
	
	Map<String, Object> session;
	Map<String, Object> request;
	
	List<User> users;
	public String signup(){
		String message = "";
		initSessionAndRequest();
		user.setCreationDate(new Date());
		user.setPassword(Util.md5Encryption(user.getPassword()));
		userService.saveUser(user);
		session.put("user", user);
		System.out.println(user);
		return "success";
	}
	public String login(){
//		returnPath = returnPath.substring(4);
		System.out.println(returnPath);
		
		initSessionAndRequest();
		user.setPassword(Util.md5Encryption(user.getPassword()));
		user = 	userService.findUser(user);
		System.out.println(remember);
		if(remember==1){
			ServletActionContext.getResponse().addCookie(CookieUtils.addCookie(user.getDisplayName()));
		}
		
		if(user==null){
			return "false";
		}
		if(user.getId()!=0){
			
			session.put("user", user);
			if(null != returnPath && returnPath.indexOf("question")>=0){
				System.out.println("question");
				return "question";
			}
			return "success";
		}
		return "false";
	}
	public String autoLogin(){
		
		String displayName = CookieUtils.getUserNameFromCookie(ServletActionContext.getRequest());
		user = userService.findUserByDisplayName(displayName);
		initSessionAndRequest();
		session.put("user", user);
		session.put("time", 2);
		return "success";
	}
	public String logout(){
		initSessionAndRequest();
		session.remove("user");
		CookieUtils.delCookie(ServletActionContext.getRequest(),ServletActionContext.getResponse());
		return "success";
	}
	public String checkuser(){
		User temp;
		if(user.getPassword()!="" && user.getPassword()!=null){
			temp = userService.findUser(user);
		}else if(user.getDisplayName()!="" && user.getDisplayName()!=null){
			temp = userService.findUserByDisplayName(user.getDisplayName());
		}else{
			temp = userService.findUserByEmail(user.getEmail());
		}
		if(users==null){
			users = new ArrayList<User>();
		}
		if(temp!=null){
			users.add(temp);
		}else{
			temp = new User();
			users.add(temp);
		}
		return "success";
	}

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	private void initSessionAndRequest(){
		session = ActionContext.getContext().getSession(); 
		request = (Map)ActionContext.getContext().get("request");
	}
	public List<User> getUsers() {
		return users;
	}
	public void setUsers(List<User> users) {
		this.users = users;
	}
	
	public String getReturnPath() {
		return returnPath;
	}
	public void setReturnPath(String returnPath) {
		this.returnPath = returnPath;
	}
	public int getRemember() {
		return remember;
	}
	public void setRemember(int remember) {
		this.remember = remember;
	}
	
	
}