package kr.co.smf.system.agent;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public interface AgentService {
	public boolean addAgentInfo(Agent agent);

	public List<Agent> viewAgentInfoList(Map<String, String> condition);

	public Agent viewAgentInfo(Agent agent);

	public boolean editAgentInfo(Agent agent);

	public boolean deleteAgentInfo(Agent agent);
}
