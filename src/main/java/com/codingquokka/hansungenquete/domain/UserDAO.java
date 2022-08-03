package com.codingquokka.hansungenquete.domain;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;

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
	public int totalVoters(String department) throws Exception {
		int num = sqlSession.selectOne(namespace+".totalvoters", department);
		return num;
	}
	public List<UserVO> allUser() throws Exception {
		return sqlSession.selectList(namespace+".allUser");
	}
	public void insertUser(ElectionvotedVO vo) throws Exception {
		sqlSession.insert(namespace + ".insertUser", vo);
	}
}

