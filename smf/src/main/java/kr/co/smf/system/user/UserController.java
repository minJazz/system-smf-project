package kr.co.smf.system.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class UserController {
	@Autowired
	private UserService userService;
}
