package com.ddukddak.partner.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ddukddak.member.model.dto.Member;
import com.ddukddak.partner.model.dto.Partner;
import com.ddukddak.partner.model.dto.Project;
import com.ddukddak.partner.model.service.InteriorService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("interior")
@Controller
@RequiredArgsConstructor
@SessionAttributes({"loginMember"})
public class ContactInteriorController {
	
	private final InteriorService service;

	@GetMapping("interiorList")
	public String interiorList(Model model) {
		
		List<Partner> interiorList = service.selectInteriorList();
		
//		log.info("interiorList : " + interiorList.toString());

//		model.addAttribute("query", query);
		model.addAttribute("interiorList", interiorList);
		
		return "partner/interior/interiorList";
	}
	
	@GetMapping("interiorPortfolio/{portfolioNo:[0-9]+}")
	public String interiorPortfolio(@PathVariable("portfolioNo") int portfolioNo,
													@SessionAttribute(value="loginMember", required=false) Member loginMember,
													Model model,
													RedirectAttributes ra,
													HttpServletRequest req,
													HttpServletResponse resp) {

		List<Partner> portfolio = service.selectPortfolio(portfolioNo);
		List<Project> mainPortfolio = service.selectMain(portfolioNo);
        if (portfolio != null) {
            model.addAttribute("portfolio", portfolio);
            log.info("portfolio : " + portfolio);
        }
        if(mainPortfolio != null) {
        	model.addAttribute("mainPortfolio", mainPortfolio);
        	log.info("mainPortfolio : " + mainPortfolio);
        }
        return "partner/interior/interiorPortfolio";
	}
	
	private List<List<Project>> chunkBoards(List<Project> portfolio, int chunkSize) {
        List<List<Project>> portfolioChunks = new ArrayList<>();
        for (int i = 0; i < portfolio.size(); i += chunkSize) {
        	portfolioChunks.add(portfolio.subList(i, Math.min(i + chunkSize, portfolio.size())));
        }
        return portfolioChunks;
    }
	
	@GetMapping("interiorPortfolioDetail")
	public String interiorPortfolioDetail(Model model, @PathVariable("portfolioNo") int portfolioNo) {
		
		List<Project> portfolio = service.selectMain(portfolioNo);
		
		log.info("portfolio : " + portfolio.toString());
		List<List<Project>> portfolioChunks = chunkBoards(portfolio, 3);
		
		if (portfolio != null) {
			model.addAttribute("portfolio", portfolio);
			model.addAttribute("portfolioChunks", portfolioChunks);
			
		}
		
		return "partner/interior/projectDetail";
	}
	
}
