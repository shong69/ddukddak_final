
// ul 태그(댓글 목록 감싸는 요소)
const ul = document.getElementById("commentList");

const selectCommentList = () => {

  fetch("/comment?boardNo=" + boardNo)
    .then(resp => resp.json())
    .then(commentList => {

      console.log(commentList);

      console.log(ul);

      ul.innerHTML = ""; // 기존 댓글 목록 삭제

      // commentList 안에 comment 에 각각 접근하는 반복문
      for (let comment of commentList) {

        // 행 생성
        const commentContainer = document.createElement("li");
        commentContainer.classList.add("commentContainer");
        // console.log(commentContainer);

        if (comment.parentCommentNo != 0) {
          commentContainer.classList.add("child-comment");
        }

        if (comment.commentDelFl == 'Y') {
          commentContainer.innerText = "삭제된 댓글입니다.";
        }
        // 삭제되지 않은 댓글

        // 작성자 영역 포함하는 div 생성, class 추가
        const commentUser = document.createElement("div");
        commentUser.classList.add("commentUser");

        // 프로필 이미지, 닉네임, 날짜 감싸는 요소
        const userInfo = document.createElement("div");
        userInfo.classList.add("userInfo");

        commentUser.append(userInfo);

        //console.log(commentUser);

        const profileImg = document.createElement("img");

        if (comment.profileImg == null) profileImg.src = userDefaultImage; // 기본이미지
        else profileImg.src = comment.profileImg;

        // 닉네임
        const nickname = document.createElement("h3");
        nickname.innerText = comment.memberNickname;

        // 날짜(작성일)
        const commentDate = document.createElement("h4");
        commentDate.innerText = comment.commentWriteDate;

        // 작성자 영역(userInfo) 에 프로필 닉네임 날짜 추가
        userInfo.append(profileImg, nickname, commentDate);

        // console.log("userInfo : ",userInfo);
        // ========================================================================

        // 댓글 + 버튼 Area 담을 div 생성, class 추가
        const commentContentArea = document.createElement("div");
        commentContentArea.classList.add("commentContentArea");

        // 댓글 담을 div 생성, class 추가
        const displayComment = document.createElement("div");
        displayComment.classList.add("displayComment");

        //   // 댓글 내용

        const commentContent = document.createElement("h3");
        commentContent.classList.add("commentContent");
        commentContent.innerText = comment.commentContent;

        displayComment.append(commentContent);

        // 버튼 담을 div 생성, class 추가
        const commentBtnArea = document.createElement("div");
        commentBtnArea.classList.add("commentBtnArea");




        // -----------------------------------------------------

        // 로그인한 회원번호가 댓글 작성자 회원번호와 같을 때
        // 댓글 수정/삭제 버튼 출력
        if (loginMemberNo != null && loginMemberNo == comment.memberNo) {

          // 수정 버튼
          const updateBtn = document.createElement("div");
          updateBtn.innerText = "수정";

          updateBtn.setAttribute("onclick",
            `showUpdateComment(${comment.commentNo}, this)`);

          // 삭제 버튼
          const deleteBtn = document.createElement("div");
          deleteBtn.innerText = "삭제";

          deleteBtn.setAttribute("onclick",
            `deleteComment(${comment.commentNo})`);

          // 버튼 영역에 수정, 삭제 버튼 추가
          commentBtnArea.append(updateBtn, deleteBtn);

        }

        //   // 답글 버튼
        const childCommentBtn = document.createElement("div");
        childCommentBtn.innerText = "답글";

        commentBtnArea.append(childCommentBtn);



        // 영역 합치기
        commentContentArea.append(displayComment, commentBtnArea);
        commentContainer.append(commentUser, commentContentArea);

        // }

        ul.prepend(commentContainer);

      }

    })

}

// =================================================================================

// ** 댓글 등록(Ajax) **

function redirectToLogin() {
  const currentUrl = window.location.href;
  
  window.location.href = `/member/login?returnUrl=${encodeURIComponent(currentUrl)}`;
  
}

const insertComment = document.querySelector("#insertComment");
const inputCommentContent = document.querySelector("#inputCommentContent");
const commentCount = document.querySelector("#commentCount");

insertComment.addEventListener("click", () => {

  if (loginMemberNo == null) {
    alert("로그인 후 이용해주세요.");
    redirectToLogin();
    return;
  }

  if (inputCommentContent.value.trim().length == 0) {

    alert("댓글 내용을 입력해주세요.");
    inputCommentContent.focus();
    return;

  }

  const data = {
    "commentContent": inputCommentContent.value,
    "boardNo": boardNo,
    "memberNo": loginMemberNo
  };

  fetch("/comment", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data)
  })
    .then(resp => resp.text())
    .then(result => {

      if (result > 0) {
        console.log(result);
        alert("댓글이 등록되었습니다.");
        inputCommentContent.value = "";
        
        selectCommentList();
      } else {
        console.log(result);
        alert("댓글 등록에 실패하였습니다.");
      }

    })
    .catch(err => console.log(err));

});

/* 이미지 */
const slideshow = document.querySelector(".boardAdContainer");
const adViewMore = document.querySelector('.adViewMore');

const next = document.querySelector('.next');
const prev = document.querySelector('.prev');

if (slideshow != null) {
  let slideIndex = 1;
  let slideInterval;

  function showSlides(n) {
    let i;
    let slides = document.getElementsByClassName("mySlides");
    if (n > slides.length) { slideIndex = 1; }
    if (n < 1) { slideIndex = slides.length; }
    for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";
      slides[i].style.opacity = 0.4;
    }
    slides[slideIndex - 1].style.display = "block";
    setTimeout(() => {
      slides[slideIndex - 1].style.opacity = 1;
    }, 30);
    if (adViewMore != null) {

      adViewMore.textContent = `${slideIndex} / ${slides.length}`;
    }
  }

  function plusSlides(n) {
    slideIndex += n;
    showSlides(slideIndex);
    resetInterval();
  }

  function currentSlide(n) {
    slideIndex = n;
    showSlides(slideIndex);
    resetInterval();
  }

  function resetInterval() {
    clearInterval(slideInterval);
    slideInterval = setInterval(() => {
      plusSlides(1);
    }, 5000);
  }

  showSlides(slideIndex);

  resetInterval();
  if (next != null) {
    next.addEventListener('click', () => {
      plusSlides(1);
      resetInterval();
    });
  }

  if (prev != null) {
    prev.addEventListener('click', () => {
      plusSlides(-1);
      resetInterval();
    });
  }
}

// ===============================================================
// 좋아요

document.querySelector("#boardLike").addEventListener("click", e => {

  if(loginMemberNo == null) {
    alert("로그인 후 이용해주세요.");
    return;
  }

  const obj = {
    "memberNo" : loginMemberNo,
    "boardNo" : boardNo,
    "likeCheck" : likeCheck
  }

  // 좋아요 INSERT / DELETE 비동기 요청
  fetch("/board/like", {
    method : "POST",
    headers : {"Content-Type" : "application/json"},
    body : JSON.stringify(obj)
  })
  .then(resp => resp.text())
  .then(count => {

    if(count == -1) {
      console.log("좋아요 실패");
      return;
    }

    likeCheck = likeCheck == 0 ? 1 : 0;

    e.target.classList.toggle("fa-regular");
    e.target.classList.toggle("fa-solid");

    e.target.nextElementSibiling.innerText = count;

  });

})