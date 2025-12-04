ROOM-003 — 방 입장 (join_time 기록)
INSERT INTO RoomParticipant (room_id, user_id, join_time)
VALUES (:room_id, :user_id, NOW());

ROOM-004 — 방 퇴장 (leave_time 업데이트)
UPDATE RoomParticipant
SET leave_time = NOW()
WHERE room_id = :room_id
  AND user_id = :user_id
  AND leave_time IS NULL;

ROOM -005
SELECT *
FROM RoomParticipant
WHERE room_id = :room_id
ORDER BY join_time ASC;

NOTI-005 — 사용자 알림 삭제 (is_deleted = true)
UPDATE NotificationUser
SET is_deleted = TRUE,
    deleted_at = NOW()
WHERE notification_user_id = :notification_user_id;

