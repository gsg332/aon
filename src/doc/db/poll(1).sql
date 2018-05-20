SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS poll_answer;
DROP TABLE IF EXISTS poll_question;
DROP TABLE IF EXISTS poll;




/* Create Tables */

CREATE TABLE poll
(
	-- 설문주제
	poll_id int unsigned NOT NULL AUTO_INCREMENT COMMENT '설문주제',
	-- 제목
	title varchar(1000) COMMENT '제목',
	-- 등록일시
	regist_date datetime DEFAULT NOW(), SYSDATE() COMMENT '등록일시',
	PRIMARY KEY (poll_id),
	UNIQUE (poll_id)
);


CREATE TABLE poll_answer
(
	-- 답변일련번호
	answer_id int unsigned NOT NULL AUTO_INCREMENT COMMENT '답변일련번호',
	-- 제목
	title varchar(1000) COMMENT '제목',
	-- 등록일시
	regist_date datetime COMMENT '등록일시',
	-- 답변수
	answer_count int unsigned COMMENT '답변수',
	-- 질문일련번호
	question_id int unsigned NOT NULL COMMENT '질문일련번호',
	-- 설문주제
	poll_id int unsigned NOT NULL COMMENT '설문주제',
	PRIMARY KEY (answer_id),
	UNIQUE (answer_id)
);


CREATE TABLE poll_question
(
	-- 질문일련번호
	question_id int unsigned NOT NULL AUTO_INCREMENT COMMENT '질문일련번호',
	-- 제목
	title varchar(1000) COMMENT '제목',
	-- 등록일시
	regist_date datetime DEFAULT NOW(), SYSDATE() COMMENT '등록일시',
	-- 설문주제
	poll_id int unsigned NOT NULL COMMENT '설문주제',
	PRIMARY KEY (question_id)
);



/* Create Foreign Keys */

ALTER TABLE poll_answer
	ADD FOREIGN KEY (poll_id)
	REFERENCES poll (poll_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE poll_question
	ADD FOREIGN KEY (poll_id)
	REFERENCES poll (poll_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE poll_answer
	ADD FOREIGN KEY (question_id)
	REFERENCES poll_question (question_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



