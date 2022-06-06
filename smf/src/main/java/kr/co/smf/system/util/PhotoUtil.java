package kr.co.smf.system.util;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import kr.co.smf.system.measurement.GrowthMeasureMapper;
import kr.co.smf.system.measurement.Measurement;

@Component
public class PhotoUtil {
	@Autowired
	private ServletContext servletContext;

	@Autowired
	private GrowthMeasureMapper growthMeasureMapper;

	public void insertPhoto(MultipartFile multipartFile, Measurement measurement)
			throws IllegalStateException, IOException {
		
		String[] time = measurement.getMeasureTime().split("[ ]");
		
		String directoryPath = servletContext.getRealPath("/image") + File.separator + measurement.getAgentIpAddress();

		File directory = new File(directoryPath);

		if (!directory.exists()) {
			directory.mkdir();
		}
		
		directoryPath = directory + (File.separator + time[0]);
		
		directory = new File(directoryPath);
		
		if (!directory.exists()) {
			directory.mkdir();
		}

		File file = new File(directoryPath + File.separator + time[1].split("[:]")[0] 
				+ multipartFile.getOriginalFilename().split("[.]")[0] + ".jpg"); // ex) 192.168.120.0\\13(1).jpg

		multipartFile.transferTo(file);
	}

	public Map<String, String> selectPhoto(Map<String, String> condition) {
		Map<String, String> fileMap = new HashMap<String, String>();

		String ipAddress = condition.get("ipAddress");
		String date = condition.get("date");
		String time = condition.get("time");
		String camera = condition.get("camera");
		int cameraNo = Integer.parseInt(camera);
		String move = condition.get("move");

		String exist = "true";

		String directoryPath = servletContext.getRealPath("/image") + File.separator + ipAddress + File.separator;

		String filePath = "";

		if ("next".equals(move)) {
			cameraNo++;

			filePath = directoryPath + date + File.separator + time + "(" + cameraNo + ").jpg";

			if (!new File(filePath).exists()) {
				cameraNo = 1;

				if (!"23".equals(time)) {
					time = String.format("%02d", (Integer.parseInt(time) + 1));
				} else {
					LocalDate localDate = LocalDate.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd"));

					localDate = localDate.plusDays(1);

					date = localDate.toString();
					time = "00";
				}

				filePath = directoryPath + date + File.separator + time + "(" + cameraNo + ").jpg";
				if (!new File(filePath).exists()) {
					exist = "overFlow";
				}
			}
		} else if ("now".equals(move)) {
			filePath = directoryPath + date + File.separator + "00(1).jpg";

			if (!new File(filePath).exists()) {
				exist = "noFile";
			}
			
		} else {
			if (1 != cameraNo) {
				cameraNo--;

				filePath = directoryPath + date + "/" + time + "(" + cameraNo + ").jpg";
			} else {
				if (!"00".equals(time)) {
					time = String.format("%02d", (Integer.parseInt(time) - 1));
				} else {
					LocalDate localDate = LocalDate.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd"));

					localDate = localDate.minusDays(1);
					
					date = localDate.toString();
					time = "23";
				}

				filePath = directoryPath + date + "/" + time + "(" + cameraNo + ").jpg";
				if (!new File(filePath).exists()) {
					exist = "underFlow";
				} else {
					cameraNo = 1;
					int nextCameraNo = 2;
					while (true) {
						filePath = directoryPath + date + "/" + time + "(" + nextCameraNo + ").jpg";
						if (!new File(filePath).exists()) {
							cameraNo = nextCameraNo - 1;
							break;
						} else {
							nextCameraNo++;
						}
					}
				}
			}
		}

		fileMap.put("date", date);
		fileMap.put("time", time);
		fileMap.put("camera", String.valueOf(cameraNo));
		fileMap.put("exist", exist);

		return fileMap;
	}

	public void deletePhoto(Measurement measurement) {
		LocalDate measureDate = LocalDate.parse(measurement.getMeasureTime(),
				DateTimeFormatter.ofPattern("yyyy-MM-dd-HH"));

		LocalDateTime measureTime = LocalDateTime.parse(measurement.getMeasureTime(),
				DateTimeFormatter.ofPattern("yyyy-MM-dd-HH"));

		File directory = new File(
				servletContext.getRealPath("/image") + File.separator + measurement.getAgentIpAddress() + File.separator + measureDate.toString());

		File[] folderList = directory.listFiles();

		for (int j = 0; j < folderList.length; j++) {
			folderList[j].delete();
		}

		if (folderList.length == 0 && directory.isDirectory()) {
			directory.delete();
		}
	}
}
