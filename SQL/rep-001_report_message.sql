--사용자 메시지 신고
--1번 id에 1번 유저가 2번 메시지에 대하여 3번 유저를 욕설로 신고합니다.
insert into report (id, reporter_user_id, chat_message_id, reported_object_id, reason, report_time, process_status)
values (1, 1, 2, 3,"욕설",current_timestamp(),"PENDING");

insert into report (id, reporter_user_id, chat_message_id, reported_object_id, reason, report_time, process_status)
values (2, 3, 4, 1,"욕설",current_timestamp(),"PENDING");