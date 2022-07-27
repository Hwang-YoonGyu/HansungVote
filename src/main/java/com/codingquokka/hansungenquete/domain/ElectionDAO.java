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
	public List<ElectionVO> SelectElection (String department) throws Exception {
		return sqlSession.selectList(namespace + ".selectElection", department);
	}
	
}
