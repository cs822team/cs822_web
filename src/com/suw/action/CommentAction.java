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
public class CommentAction {
	@Resource
	private CommentService commentService;
	@Autowired
	private Comment comment;
	
	private int questionId;
	
	
	
	Map<String, Object> session;
	Map<String, Object> request;
	
	
	private int voteValue;
	
	public int getVoteValue() {
		return voteValue;
	}

	public void setVoteValue(int voteValue) {
		this.voteValue = voteValue;
	}
	
	public String add(){
		if(null==comment){
			return "false";
		}
		initSessionAndRequest();
		User user = (User) session.get("user");
		if(null == user){
			return "false";
		}
		comment.setUserId(user.getId());
		comment.setPostId(questionId);
		comment.setCreationDate(new Date());
		commentService.addComment(comment);
		return "success";
	}
	
	
	
	private void initSessionAndRequest(){
		session = ActionContext.getContext().getSession(); 
		request = (Map)ActionContext.getContext().get("request");
	}

	public Comment getComment() {
		return comment;
	}
	public void setComment(Comment comment) {
		this.comment = comment;
	}


	public int getQuestionId() {
		return questionId;
	}
	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}

	
}
