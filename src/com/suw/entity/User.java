package com.suw.entity;

import java.util.Date;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;
import org.springframework.stereotype.Component;
@Component 
@Entity
@Table(name="user")
public class User {
//	Id	Reputation	CreationDate	DisplayName	LastAccessDate	Location	Views	UpVotes	DownVotes	Age
	private int id;
	private int reputation;
	private int reputationByReport;
	private int reputationByAnswer;
	private Date creationDate;
	private Date lastAccessDate;
	private String displayName;
	private String location;
	private String email;
	private String password;
	
	
	private int view;
	private int upVote;
	private int downVote;
	private int age;
	private int acceptAnswerCount;
	private String tags;
	private String tagId;
	private int type;
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="id",unique=true,nullable=false)
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	@Column(name="reputation")
	public int getReputation() {
		return reputation;
	}
	public void setReputation(int reputation) {
		this.reputation = reputation;
	}
	
	@Column(name="reputation_by_report")
	public int getReputationByReport() {
		return reputationByReport;
	}
	public void setReputationByReport(int reputationByReport) {
		this.reputationByReport = reputationByReport;
	}
	
	@Column(name="reputation_by_answer")
	public int getReputationByAnswer() {
		return reputationByAnswer;
	}
	public void setReputationByAnswer(int reputationByAnswer) {
		this.reputationByAnswer = reputationByAnswer;
	}
	
	@Column(name="display_name",length=20)
	public String getDisplayName() {
		return displayName;
	}
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}
	
	@Column(name="email",length=100)
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	@Column(name="password",length=100)
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	@Column(name="last_access_date")
	public Date getLastAccessDate() {
		return lastAccessDate;
	}
	public void setLastAccessDate(Date lastAccessDate) {
		this.lastAccessDate = lastAccessDate;
	}
	
	@Column(name="location",length=100)
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	
	@Column(name="view")
	public int getView() {
		return view;
	}
	public void setView(int view) {
		this.view = view;
	}
	
	@Column(name="up_vote")
	public int getUpVote() {
		return upVote;
	}
	public void setUpVote(int upVote) {
		this.upVote = upVote;
	}
	
	@Column(name="down_vote")
	public int getDownVote() {
		return downVote;
	}
	public void setDownVote(int downVote) {
		this.downVote = downVote;
	}
	
	@Column(name="age",length=3)
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	
	@Column(name="accept_answer_count")
	public int getAcceptAnswerCount() {
		return acceptAnswerCount;
	}
	public void setAcceptAnswerCount(int acceptAnswerCount) {
		this.acceptAnswerCount = acceptAnswerCount;
	}
	
	@Column(name="tags")
	public String getTags() {
		return tags;
	}
	public void setTags(String tags) {
		this.tags = tags;
	}
	
	@Column(name="tag_id")
	public String getTagId() {
		return tagId;
	}
	public void setTagId(String tagId) {
		this.tagId = tagId;
	}
	
	@Column(name="type",length=1)
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	
	@Temporal(TemporalType.DATE)
	@Column(name="creation_date")
	public Date getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", reputation=" + reputation + ", reputationByReport=" + reputationByReport
				+ ", reputationByAnswer=" + reputationByAnswer + ", creationDate=" + creationDate + ", lastAccessDate="
				+ lastAccessDate + ", displayName=" + displayName + ", location=" + location + ", email=" + email
				+ ", password=" + password + ", view=" + view + ", upVote=" + upVote + ", downVote=" + downVote
				+ ", age=" + age + ", acceptAnswerCount=" + acceptAnswerCount + ", tags=" + tags + ", tagId=" + tagId
				+ ", type=" + type + "]";
	}
	
	

	
}
