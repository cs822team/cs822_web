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

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;
import org.springframework.stereotype.Component;
@Component
@Entity
@Table(name="answer")
public class Answer {
//	idPosts	Id	PostTypeId	AcceptedAnswerId	ParentID	CreationDate	
//	Score	ViewCount	Body	OwnerUserId	Title	Tags	AnswerCount	
//	CommentCount												
	private int id;
	private int idPosts;
	private int postTypeId;
	private int parentID;
	private Date creationDate;
	private int score;
	private String  body;
	private int ownerUserId;
	private int commentCount;
	private int vote;
	
	
	private List<Comment> coments;
	private String displayName;
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="id",unique=true,nullable=false)
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
	@Temporal(TemporalType.DATE)
	@Column(name="creation_date")
	public Date getCreationDate() {
		return creationDate;
	}
	@Column(name="score")
	public int getScore() {
		return score;
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
	@Column(name="comment_count")
	public int getCommentCount() {
		return commentCount;
	}
	@Column(name="parent_id")
	public int getParentID() {
		return parentID;
	}
	@Column(name="vote")
	public int getVote() {
		return vote;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	public void setIdPosts(int idPosts) {
		this.idPosts = idPosts;
	}
	public void setPostTypeId(int postTypeId) {
		this.postTypeId = postTypeId;
	}
	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public void setBody(String  body) {
		this.body = body;
	}
	public void setOwnerUserId(int ownerUserId) {
		this.ownerUserId = ownerUserId;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	
	public void setParentID(int parentID) {
		this.parentID = parentID;
	}
	@Transient 
	public List<Comment> getComents() {
		return coments;
	}
	public void setComents(List<Comment> coments) {
		this.coments = coments;
	}
	@Transient 
	public String getDisplayName() {
		return displayName;
	}
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}
	public void setVote(int vote) {
		this.vote = vote;
	}
	
	
	
	
}
