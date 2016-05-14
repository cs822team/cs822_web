package com.suw.service;

import java.util.List;

import com.suw.entity.Answer;

public interface AnswerService {
	List<Answer> findAnswersByQuestionId(int questionId);

	void addAnswer(Answer answer);
}
