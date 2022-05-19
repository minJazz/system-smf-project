package kr.co.smf.system.setting;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController//보내는 것을 json형식으로 보내겠다.
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

	@GetMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
//	@ResponseBody // json 형식으로 송신하겠다 @RequestBody는 json 형식으로 받겠다.
	public Setting viewSetting(Setting setting) {
		System.out.println(setting.getSettingName());
		Setting checkSetting = settingService.viewSetting(setting);
		System.out.println(checkSetting.getUserPhoneNumber()+checkSetting.getCo2()+checkSetting.getSettingName());
		return null;
	}

	@PutMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
	public List<Setting> updateSetting(@RequestBody Setting setting) {
		//String phoneNumber = (String) httpSession.getAttribute("phoneNumber");
		setting.setUserPhoneNumber("01051199268");

		// 생장환경 설정 이름으로 조회 메소드를 실행하고 null이 아니면 update문, null이면 insert 문 실행
		boolean check = settingService.addSetting(setting);//
		System.out.println(check);
		
		//return을 통해  갱신한 정보를 다시 조회하여 반환해야한다.
		return null;
	}

	@DeleteMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
	public List<Setting> deleteSetting(@RequestBody Setting setting) {
		//String phoneNumber = (String) httpSession.getAttribute("phoneNumber");
		setting.setUserPhoneNumber("01051199268");

		settingService.deleteSetting(setting);// 삭제
		
		//return을 통해  삭제된 이후 정보를 다시 조회하여 반환해야한다.
		return null;
	}
}
