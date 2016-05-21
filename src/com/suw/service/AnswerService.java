package com.suw.service;

import java.util.List;

import com.suw.entity.Answer;

public interface AnswerService {
	public List<Answer> findAnswersByQuestionId(int questionId);

	public void addAnswer(Answer answer);

	public Answer vote(int answerid, int voteValue);

	public Answer update(int id,String body);
	public Answer get(int answerId);
}
