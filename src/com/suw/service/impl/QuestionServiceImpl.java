package com.suw.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mysql.jdbc.ResultSet;
import com.suw.dao.BaseDAO;
import com.suw.entity.Question;
import com.suw.entity.RandomQuestion;
import com.suw.service.QuestionService;

@Service("questionService")
public class QuestionServiceImpl implements QuestionService {
	
	@Resource
	private BaseDAO<Question> baseDAO;
	
	@Override
	public List<Question> findListAll(int pageNumber, int limitation){
		return baseDAO.find("from Question question order by question.creationDate desc", new Object[]{}, pageNumber, limitation);
	};
	
	@Override
	public List<Question> findRecommends(int userId,int limitation){
		List<Question> questions;
		if(userId == 0){
//			return baseDAO.find("select new com.suw.entity.Question(questionRandom.id, questionRandom.body,questionRandom.title) from RandomQuestion questionRandom", new Object[]{}, 0, limitation);
			
			questions = baseDAO.find(" from Question q WHERE q.acceptedAnswerId=0 ORDER BY RAND()  ", new Object[]{}, 0, limitation);
			if(questions.size()<limitation){
				List<Question> questions2 = baseDAO.find(" from Question q  ORDER BY RAND()  ", new Object[]{}, 0, limitation-questions.size());
				for(int i=0;i<questions2.size();i++){
					questions.add(questions2.get(i));
				}
			}
			return questions;
		}else{
			questions = baseDAO.find("from Question question where question.id in (select qt.questionId from TargetQuestion qt where qt.targetId in (select tu.targetId from TargetUser tu where tu.userId = ? ))  ORDER BY RAND()", new Object[] {userId},0,limitation);
			if(questions.size()<limitation){
				List<Question> questions2 = baseDAO.find(" from Question q  ORDER BY RAND()  ", new Object[]{}, 0, limitation-questions.size());
				for(int i=0;i<questions2.size();i++){
					questions.add(questions2.get(i));
				}
			}
		}
		
		return questions;
	};
	
	public void save(Question question){
		 baseDAO.save(question);
	};
	
	public Question find(int questionId){
		Question q = baseDAO.get(Question.class, questionId);
		q.setViewCount(q.getViewCount()+1);
		baseDAO.update(q);
		return q;
	};
	
	public List<Question> findHot(int limitation){
		return baseDAO.find("from Question q ORDER BY q.hotValue",new Object[]{}, 0,5);
	};
	
	 @Transactional
	public Question vote(int questionId, int vote){
		Question q = baseDAO.get(Question.class, questionId);
		q.setVote(q.getVote()+vote);
		baseDAO.update(q);
		return q;
	}
}
