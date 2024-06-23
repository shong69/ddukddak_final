

//-------------------------------------------------------------

//1. 리뷰 등록 비동기 + (사진, 텍스트, 별점)도 올리기
//  1)사진 등록하기
let reviewImgFiles = [];
function readImgURLs(input) {
    if (input.files && input.files.length > 0) {
        const reviewImgBox = document.getElementById('reviewImgBox');
        const totalReviewImages = reviewImgBox.children.length + input.files.length;

        if (totalReviewImages > 6) {
            alert('리뷰 이미지는 최대 5개까지 추가할 수 있습니다.');
            return;
        }

        Array.from(input.files).forEach(file => {
            // 이미지 파일인지 확인
            if (!file.type.startsWith('image/')) {
                alert('이미지 파일만 선택할 수 있습니다.');
                return;
            }

            reviewImgFiles.push(file); // 파일을 배열에 추가

            const reader = new FileReader();
            reader.onload = function(e) {
                const previewContainer = document.createElement('div');
                previewContainer.classList.add('preview-image-container');

                const preview = document.createElement('img');
                preview.classList.add('preview-image');
                preview.src = e.target.result;
                previewContainer.appendChild(preview);

                const deleteButton = document.createElement('button');
                deleteButton.classList.add('delete-button');
                deleteButton.classList.add('fa-solid');
                deleteButton.classList.add('fa-trash-can');
                deleteButton.onclick = function() {
                    if (confirm("해당 사진을 삭제하시겠습니까?")) {
                        const index = Array.from(reviewImgBox.children).indexOf(previewContainer);
                        reviewImgFiles.splice(index, 1); // 배열에서 파일 제거
                        previewContainer.remove(); // 이미지 삭제
                    }
                };
                previewContainer.appendChild(deleteButton);

                reviewImgBox.appendChild(previewContainer);
            };
            reader.readAsDataURL(file);
        });

        // 리셋 input file field to allow adding the same file again
        input.value = '';
    }
}


//   2) 전체 별점 구해서 총 평점 내보내기
let reviewRating;  //별점

const stars = document.querySelectorAll(".fa-star");
console.log(stars);
stars.forEach((star, index) =>{
    star.addEventListener("click",()=>{
        if(!star.classList.contains("fill")){ //누른 별이 비어있는 경우
            for(let i = 0; i<=index; i++){
                console.log(i);
                stars[i].classList.remove('fa-regular');
                stars[i].classList.add('fa-solid');
                stars[i].classList.add('fill');
 
            }
            reviewRating = index + 1;
        }else{
            console.log(star.classList);
            for(let i = 4; i>=index; i--){
                
                stars[i].classList.remove('fa-solid');
                stars[i].classList.add('fa-regular');
                stars[i].classList.remove('fill');
            }
            reviewRating=0;
        }

    })
})
console.log(typeof productNo);

