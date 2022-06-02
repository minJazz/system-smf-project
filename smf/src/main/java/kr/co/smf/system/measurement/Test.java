package kr.co.smf.system.measurement;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Test {

	public static void main(String[] args) {
		String time = "2022-05-19-17";
		LocalDate dateTime = LocalDate.parse(time, DateTimeFormatter.ofPattern("yyyy-MM-dd-HH"));

		System.out.println("dateTime : " + dateTime.toString());
	}

}
