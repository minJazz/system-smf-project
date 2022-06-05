package kr.co.smf.system.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.co.smf.system.agent.Agent;
import kr.co.smf.system.util.Navigator;

@RestController
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;

	@Autowired
	private Navigator navigator;

	@GetMapping("/form")
	public ModelAndView addUser() {
		return new ModelAndView("/user/add");
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
	public List<User> viewAddList(@RequestParam Map<String, String> condition) {
		List<User> users = userService.viewUserList(condition);


		Map<String, String> allCondition = new HashMap<String, String>();
		allCondition.putAll(condition);
		allCondition.remove("pageNo");
		List<User> allUsers = userService.viewUserList(allCondition);

		String navigatorHtml = navigator.getNavigator(allUsers.size(), Integer.parseInt(condition.get("pageNo")));

		User user = new User();
		user.setName(navigatorHtml);

		users.add(0, user);
		return users;
	}

	@GetMapping("/{no}/form")
	public ModelAndView editUser(@PathVariable String no) {
		User user = new User();
		user.setNo(Integer.valueOf(no));

		user = userService.viewUser(user);

		ModelAndView mav = new ModelAndView("/user/edit");
		mav.addObject("serviceUser", user);

		return mav;
	}

	@PutMapping
	public ModelAndView editUser(User user) {
		userService.editUser(user);

		return new ModelAndView(new RedirectView("/user"));
	}

	@DeleteMapping
	@ResponseBody
	public List<User> removeUser(@RequestBody Map<String, String> condition) {
		User user = new User();
		user.setNo(Integer.valueOf(condition.get("no")));

		userService.deleteUser(user);

		condition = new HashMap<String, String>();

		return userService.viewUserList(condition);
	}
}
