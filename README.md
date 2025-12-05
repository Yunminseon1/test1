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



# 5. 📑 요구사항 정의서 (Requirements Specification)
https://docs.google.com/spreadsheets/d/1xQt-FRa4emQ58YfOVakJ1_T3ugmK7aH82Ts8HsuSz1M/edit?gid=2043864236#gid=2043864236


---
## 📦  5. 코드




<img width="899" height="482" alt="스크린샷 2025-12-05 100923" src="https://github.com/user-attachments/assets/de6f1daa-ef6e-426a-acba-98b827aeb49f" />


<img width="918" height="613" alt="스크린샷 2025-12-05 101013" src="https://github.com/user-attachments/assets/bd38829f-c8c7-4b56-845e-abe09e5c227e" />


<img width="796" height="612" alt="image" src="https://github.com/user-attachments/assets/17986ae0-44bf-48d4-8eec-bf20e25351ec" />


<img width="793" height="472" alt="image" src="https://github.com/user-attachments/assets/dc094fd1-e7c0-4991-bfc1-31099ec4c947" />


<img width="905" height="381" alt="image" src="https://github.com/user-attachments/assets/0395d9be-af41-41fd-849a-8cdeb6c0d6b0" />


<img width="917" height="463" alt="image" src="https://github.com/user-attachments/assets/34841149-0e47-410f-8417-c66b54dafe41" />


<img width="912" height="327" alt="image" src="https://github.com/user-attachments/assets/f8d12139-762c-4b74-adbd-f9e31e96045c" />


<img width="905" height="246" alt="image" src="https://github.com/user-attachments/assets/6161d97b-9e4d-4f1d-9b75-baae86f2c5d9" />


<img width="917" height="358" alt="image" src="https://github.com/user-attachments/assets/17d49551-da86-4110-a125-b775a5580c7f" />


<img width="883" height="553" alt="image" src="https://github.com/user-attachments/assets/278357ae-5637-423e-b01d-b1e712d48239" />


<img width="917" height="611" alt="image" src="https://github.com/user-attachments/assets/43efc815-ba90-4008-9bfb-298b87c0cddd" />


<img width="888" height="607" alt="image" src="https://github.com/user-attachments/assets/1ef5b38d-5c88-4449-92d3-f72c94d47946" />





# 6. 🧱 ERD 설계서

> 📌 *이미지 파일을 `/docs/erd.png` 경로에 넣고 아래 링크 유지하면 자동 표시됩니다.*
# 7. 🗄️ DDL & DML
# 8. 🎬 실행 결과 캡처
