/***************************************************************************************************************
 * 
 * 2016.07.12			sa_category.sort_order unsigned 제거에 따른 통일
 * 
***************************************************************************************************************/
ALTER TABLE `doc_item_category` CHANGE COLUMN `sort_order` `sort_order` INT(10) NULL DEFAULT NULL COMMENT '정렬순서' AFTER `level4`;
	
ALTER TABLE `doc_item_file` CHANGE COLUMN `sort_order` `sort_order` INT(10) NULL DEFAULT NULL COMMENT '정렬순서' AFTER `dnld_count`;

ALTER TABLE `hr_category` CHANGE COLUMN `sort_order` `sort_order` INT(10) NULL DEFAULT NULL COMMENT '정렬순서' AFTER `tag`;	

ALTER TABLE `qa_item_category` CHANGE COLUMN `sort_order` `sort_order` INT(10) NULL DEFAULT NULL COMMENT '정렬순서' AFTER `tag`;

ALTER TABLE `qa_item_file` CHANGE COLUMN `sort_order` `sort_order` INT(10) NULL DEFAULT NULL COMMENT '정렬순서' AFTER `dnld_count`;	
	
-- ALTER TABLE `sa_category` CHANGE COLUMN `sort_order` `sort_order` INT(10) NULL DEFAULT NULL COMMENT '정렬순서' AFTER `flag_code`;




/***************************************************************************************************************
 * 
 * 2016.07.12			sa_message, sa_message_receiver 테이블 추가
 * 
***************************************************************************************************************/
CREATE TABLE sa_message
(
	-- 메시지일련번호
	message_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '메시지일련번호',
	-- 본문
	content text COMMENT '본문',
	-- 수신자수
	receiver_count int unsigned COMMENT '수신자수',
	-- 조회수
	read_count int unsigned COMMENT '조회수',
	-- 송신일시
	sended_date datetime COMMENT '송신일시',
	-- 수정일시
	update_date datetime COMMENT '수정일시',
	-- 송신자노출명
	sender_member_display_name varchar(150) COMMENT '송신자노출명',
	-- 송신자일련번호
	sender_member_id bigint unsigned NOT NULL COMMENT '송신자일련번호',
	PRIMARY KEY (message_id),
	UNIQUE (message_id)
);

CREATE TABLE sa_message_receiver
(
	-- 메시지일련번호
	message_id bigint unsigned NOT NULL COMMENT '메시지일련번호',
	-- 회원일련번호
	member_id bigint unsigned NOT NULL COMMENT '회원일련번호',
	-- 회원자노출명
	member_display_name varchar(150) COMMENT '회원자노출명',
	-- 수신일시
	receive_date datetime COMMENT '수신일시',
	-- 삭제여부
	is_deleted bit(1) COMMENT '삭제여부',
	-- 조회여부
	is_notified bit(1) COMMENT '조회여부',
	-- 정렬순서
	sort_order int COMMENT '정렬순서'
);

ALTER TABLE sa_message
	ADD FOREIGN KEY (sender_member_id)
	REFERENCES hr_member (member_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;

ALTER TABLE sa_message_receiver
	ADD FOREIGN KEY (member_id)
	REFERENCES hr_member (member_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;

ALTER TABLE sa_message_receiver
	ADD FOREIGN KEY (message_id)
	REFERENCES sa_message (message_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;




/***************************************************************************************************************
 * 
 * 2016.07.12			qa_item 컬럼 추가		
 *							qa_item_point 테이블 추가
 * 
***************************************************************************************************************/
ALTER TABLE `qa_item`
    ADD COLUMN `choose_count` int NULL DEFAULT 0 COMMENT '예정채택건수' AFTER `is_favorite`;

ALTER TABLE `qa_item`
    ADD COLUMN `share_type` int NULL DEFAULT 0 COMMENT '분배타입' AFTER `choose_count`;
    
ALTER TABLE `qa_item`
    ADD COLUMN `point_ratio` varchar(2000) NULL DEFAULT NULL COMMENT '포인트비율' AFTER `share_type`;


CREATE TABLE qa_item_point
(
	-- 포인트비율
	point_ratio int DEFAULT 0 COMMENT '포인트비율',
	-- 포인트
	point int DEFAULT 0 COMMENT '포인트',
	-- 순위
	rank int UNSIGNED COMMENT '순위',
	-- 등록일시
	insert_date datetime DEFAULT NOW() COMMENT '등록일시',
	-- 수정일시
	update_date datetime COMMENT '수정일시',
	-- 질문일련번호
	qa_id bigint unsigned NOT NULL COMMENT '질문일련번호',
	-- 답변일련번호
	answer_id bigint unsigned COMMENT '답변일련번호'
);

ALTER TABLE qa_item_point
	ADD FOREIGN KEY (qa_id)
	REFERENCES qa_item (qa_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;





/***************************************************************************************************************
 * 
 * 2016.08.18			pt_deposit 컬럼 추가.
 * 							pt_withdraw 컬럼 추가.
 * 
***************************************************************************************************************/
ALTER TABLE `pt_deposit`
    ADD COLUMN `payment_status` int(4) unsigned NULL COMMENT '결제상태' AFTER `status`;
    
ALTER TABLE `pt_deposit`
    ADD COLUMN `payment_id` varchar(50) NULL COMMENT '결제고유번호' AFTER `payment_status`;
    
ALTER TABLE `pt_deposit`
    ADD COLUMN `payer_email` varchar(200) NULL COMMENT '결제자이메일' AFTER `payment_id`;

ALTER TABLE `pt_deposit`
    ADD COLUMN `payment_date` varchar(50) NULL COMMENT '결제일시' AFTER `payer_email`;
    
ALTER TABLE `pt_deposit`
    ADD COLUMN `payment_fee` float(12,2) NULL COMMENT '결제수수료' AFTER `payment_date`;
        
ALTER TABLE `pt_withdraw`
    ADD COLUMN `paypal_account` varchar(200) NULL COMMENT '페이팔계정(이메일)' AFTER `status`;
    
ALTER TABLE `pt_withdraw`
    ADD COLUMN `fee` float(12,2) NULL COMMENT '수수료' AFTER `amount`;    
    
    
    
    
    
/***************************************************************************************************************
 * 
 * 2016.08.23			sa_axis 테이블 추가.
 * 
***************************************************************************************************************/
CREATE TABLE sa_axis
(
	-- 축일련번호
	axis_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '축일련번호',
	-- 축이름
	name varchar(2000) COMMENT '축이름',
	-- 축코드
	axis_code int DEFAULT -1 COMMENT '축코드',
	-- 분류일련번호
	category_id bigint unsigned COMMENT '분류일련번호',
	-- 정렬순서
	sort_order int COMMENT '정렬순서',
	PRIMARY KEY (axis_id),
	UNIQUE (axis_id)
);

ALTER TABLE sa_axis
	ADD FOREIGN KEY (category_id)
	REFERENCES sa_category (category_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;

