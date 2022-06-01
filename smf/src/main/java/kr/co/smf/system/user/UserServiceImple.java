package kr.co.smf.system.user;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImple implements UserService {
    @Autowired
    private UserMapper userMapper;
	
	@Override
	public boolean addUser(User user) {
		if (!("U".equals(String.valueOf((user.getPermission()))))) {
			user.setPermission('M');
		}else {
			user.setPermission('U');
		}
		return userMapper.insertUserInfo(user) == 1 ? true : false;
	}

	@Override
	public List<User> viewUserList(Map<String, String> condition) {
		return userMapper.selectAllUserInfo(condition);
	}

	@Override
	public User viewUser(User user) {
		return userMapper.selectUserInfo(user);
	}

	@Override
	public boolean editUser(User user) {
		return userMapper.updateUserInfo(user) == 1 ? true : false;
	}

	@Override
	public boolean deleteUser(User user) {
		return userMapper.deleteUserInfo(user) == 1 ? true : false;
	}

}
