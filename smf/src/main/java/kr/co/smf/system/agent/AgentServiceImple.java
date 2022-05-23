package kr.co.smf.system.agent;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AgentServiceImple implements AgentService {
    @Autowired
    private AgentMapper agentMapper;
	
	@Override
	public boolean addAgentInfo(Agent agent) {
		return agentMapper.insertAgentInfo(agent) == 1 ? true : false;
	}

	@Override
	public List<Agent> viewAgentInfoList(Map<String, String> condition) {
		return agentMapper.selectAllAgentInfo(condition);
	}

	@Override
	public Agent viewAgentInfo(Agent agent) {
		return agentMapper.selectAgentInfo(agent);
	}

	@Override
	public boolean editAgentInfo(Map<String, String> agent) {
		return agentMapper.updateAgentInfo(agent) == 1 ? true : false;
	}

	@Override
	public boolean deleteAgentInfo(Agent agent) {
		return agentMapper.deleteAgentInfo(agent) == 1 ? true : false;
	}

}
