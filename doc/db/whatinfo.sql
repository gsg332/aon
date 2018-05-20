SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Indexes */

DROP INDEX status ON hr_member;
DROP INDEX status ON pt_deposit;
DROP INDEX status ON pt_withdraw;
DROP INDEX is_read ON qa_item;
DROP INDEX is_choose ON qa_item;
DROP INDEX position ON qa_item;
DROP INDEX status ON qa_item;
DROP INDEX group_id ON qa_item;
DROP INDEX answer_group_id ON qa_item;



/* Drop Tables */

DROP TABLE IF EXISTS cm_inquiry;
DROP TABLE IF EXISTS cm_notice;
DROP TABLE IF EXISTS doc_item_category;
DROP TABLE IF EXISTS doc_item_file;
DROP TABLE IF EXISTS doc_item;
DROP TABLE IF EXISTS hr_access;
DROP TABLE IF EXISTS pt_withdraw;
DROP TABLE IF EXISTS hr_bank_account;
DROP TABLE IF EXISTS hr_category;
DROP TABLE IF EXISTS hr_confirm;
DROP TABLE IF EXISTS pt_deposit;
DROP TABLE IF EXISTS pt_point;
DROP TABLE IF EXISTS hr_cyber_account;
DROP TABLE IF EXISTS hr_profile;
DROP TABLE IF EXISTS qa_item_category;
DROP TABLE IF EXISTS qa_item_file;
DROP TABLE IF EXISTS qa_item_point;
DROP TABLE IF EXISTS qa_item_report;
DROP TABLE IF EXISTS qa_item;
DROP TABLE IF EXISTS sa_message_receiver;
DROP TABLE IF EXISTS sa_message;
DROP TABLE IF EXISTS sa_sms_certify;
DROP TABLE IF EXISTS hr_member;
DROP TABLE IF EXISTS sa_axis;
DROP TABLE IF EXISTS sa_category;
DROP TABLE IF EXISTS sa_config;
DROP TABLE IF EXISTS sa_lock;
DROP TABLE IF EXISTS sa_log;
DROP TABLE IF EXISTS sa_schedule;




/* Create Tables */

CREATE TABLE cm_inquiry
(
	-- 문의일련번호
	inquiry_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '문의일련번호',
	-- 사용자이름
	user_name varchar(150) COMMENT '사용자이름',
	-- 로그인아이디( 이메일)
	loginid varchar(200) COMMENT '로그인아이디( 이메일)',
	-- 본문
	content text COMMENT '본문',
	-- 이메일
	email varchar(200) COMMENT '이메일',
	-- 처리상태
	status int(4) COMMENT '처리상태',
	-- 등록일시
	insert_date datetime DEFAULT NOW() COMMENT '등록일시',
	-- 수정일시
	update_date datetime COMMENT '수정일시',
	-- 관리자메모
	admin_comment varchar(1000) COMMENT '관리자메모',
	-- 관리자일련번호
	admin_id bigint unsigned COMMENT '관리자일련번호',
	PRIMARY KEY (inquiry_id),
	UNIQUE (inquiry_id)
);


CREATE TABLE cm_notice
(
	-- 공지사항일련번호
	notice_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '공지사항일련번호',
	-- 제목
	title varchar(500) COMMENT '제목',
	-- 본문
	content text COMMENT '본문',
	-- 조회수
	read_count int unsigned COMMENT '조회수',
	-- 등록일시
	insert_date datetime DEFAULT NOW() COMMENT '등록일시',
	-- 수정일시
	update_date datetime COMMENT '수정일시',
	-- 회원일련번호
	admin_id bigint unsigned COMMENT '회원일련번호',
	PRIMARY KEY (notice_id),
	UNIQUE (notice_id)
);


