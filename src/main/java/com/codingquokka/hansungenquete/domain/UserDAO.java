package com.codingquokka.hansungenquete.domain;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.codingquokka.hansungenquete.domain.*;


@Repository
public class UserDAO {
	
	@Inject 
	SqlSession sqlSession;
	
	private static String namespace = "mapper.userMapper";
	
	//로그인 구현 
	public UserVO login(UserVO vo) throws Exception {
		return sqlSession.selectOne(namespace+".login", vo);	
	}
	
	//총유권자수 계산
	public int totalvoters(UserVO vo) throws Exception {
		int num = sqlSession.selectOne(namespace+".totalvoters", vo);
		return num;
	}
}

