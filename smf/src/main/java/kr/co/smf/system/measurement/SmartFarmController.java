package kr.co.smf.system.measurement;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.smf.system.agent.Agent;
import kr.co.smf.system.agent.AgentService;
import kr.co.smf.system.setting.Setting;
import kr.co.smf.system.util.PhotoUtil;
import kr.co.smf.system.util.SystemUtil;

@Controller
public class SmartFarmController {
	@Autowired
	private MeasurementService measurementService;

	@Autowired
	private AgentService agentService;

	@Autowired
	private SystemUtil systemUtil;
	
	@Autowired
	private PhotoUtil photoUtil;

	@GetMapping("/smartfarm")
	public ModelAndView viewSmartFarmList() {
		ModelAndView mav = new ModelAndView("smartfarm/list");

		return mav;
	}

	@GetMapping(path = "/smartfarm", consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<Map<String, String>> viewSmartFarmList(@RequestBody Map<String, String> condition) {
		List<Map<String, String>> responseList = new ArrayList<Map<String, String>>();

		List<Agent> agents = agentService.viewAgentInfoList(condition);
		Map<String, Setting> settings = new HashMap<String, Setting>();
		Map<String, Measurement> measurements = new HashMap<String, Measurement>();
		
		for (Agent agent : agents) {
			Thread thread = new Thread(new Runnable() {
				@Override
				public void run() {
					try {
						settings.put(agent.getAgentIpAddress(), systemUtil.requestNowGrowthSetting(agent));
						measurements.put(agent.getAgentIpAddress(), systemUtil.requestRealTimeGrowthInfo(agent));
					} catch (IOException e) {
						e.printStackTrace(); // TODO 예외 처리
					}
				}
			});
			
			thread.start();
		}

		while (true) {
			if (agents.size() == settings.size() && agents.size() == measurements.size()) {
				break;
			} else {
				try {
					Thread.sleep(500);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				
			}
		}
		
		for (Agent agent : agents) {
			Map<String, String> element = new HashMap<String, String>();
			
			element.put("agentNo", "" + agent.getNo());
			element.put("agentName", agent.getAgentName());
			
			element.put("settingTemperature", "" + settings.get(agent.getAgentIpAddress()).getTemperature());
			element.put("settingHumidity", "" + settings.get(agent.getAgentIpAddress()).getHumidity());
			element.put("settingCo2", "" + settings.get(agent.getAgentIpAddress()).getCo2());
			
			element.put("measureTemperature", "" + measurements.get(agent.getAgentIpAddress()).getTemperature());
			element.put("measureHumidity", "" + measurements.get(agent.getAgentIpAddress()).getHumidity());
			element.put("measureCo2", "" + measurements.get(agent.getAgentIpAddress()).getCo2());
			
			responseList.add(element);
		}
		
		return responseList;
	}

	@GetMapping("/smartfarm/{uniqueNumber}")
	public ModelAndView viewSmartFarm(Agent agent) {
		ModelAndView mav = new ModelAndView("smartfarm/view");
		mav.addObject(agentService.viewAgentInfo(agent));
		
		return mav;
	}

	@PutMapping("/smartfarm")
	@ResponseBody
	public Agent editSmartFarm(@RequestBody Agent agent) {
		Map<String, String> condition  = new HashMap<String, String>();
		condition.put("agentIpAddress", agent.getAgentIpAddress());
		condition.put("agentName", agent.getAgentName());
		
		agentService.editAgentInfo(condition);
		
		return agent;		//혹시 문제가 생길 경우 조회한 다음 조회한 결과를 반환할 것
	}

	@PutMapping("/control")
	public void controlSmartFarm(Agent agent, Setting setting) {
		try {
			systemUtil.requestControlGrowth(agent, setting);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@GetMapping(path = "/measurement", consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<Measurement> viewMeasureInfo(@RequestBody Map<String, String> condition) {
		return measurementService.viewMeasurementList(condition);
	}

	@GetMapping(path = "/photo", consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public byte[] viewPhoto(@RequestBody Map<String, String> condition) {
		File file = photoUtil.selectPhoto(condition);
		
		try {
			FileInputStream fileInputStream = new FileInputStream(file);
			
			return fileInputStream.readAllBytes();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return null;
	}
}