CREATE TABLE doc_item
(
	-- 게시글일련번호
	item_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '게시글일련번호',
	-- 제목
	title varchar(500) COMMENT '제목',
	-- 본문
	content text COMMENT '본문',
	-- 조회수
	read_count int unsigned COMMENT '조회수',
	-- 등록일시
	insert_date datetime DEFAULT NOW() COMMENT '등록일시',
	-- 수정일시
	update_date datetime COMMENT '수정일시',
	-- 버전
	version int unsigned COMMENT '버전',
	-- 그룹일련번호
	group_id bigint unsigned COMMENT '그룹일련번호',
	-- 부모일련번호
	parent_id bigint unsigned COMMENT '부모일련번호',
	-- 포지션
	position int unsigned COMMENT '포지션',
	-- 스텝(질문, 답변, 의견 구분코드)
	step int unsigned COMMENT '스텝(질문, 답변, 의견 구분코드)',
	-- 답변수
	reply_count int unsigned COMMENT '답변수',
	-- 처리상태
	status int(4) COMMENT '처리상태',
	-- 플래그코드
	flag_code int(4) COMMENT '플래그코드',
	-- 첨부확장자
	file_ext varchar(10) COMMENT '첨부확장자',
	-- 보임여부
	is_visible bit(1) COMMENT '보임여부',
	-- 회원자노출명
	member_display_name varchar(150) COMMENT '회원자노출명',
	-- 회원일련번호
	member_id bigint unsigned COMMENT '회원일련번호',
	PRIMARY KEY (item_id),
	UNIQUE (item_id)
);


CREATE TABLE doc_item_category
(
	-- 게시글일련번호
	item_id bigint unsigned NOT NULL COMMENT '게시글일련번호',
	-- 분류일련번호
	category_id bigint unsigned NOT NULL COMMENT '분류일련번호',
	-- 1레벨분류일련번호
	level1 bigint unsigned COMMENT '1레벨분류일련번호',
	-- 2레벨분류일련번호
	level2 bigint unsigned COMMENT '2레벨분류일련번호',
	-- 3레벨분류일련번호
	level3 bigint unsigned COMMENT '3레벨분류일련번호',
	-- 4레벨분류일련번호
	level4 bigint unsigned COMMENT '4레벨분류일련번호',
	-- 정렬순서
	sort_order int COMMENT '정렬순서'
);


CREATE TABLE doc_item_file
(
	-- 파일일련번호
	file_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '파일일련번호',
	-- 파일명
	file_name varchar(250) COMMENT '파일명',
	-- 파일사이즈
	file_size bigint unsigned COMMENT '파일사이즈',
	-- 파일저장경로
	save_path varchar(250) COMMENT '파일저장경로',
	-- 파일저장코드
	save_code int(4) COMMENT '파일저장코드',
	-- 다운로드수
	dnld_count int unsigned COMMENT '다운로드수',
	-- 정렬순서
	sort_order int COMMENT '정렬순서',
	-- 게시글일련번호
	item_id bigint unsigned NOT NULL COMMENT '게시글일련번호',
	PRIMARY KEY (file_id),
	UNIQUE (file_id)
);


CREATE TABLE hr_access
(
	-- 접속일련번호
	access_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '접속일련번호',
	-- 아이피
	ip bigint unsigned COMMENT '아이피',
	-- 등록일시
	insert_date datetime DEFAULT NOW() COMMENT '등록일시',
	-- 회원일련번호
	member_id bigint unsigned COMMENT '회원일련번호',
	PRIMARY KEY (access_id),
	UNIQUE (access_id)
);


CREATE TABLE hr_bank_account
(
	-- 은행계좌일련번호
	bank_acc_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '은행계좌일련번호',
	-- 은행코드
	bank_code varchar(10) COMMENT '은행코드',
	-- 계좌번호
	account_number varchar(50) COMMENT '계좌번호',
	-- 계좌명(예금주명)
	account_name varchar(50) COMMENT '계좌명(예금주명)',
	-- 등록일시
	insert_date datetime DEFAULT NOW() COMMENT '등록일시',
	-- 회원일련번호
	member_id bigint unsigned COMMENT '회원일련번호',
	PRIMARY KEY (bank_acc_id),
	UNIQUE (bank_acc_id),
	UNIQUE (member_id)
);


