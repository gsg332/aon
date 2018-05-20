SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS survey_answer;
DROP TABLE IF EXISTS survey_user_coupon;
DROP TABLE IF EXISTS survey_user;




/* Create Tables */

-- 답변
CREATE TABLE survey_answer
(
	-- 답변 id
	answer_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '답변 id',
	-- 설문 ID
	survey_id bigint unsigned NOT NULL COMMENT '설문 ID',
	-- 질문코드 (page_id + question_id)
	question_code varchar(50) NOT NULL COMMENT '질문코드',
	-- 사용자 일련번호
	user_id bigint unsigned NOT NULL COMMENT '사용자 일련번호',
	-- 주관식 값
	text_value varchar(8000) COMMENT '주관식 값',
	-- 객관식 값
	number_value int(4) unsigned COMMENT '객관식 값',
	-- 등록일
	insert_date date COMMENT '등록일',
	PRIMARY KEY (answer_id),
	UNIQUE (answer_id)
) COMMENT = '답변';


-- 사용자
CREATE TABLE survey_user
(
	-- 사용자 일련번호
	user_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '사용자 일련번호',
	-- 사용자 이름
	user_name varchar(24) NOT NULL COMMENT '이름',
	-- 사용자 ip
	user_ip varchar(25) COMMENT '사용자 ip',
	-- 사용자 언어
	user_language varchar(25) COMMENT '사용자 언어',
	-- 등록일
	insert_date date COMMENT '등록일',
	-- email
	email varchar(100) COMMENT 'email',
	-- 전화번호
	phone_number varchar(50) COMMENT '전화번호',
	-- 유형
	type int(4) COMMENT '유형',
	PRIMARY KEY (user_id),
	UNIQUE (user_id)
) COMMENT = '사용자';


-- 사용자 쿠폰
CREATE TABLE survey_user_coupon
(
	-- 쿠폰id
	coupon_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '쿠폰id',
	-- 사용자 일련번호
	user_id bigint unsigned NOT NULL COMMENT '사용자 일련번호',
	-- 설문 ID
	survey_id bigint unsigned COMMENT '설문 ID',
	-- 쿠폰 번호
	coupon_number varchar(20) COMMENT '쿠폰 번호',
	-- 쿠폰 인증키
	coupon_certikey varchar(20) COMMENT '쿠폰 인증키',
	-- 발급날짜
	-- 
	insert_date date COMMENT '발급날짜',
	-- 사용여부
	-- 
	is_use bit(1) COMMENT '사용여부',
	PRIMARY KEY (coupon_id),
	UNIQUE (coupon_id),
	UNIQUE (user_id)
) COMMENT = '사용자 쿠폰';



/* Create Foreign Keys */

ALTER TABLE survey_answer
	ADD FOREIGN KEY (user_id)
	REFERENCES survey_user (user_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE survey_user_coupon
	ADD FOREIGN KEY (user_id)
	REFERENCES survey_user (user_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



