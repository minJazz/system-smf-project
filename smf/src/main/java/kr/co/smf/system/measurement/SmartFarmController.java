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
				Setting setting = new Setting();
				Measurement measurement = new Measurement();

				@Override
				public void run() {
					try {
						setting = systemUtil.requestNowGrowthSetting(agent);
						measurement = systemUtil.requestRealTimeGrowthInfo(agent);
					} catch (IOException e) {
						System.out.println("fail to request AgentNowInfo : " + e.getMessage());
					} finally {
						settings.put(agent.getAgentIpAddress(), setting);
						measurements.put(agent.getAgentIpAddress(), measurement);
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
					Thread.sleep(200);
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

		Setting setting = new Setting();
		try {
			setting = systemUtil.requestNowGrowthSetting(agent);
		} catch (IOException e) {
			System.out.println("fail to requestNoGrowthSetting : " + e.getMessage());
		} finally {
			mav.addObject("setting", setting);
		}

		Map<String, String> condition = new HashMap<String, String>();
		condition.put("userPhoneNumber", agent.getUserPhoneNumber());

		mav.addObject("settings", settingService.viewSettingList(condition));

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
		List<Measurement> measurements = measurementService.viewMeasurementList(condition);

		List<Measurement> resultMeasurements = new ArrayList<Measurement>();
		List<Integer> bufferSize = new ArrayList<Integer>();

		if ("month".equals(condition.get("timeCondition"))) {
			int startMonth = Integer.parseInt(condition.get("startTime").split("-")[1]);

			for (int i = 0; i < 12; i++) {
				resultMeasurements.add(new Measurement());
				bufferSize.add(0);
			}

			for (Measurement measurement : measurements) {
				int month = Integer.parseInt(measurement.getMeasureTime().split("-")[1]);

				int index = month - startMonth < 0 ? month - startMonth + 12 : month - startMonth;

				Measurement measurementBuffer = resultMeasurements.get(index);
				measurementBuffer.setCo2(measurementBuffer.getCo2() + measurement.getCo2());
				measurementBuffer.setHumidity(measurementBuffer.getHumidity() + measurement.getHumidity());
				measurementBuffer.setTemperature(measurementBuffer.getTemperature() + measurement.getTemperature());
				measurementBuffer.setMeasureTime(month + "월");

				resultMeasurements.set(index, measurementBuffer);

				bufferSize.set(index, bufferSize.get(index) + 1);
			}

			for (int i = 0; i < resultMeasurements.size(); i++) {
				Measurement measurementBuffer = resultMeasurements.get(i);
				if (bufferSize.get(i) > 0) {
					measurementBuffer.setCo2(measurementBuffer.getCo2() / bufferSize.get(i));
					measurementBuffer.setHumidity(measurementBuffer.getHumidity() / bufferSize.get(i));
					measurementBuffer.setTemperature(measurementBuffer.getTemperature() / bufferSize.get(i));
				}

				int realMonth = i + startMonth < 13 ? i + startMonth : i + startMonth - 12;

				resultMeasurements.set(i, measurementBuffer);
			}

		} else if ("date".equals(condition.get("timeCondition"))) {
			int startDate = Integer.parseInt(condition.get("startTime").split("-")[2].split(" ")[0]);

			Calendar cal = Calendar.getInstance();

			cal.set(
					Integer.parseInt(condition.get("startTime").split("-")[0]),
					Integer.parseInt(condition.get("startTime").split("-")[1]), 
					1);

			int maxDayOfMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			
			for (int i = 0; i < maxDayOfMonth; i++) {
				resultMeasurements.add(new Measurement());
				bufferSize.add(0);
			}

			for (Measurement measurement : measurements) {
				int date = Integer.parseInt(measurement.getMeasureTime().split("-")[2].split(" ")[0]);

				int index = date - startDate < 0 ? date - startDate + maxDayOfMonth : date - startDate;
				
				Measurement measurementBuffer = resultMeasurements.get(index);

				measurementBuffer.setCo2(measurementBuffer.getCo2() + measurement.getCo2());
				measurementBuffer.setHumidity(measurementBuffer.getHumidity() + measurement.getHumidity());
				measurementBuffer.setTemperature(measurementBuffer.getTemperature() + measurement.getTemperature());
				measurementBuffer.setMeasureTime(date + "일");

				resultMeasurements.set(index, measurementBuffer);

				bufferSize.set(index, bufferSize.get(index) + 1);
			}

			for (int i = 0; i < resultMeasurements.size(); i++) {
				Measurement measurementBuffer = resultMeasurements.get(i);
				if (bufferSize.get(i) > 0) {
					measurementBuffer.setCo2(measurementBuffer.getCo2() / bufferSize.get(i));
					measurementBuffer.setHumidity(measurementBuffer.getHumidity() / bufferSize.get(i));
					measurementBuffer.setTemperature(measurementBuffer.getTemperature() / bufferSize.get(i));
				}

				resultMeasurements.set(i, measurementBuffer);
			}
		} else {
			resultMeasurements = measurements;
		}

		for (int i = 0; i < resultMeasurements.size(); i++) {
			if (resultMeasurements.get(i).getMeasureTime() == null) {
				resultMeasurements.remove(i);
				
				i--;
			}
		}
		
		return resultMeasurements;
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