CREATE TABLE hr_category
(
	-- 회원일련번호
	member_id bigint unsigned COMMENT '회원일련번호',
	-- 분류일련번호
	category_id bigint unsigned COMMENT '분류일련번호',
	-- 1레벨분류일련번호
	level1 bigint unsigned COMMENT '1레벨분류일련번호',
	-- 2레벨분류일련번호
	level2 bigint unsigned COMMENT '2레벨분류일련번호',
	-- 3레벨분류일련번호
	level3 bigint unsigned COMMENT '3레벨분류일련번호',
	-- 4레벨분류일련번호
	level4 bigint unsigned COMMENT '4레벨분류일련번호',
	-- 태그
	tag varchar(128) COMMENT '태그',
	-- 정렬순서
	sort_order int COMMENT '정렬순서'
);


CREATE TABLE hr_confirm
(
	-- 승인일련번호
	confirm_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '승인일련번호',
	-- 로그인아이디( 이메일)
	loginid varchar(200) COMMENT '로그인아이디( 이메일)',
	-- 승인코드
	confirm_code varchar(255) COMMENT '승인코드',
	-- 등록일시
	insert_date datetime DEFAULT NOW() COMMENT '등록일시',
	PRIMARY KEY (confirm_id),
	UNIQUE (confirm_id)
);


CREATE TABLE hr_cyber_account
(
	-- 가상계좌일련번호
	cyber_acc_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '가상계좌일련번호',
	-- 3자리 - 국가코드(ISO 3166-1 NUMERIC)
	-- 8자리 - reverse(년yyyy)+reverse(월mm)+reverse(일dd)
	-- 6자리 - 회원일련번호 뒷 6자리(zerofill)
	cyber_acc_number varchar(17) NOT NULL COMMENT '3자리 - 국가코드(ISO 3166-1 NUMERIC)
8자리 - reverse(년yyyy)+reverse(월mm)+reverse(일dd)
6자리 - 회원일련번호 뒷 6자리(zerofill)',
	-- 입금합계
	deposit_sum bigint DEFAULT 0 COMMENT '입금합계',
	-- 출금합계
	withdraw_sum bigint DEFAULT 0 COMMENT '출금합계',
	-- 채택합계
	choose_sum bigint DEFAULT 0 COMMENT '채택합계',
	-- 회원일련번호
	member_id bigint unsigned COMMENT '회원일련번호',
	PRIMARY KEY (cyber_acc_id),
	UNIQUE (cyber_acc_id),
	UNIQUE (cyber_acc_number),
	UNIQUE (member_id)
);


CREATE TABLE hr_member
(
	-- 회원일련번호
	member_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '회원일련번호',
	-- 회원유형
	type varchar(4) COMMENT '회원유형',
	-- 로그인아이디( 이메일)
	loginid varchar(200) COMMENT '로그인아이디( 이메일)',
	-- 별명
	nickname varchar(20) COMMENT '별명',
	-- 비밀번호
	password varchar(256) COMMENT '비밀번호',
	-- 이름
	first_name varchar(100) COMMENT '이름',
	-- 성
	last_name varchar(50) COMMENT '성',
	-- 국가코드(ISO 3166-1 alpha-2)
	country_code varchar(3) COMMENT '국가코드(ISO 3166-1 alpha-2)',
	-- 주소
	address varchar(500) COMMENT '주소',
	-- 전화번호국가코드(ITU-T 권고 E.164)
	phone_country_code varchar(6) COMMENT '전화번호국가코드(ITU-T 권고 E.164)',
	-- 전화번호
	phone_number varchar(30) COMMENT '전화번호',
	-- 휴대폰번호국가코드
	cell_phone_country_code varchar(6) COMMENT '휴대폰번호국가코드',
	-- 휴대폰번호
	cell_phone_number varchar(30) COMMENT '휴대폰번호',
	-- 문자수신여부
	is_sms bit(1) COMMENT '문자수신여부',
	-- 성별
	is_male bit(1) COMMENT '성별',
	-- 이메일
	email varchar(200) COMMENT '이메일',
	-- 처리상태
	status int(4) COMMENT '처리상태',
	-- 사업자등록번호
	company_number varchar(50) COMMENT '사업자등록번호',
	-- 회사명
	company_name varchar(100) COMMENT '회사명',
	-- 등록일시
	insert_date datetime DEFAULT NOW() COMMENT '등록일시',
	-- 탈퇴일시
	dropout_date datetime COMMENT '탈퇴일시',
	-- 탈퇴이유
	dropout_reason varchar(500) COMMENT '탈퇴이유',
	-- 관리자메모
	admin_comment varchar(1000) COMMENT '관리자메모',
	-- 버전
	version int unsigned COMMENT '버전',
	-- 총로그인횟수
	total_access_cnt bigint unsigned DEFAULT 0 COMMENT '총로그인횟수',
	-- 마지막로그인아아피
	last_access_ip bigint unsigned COMMENT '마지막로그인아아피',
	-- 마지막로그인일시
	last_access_date datetime COMMENT '마지막로그인일시',
	-- 관리자여부
	is_admin bit(1) COMMENT '관리자여부',
	-- 총질문수
	question_cnt bigint unsigned DEFAULT 0 COMMENT '총질문수',
	-- 총답변수
	answer_cnt bigint unsigned DEFAULT 0 COMMENT '총답변수',
	PRIMARY KEY (member_id),
	UNIQUE (member_id),
	UNIQUE (loginid),
	UNIQUE (nickname)
);


