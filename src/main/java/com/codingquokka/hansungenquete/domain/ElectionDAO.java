package com.codingquokka.hansungenquete.domain;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class ElectionDAO {
	
	@Inject 
	SqlSession sqlSession;
	
	private static String namespace = "mapper.electionMapper";
	public List<ElectionVO> selectElection(ElectionVO vo) throws Exception {
		return sqlSession.selectList(namespace + ".selectElection", vo);
	}

	public List<ElectionVO> selectElectionAll() throws Exception {
		return sqlSession.selectList(namespace + ".selectElectionAll");
	}

	public void insertUser(ElectionvotedVO vo) throws Exception {
		sqlSession.insert(namespace + ".insertUser", vo);
	}
	
}
