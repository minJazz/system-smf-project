package kr.co.smf.system.measurement;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.co.smf.system.agent.Agent;
import kr.co.smf.system.setting.Setting;

@Service
public interface MeasurementService {
	public boolean addMeasurement(Measurement measurement);
	
	public List<Measurement> viewMeasurementList(Map<String, String> condition);
	
	public Measurement viewMeasurement(Measurement measurement);
	
	public List<Measurement> viewRealTimeMeasurement(List<Agent> agents);
	
	public boolean requestControl(Agent agent, Setting setting);

}
