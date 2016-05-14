package com.suw.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.suw.dao.BaseDAO;
import com.suw.entity.Answer;
import com.suw.service.AnswerService;

@Service("answerService")
public class AnswerServiceImpl implements AnswerService {
	
	@Resource
	private BaseDAO<Answer> baseDAO;

	@Override
	public List<Answer> findAnswersByQuestionId(int questionId) {
		return baseDAO.find("from Answer ans where ans.parentID = ?",new Object[]{questionId});
	}

	@Override
	public void addAnswer(Answer answer) {
		baseDAO.save(answer);
	}

	
}
