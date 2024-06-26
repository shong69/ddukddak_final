
SELECT * FROM "MEMBER";
SELECT * FROM "PARTNER";
SELECT * FROM PRODUCT;
UPDATE "PARTNER" SET
PARTNER_PW = '1234'
WHERE PARTNER_ID = 'sm'
AND PARTNER_TEL = '01032920409'
AND PARTNER_DEL_FL = 'N';

COMMIT;
ROLLBACK;

SELECT * FROM EMAIL_AUTH;

SELECT * FROM SMS_AUTH;

INSERT INTO "MEMBER"
VALUES(1, 'seungjoo', 'rania2002@naver.com', '1234', '이승주', '닉네임이승주', 
'01036812682', '서울시 송파구 석촌동', '3000', DEFAULT, DEFAULT, DEFAULT, 2, DEFAULT);

INSERT INTO "MEMBER"
VALUES(2, 'soyoung', 'shong7576@gmail.com', '1234', '김소영', '닉네임김소영', 
'01032127576', '제주도 제주시', '1000', DEFAULT, DEFAULT, DEFAULT, 2, DEFAULT);


INSERT INTO "MEMBER"
VALUES(3, 'youngmin', 'ssong9214@gmail.com', '1234', '송영민', '닉네임송영민',
'01092467636', '경기도 구리시', '3000', DEFAULT, DEFAULT, DEFAULT, 2, DEFAULT);

INSERT INTO "MEMBER"
VALUES(4, 'saem', 'saem.hong.95@gmail.com', '1234', '홍샘', '닉네임홍샘',
'01049647684', '서울시 성동구', '3000', DEFAULT, DEFAULT, DEFAULT, 2, DEFAULT);

INSERT INTO "MEMBER"
VALUES(5, 'soomin', 'soowagger@gmail.com', '1234', '신수민', '닉네임신수민',
'01031235555', '서울시 동대문구', '3000', DEFAULT, DEFAULT, DEFAULT, 2, DEFAULT);

INSERT INTO "MEMBER"
VALUES(6, 'test1', 'test1@test.com', '1234', '테스트유저1', '닉네임테스트유저1',
'01098765555', '서울시 동대문구', '3000', DEFAULT, DEFAULT, DEFAULT, 1, DEFAULT);

INSERT INTO "MEMBER"
VALUES(SEQ_MEMBER_NO.NEXTVAL, 'test', 'test2@test.com', '1234', 'sm1', '닉네임중복테스트',
'01012345555', '서울시 동대문구', '3000', DEFAULT, DEFAULT, DEFAULT, 1, DEFAULT);


INSERT INTO "PARTNER"
VALUES(SEQ_PARTNER_NO.NEXTVAL, 'sj', '$2a$10$YXSsczaCIZZkKbF17AdY1OBukX2ou43eBVGel7WyJD2ex87FeAiSC', '01036812682', 
'(주)SJ', '이승주', '1567890123', DEFAULT, DEFAULT, DEFAULT, 2);

INSERT INTO "PARTNER"
VALUES(SEQ_PARTNER_NO.NEXTVAL, 'sh', '$2a$10$YXSsczaCIZZkKbF17AdY1OBukX2ou43eBVGel7WyJD2ex87FeAiSC', '01049647684', 
'(주)SH', '홍샘', '1678901234', DEFAULT, DEFAULT, DEFAULT, 1);


INSERT INTO "PARTNER"
VALUES(SEQ_PARTNER_NO.NEXTVAL, 'sm', '$2a$10$YXSsczaCIZZkKbF17AdY1OBukX2ou43eBVGel7WyJD2ex87FeAiSC', '01000000000', 
'(주)SM', '신수민', '1234567890', DEFAULT, DEFAULT, DEFAULT, 1);

INSERT INTO "PARTNER"
VALUES(SEQ_PARTNER_NO.NEXTVAL, 'sy', '$2a$10$YXSsczaCIZZkKbF17AdY1OBukX2ou43eBVGel7WyJD2ex87FeAiSC', '01032127576',
'(주)SY', '김소영', '1345678901', DEFAULT, DEFAULT, DEFAULT, 2);

INSERT INTO "PARTNER"
VALUES(SEQ_PARTNER_NO.NEXTVAL, 'ym', '$2a$10$YXSsczaCIZZkKbF17AdY1OBukX2ou43eBVGel7WyJD2ex87FeAiSC', '01092467636', 
'(주)YM', '송영민', '1456789012', DEFAULT, DEFAULT, DEFAULT, 2);

-- 거절 샘플 데이터
INSERT INTO "PARTNER"
VALUES(SEQ_PARTNER_NO.NEXTVAL, 'refuse', '$2a$10$YXSsczaCIZZkKbF17AdY1OBukX2ou43eBVGel7WyJD2ex87FeAiSC', '01099999999', 
'(주)거절', '김거절', '9999999999', DEFAULT, DEFAULT, DEFAULT, 2);

