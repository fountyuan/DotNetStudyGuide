-- =====================================================
-- 1. accounts 表 (账户表)
-- 说明: 存储会计账户信息
-- =====================================================
CREATE TABLE "accounts" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT, -- 账户记录ID
    -- 业务字段
    "name" VARCHAR(64) NOT NULL,                    -- 账户名称
    "type_id" BIGINT UNSIGNED NOT NULL,                -- 账户类型(关联types表)
    "category_id" BIGINT UNSIGNED NOT NULL,            -- 账户类别(关联categories表)
    "comment" VARCHAR(128) NOT NULL,                -- 账户备注
    "balance" DECIMAL(15,6) NOT NULL,               -- 账户余额
    "reconciled" DECIMAL(15,6) NOT NULL,            -- 已对账金额
    "opening" DECIMAL(15,6) NOT NULL,               -- 期初余额
    "closing" DECIMAL(15,6) NOT NULL,               -- 期末余额
    "in_coming" DECIMAL(15,6) NOT NULL,             -- 收入金额
    "out_going" DECIMAL(15,6) NOT NULL,             -- 支出金额
    "enabled" BOOLEAN NOT NULL,                     -- 是否启用
    "closed" BOOLEAN NOT NULL,                      -- 是否已关闭
    "status" TINYINT NOT NULL,                      -- 账户状态(0:正常 1:停用 2:冻结)
    "budget_amount" DECIMAL(15,6) NOT NULL,         -- 预算金额
    "budget_period" TINYINT NOT NULL,               -- 预算周期(0:月 1:季 2:年)
    "limit" DECIMAL(15,6) NOT NULL,                 -- 账户限额
    "min_authorized" DECIMAL(15,6) NOT NULL,        -- 最小授权额度
    "min_expected" DECIMAL(15,6) NOT NULL,          -- 最小期望额度
    "class_id" TINYINT NOT NULL,                       -- 账户类别(0:资产 1:负债 2:权益)
    "identification" TINYINT NOT NULL,              -- 标识类型
    "tax_related" BOOLEAN NOT NULL,                 -- 是否涉及税务
    "tax_key_record" BIGINT UNSIGNED NOT NULL,      -- 税务键值记录
    "tax_type" TINYINT NOT NULL,                    -- 税务类型
    "currency_id" BIGINT UNSIGNED NOT NULL,     -- 币种记录(关联currency表)
    "currency_rate" DECIMAL(15,6) NOT NULL,         -- 币种汇率
    "expanded" BOOLEAN NOT NULL,                    -- 是否展开显示
    "balance_up_to_date" BOOLEAN NOT NULL,          -- 余额是否最新
    "balance_total_all" DECIMAL(15,6) NOT NULL,     -- 总余额(全部)
    "balance_total_rec" DECIMAL(15,6) NOT NULL,     -- 总余额(已对账)
    "balance_transactions" BIGINT UNSIGNED NOT NULL,-- 交易总数
    "limit_warning" BOOLEAN NOT NULL,               -- 是否启用限额警告
    "limit_when_at" TINYINT NOT NULL,               -- 达到限额时触发(0:达到 1:超过)
    "limit_period" TINYINT NOT NULL,                -- 限额周期
    "deductible" BOOLEAN NOT NULL,                  -- 是否可抵扣
    -- 必备字段(软删除+审计)
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,                -- 软删除标记(0:未删除 1:已删除)
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',           -- 创建人
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',           -- 更新人
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 创建时间
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP  -- 更新时间
);

-- 索引
CREATE INDEX "idx_account_name" ON "accounts" ("name");           -- 账户名称索引
CREATE INDEX "idx_account_type_id" ON "accounts" ("type_id");           -- 账户类型索引
CREATE INDEX "idx_account_category_id" ON "accounts" ("category_id");   -- 账户类别索引
CREATE INDEX "idx_account_enabled" ON "accounts" ("enabled");     -- 启用状态索引
CREATE INDEX "idx_account_is_deleted" ON "accounts" ("is_deleted");               -- 软删除索引
CREATE INDEX "idx_account_created_time" ON "accounts" ("created_time");           -- 创建时间索引


