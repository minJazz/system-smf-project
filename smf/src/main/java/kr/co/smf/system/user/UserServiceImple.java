package kr.co.smf.system.user;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImple implements UserService {
    @Autowired
    private UserMapper UserMapper;
	
	
	@Override
	public boolean addUser(User user) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<User> viewUserList(Map<String, String> condition) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User viewUser(User user) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean editUser(User user) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteUser(User user) {
		// TODO Auto-generated method stub
		return false;
	}

}
