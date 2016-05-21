package com.suw.service.impl;

import java.util.ArrayList;
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

	@Override
	public Target findTargetsByName(String tagName,int type) {
		Target t = baseDAO.get("from Target t where t.name = ?",new Object[] { tagName});
		if(type==1 && null == t){
			t = new Target();
			t.setName(tagName);
			baseDAO.save(t);
		}
		return t;
	}

	@Override
	public List<Target> findMatchTargets(String tags) {
		String[] split = tags.split(",");
		List<Object> tagsList = new ArrayList<Object>();
		StringBuffer hql = new StringBuffer("from Target t where");
		for(int i=0;i<split.length;i++){
			tagsList.add(split[i]);
			hql.append(" t.name like ? or");
		}
		int length = hql.length();
		if(hql.indexOf("or", length-2)>0){
			hql.delete(length-2, length);
		}
		
		return baseDAO.find(hql.toString(), tagsList, 0, 30, "search");
	}

	
}