CREATE TABLE hr_profile
(
	-- 프로필제목
	profile_title varchar(100) COMMENT '프로필제목',
	-- 공개여부
	is_open bit(1) COMMENT '공개여부',
	-- 파일저장경로
	save_path varchar(250) COMMENT '파일저장경로',
	-- 파일저장코드
	save_code int(4) COMMENT '파일저장코드',
	-- 경력
	career varchar(2000) COMMENT '경력',
	-- 소개
	introduce varchar(500) COMMENT '소개',
	-- 회원일련번호
	member_id bigint unsigned COMMENT '회원일련번호'
);


CREATE TABLE pt_deposit
(
	-- 입금신청일련번호
	deposit_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '입금신청일련번호',
	-- 요청포인트
	request_point bigint unsigned COMMENT '요청포인트',
	-- 요청계좌명
	request_account_name varchar(50) COMMENT '요청계좌명',
	-- 요청일시
	request_date datetime COMMENT '요청일시',
	-- 처리상태
	status int(4) COMMENT '처리상태',
	-- 결제상태
	payment_status int(4) unsigned COMMENT '결제상태',
	-- 결제고유번호
	payment_id varchar(50) COMMENT '결제고유번호',
	-- 결제이메일
	payer_email varchar(200) COMMENT '결제이메일',
	-- 결제일시
	payment_date varchar(50) COMMENT '결제일시',
	-- 결제수수료
	payment_fee float(12,2) COMMENT '결제수수료',
	-- 금액
	amount float(12,2) COMMENT '금액',
	-- 확인포인트
	confirm_point bigint unsigned COMMENT '확인포인트',
	-- 확인계좌명
	confirm_account_name varchar(50) COMMENT '확인계좌명',
	-- 확인일시
	confirm_date datetime COMMENT '확인일시',
	-- 관리자메모
	admin_comment varchar(1000) COMMENT '관리자메모',
	-- 등록일시
	insert_date datetime DEFAULT NOW() COMMENT '등록일시',
	-- 수정일시
	update_date datetime COMMENT '수정일시',
	-- 관리자일련번호
	admin_id bigint unsigned COMMENT '관리자일련번호',
	-- 가상계좌일련번호
	cyber_acc_id bigint unsigned NOT NULL COMMENT '가상계좌일련번호',
	PRIMARY KEY (deposit_id),
	UNIQUE (deposit_id)
);


CREATE TABLE pt_point
(
	-- 포인트일련번호
	point_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '포인트일련번호',
	-- 포인트유형
	type int(4) COMMENT '포인트유형',
	-- 출처고유번호
	source_id bigint unsigned COMMENT '출처고유번호',
	-- 포인트
	point bigint COMMENT '포인트',
	-- 금액
	amount float(12,2) COMMENT '금액',
	-- 잔액
	balance bigint COMMENT '잔액',
	-- 등록일시
	insert_date datetime DEFAULT NOW() COMMENT '등록일시',
	-- 가상계좌일련번호
	cyber_acc_id bigint unsigned NOT NULL COMMENT '가상계좌일련번호',
	PRIMARY KEY (point_id),
	UNIQUE (point_id)
);


