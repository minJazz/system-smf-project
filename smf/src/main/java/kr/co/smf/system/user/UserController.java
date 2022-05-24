package kr.co.smf.system.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;
	
	@GetMapping("/form")
	public ModelAndView addUser() {
		return new ModelAndView("/WEB-INF/jsp/user/add.jsp");
	}
	
	@PostMapping
	public ModelAndView addUser(User user) {
		userService.addUser(user);
		return new ModelAndView(new RedirectView("/user"));
	}

	@GetMapping
	public ModelAndView viewAddList() {
		Map<String, String> condition = new HashMap<String, String>();
		
		ModelAndView mav = new ModelAndView("/user/list");
		mav.addObject("list", userService.viewUserList(condition));
		
		return mav;
	}
	
	@GetMapping(consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<User> viewAddList(
			@RequestBody(required = true)
			Map<String, String> condition) {
	    return userService.viewUserList(condition);
	}
	
	@GetMapping("/{no}/form")
	public ModelAndView editUser(@PathVariable String no) {
		User user = new User();
		user.setNo(Integer.valueOf(no));
		
		ModelAndView mav = new ModelAndView("/WEB-INF/jsp/user/edit.jsp");
		mav.addObject("user", user);
		
		return mav;
	}
	
	@PutMapping
	public ModelAndView editUser(User user) {
		userService.editUser(user);
		
		return new ModelAndView(new RedirectView("/user"));
	}

	@DeleteMapping
	@ResponseBody
	public List<User> removeUser(Map<String, String> condition) {
		User user = new User();
		user.setNo(Integer.valueOf(condition.get("no")));
		
		userService.deleteUser(user);
		
		condition = new HashMap<String, String>();
		
		return userService.viewUserList(condition);
	}
}
