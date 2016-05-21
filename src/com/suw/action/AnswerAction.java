package com.suw.action;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.suw.entity.Answer;
import com.suw.entity.Comment;
import com.suw.entity.Question;
import com.suw.entity.User;
import com.suw.service.AnswerService;
import com.suw.service.CommentService;
import com.suw.service.QuestionService;

@Controller
public class AnswerAction {
	@Resource
	private AnswerService answerService;
	@Autowired
	private Answer answer;
	@Autowired
	private Question question;
	
	private String returnPath;
	
	Map<String, Object> session;
	Map<String, Object> request;
	
	
	private int voteValue;
	private int answerId;
	
	
	
	public String vote(){
		answer = answerService.vote(answer.getId(), voteValue);
		return "success";
	}
	
	public String update(){
		answer = answerService.update(answerId,answer.getBody());
		return "success";
	}
	
	
	
	private void initSessionAndRequest(){
		session = ActionContext.getContext().getSession(); 
		request = (Map)ActionContext.getContext().get("request");
	}



	public Answer getAnswer() {
		return answer;
	}

	public void setAnswer(Answer answer) {
		this.answer = answer;
	}

	public AnswerService getAnswerService() {
		return answerService;
	}

	public void setAnswerService(AnswerService answerService) {
		this.answerService = answerService;
	}

	public String getReturnPath() {
		return returnPath;
	}

	public void setReturnPath(String returnPath) {
		this.returnPath = returnPath;
	}
	
	public int getVoteValue() {
		return voteValue;
	}

	public void setVoteValue(int voteValue) {
		this.voteValue = voteValue;
	}

	public int getAnswerId() {
		return answerId;
	}

	public void setAnswerId(int answerId) {
		this.answerId = answerId;
	}

	public Question getQuestion() {
		return question;
	}

	public void setQuestion(Question question) {
		this.question = question;
	}
	
	
	
	
}
