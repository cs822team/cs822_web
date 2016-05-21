package com.suw.service;

import java.util.List;

import com.suw.entity.Target;

public interface TargetService {

	public List<Target> findHotTargets();
	
	public Target findTargetsByName(String tagName,int type);

	public List<Target> findMatchTargets(String tags);
	
}
