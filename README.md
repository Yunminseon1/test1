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


# 5. 📑 요구사항 정의서 (Requirements Specification)
https://docs.google.com/spreadsheets/d/1xQt-FRa4emQ58YfOVakJ1_T3ugmK7aH82Ts8HsuSz1M/edit?gid=2043864236#gid=2043864236


# 6. 🧱 ERD 설계서

> 📌 *이미지 파일을 `/docs/erd.png` 경로에 넣고 아래 링크 유지하면 자동 표시됩니다.*
# 7. 🗄️ DDL & DML
<details open>
  <summary><b>전체 DDL 리스트 </b></summary>
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
 



  </details>

  <details open>
    <summary><b>전체 DML 리스트</b></summary>

  ... 세부 항목들

</details>
# 8. 🎬 실행 결과 캡처
<details open>
  <summary><b><img width="265" height="309" alt="001" src="https://github.com/user-attachments/assets/d65f6d9c-f6ab-4b4a-b688-dbbfb1e91b6a" />
</b></summary>

... 세부 항목들

</details>


