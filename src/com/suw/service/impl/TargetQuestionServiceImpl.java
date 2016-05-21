package com.suw.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.suw.dao.BaseDAO;
import com.suw.entity.TargetQuestion;
import com.suw.service.TargetQuestionService;
import com.suw.service.TargetService;

@Service("targetQuestionService")
public class TargetQuestionServiceImpl implements TargetQuestionService {
	
	@Resource
	private BaseDAO<TargetQuestion> baseDAO;

	@Override
	public void save(TargetQuestion t) {
		baseDAO.save(t);
	}



	
}
