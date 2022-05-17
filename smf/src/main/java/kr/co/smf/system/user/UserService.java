package kr.co.smf.system.user;

import java.util.List;
import java.util.Map;

import org.apache.catalina.Manager;
import org.springframework.stereotype.Service;

@Service
public interface UserService {
	public boolean addUser(User user);

	public List<User> viewUserList(Map<String, String> condition);

	public User viewUser(User user);

	public boolean editUser(User user);

	public boolean deleteUser(User user);
}
