package com.suw.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.suw.dao.BaseDAO;
import com.suw.entity.Target;
import com.suw.service.TargetService;

@Service("targetService")
public class TargetServiceImpl implements TargetService {
	
	@Resource
	private BaseDAO<Target> baseDAO;

	@Override
	public List<Target> findHotTargets() {
		return baseDAO.find("select new com.suw.entity.Target(ht.id, ht.name) from HotTarget ht");
	}

	
}
