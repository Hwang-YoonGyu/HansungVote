package com.codingquokka.hansungvote.domain;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class UserDAO {
	
	@Inject 
	SqlSession sqlSession;
	
	private static String namespace = "mapper.userMapper";
	
	//로그인 구현 
	public UserVO login(UserVO vo) throws Exception {
		return sqlSession.selectOne(namespace+".login", vo);	
	}

	public UserVO findDepartmentOfUser(String stuId) throws Exception {
		return sqlSession.selectOne(namespace+".findDepartmentOfUser",stuId);
	}
	public UserVO certificate(UserVO vo) throws Exception{
		return sqlSession.selectOne(namespace + ".certificate", vo);
	}
	
	//총유권자수 계산
	public int totalVoters(String department) throws Exception {
		int num = sqlSession.selectOne(namespace+".totalvoters", department);
		return num;
	}
	public List<Map<String,Object>> allUserWhoHaveRight(ElectionVO eVo) throws Exception {
		return sqlSession.selectList(namespace+".allUserWhoHaveRight", eVo);
	}
	public void insertUser(UserVO vo) throws Exception {
		sqlSession.insert(namespace + ".insertUser", vo);
	}

	public List<String> voteCan(String department) throws Exception{
		return sqlSession.selectList(namespace+".voteCan", department);
	}

	public void agreeCount(UserVO vo) {
		sqlSession.update(namespace + ".agreeCount",vo);
	}

	public void userDateDelete() {
		sqlSession.delete(namespace+".userDateDelete");
	}
}

