package com.suw.test;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.suw.entity.Question;
import com.suw.entity.Target;
import com.suw.entity.User;
import com.suw.service.QuestionService;
import com.suw.service.TargetService;
import com.suw.service.UserService;
import com.suw.util.Util;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
    "classpath:applicationContext.xml"
})
public class TestClass{

    @Autowired
    private UserService userService;
    @Autowired
    private QuestionService questionService;
    @Autowired
    private TargetService targetService;

    @Test
    public void testLogin() {
        User user = new User();
        user.setPassword(Util.md5Encryption("2516987"));
        user.setEmail("nierixin@gmail.com");
        user.setDisplayName("nierixin@gmail.com");
        
        user = userService.findUser(user);
        assertTrue(user.getId() > 0);
    }
    
    @Test
    public void testSearch() {
        Question question = new Question();
        question.setBody("mysql");
        List<Question> questions = questionService.search(question, 0);
        System.out.println(questions.size());
        for (Question question2 : questions) {
			System.out.println(question2.getTags());
		}
        
    }
    
    @Test
    public void testTagMaching() {
    	List<Target> findMatchTargets = targetService.findMatchTargets("jav");
    	for (Target target : findMatchTargets) {
			System.out.println(target.getName());
		}
        
    }
}