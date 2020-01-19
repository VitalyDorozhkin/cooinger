package ru.pparalax.cooinger.controller;

import net.bytebuddy.implementation.bind.annotation.BindingPriority;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import ru.pparalax.cooinger.domain.User;
import ru.pparalax.cooinger.domain.dto.CaptchaResponceDto;
import ru.pparalax.cooinger.service.UserService;

import javax.validation.Valid;
import java.util.Collection;
import java.util.Collections;
import java.util.Map;

@Controller
public class RegistrationController {

    private final static String CAPTCHA_URL = "https://www.google.com/recaptcha/api/siteverify?secret=%s&response=%s";

    @Autowired
    private UserService userService;

    @Autowired
    private RestTemplate restTemplate;

    @Value("${recaptcha.secret}")
    private String secret;

    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }

    @PostMapping("/registration")
    public String addUser(
            @RequestParam("passwordConfirm") String passwordConfirm,
            @RequestParam("g-recaptcha-response") String captchaResponce,
            @Valid User user,
            BindingResult bindingResult,
            Model model
    ) {

        String url = String.format(CAPTCHA_URL, secret, captchaResponce);
        CaptchaResponceDto response = restTemplate.postForObject(url, Collections.emptyList(), CaptchaResponceDto.class);

        boolean isCaptchaError = (response == null || !response.isSuccess());
        if(isCaptchaError){
            model.addAttribute("captchaError", "Fill captcha");
        }

        boolean isConfirmEmpty = (passwordConfirm == null || passwordConfirm.isEmpty());
        if (isConfirmEmpty) {
            model.addAttribute("passwordConfirmError", "Passwords confirmation cannot be empty");
        }

        boolean isPasswordsDifferent= (user.getPassword() != null && !user.getPassword().equals(passwordConfirm));
        if (isPasswordsDifferent) {
            model.addAttribute("passwordError", "Passwords are different!");
        }

        if (isCaptchaError || isConfirmEmpty || isPasswordsDifferent || bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);

            model.mergeAttributes(errors);

            return "registration";
        }

        if (!userService.addUser(user)) {
            model.addAttribute("usernameError", "User exists!");
            return "registration";
        }

        return "redirect:/login";
    }

    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code){
        boolean isActivated = userService.activateUser(code);
        model.addAttribute("message", isActivated ? "User successfully activated" : "Activation code is not found!");
        model.addAttribute("messageType", isActivated ? "success" : "danger");
        return "login";
    }
}
