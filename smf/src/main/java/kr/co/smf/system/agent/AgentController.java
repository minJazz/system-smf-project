package kr.co.smf.system.agent;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class AgentController {
	@Autowired
	private AgentService agentService;
	
}
