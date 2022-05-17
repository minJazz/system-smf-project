package kr.co.smf.system.setting;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.smf.system.user.User;

@Service
public class SettingServiceImple implements SettingService {
	@Autowired
	GrowthSettingMapper growthSettingMapper;

	@Override
	public boolean addSetting(Setting setting) {

		return growthSettingMapper.insertGrowthSetting(setting) == 0 ? false : true;
	}

	@Override
	public List<Setting> viewSettingList(Map<String, String> condition) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Setting viewSetting(Setting setting) {
		return growthSettingMapper.selectGrowthSetting(setting);
	}

	@Override
	public boolean editSetting(Setting setting) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteSetting(Setting setting) {
		return growthSettingMapper.deleteGrowthSetting(setting) == 0 ? false : true;
	}

	@Override
	public List<Setting> viewNowSetting(User user) {
		// TODO Auto-generated method stub
		return null;
	}

}
