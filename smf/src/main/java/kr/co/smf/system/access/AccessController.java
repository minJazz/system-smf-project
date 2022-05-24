package kr.co.smf.system.access;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
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
	public ModelAndView login(HttpSession httpSession,
			@CookieValue(value = "REMEMBER", required = false) Cookie cookie) {
		ModelAndView modelAndView = new ModelAndView("access/login");

		if (cookie != null) {
			modelAndView.addObject("remember", cookie.getValue());
			modelAndView.addObject("check", "checked");
		}

		return modelAndView;
	}

	@PostMapping("/login")
	public ModelAndView login(User user, HttpSession httpSession, HttpServletResponse response, boolean remember) {
//		User checkUser = accessService.login(user);
		User checkUser = user; // 삭제하고 위에 주석을 풀어야함
		ModelAndView modelAndView = null;

		if (checkUser != null) {
			httpSession.setAttribute("user", checkUser);

			if ("U".equals(checkUser.getPermission())) {
				modelAndView = new ModelAndView("smartfarm/user");
			} else {
				modelAndView = new ModelAndView("smartfarm/smartfarm");
			}

			Cookie rememberCookie = new Cookie("REMEMBER", checkUser.getPhoneNumber());

			if (remember) {
				rememberCookie.setMaxAge(60 * 60 * 24 * 30);
			} else {
				rememberCookie.setMaxAge(0);
			}

			response.addCookie(rememberCookie);

			return modelAndView;
		} else {
			modelAndView = new ModelAndView("access/login");
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
