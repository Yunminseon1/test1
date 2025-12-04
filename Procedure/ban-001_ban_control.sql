delimiter //
-- 프로시저 이름: SP_BAN_USER
-- 기능: 사용자 활동 상태 비활성화 및 BanLog에 기록
CREATE PROCEDURE SP_BAN_USER (
    IN p_user_id BIGINT,              -- 제재 대상 사용자의 ID (User.id)
    IN p_reason VARCHAR(255),         -- 제재 사유
    IN p_ban_start_time DATETIME,     -- 제재 시작 시간
    IN p_ban_end_time DATETIME        -- 제재 종료 시간 (영구 제재의 경우 NULL 또는 먼 미래의 값)
)
BEGIN
    -- 에러 발생 시 롤백을 처리하는 핸들러 설정
    declare exit handler for SQLEXCEPTION
    begin
        rollback;
    end;

    -- 데이터 일관성을 위해 트랜잭션 시작
    START TRANSACTION;

    -- 1. User 테이블의 활동 상태 변경 (is_active = 0)
    -- *참고: ERD 상 is_active가 제재 여부를 나타낸다고 가정*
    UPDATE User
    SET is_active = 0 
    WHERE id = p_user_id;

    -- 2. BanLog 테이블에 제재 기록 삽입
    INSERT INTO BanLog (
        user_id,
        reason,
        ban_start_time,
        ban_end_time
    ) VALUES (
        p_user_id,
        p_reason,
        p_ban_start_time,
        p_ban_end_time
    );

    -- 모든 작업 성공 시 트랜잭션 커밋
    COMMIT;
		
end //
delimiter ;