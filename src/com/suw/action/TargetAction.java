package com.suw.action;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.suw.entity.Target;
import com.suw.service.TargetService;

@Controller
public class TargetAction{
	@Resource
	private TargetService targetService;
	
	private String tags;
	
	Map<String, Object> session;
	Map<String, Object> request;
	
	List<Target> targets;
	
	public String hotTargets(){
		targets = targetService.findHotTargets();
		return "success";
	}
	
	public String matchTargets(){
		if(null == tags || tags.replace(",", "").trim()==""){
			hotTargets();
		}else{
			targets = targetService.findMatchTargets(tags);
		}
		
		return "success";
	}
	
	
	private void initSessionAndRequest(){
		session = ActionContext.getContext().getSession(); 
		request = (Map)ActionContext.getContext().get("request");
	}
	public List<Target> getTargets() {
		return targets;
	}
	public void setTargets(List<Target> targets) {
		this.targets = targets;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}
	
	
	
}