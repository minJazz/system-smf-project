package kr.co.smf.system.access;

import org.springframework.stereotype.Service;

import kr.co.smf.system.user.User;

@Service
public interface AccessService {
	public User login(User user);
}
