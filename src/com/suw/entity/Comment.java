package com.suw.entity;

import java.util.Date;


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

import org.hibernate.annotations.Type;
import org.springframework.stereotype.Component;
@Component
@Entity
@Table(name="comment")
public class Comment {
//	idPosts	Id	PostTypeId	AcceptedAnswerId	ParentID	CreationDate	
//	Score	ViewCount	Body	OwnerUserId	Title	Tags	AnswerCount	
//	CommentCount												
	private int id;
	private int postId;
	private int score;
	private String text;
	private Date creationDate;
	private int userId;
	
	private String displayName;
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="id",unique=true,nullable=false)
	public int getId() {
		return id;
	}


	
	public void setId(int id) {
		this.id = id;
	}


	@Column(name="post_id")
	public int getPostId() {
		return postId;
	}



	public void setPostId(int postId) {
		this.postId = postId;
	}


	@Column(name="score")
	public int getScore() {
		return score;
	}



	public void setScore(int score) {
		this.score = score;
	}

	@Lob
	@Basic(fetch = FetchType.LAZY) 
	@Type(type="text")
	@Column(name="body")
	public String getText() {
		return text;
	}



	public void setText(String text) {
		this.text = text;
	}


	@Temporal(TemporalType.DATE)
	@Column(name="creation_date")
	public Date getCreationDate() {
		return creationDate;
	}



	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}


	@Column(name="user_id")
	public int getUserId() {
		return userId;
	}



	public void setUserId(int userId) {
		this.userId = userId;
	}



	public Comment() {
		
	}


	@Transient 
	public String getDisplayName() {
		return displayName;
	}



	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}
	
	
	
	
}
