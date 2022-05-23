package kr.co.smf.system.setting;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.co.smf.system.user.User;

@Service
public interface SettingService {
	public boolean addSetting(Setting setting);

	public List<Setting> viewSettingList(Map<String, String> condition);

	public Setting viewSetting(Setting setting);

	public boolean editSetting(Setting setting);

	public boolean deleteSetting(Setting setting);
}
