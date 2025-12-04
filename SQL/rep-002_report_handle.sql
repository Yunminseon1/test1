
--사용자 신고 처리
--report의 status를 pending에서 complete로 바꾸고, 제재했다면 제재내역에 사용자추가
--2번 report만 제재
update report set process_status = "COMPLETE", where id=1;

start transaction;
update report set process_status = "COMPLETE", where id=2;
insert into BanLog(id, user_id,reason,ban_start_time,ban_end_time) 
    values (1, 1,'욕설','25-12-04 11:03:10','25-12-07 11:03:10');