-- =====================================================
-- 2. types 表 (类型表)
-- 说明: 定义账户类型分类
-- =====================================================
CREATE TABLE "types" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 类型记录ID
    
    -- 业务字段
    "name" VARCHAR(64) NOT NULL,                       -- 类型名称
    "kind" BIGINT UNSIGNED NOT NULL,                   -- 类型种类
    "accounts_count" BIGINT UNSIGNED NOT NULL,         -- 账户数量
    "categories_count" BIGINT UNSIGNED NOT NULL,       -- 类别数量
    "balance" DECIMAL(15,6) NOT NULL,                  -- 余额
    "reconciled" DECIMAL(15,6) NOT NULL,               -- 已对账金额
    "opening" DECIMAL(15,6) NOT NULL,                  -- 期初余额
    "closing" DECIMAL(15,6) NOT NULL,                  -- 期末余额
    "in_coming" DECIMAL(15,6) NOT NULL,                -- 收入金额
    "out_going" DECIMAL(15,6) NOT NULL,                -- 支出金额
    "enabled" BOOLEAN NOT NULL,                        -- 是否启用
    "status" TINYINT NOT NULL,                         -- 状态
    "budget_amount" DECIMAL(15,6) NOT NULL,            -- 预算金额
    "budget_period" TINYINT NOT NULL,                  -- 预算周期
    "limit" DECIMAL(15,6) NOT NULL,                    -- 限额
    "min_authorized" DECIMAL(15,6) NOT NULL,           -- 最小授权额度
    "min_expected" DECIMAL(15,6) NOT NULL,             -- 最小期望额度
    "expanded" BOOLEAN NOT NULL,                       -- 是否展开
    "balance_up_to_date" BOOLEAN NOT NULL,             -- 余额是否最新
    "balance_total_all" DECIMAL(15,6) NOT NULL,        -- 总余额
    "balance_total_rec" DECIMAL(15,6) NOT NULL,        -- 已对账总余额
    "balance_accounts" BIGINT UNSIGNED NOT NULL,       -- 账户余额数
    "comment" VARCHAR(128) NOT NULL,                   -- 备注
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX "idx_type_name" ON "types" ("name");
CREATE INDEX "idx_type_kind" ON "types" ("kind");
CREATE INDEX "idx_type_enabled" ON "types" ("enabled");
CREATE INDEX "idx_is_deleted" ON "types" ("is_deleted");


-- =====================================================
-- 3. categories 表 (类别表)
-- 说明: 定义收支类别
-- =====================================================
CREATE TABLE "categories" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 类别记录ID
    -- 业务字段
    "name" VARCHAR(64) NOT NULL,                   -- 类别名称
    "type_id" BIGINT UNSIGNED NOT NULL,               -- 类别类型(关联types表)
    "accounts_count" BIGINT UNSIGNED NOT NULL,     -- 账户数量
    "balance" DECIMAL(15,6) NOT NULL,              -- 余额
    "reconciled" DECIMAL(15,6) NOT NULL,           -- 已对账金额
    "opening" DECIMAL(15,6) NOT NULL,              -- 期初余额
    "closing" DECIMAL(15,6) NOT NULL,              -- 期末余额
    "in_coming" DECIMAL(15,6) NOT NULL,            -- 收入金额
    "out_going" DECIMAL(15,6) NOT NULL,            -- 支出金额
    "enabled" BOOLEAN NOT NULL,                    -- 是否启用
    "status" TINYINT NOT NULL,                     -- 状态
    "budget_amount" DECIMAL(15,6) NOT NULL,        -- 预算金额
    "budget_period" TINYINT NOT NULL,              -- 预算周期
    "limit" DECIMAL(15,6) NOT NULL,                -- 限额
    "min_authorized" DECIMAL(15,6) NOT NULL,       -- 最小授权额度
    "min_expected" DECIMAL(15,6) NOT NULL,         -- 最小期望额度
    "creation_date" BIGINT UNSIGNED NOT NULL,      -- 创建日期
    "modification_date" BIGINT UNSIGNED NOT NULL,  -- 修改日期
    "expanded" BOOLEAN NOT NULL,                   -- 是否展开
    "balance_up_to_date" BOOLEAN NOT NULL,         -- 余额是否最新
    "balance_total_all" DECIMAL(15,6) NOT NULL,    -- 总余额
    "balance_total_rec" DECIMAL(15,6) NOT NULL,    -- 已对账总余额
    "balance_accounts" BIGINT UNSIGNED NOT NULL,   -- 账户余额数
    "comment" VARCHAR(128) NOT NULL,               -- 备注
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX "idx_category_name" ON "categories" ("name");
CREATE INDEX "idx_category_type_id" ON "categories" ("type_id");
CREATE INDEX "idx_category_enabled" ON "categories" ("enabled");
CREATE INDEX "idx_is_deleted" ON "categories" ("is_deleted");