CREATE TABLE pt_withdraw
(
	-- 출금신청일련번호
	withdraw_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '출금신청일련번호',
	-- 요청포인트
	request_point bigint unsigned COMMENT '요청포인트',
	-- 처리상태
	status int(4) COMMENT '처리상태',
	-- 페이팔계정(이메일)
	paypal_account varchar(200) COMMENT '페이팔계정(이메일)',
	-- 금액
	amount float(12,2) COMMENT '금액',
	-- 수수료
	fee float(12,2) COMMENT '수수료',
	-- 확인포인트
	confirm_point bigint unsigned COMMENT '확인포인트',
	-- 확인은행코드
	confirm_bank_code varchar(10) COMMENT '확인은행코드',
	-- 확인계좌번호
	confirm_account_number varchar(50) COMMENT '확인계좌번호',
	-- 확인계좌명
	confirm_account_name varchar(50) COMMENT '확인계좌명',
	-- 확인일시
	confirm_date datetime COMMENT '확인일시',
	-- 관리자메모
	admin_comment varchar(1000) COMMENT '관리자메모',
	-- 등록일시
	insert_date datetime DEFAULT NOW() COMMENT '등록일시',
	-- 수정일시
	update_date datetime COMMENT '수정일시',
	-- 인증일련번호
	certify_id bigint unsigned COMMENT '인증일련번호',
	-- 은행계좌일련번호
	bank_acc_id bigint unsigned COMMENT '은행계좌일련번호',
	-- 관리자일련번호
	admin_id bigint unsigned COMMENT '관리자일련번호',
	-- 가상계좌일련번호
	cyber_acc_id bigint unsigned NOT NULL COMMENT '가상계좌일련번호',
	PRIMARY KEY (withdraw_id),
	UNIQUE (withdraw_id),
	UNIQUE (certify_id)
);


CREATE TABLE qa_item
(
	-- 질문답변일련번호
	qa_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '질문답변일련번호',
	-- 그룹일련번호
	group_id bigint unsigned COMMENT '그룹일련번호',
	-- 부모일련번호
	parent_id bigint unsigned COMMENT '부모일련번호',
	-- 답변그룹일련번호
	answer_group_id bigint unsigned COMMENT '답변그룹일련번호',
	-- 스텝(질문, 답변, 의견 구분코드)
	step int unsigned COMMENT '스텝(질문, 답변, 의견 구분코드)',
	-- 포지션
	position int unsigned DEFAULT 0 COMMENT '포지션',
	-- 제목
	title varchar(500) COMMENT '제목',
	-- 본문
	content text COMMENT '본문',
	-- 조회수
	read_count int unsigned COMMENT '조회수',
	-- 답변수
	reply_count int unsigned COMMENT '답변수',
	-- 포인트
	point bigint COMMENT '포인트',
	-- 평가점수
	grade_point int COMMENT '평가점수',
	-- 처리상태
	status int(4) COMMENT '처리상태',
	-- 취소사유
	cancel_reason varchar(500) COMMENT '취소사유',
	-- 채택여부
	is_choose bit(1) COMMENT '채택여부',
	-- 확인여부
	is_read bit(1) COMMENT '확인여부',
	-- 관심등록여부
	is_favorite bit(1) COMMENT '관심등록여부',
	-- 예정채택건수
	choose_count int DEFAULT 0 COMMENT '예정채택건수',
	-- 포인트분배유형(0:균등, 1:차등)
	share_type int COMMENT '포인트분배유형(0:균등, 1:차등)',
	-- 포인트비율
	point_ratio varchar(2000) COMMENT '포인트비율',
	-- 등록일시
	insert_date datetime DEFAULT NOW() COMMENT '등록일시',
	-- 만료일시
	expire_date datetime COMMENT '만료일시',
	-- 수정일시
	update_date datetime COMMENT '수정일시',
	-- 회원자노출명
	member_display_name varchar(150) COMMENT '회원자노출명',
	-- 회원일련번호
	member_id bigint unsigned COMMENT '회원일련번호',
	-- 관리자일련번호
	admin_id bigint unsigned COMMENT '관리자일련번호',
	PRIMARY KEY (qa_id),
	UNIQUE (qa_id)
);


