package kr.co.smf.system.util;

import java.io.File;
import java.util.Map;

import org.springframework.stereotype.Component;

import kr.co.smf.system.measurement.Measurement;

@Component
public class PhotoUtil {
	public boolean insertPhoto(File	file) {
		return false;
	}
	
	public File selectPhoto(Map<String, String> condition) {
		return null;
	}
	
	public boolean deletePhoto(Measurement measurement) {
		return false;
	}
}
