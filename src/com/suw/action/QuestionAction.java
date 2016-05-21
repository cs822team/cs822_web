package com.suw.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.sockjs.transport.handler.SockJsWebSocketHandler;

import com.opensymphony.xwork2.ActionContext;
import com.suw.entity.Answer;
import com.suw.entity.Comment;
import com.suw.entity.Favourite;
import com.suw.entity.Question;
import com.suw.entity.Target;
import com.suw.entity.TargetQuestion;
import com.suw.entity.User;
import com.suw.service.AnswerService;
import com.suw.service.CommentService;
import com.suw.service.FavouriteService;
import com.suw.service.QuestionService;
import com.suw.service.TargetQuestionService;
import com.suw.service.TargetService;
import com.suw.service.UserService;
import com.suw.util.Util;

@Controller
public class QuestionAction {
	@Resource
	private QuestionService questionService;
	@Resource
	private CommentService commentService;
	@Resource
	private AnswerService answerService;
	@Resource
	private UserService userService;
	@Resource
	private TargetService targetService;
	@Resource
	private TargetQuestionService targetQuestionService;
	@Resource
	private FavouriteService favouriteService;
	@Autowired
	private Question question;
	@Autowired
	private Comment comment;
	@Autowired
	private Answer answer;
	@Autowired
	private Favourite favourite;
	
	
	private int currentPage;
	private int limit;
	private int voteValue;
	private boolean fa;
	
	public int getVoteValue() {
		return voteValue;
	}

	public void setVoteValue(int voteValue) {
		this.voteValue = voteValue;
	}
	Map<String, Object> session;
	Map<String, Object> request;
	
	List<Question> questions;
	
//	normal
	public String scan(){
		if(null == question){
			return "false";
		}
		question = questionService.find(question.getId());
		question.setComments(commentService.findCommentsByQuestionId(question.getId()));
		question.setAnswers(answerService.findAnswersByQuestionId(question.getId()));
		for(int i=0;i<question.getComments().size();i++){
			User user = userService.findUserById(question.getComments().get(i).getUserId());
			if(null ==user){
				question.getComments().get(i).setDisplayName("null");
			}else{
				question.getComments().get(i).setDisplayName(user.getDisplayName());
			}
		}
		for(int i=0;i<question.getAnswers().size();i++){
			User user = userService.findUserById(question.getAnswers().get(i).getOwnerUserId());
			question.getAnswers().get(i).setDisplayName(user.getDisplayName());
			question.getAnswers().get(i).setComents(commentService.findCommentsByQuestionId(question.getAnswers().get(i).getId()));
			for(int j=0;j<question.getAnswers().get(i).getComents().size();j++){
				User user2 = userService.findUserById(question.getAnswers().get(i).getComents().get(i).getUserId());
				if(user2==null){
					question.getAnswers().get(i).getComents().get(i).setDisplayName("null");
				}else{
					question.getAnswers().get(i).getComents().get(i).setDisplayName(user2.getDisplayName());
				}
				
			}
		}
		if(question.getAcceptedAnswerId()!=0){
			boolean flag = false;
			for(int i=1;i<question.getAnswers().size();i++){
				if(question.getAnswers().get(i).getId()==question.getAcceptedAnswerId()){
					question.getAnswers().add(0, question.getAnswers().get(i));
					question.getAnswers().remove(i+1);
					flag=true;
				}
				if(flag){
					break;
				}
			}
		}
		
		initSessionAndRequest();
		User user = (User) session.get("user");
		if(null == user){
			fa = false;
		}else{
			if(null != favouriteService.get(user.getId(), question.getId())){
				fa=true;
			}else{
				fa = false;
			}
		}
		
		request.put("question", question);
		return "success";
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
		initSessionAndRequest();
		User user = (User) session.get("user");
		if(null == user){
			return "success";
		}
		question.setCreationDate(new Date());
//		question.setOwnerUserId(user.getId());
		String tags = question.getTags().trim();
		String replace = tags.replace(",", "><");
		
		question.setTags("<"+replace+">");
		String body = question.getBody();
		
		
		body = body.replace("#/light#", "</code>");
		body = body.replace("#light#", "<code>");
		body = body.replace("#code#", "<code><pre>");
		body = body.replace("#/code#", "</code></pre>");
		body = body.replace("#", "</code></pre>");
		body = body.replace("#/code#", "</code></pre>");
		body = body.replace("<div>", "<p>");
		body = body.replace("</div>", "</p>");
//		body = body.replace("<>", "");
		question.setBody(body);
		
		questionService.save(question);
		
//		find tagrt's id
		String[] tagsList = tags.split(",");
		List<Target> list = new ArrayList<Target>();
		for(int i=0;i<tagsList.length;i++){
			if(tagsList[i]!=""){
				list.add(targetService.findTargetsByName(tagsList[i],1));
			}
		}
		
//		insert data into question_target table
		for(int i=0;i<list.size();i++){
			targetQuestionService.save(new TargetQuestion(list.get(i).getId(),question.getId()));
		}
		
		
		return "success";
	}
	
	public String search(){
		question.setTitle(question.getBody());
		if(null!=question && null!=question.getTags() && question.getTags().length()<=2){
			question.setTags("");
		}
		List<Question> questions = questionService.search(question, currentPage);
		
//			if(q.getBody().length()>600){	
//				String body = q.getBody().substring(0, 601);
//				List<String> tags = new ArrayList<String>();
//				for(int i=0;i<600;i++){
//					if(body.charAt(i)=='<'){
//						StringBuffer sb = new StringBuffer();
//						sb.append(body.charAt(i));
//						i+=1;
//						while(body.charAt(i)!='>' && i<600){
//							sb.append(body.charAt(i));
//							i++;
//						}
//						if(i==599){
//							break;
//						}
//						sb.append(body.charAt(i));
//						if(sb.indexOf("/")>0 ){
//							if(tags.size()!=0){
//								tags.remove(tags.size()-1);
//							}
//						}else{
//							tags.add(sb.toString());
//						}
//						for (String s : tags) {
//							System.out.print(s+"  ");
//						}
//					}
//				}
//				for (int i=tags.size()-1;i>=0;i--){
//					if(tags.get(i).toLowerCase().indexOf("br")!=-1){
//						body += tags.get(i).replace("<", "</");
//					}
//				}
//				q.setBody(body+"<code>This question is too long, please click the title to read the detail......<code>");
//			}
		initSessionAndRequest();
		request.put("questions", questions);
		return "success";
	}
	
//	ajax
	public String all(){
		questions = questionService.findListAll(currentPage, 16);
		return "success";
	}
	
	public String favourite(){
		favouriteService.save(favourite);
		return "success";
	}
	public String unfavourite(){
		favouriteService.delete(favourite.getUserId(),favourite.getQuestionId());
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

	public Favourite getFavourite() {
		return favourite;
	}

	public void setFavourite(Favourite favourite) {
		this.favourite = favourite;
	}

	public boolean getFa() {
		return fa;
	}
	
	
	
	
}
