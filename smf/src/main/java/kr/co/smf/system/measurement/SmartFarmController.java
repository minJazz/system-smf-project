package kr.co.smf.system.measurement;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SmartFarmController {
	@Autowired
	private MeasurementService measurementService;
	
    @GetMapping("/test.do")
    public void test(String string) {
    	Measurement measurement = new Measurement();
    	
    	measurement.setAgentIpAddress(string);
    	measurement.setCo2(0);
    	measurement.setHumidity(0);
    	measurement.setMeasureTime("2022-05-17");
    	measurement.setTemperature(0);
    	
    	measurementService.addMeasurement(measurement);
    }
}
