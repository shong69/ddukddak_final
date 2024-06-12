package com.ddukddak.common.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.resource.NoResourceFoundException;

@ControllerAdvice
public class ExceptionController {

	@ExceptionHandler(NoResourceFoundException.class) 
	public String notFound() {
		return "common/error/404";
	}
	
	@ExceptionHandler(Exception.class)
	public String allExceptionHandler(Exception e, Model model) {
		
		model.addAttribute("e", e);
		
		return "error/500";
	}
	
}
