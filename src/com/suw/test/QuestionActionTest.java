package com.suw.test;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
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
import com.suw.service.UserService;

@Controller
public class QuestionActionTest {
	@Resource
	private QuestionService questionService;
	@Resource
	private CommentService commentService;
	@Resource
	private AnswerService answerService;
	@Resource
	private UserService userService;
	@Autowired
	private Question question;
	@Autowired
	private Comment comment;
	@Autowired
	private Answer answer;
	
	
	private int currentPage;
	private int limit;
	private int voteValue;
	
	public int getVoteValue() {
		return voteValue;
	}

	public void setVoteValue(int voteValue) {
		this.voteValue = voteValue;
	}
	Map<String, Object> session;
	Map<String, Object> request;
	
	List<Question> questions;
	
	@Test
	public void scan(){
//		if(null == question){
//			return "false";
//		}
		question = questionService.find(question.getId());
		question.setComments(commentService.findCommentsByQuestionId(question.getId()));
		question.setAnswers(answerService.findAnswersByQuestionId(question.getId()));
		for(int i=0;i<question.getComments().size();i++){
			User user = userService.findUserById(question.getComments().get(i).getUserId());
			question.getComments().get(i).setDisplayName(user.getDisplayName());
		}
		for(int i=0;i<question.getAnswers().size();i++){
			User user = userService.findUserById(question.getAnswers().get(i).getOwnerUserId());
			question.getAnswers().get(i).setDisplayName(user.getDisplayName());
			question.getAnswers().get(i).setComents(commentService.findCommentsByQuestionId(question.getAnswers().get(i).getId()));
			for(int j=0;j<question.getAnswers().get(i).getComents().size();j++){
				User user2 = userService.findUserById(question.getAnswers().get(i).getComents().get(i).getUserId());
				question.getAnswers().get(i).getComents().get(i).setDisplayName(user.getDisplayName());
			}
			
			
		}
		initSessionAndRequest();
		request.put("question", question);
//		return "success";
	}
	
	public String addAnswer(){
		initSessionAndRequest();
		User user = (User) session.get("user");
		if(user == null){
			return "false";
		}
		answer.setCreationDate(new Date());
		answer.setOwnerUserId(user.getId());
		answer.setParentID(question.getId());
		answerService.addAnswer(answer);
		return "success";
	}
	
	public String add(){
		return "success";
	}
	
	
	
//	ajax
	public String all(){
		System.out.println("---------------------------------");
		questions = questionService.findListAll(currentPage, 16);
		return "success";
	}
	
	public String questionsRecommend(){
		initSessionAndRequest();
		User user = (User) session.get("user");
		if(null != user){
			questions = questionService.findRecommends(user.getId(),5);
		}else{
			questions = questionService.findRecommends(0,5);
		}
		return "success";
	}
	
	public String hot(){
		questions = questionService.findHot(5);
		return "success";
	}
	
	public String vote(){
		System.out.println(question.getId());
		System.out.println(voteValue);
		question = questionService.vote(question.getId(), voteValue);
		return "success";
	}
	
	private void initSessionAndRequest(){
		session = ActionContext.getContext().getSession(); 
		request = (Map)ActionContext.getContext().get("request");
	}

	public List<Question> getQuestions() {
		return questions;
	}

	public void setQuestions(List<Question> questions) {
		this.questions = questions;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}
	public Comment getComment() {
		return comment;
	}
	public void setComment(Comment comment) {
		this.comment = comment;
	}
	public Question getQuestion() {
		return question;
	}
	public void setQuestion(Question question) {
		this.question = question;
	}
	public Answer getAnswer() {
		return answer;
	}
	public void setAnswer(Answer answer) {
		this.answer = answer;
	}
	

	
}
