package kr.co.smf.system.agent;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import kr.co.smf.system.user.User;
import kr.co.smf.system.user.UserService;


@RestController
@RequestMapping("/agent")
public class AgentController {
	@Autowired
	private AgentService agentService;
	
	@Autowired
	private UserService userService;
	
	@GetMapping("/list/{no}")
	public ModelAndView viewAgentListForm(@PathVariable String no) {
		Map<String, String> condition = new HashMap<String, String>();
		condition.put("no", no);
		
		User user = new User();
		user.setNo(Integer.valueOf(no));
				
		List<Agent> list = agentService.viewAgentInfoList(condition);
		
		ModelAndView mav = new ModelAndView("/agent/list");
		mav.addObject("user", userService.viewUser(user));
		mav.addObject("list", list);
		mav.addObject("no", no);
		
		return mav;
	}
	
	@PostMapping
	@ResponseBody
	public List<Agent> viewAgentList(@RequestBody String no) {
		Map<String, String> condition = new HashMap<String, String>();
		condition.put("no", no);
		
		return agentService.viewAgentInfoList(condition);
	}
	
	@PutMapping
	@ResponseBody
	public Map<String, String> editAgent(
			@RequestParam Map<String, String> agentInfo) {
	    
		if ("empty".equals(agentInfo.get("previousAgentIpAddress"))) {
			Agent agent = new Agent();
			agent.setAgentIpAddress(agentInfo.get("nowAgentIpAddress"));
			
			User user = new User();
			user.setMail(agentInfo.get("userMail"));
			
			user = userService.viewUser(user);
			
			agent.setUserPhoneNumber(user.getPhoneNumber());
			agentService.addAgentInfo(agent);
			
		} else if (!(agentInfo.get("previousAgentIpAddress").equals("nowAgentIpAddress"))) {
			agentService.editAgentInfo(agentInfo);
		} else {
			Map<String, String> response = new HashMap<String, String>();
			response.put("code","300");
			response.put("message","error");
			
			return response;
		}
		
		
		Map<String, String> response = new HashMap<String, String>();
	    response.put("code","200");
	    response.put("message","ok");
	    
		return response;
	}
	
	
	@DeleteMapping
	@ResponseBody
	public List<Agent> removeAgent(
			@RequestBody Map<String, String> condition) {
		
		Agent agent = new Agent();
		agent.setNo(Integer.valueOf(condition.get("no")));
		agentService.deleteAgentInfo(agent);

		String pageNo = condition.get("pageNo");
		
		condition = new HashMap<String, String>();
		condition.put("pageNo", pageNo);
		
		return agentService.viewAgentInfoList(condition);
	}
}
