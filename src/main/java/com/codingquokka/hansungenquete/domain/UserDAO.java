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
	
	private static String namespace = "mapper.UserMapper";
	
	public String login(UserVO vo) throws Exception {
		return sqlSession.selectOne(namespace+".login", vo);
		
	}
	
}