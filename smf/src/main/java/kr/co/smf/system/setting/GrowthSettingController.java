package kr.co.smf.system.setting;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import kr.co.smf.system.user.User;

@RestController // 보내는 것을 json형식으로 보내겠다.
@RequestMapping("/setting")
public class GrowthSettingController {
	@Autowired
	SettingService settingService;

	@GetMapping
	public ModelAndView viewSetting(HttpSession httpSession) {
		User user = (User) httpSession.getAttribute("user");
		Map<String, String> condition = new HashMap<String, String>();
		condition.put("userPhoneNumber", user.getPhoneNumber());
		List<Setting> settingList = settingService.viewSettingList(condition);

		System.out.println(settingList.get(0).getSettingName());

		ModelAndView modelAndView = new ModelAndView("setting/view");
		modelAndView.addObject("settingList", settingList);
		return modelAndView;
	}

	@GetMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
	public Setting viewSetting(Setting setting) {
		if("add".equals(setting.getSettingName())) {
			setting.setSettingName("");
			return setting;
		}
		return settingService.viewSetting(setting);
	}

	@PutMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
	public List<Setting> updateSetting(@RequestBody Setting setting) {
		boolean check = false;

		if (settingService.viewSetting(setting) == null) {
			check = settingService.addSetting(setting);
			System.out.println("새로운 생장환경 설정 값 추가 여부 " + check);
		} else {
			check = settingService.editSetting(setting);
			System.out.println("생장환경 설정 값 변경 여부 " + check);
		}

		Map<String, String> condition = new HashMap<String, String>();
		condition.put("userPhoneNumber", setting.getUserPhoneNumber());

		return settingService.viewSettingList(condition);
	}

	@DeleteMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
	public List<Setting> deleteSetting(@RequestBody Setting setting) {
		Map<String, String> condition = new HashMap<String, String>();
		condition.put("userPhoneNumber", setting.getUserPhoneNumber());

		return settingService.viewSettingList(condition);
	}
}
