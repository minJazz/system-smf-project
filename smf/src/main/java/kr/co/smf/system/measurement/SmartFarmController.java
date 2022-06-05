package kr.co.smf.system.measurement;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.smf.system.agent.Agent;
import kr.co.smf.system.agent.AgentService;
import kr.co.smf.system.setting.Setting;
import kr.co.smf.system.setting.SettingService;
import kr.co.smf.system.util.Navigator;
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

	@Autowired
	private Navigator navigator;

	@Autowired
	private SettingService settingService;

	@GetMapping("/smartfarm")
	public ModelAndView viewSmartFarmList() {
		ModelAndView mav = new ModelAndView("smartfarm/list");

		return mav;
	}

	@GetMapping(path = "/smartfarm", consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<Map<String, String>> viewSmartFarmList(@RequestParam Map<String, String> condition) {
		List<Map<String, String>> responseList = new ArrayList<Map<String, String>>();

		List<Agent> agents = agentService.viewAgentInfoList(condition);
		Map<String, Setting> settings = new ConcurrentHashMap<String, Setting>();
		Map<String, Measurement> measurements = new ConcurrentHashMap<String, Measurement>();

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

			thread.start(); // TODO 에이전트 구현 시 주석 해제
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
		// TODO 에이전트 구현 시 주석 해제
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
			// TODO 에이전트 구현 시 주석 해제
			responseList.add(element);
		}

		Map<String, String> allCondition = new HashMap<String, String>();

		allCondition.putAll(condition);

		allCondition.remove("pageNo");

		List<Agent> allAgents = agentService.viewAgentInfoList(allCondition);

		String navigatorHtml = navigator.getNavigator(allAgents.size(), Integer.parseInt(condition.get("pageNo")));

		if (responseList.isEmpty()) {
			responseList.add(new HashMap<String, String>());
		}

		responseList.get(0).put("navigator", navigatorHtml);

		return responseList;
	}

	@GetMapping("/smartfarm/{no}")
	public ModelAndView viewSmartFarm(Agent agent) {
		ModelAndView mav = new ModelAndView("smartfarm/view");

		agent = agentService.viewAgentInfo(agent);
		mav.addObject(agent);

		try {
			mav.addObject("setting", systemUtil.requestRealTimeGrowthInfo(agent));
		} catch (IOException e) {
			e.printStackTrace(); // TODO 예외 처리 }

			Map<String, String> condition = new HashMap<String, String>();
			condition.put("userPhoneNumber", agent.getUserPhoneNumber());

			mav.addObject("settings", settingService.viewSettingList(condition));

		}
		return mav;
	}

	@PutMapping("/smartfarm")
	public Agent editSmartFarm(Agent agent) {
		Map<String, String> condition = new HashMap<String, String>();
		condition.put("previousAgentIpAddress", agent.getAgentIpAddress());
		condition.put("nowAgentIpAddress", agent.getAgentIpAddress());
		condition.put("agentName", agent.getAgentName());

		agentService.editAgentInfo(condition);

		return agent;
	}

	@PutMapping("/control")
	public void controlSmartFarm(Agent agent, Setting setting) {
		try {
			systemUtil.requestControlGrowth(agent, setting);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	@GetMapping(path = "/measurement")
	@ResponseBody
	public List<Measurement> viewMeasureInfo(@RequestParam Map<String, String> condition) {
		System.out.println("view >>> " + condition + "list : " + measurementService.viewMeasurementList(condition));

		return measurementService.viewMeasurementList(condition);
	}

	@PostMapping(path = "/record-info", consumes = { "multipart/form-data" })
	@ResponseBody
	public Map<String, String> addMeasureInfo(@RequestPart(value = "photo") MultipartFile multipartFile,
			@RequestPart(value = "measurement", required = false) String data) {

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
		String time = dateFormat.format(Calendar.getInstance().getTime());

		String[] datas = data.split("[:]");

		Measurement measurement = new Measurement();
		measurement.setAgentIpAddress(datas[0]);
		measurement.setCo2(Integer.valueOf(datas[1]));
		measurement.setHumidity(Integer.valueOf(datas[2]));
		measurement.setTemperature(Double.valueOf(datas[3]));
		measurement.setMeasureTime(time);

		Map<String, String> response = new HashMap<String, String>();

		if (measurementService.addMeasurement(measurement)) {
			try {
				photoUtil.insertPhoto(multipartFile, measurement);
			} catch (Exception e) {
				e.printStackTrace();
			}

			response.put("code", "200");
			response.put("message", "ok");
		} else {
			response.put("code", "300");
			response.put("message", "fail");
		}

		return response;
	}

	@GetMapping(path = "/photo")
	@ResponseBody
	public Map<String, String> viewPhoto(@RequestParam Map<String, String> condition) {
		Map<String, String> response = photoUtil.selectPhoto(condition);

		return response;
	}
}
