package kr.co.smf.system.agent;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AgentController {
	@Autowired
	private AgentService agentService;
	
	@PostMapping("/agent-info")
	public void addAgent(@RequestBody Agent agent) {
		agentService.addAgentInfo(agent);
	}
	
	@GetMapping("/agent/{no}")
	public ModelAndView viewAgentList() {
		return null;
	}
	
	@GetMapping("/agent")
	@ResponseBody
	public List<Agent> viewAgentList(@RequestBody(required = false) Map<String, String> condition) {
		return agentService.viewAgentInfoList(condition);
	}
	
	@DeleteMapping("/agent")
	@ResponseBody
	public List<Agent> removeAgent(@RequestBody Map<String, String> condition) {
		Agent agent = new Agent();
		agent.setAgentIpAddress(condition.get("agentIpAddress"));
		agent.setAgentName(condition.get("agentName"));
		agent.setNo(Integer.valueOf(condition.get("no")));
		agent.setUserPhoneNumber(condition.get("userPhoneNumber"));
		
		agentService.deleteAgentInfo(agent);
		return agentService.viewAgentInfoList(condition);
	}
	
}