-- 대기 샘플 데이터
INSERT INTO "PARTNER"
VALUES(SEQ_PARTNER_NO.NEXTVAL, 'sample', '$2a$10$YXSsczaCIZZkKbF17AdY1OBukX2ou43eBVGel7WyJD2ex87FeAiSC', '01000000000', 
'(주)샘플 데이터', '김대기', '8888888888', DEFAULT, DEFAULT, DEFAULT, 2);


BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO "PARTNER" 
        VALUES (
            SEQ_PARTNER_NO.NEXTVAL, 
            'sample', 
            '$2a$10$YXSsczaCIZZkKbF17AdY1OBukX2ou43eBVGel7WyJD2ex87FeAiSC', 
            '01000000000', 
            '(주)샘플 데이터' || i, 
            '김대기', 
            '8888888888', 
            DEFAULT, 
            DEFAULT, 
            DEFAULT, 
            2
        );
    END LOOP;
END;


SELECT * FROM "PARTNER";
SELECT * FROM "SMS_AUTH";

UPDATE "PARTNER" SET 
PARTNER_DEL_FL = 'W',
PARTNER_PASS = 0
WHERE PARTNER_ID = 'sample'
AND PARTNER_DEL_FL = 'N';

COMMIT;
ROLLBACK;

-- 닉네임 : 신수민
-- soowagger@gmail.com

SELECT COUNT(*)
FROM "MEMBER"
WHERE MEMBER_NICKNAME = '신수민' 
AND MEMBER_EMAIL = 'soowagger@gmail.com'
AND MEMBER_DEL_FL = 'N';


SELECT MEMBER_ID, TO_CHAR(ENROLL_DATE, 'YY"."MM"."DD') ENROLL_DATE
FROM "MEMBER"
WHERE MEMBER_EMAIL = 'soowagger@gmail.com'
AND MEMBER_DEL_FL = 'N'
AND SOCIAL_LOGIN_TYPE = 'D';

SELECT MEMBER_ID, TO_CHAR(ENROLL_DATE, 'YY"."MM"."DD') ENROLL_DATE
FROM "MEMBER"
WHERE MEMBER_Tel = '01012341234'
AND MEMBER_DEL_FL = 'N'
AND SOCIAL_LOGIN_TYPE = 'D';


-- 파트너 컬럼 추가
ALTER TABLE "PARTNER"
ADD ENROLL_DATE DATE DEFAULT SYSDATE NOT NULL;



-- 멤버, 파트너 아이디 찾기
SELECT COUNT(*)
FROM (
    SELECT MEMBER_ID
    FROM "MEMBER"
    WHERE MEMBER_ID = 'soomin'
    AND MEMBER_DEL_FL = 'N'
    
    UNION ALL 
    
    SELECT PARTNER_ID
    FROM PARTNER
    WHERE PARTNER_ID = 'soomin'
    AND PARTNER_DEL_FL = 'N'
);


SELECT ID
FROM (
    SELECT MEMBER_ID AS ID
    FROM "MEMBER"
    WHERE MEMBER_ID = 'soomin'
    AND MEMBER_TEL = '01032920409'

    UNION

    SELECT PARTNER_ID AS ID
    FROM PARTNER
    WHERE PARTNER_ID = 'soomin'
    AND PARTNER_TEL = '01032920409'
);



-- 멤버, 파트너 비밀번호 동일 여부 체크
	SELECT PW
	FROM (
	    SELECT MEMBER_PW AS PW
	    FROM "MEMBER"
	    WHERE MEMBER_ID = 'soomin'
	    AND MEMBER_DEL_FL = 'N'
	    
	    UNION
	    
	    SELECT PARTNER_PW AS PW
	    FROM PARTNER
	    WHERE PARTNER_ID = 'soomin'
	    AND PARTNER_DEL_FL = 'N'
	    
	);

-- 닉네임 중복 체크
SELECT COUNT(*)
FROM "MEMBER"
WHERE MEMBER_NICKNAME = '닉네임신수민'
AND MEMBER_DEL_FL = 'N';

-- 이메일 중복 체크
SELECT COUNT(*)
FROM "MEMBER"
WHERE MEMBER_EMAIL = 'soowagger@gmal.com'
AND MEMBER_DEL_FL = 'N';

-- 사업자등록번호
SELECT COUNT(*)
FROM "PARTNER"
WHERE PARTNER_BUSINESS_NUM = '1234567890'
AND PARTNER_DEL_FL = 'N';

