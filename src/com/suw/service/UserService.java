package com.suw.service;

import java.util.List;

import com.suw.entity.User;

public interface UserService {

	public void saveUser(User user);
	
	public void updateUser(User user);
	
	public User findUserById(int id);
	
	public void deleteUser(User user);
	
	public List<User> findAllList();
	
	public User findUser(User user);
	
	public User findUserByNameAndPassword(String username, String password);
	
	public User findUserByEmail(String email);
	public User findUserByDisplayName(String displayName);
}
