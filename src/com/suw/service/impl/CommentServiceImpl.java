package com.suw.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.suw.dao.BaseDAO;
import com.suw.entity.Comment;
import com.suw.entity.Question;
import com.suw.service.CommentService;

@Service("commentService")
public class CommentServiceImpl implements CommentService {
	
	@Resource
	private BaseDAO<Comment> baseDAO;

	@Override
	public List<Comment> findCommentsByQuestionId(int questionId) {
		return baseDAO.find("from Comment com where com.postId = ?",new Object[]{questionId});
	}

	@Override
	public Comment addComment(Comment comment) {
		return baseDAO.save(comment);
	}

	

	
}