-- =====================================================
-- 4. transactions 表 (交易记录表)
-- 说明: 存储所有财务交易明细记录
-- =====================================================
CREATE TABLE "transactions" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 交易记录ID
    -- 业务字段
    "reference_no" BIGINT UNSIGNED NOT NULL,              -- 交易参考号
    "trans_day" BIGINT UNSIGNED NOT NULL,                    -- 交易日期(日)
    "trans_month" BIGINT UNSIGNED NOT NULL,                  -- 交易日期(月)
    "trans_year" BIGINT UNSIGNED NOT NULL,                   -- 交易日期(年)
    "trans_date" DATE NOT NULL,                              -- 交易日期
    "trans_type" BIGINT UNSIGNED NOT NULL,                   -- 交易类型
    "account_debited" BIGINT UNSIGNED NOT NULL,        -- 借方账户
    "account_credited" BIGINT UNSIGNED NOT NULL,       -- 贷方账户
    "account_debited_type" BIGINT UNSIGNED NOT NULL,   -- 借方账户类型
    "account_credited_type" BIGINT UNSIGNED NOT NULL,  -- 贷方账户类型
    "account_debited_cate" BIGINT UNSIGNED NOT NULL,   -- 借方账户类别
    "account_credited_cate" BIGINT UNSIGNED NOT NULL,  -- 贷方账户类别
    "amount" DECIMAL(15,6) NOT NULL,                   -- 交易金额
    "comment" VARCHAR(128) NOT NULL,                   -- 交易备注
    "invoice_num" VARCHAR(32) NOT NULL,                -- 发票号码
    "issuing" BIGINT UNSIGNED NOT NULL,                -- 发行方
    "enabled" BOOLEAN NOT NULL,                        -- 是否启用
    "checked" BOOLEAN NOT NULL,                        -- 是否已核对
    "status" TINYINT NOT NULL,                         -- 交易状态
    "expanded" BOOLEAN NOT NULL,                       -- 是否展开
    "detailed" BOOLEAN NOT NULL,                       -- 是否详细
    "tax_type" TINYINT NOT NULL,                       -- 税务类型
    "tax_amount" DECIMAL(15,6) NOT NULL,               -- 税额
    "tax_rate" DECIMAL(15,6) NOT NULL,                 -- 税率
    "link_to_transaction" BIGINT UNSIGNED NOT NULL,    -- 关联交易ID
    "currency_id" BIGINT UNSIGNED NOT NULL,        -- 币种记录
    "currency_rate" DECIMAL(15,6) NOT NULL,            -- 汇率
    "is_hold" BOOLEAN NOT NULL,                           -- 是否挂起
    "term_date" DATE NOT NULL,                         -- 到期日期
    "type_ref" VARCHAR(32) NOT NULL,                   -- 类型参考
    "group_id" BIGINT UNSIGNED NOT NULL,               -- 分组ID
    "project" VARCHAR(64) NOT NULL,                    -- 项目名称
    "currency_to_def_rate" DECIMAL(15,6) NOT NULL,     -- 转默认币种汇率
    "currency_direction1" TINYINT NOT NULL,            -- 币种方向1
    "currency_direction2" TINYINT NOT NULL,            -- 币种方向2
    "transaction_id" VARCHAR(64) NOT NULL,                         -- 交易唯一标识
    "attachment" BLOB,                                 -- 附件二进制数据
    "attachment_name" VARCHAR(128) NOT NULL,           -- 附件名称
    "attachment_type" VARCHAR(32) NOT NULL,            -- 附件类型
    "attachment_mac_info" VARCHAR(10) NOT NULL,        -- 附件Mac信息
    "is_flagged" BOOLEAN NOT NULL,                        -- 是否标记
    "is_deductible" BOOLEAN NOT NULL,                     -- 是否可抵扣
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 索引
CREATE INDEX "idx_trans_date" ON "transactions" ("trans_date");               -- 交易日期索引
CREATE INDEX "idx_comment" ON "transactions" ("transaction_comment");         -- 备注索引
CREATE INDEX "idx_trans_type" ON "transactions" ("trans_type");               -- 交易类型索引
CREATE INDEX "idx_account_debited" ON "transactions" ("account_debited"); -- 借方账户索引
CREATE INDEX "idx_account_credited" ON "transactions" ("account_credited"); -- 贷方账户索引
CREATE INDEX "idx_enabled" ON "transactions" ("enabled");         -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "transactions" ("is_deleted");                           -- 软删除索引


