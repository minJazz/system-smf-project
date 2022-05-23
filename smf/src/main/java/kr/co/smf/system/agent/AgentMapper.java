package kr.co.smf.system.agent;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.transaction.annotation.Transactional;

@Mapper
public interface AgentMapper {
	@Transactional
	public int insertAgentInfo(Agent agent); 
   
	public List<Agent> selectAllAgentInfo(Map<String, String> condition);
    
	public Agent selectAgentInfo(Agent agent);

	@Transactional
	public int updateAgentInfo(Map<String, String> agent);
	
	@Transactional
	public int deleteAgentInfo(Agent agent);
}
