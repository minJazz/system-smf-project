package kr.co.smf.system.util;

import org.json.JSONObject;

import kr.co.smf.system.setting.Setting;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import okhttp3.ResponseBody;

public class TestUtil {
	public static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");

	public static void main(String[] args) throws Exception {
		OkHttpClient client = new OkHttpClient();
		String json = "{\"previousAgentIpAddress\" : \"empty\", \"nowAgentIpAddress\" : \"175.115.168.17\", \"userMail\" : \"brightenyeon@gmail.com\"}";
		RequestBody body = RequestBody.create(JSON, json);

		Request request = new Request.Builder().url("http://" + "localhost" + "/agent").put(body).build();

		Response response = client.newCall(request).execute();

		ResponseBody responseBody = response.body();
		JSONObject jsonResponse = new JSONObject(responseBody.string());

		System.out.println("code " + jsonResponse.getInt("code"));

	}
}
