package kr.co.smf.system.setting;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GrowthSettingMapper {
	public int insertGrowthSetting(Setting setting);
	
    public List<Setting> selectAllGrowthSetting(Map<String, String> condition);	
	
    public Setting selectGrowthSetting(Setting setting);
    
    public int updateGrowthSetting(Setting setting);
	
    public int deleteGrowthSetting(Setting setting);
}
