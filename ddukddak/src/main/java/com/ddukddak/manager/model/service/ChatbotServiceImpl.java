package com.ddukddak.manager.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ddukddak.manager.NLPModel;
import com.ddukddak.manager.model.dto.InquiryCategory;
import com.ddukddak.manager.model.dto.RecommendAnswer;

@Service
public class ChatbotServiceImpl implements ChatbotService{

	//문의 카테고리
	@Override
	public List<InquiryCategory> getAllCategory() {
		// TODO Auto-generated method stub
		return null;
	}

	//답변 얻기
	@Override
	public RecommendAnswer recommendAnswer(String categoty, String inquiry, NLPModel nlpModel) {
		
		return null;
	}

}
