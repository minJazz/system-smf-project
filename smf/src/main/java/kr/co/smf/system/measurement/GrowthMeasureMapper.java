package kr.co.smf.system.measurement;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GrowthMeasureMapper {
	public boolean insertGrowthMeasureInfo(Measurement measurement);
	
	public List<Measurement> selectAllGrowthMeasureInfo(Map<String, String> condition);
	
    public Measurement selectGrowthMeasureInfo(Measurement measurement);	

    public boolean deleteGrowthMeasureInfo(Measurement measurement);
}
