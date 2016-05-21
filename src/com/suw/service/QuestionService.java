package com.suw.service;

import java.util.List;

import com.suw.entity.Question;

public interface QuestionService {

	public List<Question> findListAll(int pageNumber, int limitation);
	
	public List<Question> findRecommends(int userId,int limitation);
	
	public List<Question> findHot(int limitation);
	
	public Question find(int questionId);
	
	public Question vote(int questionId, int vote);
	
	public void save(Question question);
	
	public List<Question> search(Question question,int currentPage);
}
