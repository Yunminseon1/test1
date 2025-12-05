# 🧊 23기 디비프로젝트


<img width="600" height="600" alt="Image" src="https://github.com/user-attachments/assets/8da2ea3c-5c97-4df7-beb7-594d46e34c8d" />



현대 온라인 커뮤니티와 소셜 플랫폼에서는 사용자 간 실시간 소통이 활발하게 이루어지고 있으나, 익명성이 높은 플랫폼에서는 **욕설**, **비속어**, **혐오 표현**, **괴롭힘** 등 부적절한 커뮤니케이션 문제가 빈번히 발생하고 있습니다.
대부분의 채팅 서비스는 메시지 전송에 집중되어 있으며,**운영 기능**(**금칙어 관리, 신고/제재, 알림**)를 체계적으로 통합한 사례는 적습니다.

**Talk service**는 이러한 문제를 해결하기 위해 안전하고 운영 가능한 익명 기반 채팅 서비스를 구현하고,
사용자 관리부터 메시지 관리, 신고/제재, 금칙어 필터링까지 DB 중심으로 관리 가능한 구조를 설계하여 서비스의 안정성과 운영 편의성의 제공을 목표로 합니다. 


# 📚 목차
 
## 📁 1. 프로젝트
- [1-1. 개요](#1-1-개요)
- [1-2. 배경](#1-2-배경)
- [1-3. 서비스 목적 및 기대효과](#1-3-서비스-목적-및-기대효과)
- [1-4. 주요 기능](#1-4-주요-기능)
## 🗒️ 2. WBS
- [2. WBS](#2-wbs)





## 📁 1. 프로젝트

## 1-1 개요


## 1-2 배경


## 1-4 주요 기능
## 👤 회원 기능

| 기능 | 설명 |
|:---|:---|
| 회원가입/로그인 | 기본 인증 기능 제공 |
| 비밀번호 변경 | 사용자 비밀번호 수정 기능 |
| 개인정보 수정 | 프로필 및 개인정보 변경 가능 |
| 탈퇴 처리 | 탈퇴 시 계정 상태 비활성화 |
| 상태 조회 | 사용자 활성/비활성 여부 조회 가능 |
## 🚨 제재 및 신고 기능

| 기능 | 설명 |
|:---|:---|
| 제재 이력 관리 | 사용자 제재 기록 저장(BanLog) |
| 메시지 신고 | 메시지 신고 기능 제공 |
| 사용자 신고 | 특정 사용자 신고 가능 |
| 신고 처리 | 신고 검토/처리 로직 제공 |
| 신고 조회 | 신고 내역 열람 기능 |
## 💬 채팅방 기능

| 기능 | 설명 |
|:---|:---|
| 채팅방 생성/종료 | 방 생성 및 종료 기능 |
| 참여자 입장 기록 | 참여자 입장 이벤트 기록 |
| 참여자 퇴장 기록 | 참여자 퇴장 이벤트 기록 |
| 참여자 목록 조회 | 채팅방 참여자 리스트 확인 |
## 📩 메시지 관리

| 기능 | 설명 |
|:---|:---|
| 메시지 전송 | 메시지 송신 기능 |
| 메시지 삭제 | 메시지 삭제 처리 기능 |
| 메시지 읽음 처리 | 메시지 읽음 상태 저장 |
| 읽음 사용자 수 카운트 | 읽은 사용자 수 집계 |
## 🔔 알림 기능

| 기능 | 설명 |
|:---|:---|
| 공지 생성 | 시스템 공지 생성 기능 |
| 방 공지 | 채팅방 공지 기능 제공 |
| 사용자 알림 저장 | 사용자별 알림 저장 |
| 알림 읽음 처리 | 알림 읽음 상태 관리 |
| 알림 삭제 | 알림 삭제 기능 제공 |
## ⛔ 금칙어 관리

| 기능 | 설명 |
|:---|:---|
| 금칙어 등록 | 금칙어 리스트 등록 기능 |
| 금칙어 필터링 | 채팅 메시지 필터링 처리 |
| 방별 금칙어 조회 | 채팅방별 금칙어 목록 조회 |

MindMatch는 익명으로 마음을 나누는 정서 케어 플랫폼으로, 보이지 않는 마음을 연결하고 치유하는 익명 대화 공간을 제공합니다.

## 2.WBS

## 3.요구사항명세서

## 4.DB 모델링

<img width="1251" height="627" alt="Image" src="https://github.com/user-attachments/assets/f9f6b63f-59c7-4917-8774-84a972f8b169" />

https://www.erdcloud.com/d/a82D67dvEfHuW6gDL

## 📦  5. 코드

create database Talk_Service;
use Talk_Service;

CREATE TABLE User (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nickname VARCHAR(255) NOT NULL,
    join_date DATETIME NOT NULL,
    is_active BOOLEAN NOT NULL,
    role VARCHAR(255) NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    user_password VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    phonenumber varchar(255) not null,
    email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE ChatRoom (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    m_user_id BIGINT NOT NULL,
    status VARCHAR(255) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME,
    topic VARCHAR(255) NOT NULL,
    FOREIGN KEY (m_user_id) REFERENCES User(id)
);



CREATE TABLE RoomParticipant (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    room_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    join_time DATETIME NOT NULL,
    leave_time DATETIME NULL,
    is_out BOOLEAN NOT NULL,
    FOREIGN KEY (room_id) REFERENCES ChatRoom(id),
    FOREIGN KEY (user_id) REFERENCES User(id)
);

CREATE TABLE ChatMessage (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    room_id BIGINT NOT NULL,
    content VARCHAR(255) NOT NULL,
    send_time DATETIME NOT NULL,
    is_deleted BOOLEAN NOT NULL,
    count BIGINT NOT NULL,
    FOREIGN KEY (room_id) REFERENCES ChatRoom(id)
);

CREATE TABLE MessageRead (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    message_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    is_read BOOLEAN NOT NULL,
    FOREIGN KEY (message_id) REFERENCES ChatMessage(id),
    FOREIGN KEY (user_id) REFERENCES User(id)
);

CREATE TABLE Forbidden_words(
 id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 chat_room_id BIGINT NOT NULL,
 forbidden_word VARCHAR(255) NOT NULL,
 FOREIGN KEY (chat_room_id) REFERENCES ChatRoom(id)
);

CREATE TABLE Report (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    reporter_user_id BIGINT NOT NULL,
    chat_message_id BIGINT NOT NULL,
    reported_object_id BIGINT NOT NULL,
    reason VARCHAR(255) NOT NULL,
    report_time DATETIME NOT NULL,
    process_status VARCHAR(255) NOT NULL,
    FOREIGN KEY (reporter_user_id) REFERENCES User(id),
    FOREIGN KEY (chat_message_id) REFERENCES ChatMessage(id),
    FOREIGN KEY (reported_object_id) REFERENCES User(id)
);

CREATE TABLE BanLog(
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    reason VARCHAR(255) NULL,
    ban_start_time DATETIME NOT NULL,
    ban_end_time DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(id)
);

CREATE TABLE Notification (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NULL,
    content VARCHAR(3000) NOT NULL,
    created_time DATETIME NOT NULL
);

CREATE TABLE NotificationUser (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    notification_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    is_read BOOLEAN NOT NULL,
    read_time DATETIME NOT NULL,
    delivered_time DATETIME NOT NULL,
    FOREIGN KEY (notification_id) REFERENCES Notification(id),
    FOREIGN KEY (user_id) REFERENCES User(id)
);


-- 관리자, 유저 등록
INSERT INTO User(nickname, join_date, is_active, role, user_id, user_password, user_name, phonenumber, email)
VALUES 
('관리자', NOW(), TRUE, 'ADMIN', 'admin01', '1234', '관리자홍', '010-1111-1111', 'admin@test.com'),
('익명1', NOW(), TRUE, 'USER', 'user01', '1234', '홍길동', '010-2222-2222', 'user01@test.com'),
('익명2', NOW(), TRUE, 'USER', 'user02', '1234', '김철수', '010-3333-3333', 'user02@test.com'),
('익명3', NOW(), TRUE, 'USER', 'user03', '1234', '이영희', '010-4444-4444', 'user03@test.com');

--프로시저: 채팅방/메시지/강퇴/신고/제재 시연
DELIMITER //
CREATE PROCEDURE simulate_chatroom_activity()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 1;

   -- 3-1. 채팅방 생성
    INSERT INTO ChatRoom(m_user_id, status, start_time, end_time, topic)
    VALUES (2, '활성', NOW(), NULL, '연애'),
           (3, '활성', NOW(), NULL, '취미');

   -- 3-2. 방 참여
    INSERT INTO RoomParticipant(room_id, user_id, join_time, leave_time, is_out)
    VALUES (1, 2, NOW(), NULL, FALSE),
           (1, 3, NOW(), NULL, FALSE),
           (1, 4, NOW(), NULL, FALSE),
           (2, 3, NOW(), NULL, FALSE),
           (2, 4, NOW(), NULL, FALSE);

   -- 3-3. 메시지 전송 (방당 20개)
    WHILE i <= 2 DO
        SET j = 1;
        WHILE j <= 20 DO
            INSERT INTO ChatMessage(room_id, content, send_time, is_deleted, count)
            VALUES (i, CONCAT('메시지 ', j, ' in room ', i), NOW(), FALSE, 0);
            SET j = j + 1;
        END WHILE;
        SET i = i + 1;
    END WHILE;

   -- 3-4. 메시지 읽음 랜덤
    INSERT INTO MessageRead(message_id, user_id, is_read)
    SELECT id, 2 + FLOOR(RAND()*2), TRUE FROM ChatMessage;

   -- 3-5. 금칙어 등록 & 욕설 포함 메시지 강퇴
    INSERT INTO Forbidden_words(chat_room_id, forbidden_word)
    VALUES (1, '욕설1'), (1, '욕설2');

   -- 금칙어 포함 메시지 강퇴 (방장 시뮬레이션)
    UPDATE RoomParticipant SET is_out=TRUE, leave_time=NOW()
    WHERE user_id=4 AND room_id=1;

   -- 3-6. 신고 자동 생성
    INSERT INTO Report(reporter_user_id, chat_message_id, reported_object_id, reason, report_time, process_status)
    VALUES (2, 5, 4, '욕설 사용', NOW(), '대기중');

   -- 3-7. 제재 기록 생성 (관리자)
    INSERT INTO BanLog(user_id, reason, ban_start_time, ban_end_time)
    VALUES (4, '욕설 사용으로 제재', NOW(), DATE_ADD(NOW(), INTERVAL 1 DAY));
END //
DELIMITER ;
-- 프로시저 실행
CALL simulate_chatroom_activity();


-- 회원 조회
SELECT * FROM User;

-- 채팅방 조회
SELECT * FROM ChatRoom;

-- 참여자 조회
SELECT * FROM RoomParticipant;

-- 메시지 조회
SELECT * FROM ChatMessage;

-- 메시지 읽음
SELECT * FROM MessageRead;

-- 금칙어 조회
SELECT * FROM Forbidden_words;

UPDATE Forbidden_words
SET forbidden_word = '욕설변경'
WHERE id = 1;

UPDATE Forbidden_words
SET forbidden_word = 'ㅅㅂ'
WHERE id = 1;

UPDATE Forbidden_words
SET forbidden_word = '개새끼'
WHERE id = 2;
-- 금칙어등록+강퇴 발생 후
SELECT * FROM RoomParticipant WHERE is_out=TRUE;

-- 신고 조회
SELECT * FROM Report;

-- 제재 조회
SELECT * FROM BanLog;

-- 알림 생성
INSERT INTO Notification(title, content, created_time)
VALUES ('공지', '테스트 공지입니다.', NOW());

-- 알림 사용자 발송
INSERT INTO NotificationUser(notification_id, user_id, is_read, read_time, delivered_time)
VALUES (1, 2, FALSE, NOW(), NOW());

-- 알림 읽음 처리(is_read 타입을 voolean 처리를 해서 true는 1, false는 0으로 나옴)
UPDATE NotificationUser SET is_read=TRUE, read_time=NOW() WHERE id=1;
SELECT * FROM NotificationUser WHERE id = 1;

-- 알림조회
SELECT * FROM Notification; 
SELECT * FROM NotificationUser;





