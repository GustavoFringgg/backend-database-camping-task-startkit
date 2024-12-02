
-- ████████  █████   █     █ 
--   █ █   ██    █  █     ██ 
--   █ █████ ███ ███       █ 
--   █ █   █    ██  █      █ 
--   █ █   █████ █   █     █ 
-- ===================== ====================
-- 1. 用戶資料，資料表為 USER

-- 1. 新增：新增六筆用戶資料，資料如下：
--     1. 用戶名稱為`李燕容`，Email 為`lee2000@hexschooltest.io`，Role為`USER`
--     2. 用戶名稱為`王小明`，Email 為`wXlTq@hexschooltest.io`，Role為`USER`
--     3. 用戶名稱為`肌肉棒子`，Email 為`muscle@hexschooltest.io`，Role為`USER`
--     4. 用戶名稱為`好野人`，Email 為`richman@hexschooltest.io`，Role為`USER`
--     5. 用戶名稱為`Q太郎`，Email 為`starplatinum@hexschooltest.io`，Role為`USER`
--     6. 用戶名稱為 透明人，Email 為 opacity0@hexschooltest.io，Role 為 USER
INSERT INTO "USER" (NAME, email, role)
VALUES ('李燕容', 'lee2000@hexschooltest.io', 'USER'),
 	   ('王小明', 'wXlTq@hexschooltest.io', 'USER'),
  	   ('肌肉棒子', 'muscle@hexschooltest.io', 'USER'),
       ('好野人', 'richman@hexschooltest.io', 'USER'),
       ('Q太郎', 'starplatinum@hexschooltest.io', 'USER'),
       ('透明人', 'opacity0@hexschooltest.io', 'USER');
       --新增資料表

-- 1-2 修改：用 Email 找到 李燕容、肌肉棒子、Q太郎，如果他的 Role 為 USER 將他的 Role 改為 COACH
UPDATE "USER" 
SET "role" = 'COACH' --欲修改的動作
WHERE "email" IN (
    'lee2000@hexschooltest.io',
    'muscle@hexschooltest.io',
    'starplatinum@hexschooltest.io'
    )--篩選條件
AND "role" = 'USER'; --確保修改欄位資料為'USER'

-- 1-3 刪除：刪除USER 資料表中，用 Email 找到透明人，並刪除該筆資料
DELETE FROM "USER"  --使用DELTE語法
WHERE  "email" = 'opacity0@hexschooltest.io'; --需求:透過email找到該員

-- 1-4 查詢：取得USER 資料表目前所有用戶數量（提示：使用count函式）
SELECT COUNT(*) AS 用戶數量 FROM "USER" ;
--使用count函數計算USER數量，用別名'用戶數輛'呈現

-- 1-5 查詢：取得 USER 資料表所有用戶資料，並列出前 3 筆（提示：使用limit語法）
SELECT * FROM "USER" --查詢所有資料，故使用 * 做全選
LIMIT 3;--限制前3筆


--  ████████  █████   █    ████  
--    █ █   ██    █  █         █ 
--    █ █████ ███ ███       ███  
--    █ █   █    ██  █     █     
--    █ █   █████ █   █    █████ 
-- ===================== ====================
-- 2. 組合包方案 CREDIT_PACKAGE、客戶購買課程堂數 CREDIT_PURCHASE
-- 2-1. 新增：在`CREDIT_PACKAGE` 資料表新增三筆資料，資料需求如下：
    -- 1. 名稱為 `7 堂組合包方案`，價格為`1,400` 元，堂數為`7`
    -- 2. 名稱為`14 堂組合包方案`，價格為`2,520` 元，堂數為`14`
    -- 3. 名稱為 `21 堂組合包方案`，價格為`4,800` 元，堂數為`21`
INSERT INTO "CREDIT_PACKAGE" (NAME,credit_amount,price)
VALUES	('7 堂組合包方案', 7, 1400), 
('14 堂組合包方案', 14, 2520), 
('21 堂組合包方案', 21, 4800); 
-- 2-2. 新增：在 `CREDIT_PURCHASE` 資料表，新增三筆資料：（請使用 NAME 欄位做子查詢）
    -- 1. `王小明` 購買 `14 堂組合包方案`
    -- 2. `王小明` 購買 `21 堂組合包方案`
    -- 3. `好野人` 購買 `14 堂組合包方案`
