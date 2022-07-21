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
	
	
}