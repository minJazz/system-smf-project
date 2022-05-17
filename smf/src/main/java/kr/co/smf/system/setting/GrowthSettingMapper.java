package kr.co.smf.system.setting;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GrowthSettingMapper {
	public boolean insertGrowthSetting(Setting setting);
	
    public List<Setting> selectAllGrowthSetting(Map<String, String> condition);	
	
    public Setting selectGrowthSetting(Setting setting);
    
    public boolean updateGrowthSetting(Setting setting);
	
    public boolean deleteGrowthSetting(Setting setting);
}
