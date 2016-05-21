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

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;
@Entity
@Table(name="target_question")
public class TargetQuestion {
	
	private int id;
	private int targetId;
	private int questionId;
	public TargetQuestion(){
		id=0;
		targetId=0;
		questionId=0;
	}
	@Id
//	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="id",unique=true,nullable=false)
	public int getId() {
		return id;
	}

	@Column(name="target_id")
	public int getTargetId() {
		return targetId;
	}

	public void setTargetId(int targetId) {
		this.targetId = targetId;
	}
	@Column(name="question_id")
	public int getQuestionId() {
		return questionId;
	}

	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}

	public void setId(int id) {
		this.id = id;
	}
	public TargetQuestion(int targetId, int questionId) {
		super();
		this.targetId = targetId;
		this.questionId = questionId;
	}
	
	
	
	
	
	

	
}
