package com.ddukddak.partner.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ddukddak.partner.model.dto.Partner;

import lombok.RequiredArgsConstructor;

@RequestMapping("partner")
@Controller
@RequiredArgsConstructor
@SessionAttributes({"loginPartnerMember"})
public class InteriorController {
	
	@GetMapping("interiorList")
	public String interiorList() {
		
		return "partner/interior/interiorList";
		
	}

	@GetMapping("interiorPortfolio")
	public String interiorPortfolio() {
		return "partner/interior/interiorPortfolio";
	}

	//모델링
	@GetMapping("interior/modeling/main")
	public String modelingMain() {
		return "partner/interior/modeling/modelingMain";
	}
	
	@GetMapping("interior/modeling/estimate")
	public String modelingEstimate() {
		return "partner/interior/modeling/modelingEstimate";
	}
	
	@GetMapping("interiorPortfolioDetail")
	public String interiorPortfolioDetail() {
		return "partner/interior/interiorPortfolioDetail";
	}
	
	
	@GetMapping("interiorPortfolioEditMain")
    public String interiorPortfolioEditMain(@SessionAttribute("loginPartnerMember") Partner loginPartnerMember, RedirectAttributes ra) {
        if (loginPartnerMember.getPartnerType() != 1) {
            ra.addFlashAttribute("message", "접근 제한된 서비스 입니다");
            return "redirect:/partner/main";
        }
        return "partner/interior/interiorPortfolioEdit/interiorPortfolioEditMain";
    }
	
	@GetMapping("projectDetail")
	public String projectDetail() {
		return "partner/interior/interiorPortfolioEdit/projectDetail";
	}
	
	@GetMapping("interiorChatWithManager")
	public String interiorChatWithManager() {
		return "partner/interior/interiorChatWithManager/interiorChatWithManager";
	}
	
	@GetMapping("interiorChatWithManagerPopup")
	public String interiorChatWithManagerPopup() {
		return "partner/interior/interiorChatWithManager/interiorChatWithManagerPopup";
	}
	
	@GetMapping("interiorChatWithUser")
	public String interiorChatWithUser() {
		return "partner/interior/interiorChatWithUser/interiorChatWithUser";
	}
	
	@GetMapping("registProject")
	public String registProject() {
		return "partner/interior/interiorPortfolioEdit/registProject";
	}
}
