package com.suw.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.hibernate.annotations.GeneratorType;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;
import org.springframework.stereotype.Component;
@Component 
@Entity
@Table(name="question")
public class Question {
//	idPosts	Id	PostTypeId	AcceptedAnswerId	ParentID	CreationDate	
//	Score	ViewCount	Body	OwnerUserId	Title	Tags	AnswerCount	
//	CommentCount												
	private int id;
	private int idPosts;
	private int postTypeId;
	private int acceptedAnswerId;
//	private int parentID;
	private Date creationDate;
	private int score;
	private int viewCount;
	private String  body;
	private int ownerUserId;
	private String title;
	private String tags;
	private int answerCount;
	private int commentCount;
	private int hotValue;
	private int vote;
	
	
	private List<Comment> comments;
	private List<Answer> answers;
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="qr_id",unique=true,nullable=false)
	public int getId() {
		return id;
	}
	@Column(name="id_posts")
	public int getIdPosts() {
		return idPosts;
	}
	@Column(name="post_type_id")
	public int getPostTypeId() {
		return postTypeId;
	}
	@Column(name="accept_answer_id")
	public int getAcceptedAnswerId() {
		return acceptedAnswerId;
	}
	@Temporal(TemporalType.DATE)
	@Column(name="creation_date")
	public Date getCreationDate() {
		return creationDate;
	}
	@Column(name="score")
	public int getScore() {
		return score;
	}
	@Column(name="view_count")
	public int getViewCount() {
		return viewCount;
	}
	@Lob
	@Basic(fetch = FetchType.LAZY) 
	@Type(type="text")
	@Column(name="body")
	public String  getBody() {
		return body;
	}
	@Column(name="owner_user_id")
	public int getOwnerUserId() {
		return ownerUserId;
	}
	@Column(name="title")
	public String getTitle() {
		return title;
	}
	@Column(name="tags")
	public String getTags() {
		return tags;
	}
	@Column(name="answer_count")
	public int getAnswerCount() {
		return answerCount;
	}
	@Column(name="comment_count")
	public int getCommentCount() {
		return commentCount;
	}
	@Column(name="hot_value")
	public int getHotValue() {
		return hotValue;
	}
	@Column(name="vote_number")
	public int getVote() {
		return vote;
	}
	public void setVote(int vote) {
		this.vote = vote;
	}
	public void setHotValue(int hotValue) {
		this.hotValue = hotValue;
	}
	public void setId(int id) {
		this.id = id;
	}
	public void setId(String id) {
		this.id = Integer.parseInt(id);
	}
	public void setIdPosts(int idPosts) {
		this.idPosts = idPosts;
	}
	public void setPostTypeId(int postTypeId) {
		this.postTypeId = postTypeId;
	}
	public void setAcceptedAnswerId(int acceptedAnswerId) {
		this.acceptedAnswerId = acceptedAnswerId;
	}
	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public void setBody(String  body) {
		this.body = body;
	}
	public void setOwnerUserId(int ownerUserId) {
		this.ownerUserId = ownerUserId;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setTags(String tags) {
		this.tags = tags;
	}
	public void setAnswerCount(int answerCount) {
		this.answerCount = answerCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	public Question(int id, int idPosts, int postTypeId, int acceptedAnswerId, Date creationDate, int score,
			int viewCount, String body, int ownerUserId, String title, String tags, int answerCount, int commentCount) {
		super();
		this.id = id;
		this.idPosts = idPosts;
		this.postTypeId = postTypeId;
		this.acceptedAnswerId = acceptedAnswerId;
		this.creationDate = creationDate;
		this.score = score;
		this.viewCount = viewCount;
		this.body = body;
		this.ownerUserId = ownerUserId;
		this.title = title;
		this.tags = tags;
		this.answerCount = answerCount;
		this.commentCount = commentCount;
	}
	
	public Question(int id,String body,String title) {
		
		this.id = id;
		this.body = body;
		this.title = title;
	}
	
	
	public Question() {
		
	}
	
	@Transient 
	public List<Comment> getComments() {
		return comments;
	}
	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}
	@Transient 
	public List<Answer> getAnswers() {
		return answers;
	}
	public void setAnswers(List<Answer> answers) {
		this.answers = answers;
	}
	
	
	
	
}
