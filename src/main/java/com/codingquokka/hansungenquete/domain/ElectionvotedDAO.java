package com.codingquokka.hansungenquete.domain;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class ElectionvotedDAO {
	
	@Inject
	SqlSession sqlSession;
	
	private static String namespace = "mapper.electionvotedMapper";
	
	//다중 투표 방지
	public ElectionvotedVO wasVoted(ElectionvotedVO vo) throws Exception{
		return sqlSession.selectOne(namespace + ".wasVoted", vo);
	}
	
	//득표율 계산 
	public List<Map<String, String>> votepercentage(String electionName) throws Exception{
		return sqlSession.selectList(namespace+".votepercentage", electionName);
	}
	
	//투표율 계산 
	public int turnout(String electionName) throws Exception{
		int num = sqlSession.selectOne(namespace+".turnout",electionName);
		return num;
	}

	public void insertVote(ElectionvotedVO vo) throws Exception {
		sqlSession.insert(namespace + ".insertVote", vo);
	}

}