package kr.co.smf.system.util;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import kr.co.smf.system.measurement.GrowthMeasureMapper;
import kr.co.smf.system.measurement.Measurement;

@Component
public class PhotoUtil {
	private static final String IMAGEPATH = "image" + File.pathSeparator;
	
	@Autowired
	private GrowthMeasureMapper growthMeasureMapper; 
	
	public void insertPhoto(MultipartFile multipartFile, Measurement measurement)
			throws IllegalStateException, IOException {
		LocalDate measureDate = LocalDate.parse(measurement.getMeasureTime(), 
				DateTimeFormatter.ofPattern("yyyy-MM-dd-HH"));
		
		LocalDateTime measureTime = LocalDateTime.parse(measurement.getMeasureTime(), 
				DateTimeFormatter.ofPattern("yyyy-MM-dd-HH"));
		
		String directoryPath = IMAGEPATH 
				+ measurement.getAgentIpAddress() + File.pathSeparator 
				+ measureDate.toString();
		
		File directory = new File(directoryPath);
		
		if (!directory.isDirectory()) {
            directory.mkdir();
        }
		
		File file = new File(
				directoryPath + File.pathSeparator
				+ measureTime.getHour()
				+ "(" + multipartFile.getOriginalFilename() + ")"
				+ ".jpg"); // ex) 192.168.120.0\\13(1).jpg
		
		multipartFile.transferTo(file);
	}
	
	public File selectPhoto(Map<String, String> condition) {
		LocalDate measureDate = LocalDate.parse(condition.get("measureTime"), 
				DateTimeFormatter.ofPattern("yyyy-MM-dd-HH"));
		
		LocalDateTime measureTime = LocalDateTime.parse(condition.get("measureTime"), 
				DateTimeFormatter.ofPattern("yyyy-MM-dd-HH"));
		
		String path = IMAGEPATH 
				+ condition.get("agentIpAddress") + File.pathSeparator 
				+ measureDate.toString() + File.pathSeparator
				+ measureTime.getHour() + "(" + condition.get("camera") + ")" + ".jpg";
		
		return new File(path);
	}
	
	public void deletePhoto(Measurement measurement) {
		LocalDate measureDate = LocalDate.parse(measurement.getMeasureTime(), 
				DateTimeFormatter.ofPattern("yyyy-MM-dd-HH"));
		
		LocalDateTime measureTime = LocalDateTime.parse(measurement.getMeasureTime(), 
				DateTimeFormatter.ofPattern("yyyy-MM-dd-HH"));
		
		String directoryPath = IMAGEPATH 
				+ measurement.getAgentIpAddress() + File.pathSeparator 
				+ measureDate.toString();
		// TODO 여기부터 (제성이)
	}
}
