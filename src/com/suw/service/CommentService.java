package com.suw.service;

import java.util.List;

import com.suw.entity.Comment;

public interface CommentService {
	public List<Comment> findCommentsByQuestionId(int questionId);
	public Comment addComment(Comment comment);
}
