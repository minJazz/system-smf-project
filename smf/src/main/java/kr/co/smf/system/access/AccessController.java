package kr.co.smf.system.access;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.co.smf.system.user.User;

@Controller
public class AccessController {
	@Autowired
	AccessService accessService;

	@GetMapping("/login")
	public ModelAndView login(HttpSession httpSession, boolean remember) {

		return null;
	}

	@PostMapping("/login")
	public ModelAndView login(User user, HttpSession httpSession, HttpServletResponse response, boolean remember) {
		User checkUser = accessService.login(user);
		ModelAndView modelAndView = null;

		if (checkUser != null) {
			httpSession.setAttribute("userPhoneNumber", checkUser.getPhoneNumber());

			if ("U".equals(checkUser.getPermission())) {
				modelAndView = new ModelAndView("/user");
			} else {
				modelAndView = new ModelAndView("/userinfolist");
			}

			Cookie rememberCookie = new Cookie("REMEMBER", user.getPhoneNumber());
			if (remember) {
				rememberCookie.setMaxAge(60 * 60 * 24 * 30);
			} else {
				rememberCookie.setMaxAge(0);
			}
			response.addCookie(rememberCookie);
			modelAndView.addObject("user", checkUser);

			return modelAndView;
		} else {
			modelAndView = new ModelAndView("/login");
		}

		return modelAndView;
	}

	@GetMapping("/logout")
	public ModelAndView logout(HttpSession httpSession) {
		httpSession.invalidate();
		ModelAndView modelAndView = new ModelAndView(new RedirectView("/login"));

		return modelAndView;
	}
}