INSERT INTO "CREDIT_PURCHASE" (user_id,credit_package_id,purchased_credits,price_paid)
VALUES(
(SELECT id FROM "USER" WHERE NAME ='王小明'),  --這裡如果名字KEY錯會跳"null value in column "user_id"
(SELECT id FROM "CREDIT_PACKAGE" WHERE NAME = '14 堂組合包方案'),
(SELECT credit_amount FROM "CREDIT_PACKAGE" WHERE NAME = '14 堂組合包方案'),
(SELECT price FROM "CREDIT_PACKAGE" WHERE NAME= '14 堂組合包方案')
),
(
(SELECT id FROM "USER" WHERE NAME ='王小明'),
(SELECT id FROM "CREDIT_PACKAGE" WHERE NAME = '21 堂組合包方案'),
(SELECT credit_amount FROM "CREDIT_PACKAGE" WHERE NAME = '21 堂組合包方案'),
(SELECT price FROM "CREDIT_PACKAGE" WHERE NAME = '21 堂組合包方案')
),
(
(SELECT id FROM "USER" WHERE NAME ='好野人'),
(SELECT id FROM "CREDIT_PACKAGE" WHERE NAME = '14 堂組合包方案'),	
(SELECT credit_amount FROM "CREDIT_PACKAGE" WHERE NAME = '14 堂組合包方案'),
(SELECT price FROM "CREDIT_PACKAGE" WHERE NAME = '14 堂組合包方案')
);

-- ████████  █████   █    ████   
--   █ █   ██    █  █         ██ 
--   █ █████ ███ ███       ███   
--   █ █   █    ██  █         ██ 
--   █ █   █████ █   █    ████   
-- ===================== ====================
-- 3. 教練資料 ，資料表為 COACH ,SKILL,COACH_LINK_SKILL
-- 3-1 新增：在`COACH`資料表新增三筆教練資料，資料需求如下：
    -- 1. 將用戶`李燕容`新增為教練，並且年資設定為2年（提示：使用`李燕容`的email ，取得 `李燕容` 的 `id` ）
    -- 2. 將用戶`肌肉棒子`新增為教練，並且年資設定為2年
    -- 3. 將用戶`Q太郎`新增為教練，並且年資設定為2年

--土炮插入法
--每筆資料都是一個單獨的 SELECT 子查詢，系統會對 USER 表查詢 3 次。
--在資料大的情況下，效能會很差
INSERT  INTO  "COACH" (user_id,experience_years)
VALUES
((SELECT id FROM "USER" WHERE email ='lee2000@hexschooltest.io'),2),
((SELECT id FROM "USER" WHERE email ='muscle@hexschooltest.io'),2),
((SELECT id FROM "USER" WHERE email ='starplatinum@hexschooltest.io'),2)
--
--批量插入法
--1.查詢：先執行 SELECT，依據 email 條件篩選出對應的 id 資料。
--2.插入：將這些符合條件的記錄插入到 COACH 表中。
--3.靜態值：批量插入時，experience_years 的值統一為 2。
--
--效能更好。
--寫法簡潔且可擴展性更高（可以輕鬆新增或修改條件）。
--適合多筆資料的插入操作。
-- INSERT INTO "COACH" (user_id, experience_yessars)
-- SELECT id,
--   2 AS "experience_years"  --不是在篩選 experience_years = 2 的資料，而是直接為插入的記錄設定這個值。
-- FROM "USER"
-- WHERE "email" IN ( --只有符合條件的 email，它們的 id 才會被拿來進行插入。
--     'lee2000@hexschooltest.io',
--     'muscle@hexschooltest.io',
--     'starplatinum@hexschooltest.io'
-- );

-- 3-2. 新增：承1，為三名教練新增專長資料至 `COACH_LINK_SKILL` ，資料需求如下：
    -- 1. 所有教練都有 `重訓` 專長
    -- 2. 教練`肌肉棒子` 需要有 `瑜伽` 專長
    -- 3. 教練`Q太郎` 需要有 `有氧運動` 與 `復健訓練` 專長

