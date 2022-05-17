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
	public List<Agent> viewAgentList(@RequestBody Map<String, String> condition) {
		return null;
	}
	
	@DeleteMapping("/agent")
	public List<Agent> removeAgent(Map<String, String> condition) {
		return null;
	}
	
}
