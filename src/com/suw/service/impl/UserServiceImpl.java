package com.suw.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.suw.dao.BaseDAO;
import com.suw.entity.User;
import com.suw.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {
	
	@Resource
	private BaseDAO<User> baseDAO;

	@Override
	public void saveUser(User user) {
		baseDAO.save(user);
	}

	@Override
	public void updateUser(User user) {
		baseDAO.update(user);
	}

	@Override
	public User findUserById(int id) {
		return baseDAO.get(User.class, id);
	}

	@Override
	public void deleteUser(User user) {
		baseDAO.delete(user);
	}

	@Override
	public List<User> findAllList() {
		return baseDAO.find(" from User u order by u.createTime");
	}

	@Override
	public User findUserByNameAndPassword(String username, String password) {
		return baseDAO.get(" from User u where u.userName = ? and u.password = ? ", new Object[] { username, password });
	}
	public User findUserByEmail(String email){
		return baseDAO.get(" from User u where u.email = ?  ", new Object[] { email });
	};
	public User findUserByDisplayName(String displayName){;
		return baseDAO.get(" from User u where  u.displayName = ? ", new Object[] { displayName });
	}
	
	
	public User findUser(User user){
		return baseDAO.get(" from User u where ( u.displayName = ? and u.password = ? ) or (u.email = ? and u.password = ? )", new Object[] { user.getDisplayName() , user.getPassword(),user.getEmail() , user.getPassword() });
	};
}