--3.2-1 所有教練都有 `重訓` 專長
--土炮插入法
INSERT INTO "COACH_LINK_SKILL" (coach_id, skill_id) VALUES 
(
  (SELECT id FROM "COACH" WHERE user_id = (SELECT id FROM "USER" WHERE email = 'lee2000@hexschooltest.io')),
  (SELECT id FROM "SKILL" WHERE NAME = '重訓')
),(
  (SELECT id FROM "COACH" WHERE user_id = (SELECT id FROM "USER" WHERE email = 'muscle@hexschooltest.io')),
  (SELECT id FROM "SKILL" WHERE NAME = '重訓')
),
(
  (SELECT id FROM "COACH" WHERE user_id = (SELECT id FROM "USER" WHERE email = 'starplatinum@hexschooltest.io')),
  (SELECT id FROM "SKILL" WHERE NAME = '重訓')
);

--------------------
--使用多行插入，使用別名，執行順序
--1. FROM 子句執行：
--   尋找資料來源表：從 "COACH" 開始，並設定其別名為 c。
--   JOIN 操作：
--     將 "COACH" 與 "USER" 根據條件 c.user_id = u.id 進行連結。
--     將結果與 "SKILL" 根據條件 s.NAME = '重訓' 再次連結。
--2. WHERE 子句執行：
--   在連結後的結果集中，篩選出 "USER" 表中 "role" 等於 'COACH' 的記錄。
--3. SELECT 子句執行：
--   從篩選後的結果集中，選取所需的欄位 c.id 和 s.id，並分別命名為 coach_id 和 skill_id。
--4. INSERT INTO 執行：
--   將 SELECT 的結果集逐行插入到 "COACH_LINK_SKILL" 表中，對應其欄位 coach_id 和 skill_id。
--INSERT INTO "COACH_LINK_SKILL" (coach_id, skill_id)
--SELECT 
--  c.id AS coach_id,
--  s.id AS skill_id
-- FROM 
--   "COACH" c --1.將"COACH" 使用別名C
-- JOIN 
--   "USER" u ON c.user_id = u.id
-- JOIN 
--   "SKILL" s ON s.NAME = '重訓'
-- WHERE 
--   u."role" = 'COACH';
--SQL 的執行順序和程式撰寫的順序不同，它的執行邏輯是：
--邏輯執行順序：FROM → JOIN → WHERE → SELECT → INSERT
--書寫順序：INSERT → SELECT → FROM → JOIN → WHERE
--------------------

--3.2-2 教練`肌肉棒子` 需要有 `瑜伽` 專長
INSERT INTO "COACH_LINK_SKILL" (coach_id, skill_id) VALUES 
(
  (SELECT id FROM "COACH" WHERE user_id = (SELECT id FROM "USER" WHERE email = 'muscle@hexschooltest.io')),
  (SELECT id FROM "SKILL" WHERE NAME = '瑜伽')
)

--3.2-3 教練`Q太郎` 需要有 `有氧運動` 與 `復健訓練` 專長
INSERT INTO "COACH_LINK_SKILL" (coach_id, skill_id)
SELECT 
    c.id AS coach_id,
    s.id AS skill_id
FROM 
    "COACH" c
JOIN 
    "USER" u ON c.user_id = u.id
JOIN 
    "SKILL" s ON s.NAME IN ('有氧運動', '復健訓練')
WHERE 
    u.email = 'starplatinum@hexschooltest.io';


-- 3-3 修改：更新教練的經驗年數，資料需求如下：
    -- 1. 教練`肌肉棒子` 的經驗年數為3年
    -- 2. 教練`Q太郎` 的經驗年數為5年




-- 3-4 刪除：新增一個專長 空中瑜伽 至 SKILL 資料表，之後刪除此專長。


--  ████████  █████   █    █   █ 
--    █ █   ██    █  █     █   █ 
--    █ █████ ███ ███      █████ 
--    █ █   █    ██  █         █ 
--    █ █   █████ █   █        █ 
-- ===================== ==================== 
-- 4. 課程管理 COURSE 、組合包方案 CREDIT_PACKAGE

-- 4-1. 新增：在`COURSE` 新增一門課程，資料需求如下：
    -- 1. 教練設定為用戶`李燕容` 
    -- 2. 在課程專長 `skill_id` 上設定為「 `重訓` 」
    -- 3. 在課程名稱上，設定為「`重訓基礎課`」
    -- 4. 授課開始時間`start_at`設定為2024-11-25 14:00:00
    -- 5. 授課結束時間`end_at`設定為2024-11-25 16:00:00
    -- 6. 最大授課人數`max_participants` 設定為10
    -- 7. 授課連結設定`meeting_url`為 https://test-meeting.test.io


