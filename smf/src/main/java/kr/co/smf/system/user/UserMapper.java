package kr.co.smf.system.user;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
	public boolean insertUserInfo(User user);
	
    public List<User> selectAllUserInfo(Map<String, String> condition);
    
	public User selectUserInfo(User user);
	
	public boolean updateUserInfo(User user);
	
	public boolean deleteUserInfo(User user);
	
}
