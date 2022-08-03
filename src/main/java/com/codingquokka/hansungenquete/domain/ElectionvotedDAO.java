package com.codingquokka.hansungenquete.domain;

import java.util.List;

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
	public int votePercentage(ElectionvotedVO vo) throws Exception{
		int num = sqlSession.selectOne(namespace+".votepercentage",vo);
		return num;
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