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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Agent viewAgentInfo(Agent agent) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean editAgentInfo(Agent agent) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteAgentInfo(Agent agent) {
		// TODO Auto-generated method stub
		return false;
	}

}
