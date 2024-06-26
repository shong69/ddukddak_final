document.addEventListener('DOMContentLoaded', function() {
    const slideshow = document.querySelector(".boardAdContainer");
    const adViewMore = document.querySelector('.adViewMore');

    let next = document.querySelector('.next');
    let prev = document.querySelector('.prev');

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
                slides[i].style.opacity = 0.2;
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

        function resetInterval() {
            clearInterval(slideInterval);
            slideInterval = setInterval(() => {
                plusSlides(1);
            }, 5000);
        }

        showSlides(slideIndex);
        resetInterval();

        if (next != null) {
            next.removeEventListener('click', onNextClick);
            next.addEventListener('click', onNextClick);
        }

        if (prev != null) {
            prev.removeEventListener('click', onPrevClick);
            prev.addEventListener('click', onPrevClick);
        }

        function onNextClick() {
            plusSlides(1);
            resetInterval();
        }

        function onPrevClick() {
            plusSlides(-1);
            resetInterval();
        }
    }
});


const likeCount = document.querySelector("#likeCount");
const boardLike = document.querySelector("#boardLike")

if(boardLike != null) {
  boardLike.addEventListener("click", e => {

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
  
      console.log(count);
  
      if(count == -1) {
        console.log("좋아요 실패");
        return;
      }
  
      likeCheck = likeCheck == 0 ? 1 : 0;
  
      e.target.classList.toggle("fa-regular");
      e.target.classList.toggle("fa-solid");
  
      likeCount.innerText = count;
  
    });
  
  })
}

// ===============================================================

// 집들이 게시글 삭제
const deleteBtn = document.querySelector("#deleteBtn");

if(deleteBtn != null) {
  deleteBtn.addEventListener("click", () => {

    console.log(boardNo);
  
    if(!confirm("해당 노하우 게시물을 삭제하기겠습니까?")) {
  
      alert("게시글 삭제가 취소되었습니다");
      return;
  
    }
  
    fetch("/tip/deleteTip?boardNo=" + boardNo + "&boardCode=" + boardCode, {
      method : "POST",
      headers : {"Content-Type" : "application/json"}
    })
    .then(resp => resp.text())
    .then(result => {
      
      if (result > 0) {
        alert("게시글 삭제가 완료되었습니다.");
        location.href = "/tip/main?boardCode=" + boardCode;
      } else {
        alert("게시글 삭제에 실패하였습니다.");
        location.href = "/tip/detail/" + boardNo;
      }
  
    })
    
  
  });
}

// ==================================================================

// 노하우 게시글 수정
const updateBtn = document.querySelector("#updateBtn");
if (updateBtn != null) {

  updateBtn.addEventListener("click", () => {
  
    location.href = "/tip/updateTip?boardNo=" + boardNo;
  
  });
}