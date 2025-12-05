# 🗨️ Talk_Service  
익명 기반 채팅 서비스 DB 프로젝트

---

# 1. 📌 프로젝트 개요 (Overview)

<img width="600" height="800" alt="Image" src="https://github.com/user-attachments/assets/3d04becb-fc56-440f-8e69-ad3d986c08d5" />




**Talk_Service**는 사용자들이 익명으로 참여할 수 있는 안전한 채팅 환경을 제공하기 위한  
**DB 중심의 채팅 서비스 시스템**입니다.

본 프로젝트는 단순 채팅을 넘어  
**금칙어 필터링, 신고/제재, 알림, 자동 로그 생성 프로시저까지 포함한 통합 운영 시스템**을 구축하는 것을 목표로 합니다.

---

# 2. 🎯 프로젝트 목적 (Objective)

- 익명 기반 채팅 서비스의 핵심 로직을 DB 구조로 완전하게 구현
- 회원, 채팅방, 메시지, 신고/제재, 알림 기능을 통합적으로 관리
- 하루치 서비스 로그를 자동 생성하는 시뮬레이션 프로시저 구현
- CRUD 기능 및 시나리오 기반 테스트 가능하도록 구조화
- DB 설계 표준(정규화·참조무결성·이력관리)을 반영한 실전형 프로젝트 구축

---

# 3. 🧩 주요 기능 요약 (Main Features)

### 👤 **회원 기능**
- 익명 닉네임 생성, 최소 로그인 인증
- 회원정보 수정
- 활성/비활성 처리, 제재 여부 관리

### 💬 **채팅 기능**
- 채팅방 생성 / 종료
- 참여자 입장 / 퇴장 / 강퇴
- 메시지 전송 / 삭제
- 메시지 읽음 처리 및 카운트 증가

### 🔥 **운영 기능**
- 금칙어 등록·조회·검사  
- 금칙어 포함 메시지 자동 강퇴  
- 메시지 신고 / 사용자 신고 / 신고 처리

### ⛔ **제재 기능**
- 제재 등록 및 제재 기간 관리  
- 사용자 상태 조회(정상 / 제재 중)

### 🔔 **알림 기능**
- 공지 생성  
- 사용자별 알림 발송  
- 읽음 처리 / 전달 시간 기록

### ⚙️ **시연 프로시저**
- 하루치 채팅 서비스 흐름을 자동으로 생성  
(채팅방 생성 → 참여 → 메시지 → 읽음 → 금칙어 → 신고 → 제재)

---

# 4. 🗂 WBS (Work Breakdown Structure)
https://docs.google.com/spreadsheets/d/1QoSLlN1Hlh1HhbqGWCwALpak9ikuPs487jqbI0XQO9o/edit?gid=1961214343#gid=1961214343
<details open>
  <summary><b>
</b></summary>
<img width="1567" height="572" alt="wbs" src="https://github.com/user-attachments/assets/913cf75a-d1ad-40cf-b859-80cb371741fc" />
</details>

# 5. 📑 요구사항 정의서 (Requirements Specification)
https://docs.google.com/spreadsheets/d/1xQt-FRa4emQ58YfOVakJ1_T3ugmK7aH82Ts8HsuSz1M/edit?gid=2043864236#gid=2043864236
<details open>
  <summary><b>
</b></summary>
<img width="1394" height="596" alt="요구사항정의서" src="https://github.com/user-attachments/assets/a75d0baf-56bf-4d08-bb61-ccfa07384c50" />
</details>

# 6. 🧱 ERD 설계서

> 📌 *이미지 파일을 `/docs/erd.png` 경로에 넣고 아래 링크 유지하면 자동 표시됩니다.*
# 7. 🗄️ DDL & DML
#### DDL

<details>
<summary><b>테이블 생성 DDL</b></summary>
	
```sql
  
  CREATE DATABASE Talk_Service;
  USE Talk_Service;

  CREATE TABLE User (
      id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
      nickname VARCHAR(255) NOT NULL,
      join_date DATETIME NOT NULL,
      is_active BOOLEAN NOT NULL,
      role VARCHAR(255) NOT NULL,
      user_id VARCHAR(255) NOT NULL,
      user_password VARCHAR(255) NOT NULL,
      user_name VARCHAR(255) NOT NULL,
      phonenumber VARCHAR(255) NOT NULL,
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
 


  ```
</details>

</div>
</details>

<hr>

#### DML

<details>
<summary><b>테스트 데이터 입력 DML</b></summary>
	
```sql
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
```
</details>

</div>
</details>

<hr/>


# 8. 🎬 실행 결과 캡처
<details open>
  <summary><b>
</b></summary>
<img width="265" height="309" alt="001" src="https://github.com/user-attachments/assets/d65f6d9c-f6ab-4b4a-b688-dbbfb1e91b6a" />

	
<img width="806" height="240" alt="002" src="https://github.com/user-attachments/assets/d417d1df-260d-4300-b572-920eb5e59570" />


<img width="626" height="206" alt="003" src="https://github.com/user-attachments/assets/930fb553-6c6d-4376-8910-08d1fad193b3" />


<img width="578" height="194" alt="004" src="https://github.com/user-attachments/assets/8b382da6-2239-481c-ab5a-856230500ccc" />


<img width="601" height="258" alt="005" src="https://github.com/user-attachments/assets/aa243ebb-c5eb-499a-a646-4218b0a25ff2" />


<img width="453" height="219" alt="006" src="https://github.com/user-attachments/assets/a3f80bdf-54d0-4a1b-abdd-99ef1fa5c2a8" />


<img width="924" height="409" alt="007" src="https://github.com/user-attachments/assets/73518a67-8ab1-40f1-a292-7b7666be998c" />


<img width="776" height="254" alt="008" src="https://github.com/user-attachments/assets/7a061b5f-66c7-4123-9923-e9ed7c8055b0" />


</details>


