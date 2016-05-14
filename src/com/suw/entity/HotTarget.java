package com.suw.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import org.springframework.stereotype.Component;
@Component
@Entity
@Table(name="hottarget")
public class HotTarget {
	
	private int id;
	private String name;
	
	@Id
	@Column(name="id",unique=true,nullable=false)
	public int getId() {
		return id;
	}
	@Column(name="name")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setId(int id) {
		this.id = id;
	}

	
	
	

	
}