-- ████████  █████   █    █████ 
--   █ █   ██    █  █     █     
--   █ █████ ███ ███      ████  
--   █ █   █    ██  █         █ 
--   █ █   █████ █   █    ████  
-- ===================== ====================

-- 5. 客戶預約與授課 COURSE_BOOKING
-- 5-1. 新增：請在 `COURSE_BOOKING` 新增兩筆資料：
    -- 1. 第一筆：`王小明`預約 `李燕容` 的課程
        -- 1. 預約人設為`王小明`
        -- 2. 預約時間`booking_at` 設為2024-11-24 16:00:00
        -- 3. 狀態`status` 設定為即將授課
    -- 2. 新增： `好野人` 預約 `李燕容` 的課程
        -- 1. 預約人設為 `好野人`
        -- 2. 預約時間`booking_at` 設為2024-11-24 16:00:00
        -- 3. 狀態`status` 設定為即將授課

-- 5-2. 修改：`王小明`取消預約 `李燕容` 的課程，請在`COURSE_BOOKING`更新該筆預約資料：
    -- 1. 取消預約時間`cancelled_at` 設為2024-11-24 17:00:00
    -- 2. 狀態`status` 設定為課程已取消

-- 5-3. 新增：`王小明`再次預約 `李燕容`   的課程，請在`COURSE_BOOKING`新增一筆資料：
    -- 1. 預約人設為`王小明`
    -- 2. 預約時間`booking_at` 設為2024-11-24 17:10:25
    -- 3. 狀態`status` 設定為即將授課

-- 5-4. 查詢：取得王小明所有的預約紀錄，包含取消預約的紀錄

-- 5-5. 修改：`王小明` 現在已經加入直播室了，請在`COURSE_BOOKING`更新該筆預約資料（請注意，不要更新到已經取消的紀錄）：
    -- 1. 請在該筆預約記錄他的加入直播室時間 `join_at` 設為2024-11-25 14:01:59
    -- 2. 狀態`status` 設定為上課中

-- 5-6. 查詢：計算用戶王小明的購買堂數，顯示須包含以下欄位： user_id , total。 (需使用到 SUM 函式與 Group By)

-- 5-7. 查詢：計算用戶王小明的已使用堂數，顯示須包含以下欄位： user_id , total。 (需使用到 Count 函式與 Group By)

-- 5-8. [挑戰題] 查詢：請在一次查詢中，計算用戶王小明的剩餘可用堂數，顯示須包含以下欄位： user_id , remaining_credit
    -- 提示：
    -- SELECT ("CREDIT_PURCHASE".total_credit - "COURSE_BOOKING".used_credit) as remaining_credit, ...
    -- FROM ( 用戶王小明的購買堂數 ) as "CREDIT_PURCHASE"
    -- inner join ( 用戶王小明的已使用堂數) as "COURSE_BOOKING"
    -- on "COURSE_BOOKING".user_id = "CREDIT_PURCHASE".user_id;


-- ████████  █████   █     ███  
--   █ █   ██    █  █     █     
--   █ █████ ███ ███      ████  
--   █ █   █    ██  █     █   █ 
--   █ █   █████ █   █     ███  
-- ===================== ====================
-- 6. 後台報表
-- 6-1 查詢：查詢專長為重訓的教練，並按經驗年數排序，由資深到資淺（需使用 inner join 與 order by 語法)
-- 顯示須包含以下欄位： 教練名稱 , 經驗年數, 專長名稱

-- 6-2 查詢：查詢每種專長的教練數量，並只列出教練數量最多的專長（需使用 group by, inner join 與 order by 與 limit 語法）
-- 顯示須包含以下欄位： 專長名稱, coach_total

-- 6-3. 查詢：計算 11 月份組合包方案的銷售數量
-- 顯示須包含以下欄位： 組合包方案名稱, 銷售數量

-- 6-4. 查詢：計算 11 月份總營收（使用 purchase_at 欄位統計）
-- 顯示須包含以下欄位： 總營收

-- 6-5. 查詢：計算 11 月份有預約課程的會員人數（需使用 Distinct，並用 created_at 和 status 欄位統計）
-- 顯示須包含以下欄位： 預約會員人數