CREATE TABLE qa_item_category
(
	-- 질문답변일련번호
	qa_id bigint unsigned NOT NULL COMMENT '질문답변일련번호',
	-- 분류일련번호
	category_id bigint unsigned NOT NULL COMMENT '분류일련번호',
	-- 1레벨분류일련번호
	level1 bigint unsigned COMMENT '1레벨분류일련번호',
	-- 2레벨분류일련번호
	level2 bigint unsigned COMMENT '2레벨분류일련번호',
	-- 3레벨분류일련번호
	level3 bigint unsigned COMMENT '3레벨분류일련번호',
	-- 4레벨분류일련번호
	level4 bigint unsigned COMMENT '4레벨분류일련번호',
	-- 태그
	tag varchar(128) COMMENT '태그',
	-- 정렬순서
	sort_order int COMMENT '정렬순서'
);


CREATE TABLE qa_item_file
(
	-- 파일일련번호
	file_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '파일일련번호',
	-- 파일명
	file_name varchar(250) COMMENT '파일명',
	-- 파일사이즈
	file_size bigint unsigned COMMENT '파일사이즈',
	-- 파일저장경로
	save_path varchar(250) COMMENT '파일저장경로',
	-- 파일저장코드
	save_code int(4) COMMENT '파일저장코드',
	-- 다운로드수
	dnld_count int unsigned COMMENT '다운로드수',
	-- 정렬순서
	sort_order int COMMENT '정렬순서',
	-- 질문답변일련번호
	qa_id bigint unsigned NOT NULL COMMENT '질문답변일련번호',
	PRIMARY KEY (file_id),
	UNIQUE (file_id)
);


CREATE TABLE qa_item_point
(
	-- 포인트비율
	point_ratio int DEFAULT 0 COMMENT '포인트비율',
	-- 포인트
	point bigint DEFAULT 0 COMMENT '포인트',
	-- 순위
	rank int unsigned COMMENT '순위',
	-- 등록일시
	insert_date datetime DEFAULT NOW() COMMENT '등록일시',
	-- 수정일시
	update_date datetime COMMENT '수정일시',
	-- 질문일련번호
	qa_id bigint unsigned NOT NULL COMMENT '질문일련번호',
	-- 답변일련번호
	answer_id bigint unsigned COMMENT '답변일련번호'
);


CREATE TABLE qa_item_report
(
	-- 신고일련번호
	report_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '신고일련번호',
	-- 내용
	content varchar(4000) COMMENT '내용',
	-- 등록일시
	insert_date datetime DEFAULT NOW() COMMENT '등록일시',
	-- 확인일시
	confirm_date datetime COMMENT '확인일시',
	-- 확인여부
	is_confirm bit(1) COMMENT '확인여부',
	-- 관리자메모
	admin_comment varchar(1000) COMMENT '관리자메모',
	-- 회원자노출명
	member_display_name varchar(150) COMMENT '회원자노출명',
	-- 회원일련번호
	member_id bigint unsigned COMMENT '회원일련번호',
	-- 관리자노출명
	admin_display_name varchar(150) COMMENT '관리자노출명',
	-- 관리자일련번호
	admin_id bigint unsigned COMMENT '관리자일련번호',
	-- 질문답변일련번호
	qa_id bigint unsigned NOT NULL COMMENT '질문답변일련번호',
	PRIMARY KEY (report_id),
	UNIQUE (report_id)
);


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