-- 파트너 등록 요청 여부 수정 구문(테스트)
UPDATE "PARTNER" SET
PARTNER_PASS = 0
WHERE PARTNER_ID = 'soowagger';

SELECT * FROM "MEMBER";
SELECT * FROM PARTNER WHERE PARTNER_DEL_FL = 'N';

COMMIT;



SELECT PARTNER_NO, PARTNER_ID, PARTNER_BUSINESS_NAME, PARTNER_BUSINESS_NUM,
		TO_CHAR(ENROLL_DATE,'YYYY-MM-DD') ENROLL_DATE

FROM "PARTNER"
WHERE PARTNER_DEL_FL = 'W'
AND PARTNER_PASS = 0
ORDER BY PARTNER_NO DESC;




SELECT MEMBER_NO, MEMBER_ID, MEMBER_EMAIL, MEMBER_PW, MEMBER_NAME, 
MEMBER_NICKNAME, MEMBER_TEL, MEMBER_ADDR, MEMBER_POINT, PROFILE_IMG,
TO_CHAR(ENROLL_DATE, 'YYYY"년" MM"월" DD"일"') ENROLL_DATE, 
MEMBER_DEL_FL, AUTHORITY, SOCIAL_LOGIN_TYPE
FROM "MEMBER"
WHERE MEMBER_EMAIL = 'soowagger@naver.com'
AND MEMBER_DEL_FL = 'N';


-- 샘플 테스트 시 활용
SELECT * FROM "MEMBER" WHERE MEMBER_DEL_FL = 'N';
SELECT * FROM "PARTNER"WHERE PARTNER_DEL_FL = 'N';
SELECT * FROM "PARTNER";
COMMIT;

-- 회원 샘플 데이터관리
UPDATE "MEMBER" SET
MEMBER_DEL_FL = 'Y'
WHERE MEMBER_NO = 8;


-- 01092467636  01049647684 01036812682

		SELECT PARTNER_NO, PARTNER_ID, PARTNER_PW, PARTNER_TEL, 
		PARTNER_BUSINESS_NAME, PARTNER_CEO_NAME, PARTNER_BUSINESS_NUM, 
		TO_CHAR(ENROLL_DATE, 'YYYY"년" MM"월" DD"일"') ENROLL_DATE,
		PARTNER_DEL_FL, PARTNER_PASS, PARTNER_TYPE, PORTFOLIO_NO
		FROM "PARTNER"
		JOIN "PORTFOLIO" USING (PARTNER_NO)
		WHERE PARTNER_ID = 'sj'
		AND PARTNER_DEL_FL = 'N'
		AND PARTNER_PASS = 1;
	
-- 파트너 승인 대기 샘플 관리
UPDATE "PARTNER" SET 
PARTNER_DEL_FL = 'W',
PARTNER_PASS = 0
WHERE PARTNER_ID = 'sj';


-- 회원 샘플 데이터관리
UPDATE "MEMBER" SET
AUTHORITY = 1
WHERE AUTHORITY = 2;


INSERT INTO "MEMBER"
VALUES(SEQ_MEMBER_NO.NEXTVAL, 'admin', 'admin', '$2a$10$YXSsczaCIZZkKbF17AdY1OBukX2ou43eBVGel7WyJD2ex87FeAiSC', '관리자', '닉네임관리자',
NULL, '서울시 중구 남대문로 120', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 2, DEFAULT);






SELECT * FROM "CART";
SELECT * FROM "CARTITEM_OPTION";

SELECT * FROM "PAYMENT";



COMMIT;

SELECT MEMBER_NO, MEMBER_ID, MEMBER_EMAIL, MEMBER_PW, MEMBER_NAME, 
MEMBER_NICKNAME, MEMBER_TEL, MEMBER_ADDR, MEMBER_POINT, PROFILE_IMG,
TO_CHAR(ENROLL_DATE, 'YYYY"년" MM"월" DD"일"') ENROLL_DATE, 
MEMBER_DEL_FL, AUTHORITY, SOCIAL_LOGIN_TYPE
FROM "MEMBER"
WHERE MEMBER_EMAIL = 'soowagger@naver.com'
AND MEMBER_DEL_FL = 'n';

DELETE FROM "ORDERS"
WHERE ORDER_NO NOT IN(2,3,4);

COMMIT;

	
SELECT * FROM "MEMBER" WHERE MEMBER_DEL_FL = 'N';

SELECT * FROM "PARTNER";
SELECT * FROM "PAYMENT";
SELECT * FROM "PRODUCT";
SELECT * FROM DELIVERY ;

SELECT * FROM "MEMBER" ;

SELECT * FROM "ORDERS";
SELECT * FROM "PAYMENT";

SELECT * FROM "ORDER_DETAIL";
SELECT * FROM "ORDERDETAIL_OPTION";

