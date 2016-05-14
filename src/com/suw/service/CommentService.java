package com.suw.service;

import java.util.List;

import com.suw.entity.Comment;

public interface CommentService {
	List<Comment> findCommentsByQuestionId(int questionId);
	Comment addComment(Comment comment);
}