CREATE TABLE sa_category
(
	-- 분류일련번호
	category_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '분류일련번호',
	-- 부모일련번호
	parent_id bigint unsigned COMMENT '부모일련번호',
	-- 최상위부모일련번호
	root_id bigint unsigned COMMENT '최상위부모일련번호',
	-- 분류명
	category_name varchar(500) COMMENT '분류명',
	-- 플래그코드
	flag_code int(4) COMMENT '플래그코드',
	-- 정렬순서
	sort_order int COMMENT '정렬순서',
	-- 수정일시
	update_date datetime COMMENT '수정일시',
	-- 이미지클래스
	class_name varchar(255) COMMENT '이미지클래스',
	PRIMARY KEY (category_id),
	UNIQUE (category_id)
);


CREATE TABLE sa_config
(
	-- 설정코드
	code varchar(100) NOT NULL COMMENT '설정코드',
	-- 설정값
	value varchar(4000) COMMENT '설정값',
	PRIMARY KEY (code),
	UNIQUE (code)
);


CREATE TABLE sa_lock
(
	-- 락이름
	name varchar(255) NOT NULL COMMENT '락이름',
	PRIMARY KEY (name),
	UNIQUE (name)
);


CREATE TABLE sa_log
(
	-- 로그일련번호
	log_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '로그일련번호',
	-- 스케줄명
	schedule_name varchar(200) COMMENT '스케줄명',
	-- 등록일시
	insert_date datetime DEFAULT NOW() COMMENT '등록일시',
	-- 파라미터
	param varchar(200) COMMENT '파라미터',
	-- 결과
	result bit(1) COMMENT '결과',
	-- 결과상세
	result_detail varchar(4000) COMMENT '결과상세',
	-- 아이피
	ip bigint unsigned COMMENT '아이피',
	PRIMARY KEY (log_id)
);


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


CREATE TABLE sa_schedule
(
	-- 스케줄일련번호
	schedule_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '스케줄일련번호',
	-- 스케줄명
	schedule_name varchar(200) COMMENT '스케줄명',
	-- 파라미터
	param varchar(200) COMMENT '파라미터',
	-- 결과코드
	result_code int(4) unsigned COMMENT '결과코드',
	-- 정지여부
	is_paused bit(1) COMMENT '정지여부',
	-- 등록일시
	insert_date datetime DEFAULT NOW() COMMENT '등록일시',
	-- 다음수행시간
	run_date datetime COMMENT '다음수행시간',
	-- 실행간격
	period int unsigned DEFAULT 0 COMMENT '실행간격',
	-- cron표현식
	cron varchar(50) COMMENT 'cron표현식',
	PRIMARY KEY (schedule_id),
	UNIQUE (schedule_id)
);


CREATE TABLE sa_sms_certify
(
	-- 인증일련번호
	certify_id bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '인증일련번호',
	-- 휴대폰번호국가코드
	cell_phone_country_code varchar(6) COMMENT '휴대폰번호국가코드',
	-- 휴대폰번호
	cell_phone_number varchar(30) COMMENT '휴대폰번호',
	-- 인증번호(랜덤6자리)
	certify_number varchar(6) COMMENT '인증번호(랜덤6자리)',
	-- 결과코드
	result_code int(4) unsigned COMMENT '결과코드',
	-- 등록일시
	insert_date datetime DEFAULT NOW() COMMENT '등록일시',
	-- 회원일련번호
	member_id bigint unsigned COMMENT '회원일련번호',
	PRIMARY KEY (certify_id),
	UNIQUE (certify_id)
);



/* Create Foreign Keys */

