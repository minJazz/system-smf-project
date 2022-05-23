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
		return growthSettingMapper.selectAllGrowthSetting(condition);
	}

	@Override
	public Setting viewSetting(Setting setting) {
		return growthSettingMapper.selectGrowthSetting(setting);
	}

	@Override
	public boolean editSetting(Setting setting) {
		return growthSettingMapper.updateGrowthSetting(setting) == 0 ? false : true;
	}

	@Override
	public boolean deleteSetting(Setting setting) {
		return growthSettingMapper.deleteGrowthSetting(setting) == 0 ? false : true;
	}

}
