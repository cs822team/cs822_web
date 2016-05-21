package com.suw.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.suw.dao.BaseDAO;
import com.suw.entity.Answer;
import com.suw.entity.Comment;
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

	@Override
	@Transactional
	public Answer vote(int answerid, int voteValue) {
		Answer answer = baseDAO.get(Answer.class, answerid);
		answer.setVote(answer.getVote()+voteValue);
		baseDAO.update(answer);
		return answer;
	}

	@Override
	public Answer update(int id,String body) {
		Answer answer = baseDAO.get(Answer.class, id);
		answer.setBody(body);
//		baseDAO.update(answer);
		return answer;
	}

	@Override
	public Answer get(int answerId) {
		return baseDAO.get(Answer.class, answerId);
	}
	
}
