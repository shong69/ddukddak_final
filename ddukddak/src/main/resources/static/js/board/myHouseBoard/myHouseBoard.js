const myHouseDetail = document.querySelector("#myHouseDetail");
const boardCreateBtn = document.querySelector("#boardCreateBtn");


if (myHouseDetail != null) {
    myHouseDetail.addEventListener("click", () => {
    
        location.href="/myHouse/detail";
    
    });
}

if (boardCreateBtn != null) {
    boardCreateBtn.addEventListener("click", () => {
    
        location.href="/myHouse/registMyHouse";
    
    });
}

// ===============================================================================

document.querySelector("#searchBtn").addEventListener("click", () => {


});