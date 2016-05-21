package com.suw.service;

import java.util.List;

import com.suw.entity.Favourite;

public interface FavouriteService {
	public Favourite save(Favourite f);
	public Favourite get(int userId, int questionId);
	public void delete(int userId, int questionId);
}
