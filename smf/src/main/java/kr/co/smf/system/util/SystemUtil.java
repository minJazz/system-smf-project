package kr.co.smf.system.util;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.TimeUnit;

import org.json.JSONObject;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.smf.system.agent.Agent;
import kr.co.smf.system.measurement.Measurement;
import kr.co.smf.system.setting.Setting;
import kr.co.smf.system.user.User;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import okhttp3.ResponseBody;

@Component
public class SystemUtil {
	private static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");
	private OkHttpClient client;
	private ObjectMapper objectMapper;
	
	public SystemUtil() {
        client = new OkHttpClient.Builder()
                .connectTimeout(2, TimeUnit.SECONDS)
                .writeTimeout(2, TimeUnit.SECONDS)
                .readTimeout(2, TimeUnit.SECONDS).build();
        objectMapper = new ObjectMapper();
	}
	
	public Measurement requestRealTimeGrowthInfo(Agent agent) throws IOException {
		Request request = new Request.Builder()
				.url("http://" + agent.getAgentIpAddress() + ":8080/agent/measure?agentIpAddress=" + agent.getAgentIpAddress())
                .build();
		
		Response response = client.newCall(request).execute();
		
		ResponseBody responseBody = response.body();
		String responseBodyString = responseBody.string();
		
		
		JSONObject jsonResponse = new JSONObject(responseBodyString);
		
		Measurement measurement = new Measurement();
		
		measurement.setAgentIpAddress(jsonResponse.getString("agentIpAddress"));
		measurement.setTemperature(jsonResponse.getDouble("temperature"));
		measurement.setHumidity(jsonResponse.getInt("humidity"));
		measurement.setCo2(jsonResponse.getInt("co2"));
		
		measurement.setMeasureTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd-HH24")));
		
		return measurement;
	}
	
	public Setting requestNowGrowthSetting(Agent agent) throws IOException {
		Request request = new Request.Builder()
				.url("http://" + agent.getAgentIpAddress() + ":8080/agent/setting?agentIpAddress=" + agent.getAgentIpAddress())
                .build();
		
		Response response = client.newCall(request).execute();
		
		ResponseBody responseBody = response.body();
		
		String test = responseBody.string();
		
		JSONObject jsonResponse = new JSONObject(test);
		
		Setting setting = new Setting();
		setting.setTemperature(jsonResponse.getDouble("temperature"));
		setting.setHumidity(jsonResponse.getInt("humidity"));
		setting.setCo2(jsonResponse.getInt("co2"));
		
		return setting;
	}
	
	public void requestControlGrowth(Agent agent, Setting setting) throws IOException {
		String json = objectMapper.writeValueAsString(setting);
        RequestBody body = RequestBody.create(JSON, json);
		
		Request request = new Request.Builder()
				.url("http://" + agent.getAgentIpAddress() + ":8080/agent/setting")
				.post(body)
                .build();
		
		Response response = client.newCall(request).execute();
		
		ResponseBody responseBody = response.body();
		JSONObject jsonResponse = new JSONObject(responseBody.string());
		
		if (!jsonResponse.getString("code").equals("200")) {
			System.out.println("?????? ?????? ?????? : " + jsonResponse.getString("message"));
		}
	}
	
	public void sendUserInfo(Agent agent, User user) throws IOException {
		String json = "{\"agentIpAddress\" : \"" + agent.getAgentIpAddress() + "\", "
					 + "\"userMail\" : \"" + user.getMail() + "\" }";
        RequestBody body = RequestBody.create(JSON, json);
		
		Request request = new Request.Builder()
				.url("http://" + agent.getAgentIpAddress() + ":8080/agent/user")
				.put(body)
                .build();
		
		Response response = client.newCall(request).execute();
		
		ResponseBody responseBody = response.body();
		JSONObject jsonResponse = new JSONObject(responseBody.string());
		
		if (!jsonResponse.getString("code").equals("200")) {
			System.out.println("?????? ?????? ?????? : " + jsonResponse.getString("message"));	//TODO Logger ?????? ??? ?????? ??????
		}
	}

}
