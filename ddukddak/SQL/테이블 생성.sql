CREATE TABLE "ORDERS" (
	"ORDER_NO"	NUMBER		NOT NULL,
	"ORDER_DATE"	DATE		NOT NULL,
	"TOTAL_PRICE"	NUMBER		NOT NULL,
	"ORDER_STATUS"	NVARCHAR2(50)	DEFAULT '결제대기'	NOT NULL,
	"ORDER_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"DELIVERY_ID"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "ORDERS"."ORDER_NO" IS '주문번호(PK)';

COMMENT ON COLUMN "ORDERS"."ORDER_DATE" IS '주문날짜';

COMMENT ON COLUMN "ORDERS"."TOTAL_PRICE" IS '총주문금액';

COMMENT ON COLUMN "ORDERS"."ORDER_STATUS" IS '주문상태';

COMMENT ON COLUMN "ORDERS"."ORDER_DEL_FL" IS '주문취소여부';

COMMENT ON COLUMN "ORDERS"."MEMBER_NO" IS '회원번호(FK)';

COMMENT ON COLUMN "ORDERS"."DELIVERY_ID" IS '배송번호';

CREATE TABLE "COMMUNITY" (
	"BOARD_NO"	NUMBER		NOT NULL,
	"BOARD_TITLE"	NVARCHAR2(100)		NOT NULL,
	"BOARD_CONTENT"	NVARCHAR2(1000)		NOT NULL,
	"BOARD_WRITE_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"BOARD_UPDATE_DATE"	DATE		NULL,
	"READ_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"BOARD_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"BOARD_TYPE"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "COMMUNITY"."BOARD_NO" IS '게시물번호';

COMMENT ON COLUMN "COMMUNITY"."BOARD_TITLE" IS '게시글 제목';

COMMENT ON COLUMN "COMMUNITY"."BOARD_CONTENT" IS '게시물내용';

COMMENT ON COLUMN "COMMUNITY"."BOARD_WRITE_DATE" IS '게시글 작성날짜';

COMMENT ON COLUMN "COMMUNITY"."BOARD_UPDATE_DATE" IS '게시글 수정날짜';

COMMENT ON COLUMN "COMMUNITY"."READ_COUNT" IS '게시글조회수';

COMMENT ON COLUMN "COMMUNITY"."BOARD_DEL_FL" IS '게시글삭제여부(Y/N)';

COMMENT ON COLUMN "COMMUNITY"."MEMBER_NO" IS '회원번호(FK)';

COMMENT ON COLUMN "COMMUNITY"."BOARD_TYPE" IS '커뮤니티 유형(1:집들이 / 2:노하우)';

CREATE TABLE "PRODUCT" (
	"PRODUCT_NO"	NUMBER		NOT NULL,
	"PRODUCT_NAME"	NVARCHAR2(100)		NOT NULL,
	"PRODUCT_PRICE"	NUMBER		NOT NULL,
	"PRODUCT_CREATE_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"PRODUCT_UPDATE_DATE"	DATE		NOT NULL,
	"PRODUCT_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"CATEGORY_NO"	NUMBER		NOT NULL,
	"OPTION_ID"	NUMBER		NOT NULL,
	"PARTNER_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "PRODUCT"."PRODUCT_NO" IS '상품번호(PK)';

COMMENT ON COLUMN "PRODUCT"."PRODUCT_NAME" IS '상품명';

COMMENT ON COLUMN "PRODUCT"."PRODUCT_PRICE" IS '상품가격';

COMMENT ON COLUMN "PRODUCT"."PRODUCT_CREATE_DATE" IS '상품등록일';

COMMENT ON COLUMN "PRODUCT"."PRODUCT_UPDATE_DATE" IS '상품수정일';

COMMENT ON COLUMN "PRODUCT"."PRODUCT_FL" IS 'N/Y';

COMMENT ON COLUMN "PRODUCT"."CATEGORY_NO" IS '카테고리아이디(FK)';

COMMENT ON COLUMN "PRODUCT"."OPTION_ID" IS '옵션아이디(FK)';

COMMENT ON COLUMN "PRODUCT"."PARTNER_NO" IS '시공사번호(FK)';

CREATE TABLE "WISHLIST" (
	"MEMBER_NO"	NUMBER		NOT NULL,
	"PRODUCT_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "WISHLIST"."MEMBER_NO" IS '회원번호(FK)';

COMMENT ON COLUMN "WISHLIST"."PRODUCT_NO" IS '상품번호(FK)';

CREATE TABLE "CHATTING_ROOM" (
	"CHATTING_NO"	NUMBER		NOT NULL,
	"CHATTING_CREATE_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"PARTNER_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "CHATTING_ROOM"."CHATTING_NO" IS '채팅방번호(PK)';

COMMENT ON COLUMN "CHATTING_ROOM"."CHATTING_CREATE_DATE" IS '채팅방생성날짜';

COMMENT ON COLUMN "CHATTING_ROOM"."MEMBER_NO" IS '회원번호(FK)';

COMMENT ON COLUMN "CHATTING_ROOM"."PARTNER_NO" IS '시공사번호(FK)';

CREATE TABLE "CHATTING_MESSAGE" (
	"MESSAGE_NO"	NUMBER		NOT NULL,
	"MESSAGE_CONTENT"	NVARCHAR2(1000)		NOT NULL,
	"READ_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"SEND_TIME"	DATE	DEFAULT SYSDATE	NOT NULL,
	"SENDER_NO"	NUMBER		NOT NULL,
	"CHATTING_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "CHATTING_MESSAGE"."MESSAGE_NO" IS '메시지번호(PK)';

COMMENT ON COLUMN "CHATTING_MESSAGE"."MESSAGE_CONTENT" IS '메시지내용';

COMMENT ON COLUMN "CHATTING_MESSAGE"."READ_FL" IS '읽음 여부';

COMMENT ON COLUMN "CHATTING_MESSAGE"."SEND_TIME" IS '메시지발신시간';

COMMENT ON COLUMN "CHATTING_MESSAGE"."SENDER_NO" IS '발신회원번호';

COMMENT ON COLUMN "CHATTING_MESSAGE"."CHATTING_NO" IS '채팅방번호(FK)';

CREATE TABLE "REPORT" (
	"REPORT_NO"	NUMBER		NOT NULL,
	"REPORTED_MEMBER_NO"	NUMBER		NOT NULL,
	"REPORT_REASON"	NVARCHAR2(200)		NOT NULL,
	"REPORT_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "REPORT"."REPORT_NO" IS '신고번호(PK)';

COMMENT ON COLUMN "REPORT"."REPORTED_MEMBER_NO" IS '피신고자회원번호';

COMMENT ON COLUMN "REPORT"."REPORT_REASON" IS '신고사유';

COMMENT ON COLUMN "REPORT"."REPORT_DATE" IS '신고날짜';

COMMENT ON COLUMN "REPORT"."MEMBER_NO" IS '회원번호(FK)';

COMMENT ON COLUMN "REPORT"."BOARD_NO" IS '게시물번호';

CREATE TABLE "PORTFOLIO" (
	"PORTFOLIO_NO"	NUMBER		NOT NULL,
	"PORTFOLIO_DETAIL"	NVARCHAR2(500)		NULL,
	"HOME_LINK"	NVARCHAR2(300)		NULL,
	"PARTNER_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "PORTFOLIO"."PORTFOLIO_NO" IS '포트폴리오번호(PK)';

COMMENT ON COLUMN "PORTFOLIO"."PORTFOLIO_DETAIL" IS '업체 설명';

COMMENT ON COLUMN "PORTFOLIO"."HOME_LINK" IS '업체 홈페이지 링크';

COMMENT ON COLUMN "PORTFOLIO"."PARTNER_NO" IS '시공사번호(FK)';

CREATE TABLE "PROJECT" (
	"PROJECT_NO"	NUMBER		NOT NULL,
	"PROJECT_NAME"	NVARCHAR2(100)		NOT NULL,
	"PORTFOLIO_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "PROJECT"."PROJECT_NO" IS '프로젝트번호(PK)';

COMMENT ON COLUMN "PROJECT"."PROJECT_NAME" IS '프로젝트명';

COMMENT ON COLUMN "PROJECT"."PORTFOLIO_NO" IS '포트폴리오번호(FK)';

CREATE TABLE "CATEGORY" (
	"CATEGORY_NO"	NUMBER		NOT NULL,
	"CATEGORY_NAME"	NVARCHAR2(50)		NOT NULL,
	"BIG_CATEGORY_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "CATEGORY"."CATEGORY_NO" IS '카테고리아이디(PK)';

COMMENT ON COLUMN "CATEGORY"."CATEGORY_NAME" IS '카테고리이름';

COMMENT ON COLUMN "CATEGORY"."BIG_CATEGORY_NO" IS '카테고리아이디(FK)';

CREATE TABLE "ORDER_DETAIL" (
	"ORDER_ITEM_NO"	NUMBER		NOT NULL,
	"ORDER_QUANTITY"	NUMBER	DEFAULT 1	NOT NULL,
	"ORDER_PRICE"	NUMBER		NOT NULL,
	"ORDER_NO"	NUMBER		NOT NULL,
	"PRODUCT_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "ORDER_DETAIL"."ORDER_ITEM_NO" IS '주문상품번호(PK)';

COMMENT ON COLUMN "ORDER_DETAIL"."ORDER_QUANTITY" IS '주문수량';

COMMENT ON COLUMN "ORDER_DETAIL"."ORDER_PRICE" IS '주문가격';

COMMENT ON COLUMN "ORDER_DETAIL"."ORDER_NO" IS '주문번호(FK)';

COMMENT ON COLUMN "ORDER_DETAIL"."PRODUCT_NO" IS '상품번호(FK)';

CREATE TABLE "CART" (
	"CART_ID"	NUMBER		NOT NULL,
	"PRODUCT_COUNT"	NUMBER	DEFAULT 1	NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"PRODUCT_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "CART"."PRODUCT_COUNT" IS '상품수량';

COMMENT ON COLUMN "CART"."MEMBER_NO" IS '회원번호(FK)';

COMMENT ON COLUMN "CART"."PRODUCT_NO" IS '상품번호(FK)';

CREATE TABLE "REVIEW" (
	"REVIEW_NO"	NUMBER		NOT NULL,
	"REVIEW_CONTENT"	NVARCHAR2(500)		NOT NULL,
	"REVIEW_CREATE_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"REVIEW_UPDATE_DATE"	DATE		NULL,
	"REVIEW_RATING"	NUMBER	DEFAULT 0	NOT NULL,
	"PRODUCT_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"ORDER_ITEM_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "REVIEW"."REVIEW_NO" IS '리뷰번호(PK)';

COMMENT ON COLUMN "REVIEW"."REVIEW_CONTENT" IS '리뷰내용';

COMMENT ON COLUMN "REVIEW"."REVIEW_CREATE_DATE" IS '리뷰작성시간';

COMMENT ON COLUMN "REVIEW"."REVIEW_UPDATE_DATE" IS '리뷰수정시간';

COMMENT ON COLUMN "REVIEW"."REVIEW_RATING" IS '리뷰평점(1~5)';

COMMENT ON COLUMN "REVIEW"."PRODUCT_NO" IS '상품번호(FK)';

COMMENT ON COLUMN "REVIEW"."MEMBER_NO" IS '회원번호(FK)';

COMMENT ON COLUMN "REVIEW"."ORDER_ITEM_NO" IS '주문상품번호(FK)';

CREATE TABLE "SMS_AUTH" (
	"SMS_KEY_NO"	NUMBER		NOT NULL,
	"SMS_TEL"	NVARCHAR2(11)		NOT NULL,
	"SMS_AUTH_KEY"	CHAR(6)		NOT NULL,
	"SMS_CREATE_TIME"	DATE	DEFAULT SYSDATE	NOT NULL
);

COMMENT ON COLUMN "SMS_AUTH"."SMS_KEY_NO" IS '인증키 구분 번호(시퀀스)';

COMMENT ON COLUMN "SMS_AUTH"."SMS_TEL" IS '인증 번호';

COMMENT ON COLUMN "SMS_AUTH"."SMS_AUTH_KEY" IS '인증키';

COMMENT ON COLUMN "SMS_AUTH"."SMS_CREATE_TIME" IS '인증키 생성 시간';

CREATE TABLE "EMAIL_AUTH" (
	"KEY_NO"	NUMBER		NOT NULL,
	"EMAIL"	NVARCHAR2(50)		NOT NULL,
	"AUTH_KEY"	CHAR(6)		NOT NULL,
	"CREATE_TIME"	DATE	DEFAULT SYSDATE	NOT NULL
);

COMMENT ON COLUMN "EMAIL_AUTH"."KEY_NO" IS '인증키 구분 번호(시퀀스)';

COMMENT ON COLUMN "EMAIL_AUTH"."EMAIL" IS '인증 이메일';

COMMENT ON COLUMN "EMAIL_AUTH"."AUTH_KEY" IS '인증 키';

COMMENT ON COLUMN "EMAIL_AUTH"."CREATE_TIME" IS '인증키 생성 시간';

CREATE TABLE "UPLOAD_FILE" (
	"PROJECT_IMG_NO"	NUMBER		NOT NULL,
	"PROJECT_IMG_PATH"	NVARCHAR2(200)		NOT NULL,
	"PROJECT_IMG_OG_NAME"	NVARCHAR2(50)		NOT NULL,
	"PROJECT_IMG_RENAME"	NVARCHAR2(50)		NOT NULL,
	"PROJECT_IMG_ORDER"	NUMBER		NOT NULL,
	"CATEGORY"	NUMBER		NOT NULL,
	"PRODUCT_NO"	NUMBER		NULL,
	"BOARD_NO"	NUMBER		NULL,
	"REVIEW_NO"	NUMBER		NULL,
	"PROJECT_NO"	NUMBER		NULL
);

COMMENT ON COLUMN "UPLOAD_FILE"."PROJECT_IMG_NO" IS '프로젝트 이미지 번호(PK)';

COMMENT ON COLUMN "UPLOAD_FILE"."PROJECT_IMG_PATH" IS '프로젝트 이미지 요청 경로';

COMMENT ON COLUMN "UPLOAD_FILE"."PROJECT_IMG_OG_NAME" IS '프로젝트 이미지 원본명';

COMMENT ON COLUMN "UPLOAD_FILE"."PROJECT_IMG_RENAME" IS '프로젝트 이미지 변경명';

COMMENT ON COLUMN "UPLOAD_FILE"."PROJECT_IMG_ORDER" IS '프로젝트 이미지 순서';

COMMENT ON COLUMN "UPLOAD_FILE"."CATEGORY" IS '카테고리별 이미지 업로드';

COMMENT ON COLUMN "UPLOAD_FILE"."PRODUCT_NO" IS '상품번호(FK) : 상품등록시';

COMMENT ON COLUMN "UPLOAD_FILE"."BOARD_NO" IS '게시물번호';

COMMENT ON COLUMN "UPLOAD_FILE"."REVIEW_NO" IS '리뷰번호(FK)';

COMMENT ON COLUMN "UPLOAD_FILE"."PROJECT_NO" IS '프로젝트번호(FK)';

CREATE TABLE "PROJECT_INFO" (
	"PROJECT_INFO_NO"	NUMBER		NOT NULL,
	"HOUSING_TYPE"	NVARCHAR2(20)		NOT NULL,
	"WORK_FORM"	NVARCHAR2(20)		NOT NULL,
	"WORK_AREA"	NUMBER		NOT NULL,
	"CONSTRUCTION_COST"	NUMBER		NOT NULL,
	"REGION"	NVARCHAR2(20)		NOT NULL,
	"CONSTRUCTION_YEAR"	CHAR(4)		NOT NULL,
	"FAMILY_SIZE"	NVARCHAR2(20)		NOT NULL,
	"MAIN_PROJECT_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"PROJECT_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "PROJECT_INFO"."PROJECT_INFO_NO" IS '프로젝트 정보 번호(PK)';

COMMENT ON COLUMN "PROJECT_INFO"."HOUSING_TYPE" IS '주거 형태';

COMMENT ON COLUMN "PROJECT_INFO"."WORK_FORM" IS '작업 분류';

COMMENT ON COLUMN "PROJECT_INFO"."WORK_AREA" IS '작업면적';

COMMENT ON COLUMN "PROJECT_INFO"."CONSTRUCTION_COST" IS '시공비용';

COMMENT ON COLUMN "PROJECT_INFO"."REGION" IS '작업 지역';

COMMENT ON COLUMN "PROJECT_INFO"."CONSTRUCTION_YEAR" IS '시공연도(연도만)';

COMMENT ON COLUMN "PROJECT_INFO"."FAMILY_SIZE" IS '가족형태';

COMMENT ON COLUMN "PROJECT_INFO"."MAIN_PROJECT_FL" IS '메인프로젝트 여부';

COMMENT ON COLUMN "PROJECT_INFO"."PROJECT_NO" IS '프로젝트번호(FK)';

CREATE TABLE "BIG_CATEGORY" (
	"BIG_CATEGORY_NO"	NUMBER		NOT NULL,
	"BIG_CATEGORY_NAME"	NVARCHAR2(50)		NOT NULL
);

COMMENT ON COLUMN "BIG_CATEGORY"."BIG_CATEGORY_NO" IS '카테고리아이디(PK)';

COMMENT ON COLUMN "BIG_CATEGORY"."BIG_CATEGORY_NAME" IS '카테고리이름';

CREATE TABLE "OPTION" (
	"OPTION_ID"	NUMBER		NOT NULL,
	"OPTION_NAME"	NVARCHAR2(100)		NOT NULL,
	"OPTION_VALUE"	NVARCHAR2(100)		NOT NULL,
	"PRODUCT_COUNT"	NUMBER	DEFAULT 0	NOT NULL
);

COMMENT ON COLUMN "OPTION"."OPTION_ID" IS '옵션아이디';

COMMENT ON COLUMN "OPTION"."OPTION_NAME" IS '옵션이름';

COMMENT ON COLUMN "OPTION"."OPTION_VALUE" IS '옵션값';

COMMENT ON COLUMN "OPTION"."PRODUCT_COUNT" IS '상품재고개수';

CREATE TABLE "PARTNER_TYPE" (
	"PARTNER_TYPE"	NUMBER		NOT NULL,
	"PARTNER_NAME"	NVARCHAR2(3)		NOT NULL
);

COMMENT ON COLUMN "PARTNER_TYPE"."PARTNER_TYPE" IS '파트너유형(1: 시공사 / 2:판매자)';

COMMENT ON COLUMN "PARTNER_TYPE"."PARTNER_NAME" IS '유형이름';

CREATE TABLE "MEMBER" (
	"MEMBER_NO"	NUMBER		NOT NULL,
	"MEMBER_ID"	NVARCHAR2(50)		NOT NULL,
	"MEMBER_EMAIL"	NVARCHAR2(50)		NOT NULL,
	"MEMBER_PW"	NVARCHAR2(50)		NOT NULL,
	"MEMBER_NAME" NVARCHAR2(20) NOT NULL,
	"MEMBER_NICKNAME"	NVARCHAR2(20)		NOT NULL,
	"MEMBER_TEL"	NVARCHAR2(11)		NULL,
	"MEBMER_ADDR"	NVARCHAR2(100)		NOT NULL,
	"MEMBER_POINT"	NUMBER	DEFAULT 0	NOT NULL,
	"PROFILE_IMG"	NVARCHAR2(150)		NULL,
	"ENROLL_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"MEMBER_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"AUTHORITY"	NUMBER	DEFAULT 1	NOT NULL,
	"SOCIAL_LOGIN_TYPE"	CHAR(1)	DEFAULT 'D'	NOT NULL
);

COMMENT ON COLUMN "MEMBER"."MEMBER_NO" IS '회원번호(PK)';

COMMENT ON COLUMN "MEMBER"."MEMBER_ID" IS '회원아이디';

COMMENT ON COLUMN "MEMBER"."MEMBER_EMAIL" IS '회원이메일';

COMMENT ON COLUMN "MEMBER"."MEMBER_PW" IS '회원비밀번호';

COMMENT ON COLUMN "MEMBER"."MEMBER_NICKNAME" IS '회원닉네임';

COMMENT ON COLUMN "MEMBER"."MEMBER_TEL" IS '회원전화번호';

COMMENT ON COLUMN "MEMBER"."MEBMER_ADDR" IS '회원주소';

COMMENT ON COLUMN "MEMBER"."MEMBER_POINT" IS '회원포인트';

COMMENT ON COLUMN "MEMBER"."PROFILE_IMG" IS '프로필이미지';

COMMENT ON COLUMN "MEMBER"."ENROLL_DATE" IS '회원가입일';

COMMENT ON COLUMN "MEMBER"."MEMBER_DEL_FL" IS '회원탈퇴여부(Y/N)';

COMMENT ON COLUMN "MEMBER"."AUTHORITY" IS '권한(일반회원:1/관리자:2)';

COMMENT ON COLUMN "MEMBER"."SOCIAL_LOGIN_TYPE" IS '일반D/네이버N/카카오K';

CREATE TABLE "DELIVERY" (
	"DELIVERY_ID"	NUMBER		NOT NULL,
	"DELIVERY_ADDRESS"	NVARCHAR2(100)		NOT NULL,
	"DELIVERY_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL
);

COMMENT ON COLUMN "DELIVERY"."DELIVERY_ID" IS '배송번호';

COMMENT ON COLUMN "DELIVERY"."DELIVERY_ADDRESS" IS '배송주소';

COMMENT ON COLUMN "DELIVERY"."DELIVERY_FL" IS '배송상태';

CREATE TABLE "PROFILE_IMG" (
	"PROFILE_IMG_NO"	NUMBER		NOT NULL,
	"PROFILE_IMG_PATH"	NVARCHAR2(200)		NOT NULL,
	"PROFILE_IMG_OG_NAME"	NVARCHAR2(50)		NOT NULL,
	"PROFILE_IMG_RENAME"	NVARCHAR2(50)		NOT NULL,
	"PROFILE_IMG_ORDER"	NUMBER		NOT NULL,
	"CATEGORY"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NULL,
	"PARTNER_NO"	NUMBER		NULL
);

COMMENT ON COLUMN "PROFILE_IMG"."PROFILE_IMG_NO" IS '프로젝트 이미지 번호(PK)';

COMMENT ON COLUMN "PROFILE_IMG"."PROFILE_IMG_PATH" IS '프로젝트 이미지 요청 경로';

COMMENT ON COLUMN "PROFILE_IMG"."PROFILE_IMG_OG_NAME" IS '프로젝트 이미지 원본명';

COMMENT ON COLUMN "PROFILE_IMG"."PROFILE_IMG_RENAME" IS '프로젝트 이미지 변경명';

COMMENT ON COLUMN "PROFILE_IMG"."PROFILE_IMG_ORDER" IS '프로젝트 이미지 순서';

COMMENT ON COLUMN "PROFILE_IMG"."CATEGORY" IS '카테고리별 이미지 업로드';

COMMENT ON COLUMN "PROFILE_IMG"."MEMBER_NO" IS '회원번호(FK) : 이미지업로드회원';

COMMENT ON COLUMN "PROFILE_IMG"."PARTNER_NO" IS '시공사번호(FK)';

CREATE TABLE "BOARD_TYPE" (
	"BOARD_TYPE"	NUMBER		NOT NULL,
	"BOARD_NAME"	NVARCHAR2(50)		NOT NULL
);

COMMENT ON COLUMN "BOARD_TYPE"."BOARD_TYPE" IS '커뮤니티 유형(1:집들이 / 2:노하우)';

COMMENT ON COLUMN "BOARD_TYPE"."BOARD_NAME" IS '커뮤니티 이름';

CREATE TABLE "BOARD_LIKE" (
	"MEMBER_NO"	NUMBER		NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "BOARD_LIKE"."MEMBER_NO" IS '회원번호(PK)';

COMMENT ON COLUMN "BOARD_LIKE"."BOARD_NO" IS '게시물번호';

CREATE TABLE "PAYMENT" (
	"PAYMENT_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"ORDER_NO"	NUMBER		NOT NULL,
	"IMP_UID"	NVARCHAR2(300)		NULL,
	"MERCHANT_UID"	NVARCHAR2(300)		NULL,
	"CUSTOMER_UID"	NVARCHAR2(300)		NULL,
	"CUSTOMER_UID_USAGE"	NVARCHAR2(300)		NULL,
	"STARTED_AT"	NUMBER		NULL,
	"STATUS"	NVARCHAR2(300)		NULL,
	"FAIL_REASON"	NVARCHAR2(300)		NULL,
	"FAILED_AT"	NUMBER		NULL,
	"PAID_AT"	NUMBER		NULL,
	"CANCEL_REASON"	NVARCHAR2(300)		NULL,
	"CANCEL_AMOUNT"	NUMBER		NULL,
	"CANCELLED_AT"	NUMBER		NULL,
	"AMOUNT"	NUMBER		NULL,
	"CURRENCY"	NVARCHAR2(300)		NULL,
	"PAY_METHOD"	NVARCHAR2(300)		NULL,
	"NAME"	NVARCHAR2(300)		NULL,
	"BUYER_NAME"	NVARCHAR2(300)		NULL,
	"BUYER_TEL"	NVARCHAR2(300)		NULL,
	"BUYER_EMAIL"	NVARCHAR2(300)		NULL,
	"BUYER_POSTCODE"	NVARCHAR2(300)		NULL,
	"BUYER_ADDR"	NVARCHAR2(300)		NULL,
	"PG_ID"	NVARCHAR2(300)		NULL,
	"PG_TID"	NVARCHAR2(300)		NULL,
	"PG_PROVIDER"	NVARCHAR2(300)		NULL,
	"CARD_CODE"	NVARCHAR2(300)		NULL,
	"CARD_NAME"	NVARCHAR2(300)		NULL,
	"CARD_TYPE"	NUMBER		NULL,
	"CARD_NUMBER"	NVARCHAR2(300)		NULL,
	"CARD_QUOTA"	NUMBER		NULL,
	"APPLY_NUM"	NVARCHAR2(300)		NULL,
	"CUSTOM_DATA"	NVARCHAR2(300)		NULL,
	"ESCROW"	NVARCHAR2(300)		NULL
);

COMMENT ON COLUMN "PAYMENT"."MEMBER_NO" IS '회원번호(FK)';

COMMENT ON COLUMN "PAYMENT"."ORDER_NO" IS '주문번호(FK)';

COMMENT ON COLUMN "PAYMENT"."IMP_UID" IS '포트원거래고유번호';

COMMENT ON COLUMN "PAYMENT"."MERCHANT_UID" IS '가맹점주문번호';

COMMENT ON COLUMN "PAYMENT"."CUSTOMER_UID" IS '구매자 결제수단 식별 고유번호(빌링키)';

COMMENT ON COLUMN "PAYMENT"."CUSTOMER_UID_USAGE" IS '구매자 결제 수단 식별 고유번호 사용 구분코드';

COMMENT ON COLUMN "PAYMENT"."STARTED_AT" IS '결제 요청 시각';

COMMENT ON COLUMN "PAYMENT"."STATUS" IS '결제 상태(미결제/결제완료/결제취소/결제실패)';

COMMENT ON COLUMN "PAYMENT"."FAIL_REASON" IS '실패 사유';

COMMENT ON COLUMN "PAYMENT"."FAILED_AT" IS '실패 시각';

COMMENT ON COLUMN "PAYMENT"."PAID_AT" IS '결제 시각';

COMMENT ON COLUMN "PAYMENT"."CANCEL_REASON" IS '취소 사유';

COMMENT ON COLUMN "PAYMENT"."CANCEL_AMOUNT" IS '취소 금액';

COMMENT ON COLUMN "PAYMENT"."CANCELLED_AT" IS '취소 시각';

COMMENT ON COLUMN "PAYMENT"."AMOUNT" IS '결제 금액';

COMMENT ON COLUMN "PAYMENT"."CURRENCY" IS '결제 통화구분코드(KRW,USD...)';

COMMENT ON COLUMN "PAYMENT"."PAY_METHOD" IS '결제 방법';

COMMENT ON COLUMN "PAYMENT"."NAME" IS '결제 이름';

COMMENT ON COLUMN "PAYMENT"."BUYER_NAME" IS '주문자 이름';

COMMENT ON COLUMN "PAYMENT"."BUYER_TEL" IS '주문자 전화번호';

COMMENT ON COLUMN "PAYMENT"."BUYER_EMAIL" IS '주문자 이메일';

COMMENT ON COLUMN "PAYMENT"."BUYER_POSTCODE" IS '주문자 우편변호';

COMMENT ON COLUMN "PAYMENT"."BUYER_ADDR" IS '주문자 주소';

COMMENT ON COLUMN "PAYMENT"."PG_ID" IS 'PG사 상점 아이디';

COMMENT ON COLUMN "PAYMENT"."PG_TID" IS 'PG사 거래번호';

COMMENT ON COLUMN "PAYMENT"."PG_PROVIDER" IS 'PG사 구분코드';

COMMENT ON COLUMN "PAYMENT"."CARD_CODE" IS '카드 코드';

COMMENT ON COLUMN "PAYMENT"."CARD_NAME" IS '카드사 이름';

COMMENT ON COLUMN "PAYMENT"."CARD_TYPE" IS '카드 유형(0 : 신용 / 1 : 체크)';

COMMENT ON COLUMN "PAYMENT"."CARD_NUMBER" IS '카드번호(dddd-dddd-dddd-dddd)';

COMMENT ON COLUMN "PAYMENT"."CARD_QUOTA" IS '카드 할부 개월수';

COMMENT ON COLUMN "PAYMENT"."APPLY_NUM" IS '신용카드 승인번호';

COMMENT ON COLUMN "PAYMENT"."CUSTOM_DATA" IS '고객 추가 정보';

COMMENT ON COLUMN "PAYMENT"."ESCROW" IS '에스크로 결제 여부';

CREATE TABLE "COMMENT" (
	"COMMENT_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL,
	"COMMENT_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"COMMENT_CONTENT"	NVARCHAR2(500)		NOT NULL,
	"COMMENT_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL
);

COMMENT ON COLUMN "COMMENT"."COMMENT_NO" IS '댓글번호(PK)';

COMMENT ON COLUMN "COMMENT"."MEMBER_NO" IS '회원번호(FK)';

COMMENT ON COLUMN "COMMENT"."BOARD_NO" IS '게시물번호';

COMMENT ON COLUMN "COMMENT"."COMMENT_DATE" IS '댓글등록날짜';

COMMENT ON COLUMN "COMMENT"."COMMENT_CONTENT" IS '댓글내용';

COMMENT ON COLUMN "COMMENT"."COMMENT_DEL_FL" IS '댓글삭제여부';

CREATE TABLE "PARTNER" (
	"PARTNER_NO"	NUMBER		NOT NULL,
	"PARTNER_ID"	NVARCHAR2(50)		NOT NULL,
	"PARTNER_PW"	NVARCHAR2(50)		NOT NULL,
	"PARTNER_TEL"	NVARCHAR2(50)		NOT NULL,
	"PARTNER_BUSINESS_NAME"	NVARCHAR2(30)		NOT NULL,
	"PARTNER_CEO_NAME"	NVARCHAR2(20)		NOT NULL,
	"PARTNER_BUSINESS_NUM"	NVARCHAR2(10)		NOT NULL,
	"PARTNER_TYPE"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "PARTNER"."PARTNER_NO" IS '시공사번호(PK)';

COMMENT ON COLUMN "PARTNER"."PARTNER_ID" IS '시공사아이디';

COMMENT ON COLUMN "PARTNER"."PARTNER_PW" IS '시공사비밀번호';

COMMENT ON COLUMN "PARTNER"."PARTNER_TEL" IS '시공사전화번호';

COMMENT ON COLUMN "PARTNER"."PARTNER_BUSINESS_NAME" IS '시공사상호명';

COMMENT ON COLUMN "PARTNER"."PARTNER_CEO_NAME" IS '시공사대표자명';

COMMENT ON COLUMN "PARTNER"."PARTNER_BUSINESS_NUM" IS '시공사사업자등록번호';

COMMENT ON COLUMN "PARTNER"."PARTNER_TYPE" IS '유형번호(1: 시공사 / 2:판매자)';

CREATE TABLE "ORDER_RECEIPT" (
	"PARTNER_NO"	NUMBER		NOT NULL,
	"ORDER_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "ORDER_RECEIPT"."PARTNER_NO" IS '시공사번호(PK)';

COMMENT ON COLUMN "ORDER_RECEIPT"."ORDER_NO" IS '주문번호(PK)';

ALTER TABLE "ORDERS" ADD CONSTRAINT "PK_ORDERS" PRIMARY KEY (
	"ORDER_NO"
);

ALTER TABLE "COMMUNITY" ADD CONSTRAINT "PK_COMMUNITY" PRIMARY KEY (
	"BOARD_NO"
);

ALTER TABLE "PRODUCT" ADD CONSTRAINT "PK_PRODUCT" PRIMARY KEY (
	"PRODUCT_NO"
);

ALTER TABLE "CHATTING_ROOM" ADD CONSTRAINT "PK_CHATTING_ROOM" PRIMARY KEY (
	"CHATTING_NO"
);

ALTER TABLE "CHATTING_MESSAGE" ADD CONSTRAINT "PK_CHATTING_MESSAGE" PRIMARY KEY (
	"MESSAGE_NO"
);

ALTER TABLE "REPORT" ADD CONSTRAINT "PK_REPORT" PRIMARY KEY (
	"REPORT_NO"
);

ALTER TABLE "PORTFOLIO" ADD CONSTRAINT "PK_PORTFOLIO" PRIMARY KEY (
	"PORTFOLIO_NO"
);

ALTER TABLE "PROJECT" ADD CONSTRAINT "PK_PROJECT" PRIMARY KEY (
	"PROJECT_NO"
);

ALTER TABLE "CATEGORY" ADD CONSTRAINT "PK_CATEGORY" PRIMARY KEY (
	"CATEGORY_NO"
);

ALTER TABLE "ORDER_DETAIL" ADD CONSTRAINT "PK_ORDER_DETAIL" PRIMARY KEY (
	"ORDER_ITEM_NO"
);

ALTER TABLE "CART" ADD CONSTRAINT "PK_CART" PRIMARY KEY (
	"CART_ID"
);

ALTER TABLE "REVIEW" ADD CONSTRAINT "PK_REVIEW" PRIMARY KEY (
	"REVIEW_NO"
);

ALTER TABLE "SMS_AUTH" ADD CONSTRAINT "PK_SMS_AUTH" PRIMARY KEY (
	"SMS_KEY_NO"
);

ALTER TABLE "EMAIL_AUTH" ADD CONSTRAINT "PK_EMAIL_AUTH" PRIMARY KEY (
	"KEY_NO"
);

ALTER TABLE "UPLOAD_FILE" ADD CONSTRAINT "PK_UPLOAD_FILE" PRIMARY KEY (
	"PROJECT_IMG_NO"
);

ALTER TABLE "PROJECT_INFO" ADD CONSTRAINT "PK_PROJECT_INFO" PRIMARY KEY (
	"PROJECT_INFO_NO"
);

ALTER TABLE "BIG_CATEGORY" ADD CONSTRAINT "PK_BIG_CATEGORY" PRIMARY KEY (
	"BIG_CATEGORY_NO"
);

ALTER TABLE "OPTION" ADD CONSTRAINT "PK_OPTION" PRIMARY KEY (
	"OPTION_ID"
);

ALTER TABLE "PARTNER_TYPE" ADD CONSTRAINT "PK_PARTNER_TYPE" PRIMARY KEY (
	"PARTNER_TYPE"
);

ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
	"MEMBER_NO"
);

ALTER TABLE "DELIVERY" ADD CONSTRAINT "PK_DELIVERY" PRIMARY KEY (
	"DELIVERY_ID"
);

ALTER TABLE "PROFILE_IMG" ADD CONSTRAINT "PK_PROFILE_IMG" PRIMARY KEY (
	"PROFILE_IMG_NO"
);

ALTER TABLE "BOARD_TYPE" ADD CONSTRAINT "PK_BOARD_TYPE" PRIMARY KEY (
	"BOARD_TYPE"
);

ALTER TABLE "PAYMENT" ADD CONSTRAINT "PK_PAYMENT" PRIMARY KEY (
	"PAYMENT_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "PK_COMMENT" PRIMARY KEY (
	"COMMENT_NO"
);

ALTER TABLE "PARTNER" ADD CONSTRAINT "PK_PARTNER" PRIMARY KEY (
	"PARTNER_NO"
);

ALTER TABLE "ORDERS" ADD CONSTRAINT "FK_MEMBER_TO_ORDERS_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "ORDERS" ADD CONSTRAINT "FK_DELIVERY_TO_ORDERS_1" FOREIGN KEY (
	"DELIVERY_ID"
)
REFERENCES "DELIVERY" (
	"DELIVERY_ID"
);

ALTER TABLE "COMMUNITY" ADD CONSTRAINT "FK_MEMBER_TO_COMMUNITY_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "COMMUNITY" ADD CONSTRAINT "FK_BOARD_TYPE_TO_COMMUNITY_1" FOREIGN KEY (
	"BOARD_TYPE"
)
REFERENCES "BOARD_TYPE" (
	"BOARD_TYPE"
);

ALTER TABLE "PRODUCT" ADD CONSTRAINT "FK_CATEGORY_TO_PRODUCT_1" FOREIGN KEY (
	"CATEGORY_NO"
)
REFERENCES "CATEGORY" (
	"CATEGORY_NO"
);

ALTER TABLE "PRODUCT" ADD CONSTRAINT "FK_OPTION_TO_PRODUCT_1" FOREIGN KEY (
	"OPTION_ID"
)
REFERENCES "OPTION" (
	"OPTION_ID"
);

ALTER TABLE "PRODUCT" ADD CONSTRAINT "FK_PARTNER_TO_PRODUCT_1" FOREIGN KEY (
	"PARTNER_NO"
)
REFERENCES "PARTNER" (
	"PARTNER_NO"
);

ALTER TABLE "WISHLIST" ADD CONSTRAINT "FK_MEMBER_TO_WISHLIST_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "WISHLIST" ADD CONSTRAINT "FK_PRODUCT_TO_WISHLIST_1" FOREIGN KEY (
	"PRODUCT_NO"
)
REFERENCES "PRODUCT" (
	"PRODUCT_NO"
);

ALTER TABLE "CHATTING_ROOM" ADD CONSTRAINT "FK_MEMBER_TO_CHATTING_ROOM_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "CHATTING_ROOM" ADD CONSTRAINT "FK_PARTNER_TO_CHATTING_ROOM_1" FOREIGN KEY (
	"PARTNER_NO"
)
REFERENCES "PARTNER" (
	"PARTNER_NO"
);

ALTER TABLE "CHATTING_MESSAGE" ADD CONSTRAINT "FK_CHATTING_ROOM_TO_CHATTING_MESSAGE_1" FOREIGN KEY (
	"CHATTING_NO"
)
REFERENCES "CHATTING_ROOM" (
	"CHATTING_NO"
);

ALTER TABLE "REPORT" ADD CONSTRAINT "FK_MEMBER_TO_REPORT_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "REPORT" ADD CONSTRAINT "FK_COMMUNITY_TO_REPORT_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "COMMUNITY" (
	"BOARD_NO"
);

ALTER TABLE "PORTFOLIO" ADD CONSTRAINT "FK_PARTNER_TO_PORTFOLIO_1" FOREIGN KEY (
	"PARTNER_NO"
)
REFERENCES "PARTNER" (
	"PARTNER_NO"
);

ALTER TABLE "PROJECT" ADD CONSTRAINT "FK_PORTFOLIO_TO_PROJECT_1" FOREIGN KEY (
	"PORTFOLIO_NO"
)
REFERENCES "PORTFOLIO" (
	"PORTFOLIO_NO"
);

ALTER TABLE "CATEGORY" ADD CONSTRAINT "FK_BIG_CATEGORY_TO_CATEGORY_1" FOREIGN KEY (
	"BIG_CATEGORY_NO"
)
REFERENCES "BIG_CATEGORY" (
	"BIG_CATEGORY_NO"
);

ALTER TABLE "ORDER_DETAIL" ADD CONSTRAINT "FK_ORDERS_TO_ORDER_DETAIL_1" FOREIGN KEY (
	"ORDER_NO"
)
REFERENCES "ORDERS" (
	"ORDER_NO"
);

ALTER TABLE "ORDER_DETAIL" ADD CONSTRAINT "FK_PRODUCT_TO_ORDER_DETAIL_1" FOREIGN KEY (
	"PRODUCT_NO"
)
REFERENCES "PRODUCT" (
	"PRODUCT_NO"
);

ALTER TABLE "CART" ADD CONSTRAINT "FK_MEMBER_TO_CART_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "CART" ADD CONSTRAINT "FK_PRODUCT_TO_CART_1" FOREIGN KEY (
	"PRODUCT_NO"
)
REFERENCES "PRODUCT" (
	"PRODUCT_NO"
);

ALTER TABLE "REVIEW" ADD CONSTRAINT "FK_PRODUCT_TO_REVIEW_1" FOREIGN KEY (
	"PRODUCT_NO"
)
REFERENCES "PRODUCT" (
	"PRODUCT_NO"
);

ALTER TABLE "REVIEW" ADD CONSTRAINT "FK_MEMBER_TO_REVIEW_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "REVIEW" ADD CONSTRAINT "FK_ORDER_DETAIL_TO_REVIEW_1" FOREIGN KEY (
	"ORDER_ITEM_NO"
)
REFERENCES "ORDER_DETAIL" (
	"ORDER_ITEM_NO"
);

ALTER TABLE "UPLOAD_FILE" ADD CONSTRAINT "FK_PRODUCT_TO_UPLOAD_FILE_1" FOREIGN KEY (
	"PRODUCT_NO"
)
REFERENCES "PRODUCT" (
	"PRODUCT_NO"
);

ALTER TABLE "UPLOAD_FILE" ADD CONSTRAINT "FK_COMMUNITY_TO_UPLOAD_FILE_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "COMMUNITY" (
	"BOARD_NO"
);

ALTER TABLE "UPLOAD_FILE" ADD CONSTRAINT "FK_REVIEW_TO_UPLOAD_FILE_1" FOREIGN KEY (
	"REVIEW_NO"
)
REFERENCES "REVIEW" (
	"REVIEW_NO"
);

ALTER TABLE "UPLOAD_FILE" ADD CONSTRAINT "FK_PROJECT_TO_UPLOAD_FILE_1" FOREIGN KEY (
	"PROJECT_NO"
)
REFERENCES "PROJECT" (
	"PROJECT_NO"
);

ALTER TABLE "PROJECT_INFO" ADD CONSTRAINT "FK_PROJECT_TO_PROJECT_INFO_1" FOREIGN KEY (
	"PROJECT_NO"
)
REFERENCES "PROJECT" (
	"PROJECT_NO"
);

ALTER TABLE "PROFILE_IMG" ADD CONSTRAINT "FK_MEMBER_TO_PROFILE_IMG_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "PROFILE_IMG" ADD CONSTRAINT "FK_PARTNER_TO_PROFILE_IMG_1" FOREIGN KEY (
	"PARTNER_NO"
)
REFERENCES "PARTNER" (
	"PARTNER_NO"
);

ALTER TABLE "BOARD_LIKE" ADD CONSTRAINT "FK_MEMBER_TO_BOARD_LIKE_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "BOARD_LIKE" ADD CONSTRAINT "FK_COMMUNITY_TO_BOARD_LIKE_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "COMMUNITY" (
	"BOARD_NO"
);

ALTER TABLE "PAYMENT" ADD CONSTRAINT "FK_MEMBER_TO_PAYMENT_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "PAYMENT" ADD CONSTRAINT "FK_ORDERS_TO_PAYMENT_1" FOREIGN KEY (
	"ORDER_NO"
)
REFERENCES "ORDERS" (
	"ORDER_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "FK_MEMBER_TO_COMMENT_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "FK_COMMUNITY_TO_COMMENT_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "COMMUNITY" (
	"BOARD_NO"
);

ALTER TABLE "PARTNER" ADD CONSTRAINT "FK_PARTNER_TYPE_TO_PARTNER_1" FOREIGN KEY (
	"PARTNER_TYPE"
)
REFERENCES "PARTNER_TYPE" (
	"PARTNER_TYPE"
);

ALTER TABLE "ORDER_RECEIPT" ADD CONSTRAINT "FK_PARTNER_TO_ORDER_RECEIPT_1" FOREIGN KEY (
	"PARTNER_NO"
)
REFERENCES "PARTNER" (
	"PARTNER_NO"
);

ALTER TABLE "ORDER_RECEIPT" ADD CONSTRAINT "FK_ORDERS_TO_ORDER_RECEIPT_1" FOREIGN KEY (
	"ORDER_NO"
)
REFERENCES "ORDERS" (
	"ORDER_NO"
);

ALTER TABLE "CHATTING_MESSAGE"
ADD "SENDER_TYPE" CHAR(1) NOT NULL;

COMMENT ON COLUMN "CHATTING_MESSAGE"."SENDER_TYPE" IS '발신자 유형';


COMMIT;


-- 위시리스트, 게시글 좋아요, 접수 테이블 제외 26개

-- 멤버
CREATE SEQUENCE SEQ_MEMBER_NO NOCACHE;

-- 파트너
CREATE SEQUENCE SEQ_PARTNER_TYPE_NO NOCACHE;
CREATE SEQUENCE SEQ_PARTNER_NO NOCACHE;

-- 게시글
CREATE SEQUENCE SEQ_BOARD_TYPE_NO NOCACHE;
CREATE SEQUENCE SEQ_BOARD_NO NOCACHE;
CREATE SEQUENCE SEQ_COMMENT_NO NOCACHE;


-- 이미지
CREATE SEQUENCE SEQ_UPLOAD_IMG_NO NOCACHE;
CREATE SEQUENCE SEQ_PROFILE_IMG_NO NOCACHE;

-- 인증
CREATE SEQUENCE SEQ_EMAIL_KEY_NO NOCACHE;
CREATE SEQUENCE SEQ_SMS_KEY_NO NOCACHE;

-- 채팅
CREATE SEQUENCE SEQ_CHATTING_ROOM_NO NOCACHE;
CREATE SEQUENCE SEQ_CHATTING_MESSAGE_NO NOCACHE;

-- 포트폴리오
CREATE SEQUENCE SEQ_PORTFOLIO_NO NOCACHE;
CREATE SEQUENCE SEQ_PROJECT_NO NOCACHE;
CREATE SEQUENCE SEQ_PROJECT_INFO_NO NOCACHE;


-- 상품
CREATE SEQUENCE SEQ_PRODUCT_NO NOCACHE;
CREATE SEQUENCE SEQ_CATEGORY_NO NOCACHE;
CREATE SEQUENCE SEQ_BIG_CATEGORY_NO NOCACHE;
CREATE SEQUENCE SEQ_OPTION_ID NOCACHE;
CREATE SEQUENCE SEQ_REVIEW_NO NOCACHE;
CREATE SEQUENCE SEQ_CART_ID NOCACHE;

-- 주문
CREATE SEQUENCE SEQ_ORDER_NO NOCACHE;
CREATE SEQUENCE SEQ_ORDER_ITEM_NO NOCACHE;
CREATE SEQUENCE SEQ_DELIVERY_ID NOCACHE;

-- 결제
CREATE SEQUENCE SEQ_PAYMENT_NO NOCACHE;

-- 신고
CREATE SEQUENCE SEQ_REPORT_NO NOCACHE;


-- 테스트용 비밀번호 1234 
-- $2a$10$YXSsczaCIZZkKbF17AdY1OBukX2ou43eBVGel7WyJD2ex87FeAiSC