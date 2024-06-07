package com.ddukddak.myPage.model.mapper;

<<<<<<< HEAD
import org.apache.ibatis.annotations.Mapper;

import com.ddukddak.member.model.dto.Member;
=======
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ddukddak.member.model.dto.Member;

>>>>>>> 5d7dde5da7db498bbee33043b0f88b7fe8780a53
@Mapper
public interface MemberInfoMapper {

	/** 프로필 이미지 업데이트
	 * @param mem
	 * @return
	 */
	int updateImg(Member mem);

	/** memberNo에 해당하는 비밀번호 찾기
	 * @param memberNo
	 * @return
	 */
	String selectPw(int memberNo);

	/** 비밀번호 업데이트하기
	 * @param map
	 * @return
	 */
	int changePassword(Map<String, String> map);

	/** 이메일 중복 검사
	 * @param memberEmail
	 * @return
	 */
	int checkEmail(String memberEmail);


}
