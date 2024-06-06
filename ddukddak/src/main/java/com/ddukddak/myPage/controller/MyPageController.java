package com.ddukddak.myPage.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ddukddak.member.model.dto.Member;
import com.ddukddak.myPage.model.service.MemberInfoService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("myPage")
@SessionAttributes("loginMember")
@RequiredArgsConstructor
public class MyPageController {
	private final MemberInfoService infoService;
	
	@GetMapping("")
	public String main() {
		return"myPage/myPageMain";
	}
	
	@GetMapping("wishList")
	public String wishList() {
		return"myPage/wishList";
	}
	
	@GetMapping("cart")
	public String cart() {
		return "myPage/cart";
	}
	
	
	//회원정보 진입
	@GetMapping("memberInfo")
	public String memberInfo() {
		return"myPage/memberInfo";
	}
	
//	/**[회원정보] 프로필 이미지 변경
//	 * @return
//	 * @throws Exception 
//	 */
//	@PostMapping("memberInfo/profileImg")  -> 동기 방식
//	public String changeProfileImg(
//				@RequestParam("profile-image") MultipartFile profileImg,
//				@SessionAttribute("loginMember") Member loginMember,
//				RedirectAttributes ra
//				) throws Exception{
//		int result = infoService.updateImg(profileImg, loginMember);
//		String message = null;
//		
//		if(result > 0) message = "프로필 이미지가 변경되었습니다.";
//		else		   message = "프로필 이미지 변경 실패 \n다시 시도해주세요";
//		
//		ra.addFlashAttribute("message", message);
//		
//		return"redirect:/myPage/memberInfo";
//	}
	
	/**[회원정보] 프로필 이미지 변경 - 비동기
	 * @param file
	 * @param loginMemebr
	 * @return
	 * @throws Exception
	 */
//	@PostMapping("memberInfo/profileImg")
//	@ResponseBody
//	public ResponseEntity<String> changeProfileImg(
//			@RequestParam("profile-image") MultipartFile file,
//			@SessionAttribute("loginMember") Member loginMemebr) throws Exception{
//		int result  = infoService.updateImg(file, loginMemebr);
//		
//		if(result >0) return ResponseEntity.ok().build();
//		else return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
//
//		
//	}
	
	
	
	
	/**[회원정보]비밀번호 변경 -비동기
	 * @return
	 */
	@ResponseBody
	@GetMapping("memberInfo/password")
	public Map<String, String> changePassword(
			@RequestBody Map<String, String> map,
			@SessionAttribute("loginMember") Member mem) {
		
		int memberNo = mem.getMemberNo();
		
		int result = infoService.changePassword(map, memberNo);
		
		String message=null;
		Map<String, String> response = new HashMap<>();
		if(result>0) message = "비밀번호가 변경되었습니다.";
		else 		 message = "비밀번호 변경 실패\n다시 시도해주세요.";
		
		response.put("message", message);
		return response;
		
	}
	
	
	/**[회원정보] 이메일 중복 확인
	 * @param memberEmail
	 * @return
	 */
	@ResponseBody
	@GetMapping("memberInfo/emailDup")
	public int checkEmail(@RequestParam("memberEmail") String memberEmail) {
		return infoService.checkEmail(memberEmail);
	}
	
	@PostMapping("memberInfo/nickname")
	public String changeNickname() {
		return"";
	}
	
	@PostMapping("memberInfo/phoneNum")
	public String changePhoneNum() {
		return "";
	}
}