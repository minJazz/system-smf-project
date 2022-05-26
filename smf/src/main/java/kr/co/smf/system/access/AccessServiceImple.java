package kr.co.smf.system.access;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.smf.system.user.User;
import kr.co.smf.system.user.UserMapper;

@Service
public class AccessServiceImple implements AccessService {
	@Autowired
	UserMapper userMapper;

	@Override
	public User login(User user) {
		return userMapper.selectUserInfo(user);
	}
}
