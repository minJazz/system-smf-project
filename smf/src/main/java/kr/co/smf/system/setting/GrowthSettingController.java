package kr.co.smf.system.setting;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/setting")
public class GrowthSettingController {
	@Autowired
	SettingService settingService;

	@GetMapping
	public ModelAndView viewSetting(HttpSession httpSession) {
		String phoneNumber = (String) httpSession.getAttribute("phoneNumber");
		System.out.println("성공");

		return null;
	}

	@GetMapping(consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody // json 형식으로 송신하겠다 @RequestBody는 json 형식으로 받겠다.
	public Setting viewSetting(@RequestBody Setting setting, HttpSession httpSession) {
		String phoneNumber = (String) httpSession.getAttribute("phoneNumber");
		Setting checkSetting = settingService.viewSetting(setting);
		System.out.println(checkSetting);
		return null;
	}

	@PutMapping(consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<Setting> updateSetting(HttpSession httpSession, @RequestBody Setting setting) {
		//String phoneNumber = (String) httpSession.getAttribute("phoneNumber");
		setting.setUserPhoneNumber("01051199268");

		// 생장환경 설정 이름으로 조회 메소드를 실행하고 null이 아니면 update문, null이면 insert 문 실행
		boolean check = settingService.addSetting(setting);
		System.out.println(check);

		return null;
	}

	@DeleteMapping(consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<Setting> deleteSetting(@RequestBody Setting setting, HttpSession httpSession) {
		//String phoneNumber = (String) httpSession.getAttribute("phoneNumber");
		setting.setUserPhoneNumber("01051199268");

		settingService.deleteSetting(setting);
		return null;
	}
}
