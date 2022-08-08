package com.codingquokka.hansungenquete.domain;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class CandidateDAO {
	
	@Inject
	SqlSession sqlSession;
	
	private static String namespace = "mapper.candidateMapper";
	
	public void insert(CandidateVO vo) {
		sqlSession.insert(namespace+".insertCandidate", vo);
		
	}
	public List<CandidateVO> selectList(String electionName) {
		return sqlSession.selectList(namespace+".selectCandidate", electionName);
		
	}

	public CandidateVO selectSpecipicCandidate(String candidateName) {
		return sqlSession.selectOne(namespace+".selectSpecipicCandidate", candidateName);
	}
	public void deleteCandidate(String electionName) throws Exception {
		sqlSession.delete(namespace+".deleteCandidate", electionName);
	}
}
