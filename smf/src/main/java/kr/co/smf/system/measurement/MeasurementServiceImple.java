package kr.co.smf.system.measurement;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.smf.system.agent.Agent;
import kr.co.smf.system.setting.Setting;
import kr.co.smf.system.util.SystemUtil;

@Service
public class MeasurementServiceImple implements MeasurementService {
    @Autowired
    private GrowthMeasureMapper growthMeasureMapper;
    
    @Autowired
    private SystemUtil systemUtil;
    
	@Override
	public boolean addMeasurement(Measurement measurement) {
		return growthMeasureMapper.insertGrowthMeasureInfo(measurement) == 0 ? false : true;
	}

	@Override
	public List<Measurement> viewMeasurementList(Map<String, String> condition) {
		return growthMeasureMapper.selectAllGrowthMeasureInfo(condition);
	}

	@Override
	public Measurement viewMeasurement(Measurement measurement) {
		return growthMeasureMapper.selectGrowthMeasureInfo(measurement);
	}

	@Override
	public List<Measurement> viewRealTimeMeasurement(List<Agent> agents) {
		List<Measurement> measurements = new ArrayList<Measurement>();
		
		while(true) {
			for (Agent agent : agents) {
				Thread thread = new Thread(new Runnable() {
					@Override
					public void run() {
						try {
							measurements.add(systemUtil.requestRealTimeGrowthInfo(agent));//리스트에 add하는게 동기화 문제 생길수도..?
						} catch (IOException e) {
							e.printStackTrace();
							//요청 중 예외 발생...
						}
					}
				});
				
				thread.start();
			}
			
			if (measurements.size() == agents.size()) {
				break;
			}
		}
		
		return measurements;
	}

	@Override
	public boolean requestControl(Agent agent, Setting setting) {
		try {
			systemUtil.requestControlGrowth(agent, setting);
			
			return true;
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

}