//  3) 비동기로 리뷰 작성(+수정)하기
function handleFormMissionReview(event) {
    event.preventDefault();

    const form = document.getElementById('reviewForm');
    const formData = new FormData(form);
    console.log(typeof formData);

    // 리뷰 이미지 파일을 FormData에 추가
    reviewImgFiles.forEach(file => {
        formData.append('reviewImgs', file);
    });
    
    //orderItemNo 추가
    const orderItemNoSelect = document.querySelector(".reviewOptSelect");
    const option = orderItemNoSelect.options[orderItemNoSelect.selectedIndex]; 
    const optionValue = orderItemNoSelect.options[orderItemNoSelect.selectedIndex].getAttribute("data-value"); //옵션명 가져오기
    console.log(optionValue);//옵션명 불러오기 여부 확인
    formData.append("orderItemNo", option.value);
    formData.append("optionValue", optionValue); 


    formData.append('reviewRating', reviewRating); // 별점 추가
    formData.append('productNo', productNo); //상품 번호 추가

    // FormData 내용을 콘솔에 출력 (모든 키와 값을 출력)
    for (let [key, value] of formData.entries()) {
        console.log(key, typeof value);
    }

    // reviewNo 가져오기
    const reviewNo = document.querySelector("#hiddenReviewNo").value;
    const url = reviewNo ? "/eCommerce/updateReview" : "/eCommerce/reviewPost";

    fetch(url, {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())
    .then(result => {
        console.log('result:', result);  
        if(result > 0){
            alert(reviewNo ? "리뷰가 수정되었습니다." : "리뷰가 등록되었습니다.");
            getReviewCount(productNo); //리뷰 개수 업데이트
            openReviewCheck(productNo); //리뷰 작성 가능 여부 
            getAvgReviewScore(productNo) // 평점 업데이트
            selectReviewList(productNo); // 리뷰 목록 새로 고침
        }else{
            alert(reviewNo ? "리뷰 수정 실패" : "리뷰 등록 실패");
            return;
        }
    })
    .catch((error) => {
        console.error('Error:', error);
        alert(reviewNo ? "리뷰 수정에 실패했습니다." : "리뷰 등록에 실패했습니다.");
        return;
    });

}

function calcleReviewSubmit(event){
     const commentContent = document.querySelector("#commentContent");
     commentContent.value = "";
     const productRate = document.querySelector("#productRate");
     console.log(productRate.children);
     for(let i = 0; i<productRate.childElementCount;i++){
        if(productRate.children[i].classList.contains("fa-solid")){
            productRate.children[i].classList.remove("fa-solid");
            productRate.children[i].classList.add("fa-regular");
        }
     }
     const reviewForm = document.querySelector("#reviewForm");
     reviewForm.classList.add("display-none");
     selectReviewList(productNo);
}




//2. 리뷰 열었을 때 선택한 멤버가 리뷰 작성 권한이 있는지(상품id과 주문테이블에 겹치는지) 확인
async function openReviewCheck(productNo){

    //리뷰 작성 권한 비동기로 알아오기
    const reviewForm = document.querySelector("#reviewForm");
    const optionDiv = document.querySelector("#optionDiv");

    //로그인 여부 확인
    if(typeof loginMember === 'undefined' || loginMember === null){
        reviewForm.classList.add('display-none');
        selectReviewList(productNo);
        return;
    }
    const reviewAuthList = await checkReviewAuth(productNo);
    console.log(reviewAuthList);
    if(reviewAuthList&& reviewAuthList.length > 0){//작성 하지 않은 리뷰가 존재하는 경우
        //id=reviewForm 노출시키기
        reviewForm.classList.remove('display-none');
        
        
        const existingSelect = document.querySelector("select.reviewOptSelect");
        if(existingSelect) {
            optionDiv.removeChild(existingSelect);
        }
        const div = document.createElement("div");
        div.innerText ="주문상품 기록";
        const select = document.createElement("select");
        select.classList.add("reviewOptSelect");
        
        //옵션 추가하기
        reviewAuthList.forEach(item =>{
            const option = document.createElement("option");
            option.value = `${item.orderItemNo}`;
            option.innerHTML = `주문일:${item.orderDate} | 주문옵션:${item.optionValue} ${item.orderQuantity}개`;
            option.setAttribute("data-value", `${item.optionValue}`); //data-value에 optionvalue 넣어서 옵션명 리뷰에 저장하기
            select.append(option);
            console.log(option);
        })
        optionDiv.append(div,select);
    }else{
        reviewForm.classList.add('display-none');
    }
    
    //리뷰 리스트 알아오기
    selectReviewList(productNo);
}

//3. 리뷰 작성 가능 주문 상품 목록
async function checkReviewAuth(productNo){
    try {
        const response = await fetch("/eCommerce/checkReviewAuth?productNo=" + productNo);
        const result = await response.json();
        return result;
    } catch (error) {
        console.error('Error:', error);
        return [];
    }
}


//4. 리뷰 리스트 불러오기
function selectReviewList(productNo){
    console.log(productNo);
    fetch("/eCommerce/selectReviewList?productNo="+productNo)
    .then(resp=>resp.json())
    .then(result => {
        const reviewList = result;
        const reviewContainer = document.getElementById("reviewContainer");
        reviewContainer.innerHTML = "";

        if(reviewList == null || reviewList.length == 0){
            const li = document.createElement("li");
            li.classList.add("noReviewLi");
            const div = document.createElement("div");
            div.innerHTML = "-리뷰가 존재하지 않습니다-";
            div.classList.add("noReviewArea");
            li.append(div);
            reviewContainer.append(li);
        }else{
            reviewList.forEach(review=>{
                const li = document.createElement("li");
                li.classList.add("reviewRow");

                if(review.reviewDelFl == 'Y'){
                    const delDiv = document.createElement("div");
                    delDiv.classList.add("deleteReviewArea");
                    li.append(delDiv);
                }else{
                    const reviewWrite =document.createElement("div");
                    reviewWrite.classList.add("reviewWrite");

                    const infoArea = document.createElement("div");
                    infoArea.classList.add("infoArea");

                    const memberId = document.createElement("span");
                    memberId.classList.add("memberId");
                    memberId.textContent = `@${review.memberId}`; //멤버 아이디 적기
                    const commentWriteDate = document.createElement("span");
                    commentWriteDate.classList.add("commentWriteDate");
                    if(review.reviewUpdateDate != null){
                        commentWriteDate.textContent = review.reviewUpdateDate; //리뷰 작성일 적기
                    }
                    commentWriteDate.textContent = review.reviewCreateDate; //리뷰 작성일 적기

                    infoArea.append(memberId, commentWriteDate);

                    const editArea = document.createElement("div");
                    editArea.classList.add("editArea");
                    editArea.style.display=loginMemberNo && review.memberNo == loginMemberNo?"block":"none";  // 작성한 멤버면 display = "block"; 주기

                    const updateBtn = document.createElement("button");
                    updateBtn.classList.add("updateBtn");
                    updateBtn.textContent = "수정";
                    updateBtn.onclick=function(){
                        updateFn(review.reviewNo, productNo)
                    };
                    const delBtn = document.createElement("button");
                    delBtn.classList.add("delBtn");
                    delBtn.textContent = "삭제";
                    delBtn.onclick=function(){
                        delReview(review.reviewNo, productNo)
                    };

                    
                    editArea.append(updateBtn, delBtn);                    
                    reviewWrite.append(editArea, infoArea);
                    li.append(reviewWrite);

                    //이미지 배열 추가----------------------------------
                    console.log(review.imgList);
                    if (review.imgList && review.imgList.length > 0) {
                        const reviewImg = document.createElement("div");
                        reviewImg.classList.add("reviewImg");
                        const imgRow = document.createElement("div");

                        review.imgList.forEach(imgUrl => {
                            console.log(imgUrl);
                            const img = document.createElement("img");
                            img.src = imgUrl;
                            img.classList.add("oneReviewImg");
                            imgRow.append(img);
                        });

                        reviewImg.append(imgRow); 
                        li.append(reviewImg);
                    }


                    //옵션, 별점-----------------------------------------
                    const additionalInfoArea = document.createElement("div");
                    additionalInfoArea.classList.add("additionalInfoArea");

                    const rateDiv =  document.createElement("span");
                    rateDiv.classList.add("rateDiv");
                    const rateTitle = document.createElement("span");
                    rateTitle.innerText="별점";
                    rateDiv.append(rateTitle);
                    const optionValue = document.createElement("span");
                    optionValue.classList.add("optionValue");
                    optionValue.innerText = `[ ${review.optionValue} ]`;

                    const stars = [];
                    for (let i = 0; i < 5; i++) {
                        const star = document.createElement("span");
                        star.classList.add("fa-star");
                        if (i < review.reviewRating) {
                            star.classList.add("fa-solid");
                        } else {
                            star.classList.add("fa-regular");
                        }
                        stars.push(star);
                    }
                    
                    rateDiv.append(...stars);
                    additionalInfoArea.append(rateDiv, optionValue);

                    //리뷰 콘텐트 추가-------------------------------------------------
                    
                    const contentArea = document.createElement("div");
                    contentArea.classList.add("reviewContent");

                    const content = document.createElement("p");
                    content.classList.add("content");
                    contentArea.append(content);
                    content.innerText = review.reviewContent;

                    li.append(additionalInfoArea, contentArea);

                    // - 리뷰 콘텐트 더보기 버튼
                    const moreBtn = document.createElement('input');
                    moreBtn.classList.add("moreBtn");
                    moreBtn.type = "checkbox";

                    contentArea.append(moreBtn);
  
                reviewContainer.append(li);
                }
            });
        }

    })
    .catch(error => console.error('Error:', error));
}



//5. 내가 쓴 리뷰 삭제 비동기
function delReview(reviewNo,productNo){
    if(confirm("정말 리뷰를 삭제하시겠습니까?")){
        fetch(`/eCommerce/delReview?reviewNo=${reviewNo}`, {
            method: 'DELETE'
        })
        .then(resp => resp.text())
        .then(result => {
            if (result ==1) {
                alert("리뷰가 삭제되었습니다.");
                selectReviewList(productNo); // 리뷰 목록 새로 고침
            } else {
                alert("리뷰 삭제에 실패했습니다.");
            }
        })
        .catch(error => console.error('Error:', error));
    }
    getReviewCount(productNo);//개수 업데이트
}



//6. 내가 쓴 리뷰 수정하기 비동기
function updateFn(reviewNo,productNo) {
    //리뷰 불러오기
    fetch("/eCommerce/reloadReview?reviewNo="+reviewNo)
    .then(resp => resp.json())
    .then(result =>{
        if(result == null){
            //리뷰 불러오기 실패
            alert("리뷰 수정 실패");
            return;
        }
        //수정 영역 안보이도록
        const editAreas = document.querySelectorAll(".editArea");
        console.log(editAreas,"didi");
        editAreas.forEach(editArea=>{
            
            editArea.style.display = "none";
            console.log(editArea.display);
        }) 

        //#review 에 내용 넣기
        const review = result;
        console.log(review);
        const reviewForm = document.querySelector("#reviewForm");
        if(reviewForm.classList.contains("display-none")){
            reviewForm.classList.remove("display-none");
        }


        //주문 옵션
        const div = document.createElement("div");
        div.innerText ="주문상품";
        const select = document.createElement("select");
        select.classList.add("reviewOptSelect");
        
        //옵션 추가하기
        const option = document.createElement("option");
        option.value = `${review.orderItemNo}`;
        option.innerHTML = `주문일:${review.orderDate} | 주문옵션:${review.optionValue} ${review.orderQuantity}개`;
        option.setAttribute("data-value", `${review.optionValue}`); //data-value에 optionvalue 넣어서 옵션명 리뷰에 저장하기
        select.append(option);
        console.log(option);
        const optionDiv = document.querySelector("#optionDiv"); 
        optionDiv.append(div,select);

        // 리뷰 내용
        const commentContent = document.querySelector("#commentContent");
        commentContent.value = review.reviewContent;

        // 별점 채우기
        const stars = reviewForm.querySelectorAll(".fa-star");
        stars.forEach((star, index) => {
            if (index < review.reviewRating) {
                star.classList.remove('fa-regular');
                star.classList.add('fa-solid');
                star.classList.add('fill');
            } else {
                star.classList.remove('fa-solid');
                star.classList.add('fa-regular');
                star.classList.remove('fill');
            }
        });
        reviewRating = review.reviewRating; // 리뷰 별점 저장


        const reviewImgBox = document.querySelector('#reviewImgBox');
        reviewImgBox.innerHTML = ''; // 기존 이미지 초기화
        reviewImgFiles = []; // 이미지 파일 배열 초기화
        if(review.imgList && review.imgList.length>0){
            review.imgList.forEach(img=>{
                const previewContainer = document.createElement('div');
                previewContainer.classList.add('preview-image-container');

                const preview = document.createElement('img');
                preview.classList.add('preview-image');
                preview.src = img;
                previewContainer.appendChild(preview);

                const deleteButton = document.createElement('button');
                deleteButton.classList.add('delete-button');
                deleteButton.classList.add('fa-solid');
                deleteButton.classList.add('fa-trash-can');
                deleteButton.onclick = function() {
                    if (confirm("해당 사진을 삭제하시겠습니까?")) {
                        const index = Array.from(reviewImgBox.children).indexOf(previewContainer);
                        reviewImgFiles.splice(index, 1); // 배열에서 파일 제거
                        previewContainer.remove(); // 이미지 삭제
                    }
                };
                previewContainer.appendChild(deleteButton);

                reviewImgBox.appendChild(previewContainer);
            });
        reviewForm.scrollIntoView({behavior : 'smooth'});
        }
        document.querySelector("#hiddenReviewNo").value = reviewNo;
    });
    getReviewCount(productNo); //개수 업데이트

}


//전체 리뷰 개수 

async function getReviewCount(productNo) {
    
    try{
        const response = await fetch("/eCommerce/reviewCount?productNo="+productNo);
        const result = await response.text();
        const num = result;
        
        const reviewCounts = document.querySelectorAll(".totalReviewCount");
        reviewCounts.forEach(reviewCount =>{
            reviewCount.innerHTML = num;
        });
    }catch(error){
        console.log("ERROR : ",error);
    }

}

async function getAvgReviewScore(productNo) {
    
    try{
        const response = await fetch("/eCommerce/getAvgReviewScore?productNo="+productNo);
        const result = await response.text();

        const totalRating = document.querySelector(".totalRating");
        totalRating.innerHTML = result;
    }catch(error){
        console.log("ERROR : ",error);
    }

}
getReviewCount(productNo);

getAvgReviewScore(productNo);