ALTER TABLE doc_item_category
	ADD FOREIGN KEY (item_id)
	REFERENCES doc_item (item_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE doc_item_file
	ADD CONSTRAINT doc_item_file_ibfk_1 FOREIGN KEY (item_id)
	REFERENCES doc_item (item_id)
	ON UPDATE NO ACTION
	ON DELETE CASCADE
;


ALTER TABLE pt_withdraw
	ADD FOREIGN KEY (bank_acc_id)
	REFERENCES hr_bank_account (bank_acc_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE pt_deposit
	ADD FOREIGN KEY (cyber_acc_id)
	REFERENCES hr_cyber_account (cyber_acc_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE pt_point
	ADD FOREIGN KEY (cyber_acc_id)
	REFERENCES hr_cyber_account (cyber_acc_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE pt_withdraw
	ADD FOREIGN KEY (cyber_acc_id)
	REFERENCES hr_cyber_account (cyber_acc_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE cm_inquiry
	ADD FOREIGN KEY (admin_id)
	REFERENCES hr_member (member_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE cm_notice
	ADD FOREIGN KEY (admin_id)
	REFERENCES hr_member (member_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE doc_item
	ADD CONSTRAINT doc_item_ibfk_1 FOREIGN KEY (member_id)
	REFERENCES hr_member (member_id)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
;


ALTER TABLE hr_access
	ADD CONSTRAINT hr_member_access_ibfk_1 FOREIGN KEY (member_id)
	REFERENCES hr_member (member_id)
	ON UPDATE NO ACTION
	ON DELETE CASCADE
;


ALTER TABLE hr_bank_account
	ADD FOREIGN KEY (member_id)
	REFERENCES hr_member (member_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE hr_category
	ADD FOREIGN KEY (member_id)
	REFERENCES hr_member (member_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE hr_cyber_account
	ADD FOREIGN KEY (member_id)
	REFERENCES hr_member (member_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE hr_profile
	ADD CONSTRAINT hr_member_profile_ibfk_1 FOREIGN KEY (member_id)
	REFERENCES hr_member (member_id)
	ON UPDATE NO ACTION
	ON DELETE CASCADE
;


ALTER TABLE pt_deposit
	ADD FOREIGN KEY (admin_id)
	REFERENCES hr_member (member_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE pt_withdraw
	ADD FOREIGN KEY (admin_id)
	REFERENCES hr_member (member_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE qa_item
	ADD FOREIGN KEY (member_id)
	REFERENCES hr_member (member_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE qa_item
	ADD FOREIGN KEY (admin_id)
	REFERENCES hr_member (member_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE qa_item_report
	ADD FOREIGN KEY (member_id)
	REFERENCES hr_member (member_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE qa_item_report
	ADD FOREIGN KEY (admin_id)
	REFERENCES hr_member (member_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


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


ALTER TABLE sa_sms_certify
	ADD FOREIGN KEY (member_id)
	REFERENCES hr_member (member_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE qa_item_category
	ADD FOREIGN KEY (qa_id)
	REFERENCES qa_item (qa_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE qa_item_file
	ADD FOREIGN KEY (qa_id)
	REFERENCES qa_item (qa_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE qa_item_point
	ADD FOREIGN KEY (answer_id)
	REFERENCES qa_item (qa_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE qa_item_point
	ADD FOREIGN KEY (qa_id)
	REFERENCES qa_item (qa_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE qa_item_report
	ADD FOREIGN KEY (qa_id)
	REFERENCES qa_item (qa_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE doc_item_category
	ADD FOREIGN KEY (category_id)
	REFERENCES sa_category (category_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE hr_category
	ADD FOREIGN KEY (category_id)
	REFERENCES sa_category (category_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE qa_item_category
	ADD FOREIGN KEY (category_id)
	REFERENCES sa_category (category_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE sa_axis
	ADD FOREIGN KEY (category_id)
	REFERENCES sa_category (category_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE sa_message_receiver
	ADD FOREIGN KEY (message_id)
	REFERENCES sa_message (message_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE pt_withdraw
	ADD FOREIGN KEY (certify_id)
	REFERENCES sa_sms_certify (certify_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



/* Create Indexes */

CREATE INDEX status ON hr_member (status ASC);
CREATE INDEX status ON pt_deposit (status ASC);
CREATE INDEX status ON pt_withdraw (status ASC);
CREATE INDEX is_read ON qa_item (is_read ASC);
CREATE INDEX is_choose ON qa_item (is_choose ASC);
CREATE INDEX position ON qa_item (position ASC);
CREATE INDEX status ON qa_item (status ASC);
CREATE INDEX group_id ON qa_item (group_id ASC);
CREATE INDEX answer_group_id ON qa_item (answer_group_id ASC);