SELECT 
		PAYMENT_NO,
		MERCHANT_UID,
		BUYER_NAME,
		AMOUNT,
		STATUS,
		PG_PROVIDER,
		PAY_METHOD,
		STARTED_AT
FROM "PAYMENT";
-- 
SELECT MEMBER_ID
FROM "MEMBER"
JOIN "PAYMENT" m ON MEMBER_NO; 


COMMIT; 

SELECT * FROM UPLOAD_FILE ;

SELECT * FROM "OPTION" ;

SELECT * FROM "ORDERS";
SELECT * FROM ORDER_DETAIL ;


SELECT * FROM ORDERDETAIL_OPTION ;

SELECT ORDER_ITEM_NO
FROM "ORDER_DETAIL"
WHERE ORDER_NO = 238
AND PRODUCT_NO = 21
AND CART_ID = 49;


-- ORDER_STATUS를 구매확정으로 바꿔주면 됨

ALTER TABLE ORDERS
ADD STATUS NVARCHAR2(300);

SELECT * FROM CART; 
SELECT * FROM CARTITEM_OPTION co ;

COMMIT;

ALTER TABLE ORDERS
ADD FAIL_REASON NVARCHAR2(300);

ALTER TABLE ORDERS
ADD MERCHANT_UID NVARCHAR2(300);


INSERT INTO "DELIVERY" 
VALUES (1, '주문 생성용', 'N'); 

		SELECT MEMBER_NO, ORDER_NO
		FROM "ORDERS"
		WHERE MERCHANT_UID = 'ORD-20240620151704977';

-- 추후 MERCHANT_UID 널 ㄱㄱ

SELECT * FROM "MEMBER" WHERE MEMBER_NO = 2;


SELECT * FROM "ORDERS"
WHERE MERCHANT_UID = 'ORD-202406201011070001';

-- 구매 페이지
SELECT MEMBER_NO, ORDER_NO, MERCHANT_UID, AMOUNT, PAY_METHOD, 
BUYER_NAME, BUYER_TEL, BUYER_EMAIL, BUYER_POSTCODE ,BUYER_ADDR, PG_PROVIDER , CARD_NAME ,APPLY_NUM,
PAID_AT 
FROM "PAYMENT";


CREATE SEQUENCE SEQ_ORDERDETAIL_OPTION_ID NOCACHE;



SELECT FLOOR(12300*0.01 / 10)*10 FROM DUAL;


		SELECT ORDER_NO, MEMBER_NO
		FROM "ORDERS"
		WHERE MERCHANT_UID = 'ORD-20240621153933039'
		AND STATUS = 'paid';

--ORD-20240621153933039


	
-- 마이페이지 주문 내역 백업 쿼리
	SELECT O.MERCHANT_UID , O.ORDER_NO, ORDER_DATE, D.ORDER_STATUS, ORDER_DEL_FL, D.ORDER_ITEM_NO, ORDER_QUANTITY, ORDER_PRICE, D.PRODUCT_NO,P.PRODUCT_NAME, 
	L.DELIVERY_ADDRESS, MEMBER_NO,
	(SELECT UPLOAD_IMG_PATH||UPLOAD_IMG_RENAME FROM UPLOAD_FILE F WHERE F.PRODUCT_NO =D.PRODUCT_NO AND UPLOAD_IMG_ORDER=0) PRODUCT_IMG,
	(LISTAGG(OPTION_VALUE,',') WITHIN GROUP (ORDER BY T.OPTION_NO)) OPTION_VALUE 
	FROM ORDERS O
	LEFT JOIN ORDER_DETAIL D ON(O.ORDER_NO = D.ORDER_NO)
	LEFT JOIN PRODUCT P ON(D.PRODUCT_NO = P.PRODUCT_NO)
	LEFT JOIN DELIVERY L ON(O.DELIVERY_ID = L.DELIVERY_ID)
	LEFT JOIN ORDERDETAIL_OPTION O2 ON(O2.ORDER_ITEM_NO = D.ORDER_ITEM_NO)
	LEFT JOIN "OPTION" T ON(T.OPTION_NO=O2.OPTION_NO)
	WHERE MEMBER_NO = #{memberNo}
	AND O.STATUS = 'paid'
	GROUP BY 
	     O.MERCHANT_UID, O.ORDER_NO, O.ORDER_DATE, D.ORDER_STATUS, O.ORDER_DEL_FL, 
	    D.ORDER_ITEM_NO, D.ORDER_QUANTITY, D.ORDER_PRICE, D.PRODUCT_NO, 
	    P.PRODUCT_NAME, L.DELIVERY_ADDRESS, O.MEMBER_NO
	ORDER BY ORDER_DATE DESC