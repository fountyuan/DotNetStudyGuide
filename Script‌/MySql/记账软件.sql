-- =====================================================
-- 1. accounts 表 (账户表)
-- 说明: 存储会计账户信息
-- =====================================================
CREATE TABLE "accounts" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT, -- 账户记录ID
    
    -- 业务字段
    "account_name" VARCHAR(64) NOT NULL,                    -- 账户名称
    --"account_record" BIGINT UNSIGNED NOT NULL,              -- 账户记录ID
    "account_type" BIGINT UNSIGNED NOT NULL,                -- 账户类型(关联types表)
    "account_category" BIGINT UNSIGNED NOT NULL,            -- 账户类别(关联categories表)
    "account_comment" VARCHAR(128) NOT NULL,                -- 账户备注
    "account_balance" DECIMAL(15,6) NOT NULL,               -- 账户余额
    "account_reconciled" DECIMAL(15,6) NOT NULL,            -- 已对账金额
    "account_opening" DECIMAL(15,6) NOT NULL,               -- 期初余额
    "account_closing" DECIMAL(15,6) NOT NULL,               -- 期末余额
    "account_in_coming" DECIMAL(15,6) NOT NULL,             -- 收入金额
    "account_out_going" DECIMAL(15,6) NOT NULL,             -- 支出金额
    "account_enabled" BOOLEAN NOT NULL,                     -- 是否启用
    "account_closed" BOOLEAN NOT NULL,                      -- 是否已关闭
    "account_status" TINYINT NOT NULL,                      -- 账户状态(0:正常 1:停用 2:冻结)
    "account_budget_amount" DECIMAL(15,6) NOT NULL,         -- 预算金额
    "account_budget_period" TINYINT NOT NULL,               -- 预算周期(0:月 1:季 2:年)
    "account_limit" DECIMAL(15,6) NOT NULL,                 -- 账户限额
    "account_min_authorized" DECIMAL(15,6) NOT NULL,        -- 最小授权额度
    "account_min_expected" DECIMAL(15,6) NOT NULL,          -- 最小期望额度
    "account_class" TINYINT NOT NULL,                       -- 账户类别(0:资产 1:负债 2:权益)
    "account_identification" TINYINT NOT NULL,              -- 标识类型
    "account_tax_related" BOOLEAN NOT NULL,                 -- 是否涉及税务
    "account_tax_key_record" BIGINT UNSIGNED NOT NULL,      -- 税务键值记录
    "account_tax_type" TINYINT NOT NULL,                    -- 税务类型
    "account_currency_record" BIGINT UNSIGNED NOT NULL,     -- 币种记录(关联currency表)
    "account_currency_rate" DECIMAL(15,6) NOT NULL,         -- 币种汇率
    "account_expanded" BOOLEAN NOT NULL,                    -- 是否展开显示
    "account_balance_up_to_date" BOOLEAN NOT NULL,          -- 余额是否最新
    "account_balance_total_all" DECIMAL(15,6) NOT NULL,     -- 总余额(全部)
    "account_balance_total_rec" DECIMAL(15,6) NOT NULL,     -- 总余额(已对账)
    "account_balance_transactions" BIGINT UNSIGNED NOT NULL,-- 交易总数
    "account_limit_warning" BOOLEAN NOT NULL,               -- 是否启用限额警告
    "account_limit_when_at" TINYINT NOT NULL,               -- 达到限额时触发(0:达到 1:超过)
    "account_limit_period" TINYINT NOT NULL,                -- 限额周期
    "account_deductible" BOOLEAN NOT NULL,                  -- 是否可抵扣
    
    -- 必备字段(软删除+审计)
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,                -- 软删除标记(0:未删除 1:已删除)
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',           -- 创建人
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',           -- 更新人
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 创建时间
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP  -- 更新时间
);

-- 索引
CREATE INDEX "idx_account_name" ON "accounts" ("account_name");           -- 账户名称索引
CREATE INDEX "idx_account_type" ON "accounts" ("account_type");           -- 账户类型索引
CREATE INDEX "idx_account_category" ON "accounts" ("account_category");   -- 账户类别索引
CREATE INDEX "idx_account_enabled" ON "accounts" ("account_enabled");     -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "accounts" ("is_deleted");               -- 软删除索引
CREATE INDEX "idx_created_time" ON "accounts" ("created_time");           -- 创建时间索引


-- =====================================================
-- 2. types 表 (类型表)
-- 说明: 定义账户类型分类
-- =====================================================
CREATE TABLE "types" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 类型记录ID
    
    -- 业务字段
    "type_name" VARCHAR(64) NOT NULL,                       -- 类型名称
    --"type_record" BIGINT UNSIGNED NOT NULL,                 -- 类型记录ID
    "type_kind" BIGINT UNSIGNED NOT NULL,                   -- 类型种类
    "type_accounts_count" BIGINT UNSIGNED NOT NULL,         -- 账户数量
    "type_categories_count" BIGINT UNSIGNED NOT NULL,       -- 类别数量
    "type_balance" DECIMAL(15,6) NOT NULL,                  -- 余额
    "type_reconciled" DECIMAL(15,6) NOT NULL,               -- 已对账金额
    "type_opening" DECIMAL(15,6) NOT NULL,                  -- 期初余额
    "type_closing" DECIMAL(15,6) NOT NULL,                  -- 期末余额
    "type_in_coming" DECIMAL(15,6) NOT NULL,                -- 收入金额
    "type_out_going" DECIMAL(15,6) NOT NULL,                -- 支出金额
    "type_enabled" BOOLEAN NOT NULL,                        -- 是否启用
    "type_status" TINYINT NOT NULL,                         -- 状态
    "type_budget_amount" DECIMAL(15,6) NOT NULL,            -- 预算金额
    "type_budget_period" TINYINT NOT NULL,                  -- 预算周期
    "type_limit" DECIMAL(15,6) NOT NULL,                    -- 限额
    "type_min_authorized" DECIMAL(15,6) NOT NULL,           -- 最小授权额度
    "type_min_expected" DECIMAL(15,6) NOT NULL,             -- 最小期望额度
    "type_creation_date" BIGINT UNSIGNED NOT NULL,          -- 创建日期(时间戳)
    "type_modification_date" BIGINT UNSIGNED NOT NULL,      -- 修改日期(时间戳)
    "type_expanded" BOOLEAN NOT NULL,                       -- 是否展开
    "type_balance_up_to_date" BOOLEAN NOT NULL,             -- 余额是否最新
    "type_balance_total_all" DECIMAL(15,6) NOT NULL,        -- 总余额
    "type_balance_total_rec" DECIMAL(15,6) NOT NULL,        -- 已对账总余额
    "type_balance_accounts" BIGINT UNSIGNED NOT NULL,       -- 账户余额数
    "type_comment" VARCHAR(128) NOT NULL,                   -- 备注
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX "idx_type_name" ON "types" ("type_name");
CREATE INDEX "idx_type_kind" ON "types" ("type_kind");
CREATE INDEX "idx_type_enabled" ON "types" ("type_enabled");
CREATE INDEX "idx_is_deleted" ON "types" ("is_deleted");


-- =====================================================
-- 3. categories 表 (类别表)
-- 说明: 定义收支类别
-- =====================================================
CREATE TABLE "categories" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 类别记录ID
    
    -- 业务字段
    "category_name" VARCHAR(64) NOT NULL,                   -- 类别名称
    --"category_record" BIGINT UNSIGNED NOT NULL,             -- 类别记录ID
    "category_type" BIGINT UNSIGNED NOT NULL,               -- 类别类型(关联types表)
    "category_accounts_count" BIGINT UNSIGNED NOT NULL,     -- 账户数量
    "category_balance" DECIMAL(15,6) NOT NULL,              -- 余额
    "category_reconciled" DECIMAL(15,6) NOT NULL,           -- 已对账金额
    "category_opening" DECIMAL(15,6) NOT NULL,              -- 期初余额
    "category_closing" DECIMAL(15,6) NOT NULL,              -- 期末余额
    "category_in_coming" DECIMAL(15,6) NOT NULL,            -- 收入金额
    "category_out_going" DECIMAL(15,6) NOT NULL,            -- 支出金额
    "category_enabled" BOOLEAN NOT NULL,                    -- 是否启用
    "category_status" TINYINT NOT NULL,                     -- 状态
    "category_budget_amount" DECIMAL(15,6) NOT NULL,        -- 预算金额
    "category_budget_period" TINYINT NOT NULL,              -- 预算周期
    "category_limit" DECIMAL(15,6) NOT NULL,                -- 限额
    "category_min_authorized" DECIMAL(15,6) NOT NULL,       -- 最小授权额度
    "category_min_expected" DECIMAL(15,6) NOT NULL,         -- 最小期望额度
    "category_creation_date" BIGINT UNSIGNED NOT NULL,      -- 创建日期
    "category_modification_date" BIGINT UNSIGNED NOT NULL,  -- 修改日期
    "category_expanded" BOOLEAN NOT NULL,                   -- 是否展开
    "category_balance_up_to_date" BOOLEAN NOT NULL,         -- 余额是否最新
    "category_balance_total_all" DECIMAL(15,6) NOT NULL,    -- 总余额
    "category_balance_total_rec" DECIMAL(15,6) NOT NULL,    -- 已对账总余额
    "category_balance_accounts" BIGINT UNSIGNED NOT NULL,   -- 账户余额数
    "category_comment" VARCHAR(128) NOT NULL,               -- 备注
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX "idx_category_name" ON "categories" ("category_name");
CREATE INDEX "idx_category_type" ON "categories" ("category_type");
CREATE INDEX "idx_category_enabled" ON "categories" ("category_enabled");
CREATE INDEX "idx_is_deleted" ON "categories" ("is_deleted");


-- =====================================================
-- 4. transactions 表 (交易记录表)
-- 说明: 存储所有财务交易明细记录
-- =====================================================
CREATE TABLE "transactions" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 交易记录ID
    
    -- 业务字段
    --"transaction_record" BIGINT UNSIGNED NOT NULL,                 -- 交易记录ID
    "transaction_reference" BIGINT UNSIGNED NOT NULL,              -- 交易参考号
    "transaction_day" BIGINT UNSIGNED NOT NULL,                    -- 交易日期(日)
    "transaction_month" BIGINT UNSIGNED NOT NULL,                  -- 交易日期(月)
    "transaction_year" BIGINT UNSIGNED NOT NULL,                   -- 交易日期(年)
    "transaction_date" DATE NOT NULL,                              -- 交易日期
    "transaction_creation_date" BIGINT UNSIGNED NOT NULL,          -- 创建日期(时间戳)
    "transaction_modification_date" BIGINT UNSIGNED NOT NULL,      -- 修改日期(时间戳)
    "transaction_type" BIGINT UNSIGNED NOT NULL,                   -- 交易类型
    "transaction_account_debited" BIGINT UNSIGNED NOT NULL,        -- 借方账户
    "transaction_account_credited" BIGINT UNSIGNED NOT NULL,       -- 贷方账户
    "transaction_account_debited_type" BIGINT UNSIGNED NOT NULL,   -- 借方账户类型
    "transaction_account_credited_type" BIGINT UNSIGNED NOT NULL,  -- 贷方账户类型
    "transaction_account_debited_cate" BIGINT UNSIGNED NOT NULL,   -- 借方账户类别
    "transaction_account_credited_cate" BIGINT UNSIGNED NOT NULL,  -- 贷方账户类别
    "transaction_amount" DECIMAL(15,6) NOT NULL,                   -- 交易金额
    "transaction_comment" VARCHAR(128) NOT NULL,                   -- 交易备注
    "transaction_invoice_num" VARCHAR(32) NOT NULL,                -- 发票号码
    "transaction_issuing" BIGINT UNSIGNED NOT NULL,                -- 发行方
    "transaction_enabled" BOOLEAN NOT NULL,                        -- 是否启用
    "transaction_checked" BOOLEAN NOT NULL,                        -- 是否已核对
    "transaction_status" TINYINT NOT NULL,                         -- 交易状态
    "transaction_expanded" BOOLEAN NOT NULL,                       -- 是否展开
    "transaction_detailed" BOOLEAN NOT NULL,                       -- 是否详细
    "transaction_tax_type" TINYINT NOT NULL,                       -- 税务类型
    "transaction_tax_amount" DECIMAL(15,6) NOT NULL,               -- 税额
    "transaction_tax_rate" DECIMAL(15,6) NOT NULL,                 -- 税率
    "transaction_link_to_transaction" BIGINT UNSIGNED NOT NULL,    -- 关联交易ID
    "transaction_currency_record" BIGINT UNSIGNED NOT NULL,        -- 币种记录
    "transaction_currency_rate" DECIMAL(15,6) NOT NULL,            -- 汇率
    "transaction_hold" BOOLEAN NOT NULL,                           -- 是否挂起
    "transaction_term_date" DATE NOT NULL,                         -- 到期日期
    "transaction_type_ref" VARCHAR(32) NOT NULL,                   -- 类型参考
    "transaction_group_id" BIGINT UNSIGNED NOT NULL,               -- 分组ID
    "transaction_project" VARCHAR(64) NOT NULL,                    -- 项目名称
    "transaction_currency_to_def_rate" DECIMAL(15,6) NOT NULL,     -- 转默认币种汇率
    "transaction_currency_direction1" TINYINT NOT NULL,            -- 币种方向1
    "transaction_currency_direction2" TINYINT NOT NULL,            -- 币种方向2
    "transaction_id" VARCHAR(64) NOT NULL,                         -- 交易唯一标识
    "transaction_attachment" BLOB,                                 -- 附件二进制数据
    "transaction_attachment_name" VARCHAR(128) NOT NULL,           -- 附件名称
    "transaction_attachment_type" VARCHAR(32) NOT NULL,            -- 附件类型
    "transaction_attachment_mac_info" VARCHAR(10) NOT NULL,        -- 附件Mac信息
    "transaction_flagged" BOOLEAN NOT NULL,                        -- 是否标记
    "transaction_deductible" BOOLEAN NOT NULL,                     -- 是否可抵扣
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 索引
CREATE INDEX "idx_transaction_date" ON "transactions" ("transaction_date");               -- 交易日期索引
CREATE INDEX "idx_transaction_comment" ON "transactions" ("transaction_comment");         -- 备注索引
CREATE INDEX "idx_transaction_type" ON "transactions" ("transaction_type");               -- 交易类型索引
CREATE INDEX "idx_transaction_account_debited" ON "transactions" ("transaction_account_debited"); -- 借方账户索引
CREATE INDEX "idx_transaction_account_credited" ON "transactions" ("transaction_account_credited"); -- 贷方账户索引
CREATE INDEX "idx_transaction_enabled" ON "transactions" ("transaction_enabled");         -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "transactions" ("is_deleted");                           -- 软删除索引


-- =====================================================
-- 5. transaction_types 表 (交易类型表)
-- 说明: 定义交易的类型分类
-- =====================================================
CREATE TABLE "transaction_types" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 交易类型记录ID
    
    -- 业务字段
    "transaction_type_name" VARCHAR(64) NOT NULL,              -- 交易类型名称
    --"transaction_type_record" BIGINT UNSIGNED NOT NULL,        -- 交易类型记录ID
    "transaction_type_type" BIGINT UNSIGNED NOT NULL,          -- 类型分类
    "transaction_type_balance" DECIMAL(15,6) NOT NULL,         -- 余额
    "transaction_type_internal" DECIMAL(15,6) NOT NULL,        -- 内部金额
    "transaction_type_enabled" BOOLEAN NOT NULL,               -- 是否启用
    "transaction_type_status" TINYINT NOT NULL,                -- 状态
    "transaction_type_creation_date" BIGINT UNSIGNED NOT NULL, -- 创建日期
    "transaction_type_modification_date" BIGINT UNSIGNED NOT NULL, -- 修改日期
    "transaction_type_expanded" BOOLEAN NOT NULL,              -- 是否展开
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX "idx_transaction_type_name" ON "transaction_types" ("transaction_type_name"); -- 类型名称索引
CREATE INDEX "idx_transaction_type_enabled" ON "transaction_types" ("transaction_type_enabled"); -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "transaction_types" ("is_deleted");


-- =====================================================
-- 6. details 表 (明细表)
-- 说明: 存储交易的详细行项信息
-- =====================================================
CREATE TABLE "details" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 明细记录ID
    
    -- 业务字段
    --"details_record" BIGINT UNSIGNED NOT NULL,                 -- 明细记录ID
    "details_linked_to_table" VARCHAR(32) NOT NULL,            -- 关联表名
    "details_linked_to_record" BIGINT UNSIGNED NOT NULL,       -- 关联记录ID
    "details_quantity" BIGINT UNSIGNED NOT NULL,               -- 数量
    "details_reference" VARCHAR(32) NOT NULL,                  -- 参考号
    "details_description" VARCHAR(128) NOT NULL,               -- 描述
    "details_amount" DECIMAL(15,6) NOT NULL,                   -- 金额
    "details_discount" DECIMAL(15,6) NOT NULL,                 -- 折扣
    "details_currency_record" BIGINT UNSIGNED NOT NULL,        -- 币种记录
    "details_currency_rate" DECIMAL(15,6) NOT NULL,            -- 汇率
    "details_enabled" BOOLEAN NOT NULL,                        -- 是否启用
    "details_status" TINYINT NOT NULL,                         -- 状态
    "details_expanded" BOOLEAN NOT NULL,                       -- 是否展开
    "details_creation_date" DECIMAL(15,6) NOT NULL,            -- 创建日期
    "details_modification_date" DECIMAL(15,6) NOT NULL,        -- 修改日期
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX "idx_details_linked_to_table" ON "details" ("details_linked_to_table");   -- 关联表名索引
CREATE INDEX "idx_details_linked_to_record" ON "details" ("details_linked_to_record"); -- 关联记录ID索引
CREATE INDEX "idx_details_enabled" ON "details" ("details_enabled");                   -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "details" ("is_deleted");


-- =====================================================
-- 7. taxes 表 (税务表)
-- 说明: 存储税务相关配置和信息
-- =====================================================
CREATE TABLE "taxes" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 税务记录ID
    
    -- 业务字段
    "tax_key" VARCHAR(64) NOT NULL,                         -- 税务键值/编码
    --"tax_record" BIGINT UNSIGNED NOT NULL,                  -- 税务记录ID
    "tax_linked_to_table" VARCHAR(32) NOT NULL,             -- 关联表名
    "tax_linked_to_record" BIGINT UNSIGNED NOT NULL,        -- 关联记录ID
    "tax_type" TINYINT NOT NULL,                            -- 税务类型(0:增值税 1:所得税 2:消费税等)
    "tax_value" DECIMAL(15,6) NOT NULL,                     -- 税额值
    "tax_percentage" DECIMAL(15,6) NOT NULL,                -- 税率百分比
    "tax_tax_type" TINYINT NOT NULL,                        -- 税务子类型
    "tax_account" BIGINT UNSIGNED NOT NULL,                 -- 关联账户ID
    "tax_comment" VARCHAR(128) NOT NULL,                    -- 税务备注
    "tax_enabled" BOOLEAN NOT NULL,                         -- 是否启用
    "tax_status" TINYINT NOT NULL,                          -- 状态(0:正常 1:停用)
    "tax_creation_date" BIGINT UNSIGNED NOT NULL,           -- 创建日期(时间戳)
    "tax_modification_date" BIGINT UNSIGNED NOT NULL,       -- 修改日期(时间戳)
    "tax_expanded" BOOLEAN NOT NULL,                        -- 是否展开显示
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 索引
CREATE INDEX "idx_tax_key" ON "taxes" ("tax_key");                         -- 税务键值索引
CREATE INDEX "idx_tax_linked_to_table" ON "taxes" ("tax_linked_to_table"); -- 关联表名索引
CREATE INDEX "idx_tax_linked_to_record" ON "taxes" ("tax_linked_to_record"); -- 关联记录ID索引
CREATE INDEX "idx_tax_enabled" ON "taxes" ("tax_enabled");                 -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "taxes" ("is_deleted");


-- =====================================================
-- 8. preferences 表 (偏好设置表)
-- 说明: 存储应用程序的用户偏好配置
-- =====================================================
CREATE TABLE "preferences" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 配置记录ID
    
    -- 业务字段
    "pref_entry_name" VARCHAR(64) NOT NULL,                 -- 配置项名称
    "pref_entry_value" VARCHAR(1024) NOT NULL,              -- 配置项值
    --"pref_entry_record" BIGINT UNSIGNED NOT NULL,           -- 配置记录ID
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX "idx_pref_entry_name" ON "preferences" ("pref_entry_name"); -- 配置项名称索引
CREATE INDEX "idx_is_deleted" ON "preferences" ("is_deleted");


-- =====================================================
-- 9. preset 表 (预设表)
-- 说明: 存储系统预设值和模板
-- =====================================================
CREATE TABLE "preset" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 预设记录ID
    
    -- 业务字段
    "preset_name" VARCHAR(64) NOT NULL,                     -- 预设名称
    "preset_type" VARCHAR(64) NOT NULL,                     -- 预设类型
    "preset_value" VARCHAR(256) NOT NULL,                   -- 预设值
    --"preset_record" BIGINT UNSIGNED NOT NULL,               -- 预设记录ID
    "preset_enabled" BOOLEAN NOT NULL,                      -- 是否启用
    "preset_status" TINYINT NOT NULL,                       -- 状态
    "preset_expanded" BOOLEAN NOT NULL,                     -- 是否展开
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX "idx_preset_name" ON "preset" ("preset_name");     -- 预设名称索引
CREATE INDEX "idx_preset_type" ON "preset" ("preset_type");     -- 预设类型索引
CREATE INDEX "idx_preset_enabled" ON "preset" ("preset_enabled"); -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "preset" ("is_deleted");


-- =====================================================
-- 10. contact 表 (联系人表)
-- 说明: 存储客户、供应商等联系人信息
-- =====================================================
CREATE TABLE "contact" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 联系人记录ID
    
    -- 业务字段
    "contact_name" VARCHAR(128) NOT NULL,                       -- 联系人姓名/名称
    "contact_id" VARCHAR(64) NOT NULL,                          -- 联系人编号/身份证号
    --"contact_record" BIGINT UNSIGNED NOT NULL,                  -- 联系人记录ID
    "contact_linked_to_table" VARCHAR(32) NOT NULL,             -- 关联表名
    "contact_linked_to_record" BIGINT UNSIGNED NOT NULL,        -- 关联记录ID
    "contact_type" TINYINT NOT NULL,                            -- 联系人类型(0:客户 1:供应商 2:员工等)
    "contact_tax_id" VARCHAR(64) NOT NULL,                      -- 税号/纳税人识别号
    "contact_street" VARCHAR(256) NOT NULL,                     -- 街道地址
    "contact_suburb" VARCHAR(128) NOT NULL,                     -- 郊区/区域
    "contact_city" VARCHAR(128) NOT NULL,                       -- 城市
    "contact_state" VARCHAR(128) NOT NULL,                      -- 州/省
    "contact_zip" VARCHAR(32) NOT NULL,                         -- 邮政编码
    "contact_country" VARCHAR(128) NOT NULL,                    -- 国家
    "contact_phone" VARCHAR(64) NOT NULL,                       -- 电话号码
    "contact_mobile" VARCHAR(64) NOT NULL,                      -- 手机号码
    "contact_fax" VARCHAR(64) NOT NULL,                         -- 传真号码
    "contact_email" VARCHAR(128) NOT NULL,                      -- 电子邮箱
    "contact_web" VARCHAR(128) NOT NULL,                        -- 网址
    "contact_comment" VARCHAR(256) NOT NULL,                    -- 备注
    "contact_enabled" BOOLEAN NOT NULL,                         -- 是否启用
    "contact_status" TINYINT NOT NULL,                          -- 状态
    "contact_class" TINYINT NOT NULL,                           -- 分类
    "contact_identification" TINYINT NOT NULL,                  -- 标识类型
    "contact_tax_key_record" BIGINT UNSIGNED NOT NULL,          -- 税务键值记录
    "contact_creation_date" DECIMAL(15,6) NOT NULL,             -- 创建日期
    "contact_modification_date" DECIMAL(15,6) NOT NULL,         -- 修改日期
    "contact_expanded" BOOLEAN NOT NULL,                        -- 是否展开
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 索引
CREATE INDEX "idx_contact_name" ON "contact" ("contact_name");                     -- 联系人名称索引
CREATE INDEX "idx_contact_id" ON "contact" ("contact_id");                         -- 联系人编号索引
CREATE INDEX "idx_contact_linked_to_table" ON "contact" ("contact_linked_to_table"); -- 关联表名索引
CREATE INDEX "idx_contact_linked_to_record" ON "contact" ("contact_linked_to_record"); -- 关联记录ID索引
CREATE INDEX "idx_contact_enabled" ON "contact" ("contact_enabled");               -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "contact" ("is_deleted");


-- =====================================================
-- 11. memo 表 (备忘录表)
-- 说明: 存储与各记录关联的备注和说明文本
-- =====================================================
CREATE TABLE "memo" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 备忘录记录ID
    
    -- 业务字段
    "memo_key_name" VARCHAR(64) NOT NULL,                       -- 备忘录键名
    --"memo_record" BIGINT UNSIGNED NOT NULL,                     -- 备忘录记录ID
    "memo_type" TINYINT NOT NULL,                               -- 备忘录类型
    "memo_linked_to_table" VARCHAR(32) NOT NULL,                -- 关联表名
    "memo_linked_to_record" BIGINT UNSIGNED NOT NULL,           -- 关联记录ID
    "memo_str_value" TEXT,                                      -- 备忘录文本内容
    "memo_enabled" BOOLEAN NOT NULL,                            -- 是否启用
    "memo_status" TINYINT NOT NULL,                             -- 状态
    "memo_creation_date" DECIMAL(15,6) NOT NULL,                -- 创建日期
    "memo_modification_date" DECIMAL(15,6) NOT NULL,            -- 修改日期
    "memo_expanded" BOOLEAN NOT NULL,                           -- 是否展开
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX "idx_memo_key_name" ON "memo" ("memo_key_name");                 -- 键名索引
CREATE INDEX "idx_memo_linked_to_table" ON "memo" ("memo_linked_to_table");   -- 关联表名索引
CREATE INDEX "idx_memo_linked_to_record" ON "memo" ("memo_linked_to_record"); -- 关联记录ID索引
CREATE INDEX "idx_memo_enabled" ON "memo" ("memo_enabled");                   -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "memo" ("is_deleted");


-- =====================================================
-- 12. favorite 表 (收藏夹表)
-- 说明: 存储用户常用的交易模板和收藏项
-- =====================================================
CREATE TABLE "favorite" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 收藏记录ID
    
    -- 业务字段
    "favorite_name" VARCHAR(64) NOT NULL,                       -- 收藏项名称
    --"favorite_record" BIGINT UNSIGNED NOT NULL,                 -- 收藏记录ID
    "favorite_type" BIGINT UNSIGNED NOT NULL,                   -- 收藏类型
    "favorite_account_debited" BIGINT UNSIGNED NOT NULL,        -- 借方账户(预设)
    "favorite_account_credited" BIGINT UNSIGNED NOT NULL,       -- 贷方账户(预设)
    "favorite_amount" DECIMAL(15,6) NOT NULL,                   -- 预设金额
    "favorite_comment" VARCHAR(128) NOT NULL,                   -- 预设备注
    "favorite_auto_reconcile" BOOLEAN NOT NULL,                 -- 是否自动对账
    "favorite_currency_record" BIGINT UNSIGNED NOT NULL,        -- 币种记录
    "favorite_currency_rate" DECIMAL(15,6) NOT NULL,            -- 汇率
    "favorite_enabled" BOOLEAN NOT NULL,                        -- 是否启用
    "favorite_checked" BOOLEAN NOT NULL,                        -- 是否已核对
    "favorite_status" TINYINT NOT NULL,                         -- 状态
    "favorite_expanded" BOOLEAN NOT NULL,                       -- 是否展开
    "favorite_type_ref" VARCHAR(32) NOT NULL,                   -- 类型参考
    "favorite_group_id" BIGINT UNSIGNED NOT NULL,               -- 分组ID
    "favorite_issuing" BIGINT UNSIGNED NOT NULL,                -- 发行方
    "favorite_project" VARCHAR(64) NOT NULL,                    -- 项目名称
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX "idx_favorite_name" ON "favorite" ("favorite_name");                 -- 收藏项名称索引
CREATE INDEX "idx_favorite_type" ON "favorite" ("favorite_type");                 -- 类型索引
CREATE INDEX "idx_favorite_account_debited" ON "favorite" ("favorite_account_debited"); -- 借方账户索引
CREATE INDEX "idx_favorite_account_credited" ON "favorite" ("favorite_account_credited"); -- 贷方账户索引
CREATE INDEX "idx_favorite_enabled" ON "favorite" ("favorite_enabled");           -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "favorite" ("is_deleted");


-- =====================================================
-- 13. scheduling 表 (计划任务表)
-- 说明: 存储定期交易计划，如每月自动扣款、定期转账等
-- =====================================================
CREATE TABLE "scheduling" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 计划记录ID
    
    -- 业务字段
    --"scheduling_record" BIGINT UNSIGNED NOT NULL,                      -- 计划记录ID
    "scheduling_type" BIGINT UNSIGNED NOT NULL,                        -- 计划类型
    "scheduling_account_debited" BIGINT UNSIGNED NOT NULL,             -- 借方账户
    "scheduling_account_credited" BIGINT UNSIGNED NOT NULL,            -- 贷方账户
    "scheduling_amount" DECIMAL(15,6) NOT NULL,                        -- 计划金额
    "scheduling_comment" VARCHAR(128) NOT NULL,                        -- 计划备注
    "scheduling_issuing" BIGINT UNSIGNED NOT NULL,                     -- 发行方
    "scheduling_auto_reconcile" BOOLEAN NOT NULL,                      -- 是否自动对账
    "scheduling_currency_record" BIGINT UNSIGNED NOT NULL,             -- 币种记录
    "scheduling_currency_rate" DECIMAL(15,6) NOT NULL,                 -- 汇率
    "scheduling_start_date" DATE NOT NULL,                             -- 开始日期
    "scheduling_end_date" DATE NOT NULL,                               -- 结束日期
    "scheduling_period" TINYINT NOT NULL,                              -- 执行周期(0:日 1:周 2:月 3:季 4:年)
    "scheduling_count" BIGINT UNSIGNED NOT NULL,                       -- 已执行次数
    "scheduling_ending" TINYINT NOT NULL,                              -- 结束条件(0:无结束 1:按次数 2:按日期)
    "scheduling_next_date" DATE NOT NULL,                              -- 下次执行日期
    "scheduling_last_date" DATE NOT NULL,                              -- 上次执行日期
    "scheduling_day" BIGINT UNSIGNED NOT NULL,                         -- 计划日
    "scheduling_month" BIGINT UNSIGNED NOT NULL,                       -- 计划月
    "scheduling_year" BIGINT UNSIGNED NOT NULL,                        -- 计划年
    "scheduling_enabled" BOOLEAN NOT NULL,                             -- 是否启用
    "scheduling_checked" BOOLEAN NOT NULL,                             -- 是否已核对
    "scheduling_status" TINYINT NOT NULL,                              -- 状态
    "scheduling_expanded" BOOLEAN NOT NULL,                            -- 是否展开
    "scheduling_budget" BOOLEAN NOT NULL,                              -- 是否纳入预算
    "scheduling_project" VARCHAR(64) NOT NULL,                         -- 项目名称
    "scheduling_delete_when_done" BOOLEAN NOT NULL,                    -- 完成后是否删除
    "scheduling_tax_type" TINYINT NOT NULL,                            -- 税务类型
    "scheduling_tax_amount" DECIMAL(15,6) NOT NULL,                    -- 税额
    "scheduling_tax_rate" DECIMAL(15,6) NOT NULL,                      -- 税率
    "scheduling_amount_variation" DECIMAL(15,6) NOT NULL,              -- 金额变动值
    "scheduling_amount_variation_percentage" BOOLEAN NOT NULL,         -- 变动是否为百分比
    "scheduling_amount_variation_direction" BOOLEAN NOT NULL,          -- 变动方向(0:增加 1:减少)
    "scheduling_amount_last" DECIMAL(15,6) NOT NULL,                   -- 上次执行金额
    "scheduling_amount_list" TEXT,                                     -- 金额列表(JSON格式)
    "scheduling_amount_list_pointer" BIGINT UNSIGNED NOT NULL,         -- 金额列表指针
    "scheduling_end_of_month" BOOLEAN NOT NULL,                        -- 是否在月末执行
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 索引
CREATE INDEX "idx_scheduling_type" ON "scheduling" ("scheduling_type");                     -- 计划类型索引
CREATE INDEX "idx_scheduling_account_debited" ON "scheduling" ("scheduling_account_debited"); -- 借方账户索引
CREATE INDEX "idx_scheduling_account_credited" ON "scheduling" ("scheduling_account_credited"); -- 贷方账户索引
CREATE INDEX "idx_scheduling_start_date" ON "scheduling" ("scheduling_start_date");         -- 开始日期索引
CREATE INDEX "idx_scheduling_end_date" ON "scheduling" ("scheduling_end_date");             -- 结束日期索引
CREATE INDEX "idx_scheduling_next_date" ON "scheduling" ("scheduling_next_date");           -- 下次执行日期索引
CREATE INDEX "idx_scheduling_enabled" ON "scheduling" ("scheduling_enabled");               -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "scheduling" ("is_deleted");


-- =====================================================
-- 14. items 表 (商品/项目表)
-- 说明: 存储商品、服务、库存项目等信息
-- =====================================================
CREATE TABLE "items" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 项目记录ID
    
    -- 业务字段
    --"item_record" BIGINT UNSIGNED NOT NULL,                         -- 项目记录ID
    "item_linked_to_table" VARCHAR(32) NOT NULL,                    -- 关联表名
    "item_linked_to_record" BIGINT UNSIGNED NOT NULL,               -- 关联记录ID
    "item_reference" VARCHAR(32) NOT NULL,                          -- 项目编号/参考号
    "item_description" VARCHAR(128) NOT NULL,                       -- 项目描述
    "item_price" DECIMAL(15,6) NOT NULL,                            -- 单价
    "item_discount" DECIMAL(15,6) NOT NULL,                         -- 折扣
    "item_cost" DECIMAL(15,6) NOT NULL,                             -- 成本
    "item_currency_record" BIGINT UNSIGNED NOT NULL,                -- 币种记录
    "item_currency_rate" DECIMAL(15,6) NOT NULL,                    -- 汇率
    "item_type" BIGINT UNSIGNED NOT NULL,                           -- 项目类型
    "item_category" BIGINT UNSIGNED NOT NULL,                       -- 项目类别
    "item_class" TINYINT NOT NULL,                                  -- 分类
    "item_identification" TINYINT NOT NULL,                         -- 标识类型
    "item_tax_key_record" BIGINT UNSIGNED NOT NULL,                 -- 税务键值记录
    "item_enabled" BOOLEAN NOT NULL,                                -- 是否启用
    "item_status" TINYINT NOT NULL,                                 -- 状态
    "item_expanded" BOOLEAN NOT NULL,                               -- 是否展开
    "item_creation_date" DECIMAL(15,6) NOT NULL,                    -- 创建日期
    "item_modification_date" DECIMAL(15,6) NOT NULL,                -- 修改日期
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX "idx_item_reference" ON "items" ("item_reference");                 -- 项目编号索引
CREATE INDEX "idx_item_linked_to_table" ON "items" ("item_linked_to_table");     -- 关联表名索引
CREATE INDEX "idx_item_linked_to_record" ON "items" ("item_linked_to_record");   -- 关联记录ID索引
CREATE INDEX "idx_item_type" ON "items" ("item_type");                           -- 项目类型索引
CREATE INDEX "idx_item_category" ON "items" ("item_category");                   -- 项目类别索引
CREATE INDEX "idx_item_enabled" ON "items" ("item_enabled");                     -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "items" ("is_deleted");


-- =====================================================
-- 15. currency 表 (币种表)
-- 说明: 存储货币/加密货币信息和汇率
-- =====================================================
CREATE TABLE "currency" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 币种记录ID
    
    -- 业务字段
    --"currency_record" BIGINT UNSIGNED NOT NULL,                     -- 币种记录ID
    "currency_symbol" VARCHAR(32) NOT NULL,                         -- 货币符号(如¥、$、€)
    "currency_description" VARCHAR(128) NOT NULL,                   -- 货币描述/名称
    "currency_formatting_symbol" VARCHAR(32) NOT NULL,              -- 格式化符号
    "currency_formatting_symbol_pos" TINYINT NOT NULL,              -- 符号位置(0:前 1:后)
    "currency_show_formatting_symbol" BOOLEAN NOT NULL,             -- 是否显示符号
    "currency_formatting_decimals" TINYINT NOT NULL,                -- 小数位数
    "currency_formatting_t_separator" BOOLEAN NOT NULL,             -- 是否使用千位分隔符
    "currency_rate" DECIMAL(15,6) NOT NULL,                         -- 汇率(相对默认币种)
    "currency_direction" TINYINT NOT NULL,                          -- 汇率方向(0:直接 1:间接)
    "currency_bid" DECIMAL(15,6) NOT NULL,                          -- 买入价
    "currency_ask" DECIMAL(15,6) NOT NULL,                          -- 卖出价
    "currency_date" DATE NOT NULL,                                  -- 汇率日期
    "currency_reference" BIGINT UNSIGNED NOT NULL,                  -- 参考值
    "currency_class" TINYINT NOT NULL,                              -- 分类
    "currency_identification" TINYINT NOT NULL,                     -- 标识类型
    "currency_enabled" BOOLEAN NOT NULL,                            -- 是否启用
    "currency_status" TINYINT NOT NULL,                             -- 状态
    "currency_expanded" BOOLEAN NOT NULL,                           -- 是否展开
    "currency_creation_date" DECIMAL(15,6) NOT NULL,                -- 创建日期
    "currency_modification_date" DECIMAL(15,6) NOT NULL,            -- 修改日期
    "currency_is_default" BOOLEAN NOT NULL,                         -- 是否为默认币种
    "currency_is_cryptocurrency" BOOLEAN NOT NULL,                  -- 是否为加密货币
    "currency_cryptocurrency_icon_url" VARCHAR(128) NOT NULL,       -- 加密货币图标URL
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX "idx_currency_symbol" ON "currency" ("currency_symbol");               -- 货币符号索引
CREATE INDEX "idx_currency_is_default" ON "currency" ("currency_is_default");       -- 默认币种索引
CREATE INDEX "idx_currency_is_cryptocurrency" ON "currency" ("currency_is_cryptocurrency"); -- 加密货币索引
CREATE INDEX "idx_currency_enabled" ON "currency" ("currency_enabled");             -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "currency" ("is_deleted");


-- =====================================================
-- 16. portfolio 表 (投资组合表)
-- 说明: 存储股票、基金等投资组合交易记录
-- =====================================================
CREATE TABLE "portfolio" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 投资组合记录ID
    
    -- 业务字段
    --"portfolio_record" BIGINT UNSIGNED NOT NULL,                        -- 投资组合记录ID
    "portfolio_type" TINYINT NOT NULL,                                  -- 投资类型(0:股票 1:基金 2:债券 3:期货等)
    "portfolio_linked_to_table" VARCHAR(32) NOT NULL,                   -- 关联表名
    "portfolio_linked_to_record" BIGINT UNSIGNED NOT NULL,              -- 关联记录ID
    "portfolio_symbol" VARCHAR(32) NOT NULL,                            -- 交易代码/股票代码
    "portfolio_description" VARCHAR(128) NOT NULL,                      -- 投资描述/公司名称
    "portfolio_transaction_type" TINYINT NOT NULL,                      -- 交易类型(0:买入 1:卖出)
    "portfolio_purchase_date" DATE NOT NULL,                            -- 购买日期
    "portfolio_purchase_shares" BIGINT UNSIGNED NOT NULL,               -- 购买数量/股数
    "portfolio_purchase_price" DECIMAL(15,6) NOT NULL,                  -- 购买单价
    "portfolio_entry_commission" DECIMAL(15,6) NOT NULL,                -- 买入佣金
    "portfolio_sales_date" DATE NOT NULL,                               -- 卖出日期
    "portfolio_sales_shares" BIGINT UNSIGNED NOT NULL,                  -- 卖出数量
    "portfolio_sales_price" DECIMAL(15,6) NOT NULL,                     -- 卖出单价
    "portfolio_exit_commission" DECIMAL(15,6) NOT NULL,                 -- 卖出佣金
    "portfolio_currency_record" BIGINT UNSIGNED NOT NULL,               -- 币种记录
    "portfolio_currency_rate" DECIMAL(15,6) NOT NULL,                   -- 汇率
    "portfolio_class" TINYINT NOT NULL,                                 -- 分类
    "portfolio_identification" TINYINT NOT NULL,                        -- 标识类型
    "portfolio_enabled" BOOLEAN NOT NULL,                               -- 是否启用
    "portfolio_status" TINYINT NOT NULL,                                -- 状态
    "portfolio_expanded" BOOLEAN NOT NULL,                              -- 是否展开
    "portfolio_creation_date" DECIMAL(15,6) NOT NULL,                   -- 创建日期
    "portfolio_modification_date" DECIMAL(15,6) NOT NULL,               -- 修改日期
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 索引
CREATE INDEX "idx_portfolio_symbol" ON "portfolio" ("portfolio_symbol");                 -- 股票代码索引
CREATE INDEX "idx_portfolio_linked_to_table" ON "portfolio" ("portfolio_linked_to_table"); -- 关联表名索引
CREATE INDEX "idx_portfolio_linked_to_record" ON "portfolio" ("portfolio_linked_to_record"); -- 关联记录ID索引
CREATE INDEX "idx_portfolio_purchase_date" ON "portfolio" ("portfolio_purchase_date");   -- 购买日期索引
CREATE INDEX "idx_portfolio_sales_date" ON "portfolio" ("portfolio_sales_date");         -- 卖出日期索引
CREATE INDEX "idx_portfolio_enabled" ON "portfolio" ("portfolio_enabled");               -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "portfolio" ("is_deleted");


-- =====================================================
-- 17. quotes 表 (行情报价表)
-- 说明: 存储股票、基金等金融产品的历史行情数据
-- =====================================================
CREATE TABLE "quotes" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 行情记录ID
    
    -- 业务字段
    --"quotes_record" BIGINT UNSIGNED NOT NULL,                        -- 行情记录ID
    "quotes_symbol" VARCHAR(32) NOT NULL,                            -- 交易代码/股票代码
    "quotes_description" VARCHAR(128) NOT NULL,                      -- 行情描述
    "quotes_date" DATE NOT NULL,                                     -- 行情日期
    "quotes_open" DECIMAL(15,6) NOT NULL,                            -- 开盘价
    "quotes_high" DECIMAL(15,6) NOT NULL,                            -- 最高价
    "quotes_low" DECIMAL(15,6) NOT NULL,                             -- 最低价
    "quotes_close" DECIMAL(15,6) NOT NULL,                           -- 收盘价
    "quotes_volume" BIGINT UNSIGNED NOT NULL,                        -- 成交量
    "quotes_day" BIGINT UNSIGNED NOT NULL,                           -- 日期(日)
    "quotes_month" BIGINT UNSIGNED NOT NULL,                         -- 日期(月)
    "quotes_year" BIGINT UNSIGNED NOT NULL,                          -- 日期(年)
    "quotes_currency_record" BIGINT UNSIGNED NOT NULL,               -- 币种记录
    "quotes_currency_rate" DECIMAL(15,6) NOT NULL,                   -- 汇率
    "quotes_class" TINYINT NOT NULL,                                 -- 分类
    "quotes_identification" TINYINT NOT NULL,                        -- 标识类型
    "quotes_enabled" BOOLEAN NOT NULL,                               -- 是否启用
    "quotes_status" TINYINT NOT NULL,                                -- 状态
    "quotes_expanded" BOOLEAN NOT NULL,                              -- 是否展开
    "quotes_creation_date" DECIMAL(15,6) NOT NULL,                   -- 创建日期
    "quotes_modification_date" DECIMAL(15,6) NOT NULL,               -- 修改日期
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX "idx_quotes_symbol" ON "quotes" ("quotes_symbol");       -- 股票代码索引
CREATE INDEX "idx_quotes_date" ON "quotes" ("quotes_date");           -- 行情日期索引
CREATE INDEX "idx_quotes_enabled" ON "quotes" ("quotes_enabled");     -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "quotes" ("is_deleted");


-- =====================================================
-- 18. loan 表 (贷款表)
-- 说明: 存储贷款、借款信息及还款计划
-- =====================================================
CREATE TABLE "loan" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 贷款记录ID
    
    -- 业务字段
    "loan_name" VARCHAR(64) NOT NULL,                                -- 贷款名称
    "loan_comment" VARCHAR(256) NOT NULL,                            -- 贷款备注
    --"loan_record" BIGINT UNSIGNED NOT NULL,                          -- 贷款记录ID
    "loan_linked_to_table" VARCHAR(32) NOT NULL,                     -- 关联表名
    "loan_linked_to_record" BIGINT UNSIGNED NOT NULL,                -- 关联记录ID
    "loan_amount" DECIMAL(15,6) NOT NULL,                            -- 贷款金额
    "loan_length" DECIMAL(15,6) NOT NULL,                            -- 贷款期限
    "loan_period" TINYINT NOT NULL,                                  -- 还款周期(0:月 1:季 2:半年 3:年)
    "loan_rate" DECIMAL(15,6) NOT NULL,                              -- 利率(百分比)
    "loan_type" TINYINT NOT NULL,                                    -- 贷款类型(0:等额本息 1:等额本金 2:先息后本)
    "loan_compounding" TINYINT NOT NULL,                             -- 复利方式(0:不复合 1:年复利 2:月复利)
    "loan_start_date" DATE NOT NULL,                                 -- 贷款开始日期
    "loan_end_date" DATE NOT NULL,                                   -- 贷款结束日期
    "loan_period_begin_end" TINYINT NOT NULL,                        -- 期初期末(0:期初 1:期末)
    "loan_currency_record" BIGINT UNSIGNED NOT NULL,                 -- 币种记录
    "loan_currency_rate" DECIMAL(15,6) NOT NULL,                     -- 汇率
    "loan_class" TINYINT NOT NULL,                                   -- 分类
    "loan_identification" TINYINT NOT NULL,                          -- 标识类型
    "loan_enabled" BOOLEAN NOT NULL,                                 -- 是否启用
    "loan_status" TINYINT NOT NULL,                                  -- 状态(0:正常 1:逾期 2:已结清)
    "loan_expanded" BOOLEAN NOT NULL,                                -- 是否展开
    "loan_creation_date" DECIMAL(15,6) NOT NULL,                     -- 创建日期
    "loan_modification_date" DECIMAL(15,6) NOT NULL,                 -- 修改日期
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX "idx_loan_name" ON "loan" ("loan_name");                         -- 贷款名称索引
CREATE INDEX "idx_loan_linked_to_table" ON "loan" ("loan_linked_to_table");   -- 关联表名索引
CREATE INDEX "idx_loan_linked_to_record" ON "loan" ("loan_linked_to_record"); -- 关联记录ID索引
CREATE INDEX "idx_loan_start_date" ON "loan" ("loan_start_date");             -- 开始日期索引
CREATE INDEX "idx_loan_end_date" ON "loan" ("loan_end_date");                 -- 结束日期索引
CREATE INDEX "idx_loan_enabled" ON "loan" ("loan_enabled");                   -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "loan" ("is_deleted");


-- =====================================================
-- 19. banks 表 (银行信息表)
-- 说明: 存储银行账户信息和银行联系方式
-- =====================================================
CREATE TABLE "banks" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 银行记录ID
    
    -- 业务字段
    "bank_name" VARCHAR(128) NOT NULL,                              -- 银行名称
    "bank_id" VARCHAR(64) NOT NULL,                                 -- 银行ID/代码
    --"bank_record" BIGINT UNSIGNED NOT NULL,                         -- 银行记录ID
    "bank_linked_to_table" VARCHAR(32) NOT NULL,                    -- 关联表名
    "bank_linked_to_record" BIGINT UNSIGNED NOT NULL,               -- 关联记录ID
    "bank_type" TINYINT NOT NULL,                                   -- 银行类型(0:商业银行 1:央行 2:投资银行等)
    "bank_swiftcode" VARCHAR(32) NOT NULL,                          -- SWIFT代码/银行国际代码
    "bank_account_number" VARCHAR(64) NOT NULL,                     -- 银行账号
    "bank_iban" VARCHAR(64) NOT NULL,                               -- IBAN国际银行账号
    "bank_currency_record" BIGINT UNSIGNED NOT NULL,                -- 币种记录
    "bank_currency_rate" DECIMAL(15,6) NOT NULL,                    -- 汇率
    "bank_street" VARCHAR(256) NOT NULL,                            -- 银行街道地址
    "bank_suburb" VARCHAR(128) NOT NULL,                            -- 银行所在区域
    "bank_city" VARCHAR(128) NOT NULL,                              -- 银行所在城市
    "bank_state" VARCHAR(128) NOT NULL,                             -- 银行所在州/省
    "bank_zip" VARCHAR(32) NOT NULL,                                -- 银行邮政编码
    "bank_country" VARCHAR(128) NOT NULL,                           -- 银行所在国家
    "bank_phone" VARCHAR(64) NOT NULL,                              -- 银行电话
    "bank_mobile" VARCHAR(64) NOT NULL,                             -- 银行手机
    "bank_fax" VARCHAR(64) NOT NULL,                                -- 银行传真
    "bank_email" VARCHAR(128) NOT NULL,                             -- 银行电子邮箱
    "bank_web" VARCHAR(128) NOT NULL,                               -- 银行网址
    "bank_comment" VARCHAR(256) NOT NULL,                           -- 银行备注
    "bank_enabled" BOOLEAN NOT NULL,                                -- 是否启用
    "bank_status" TINYINT NOT NULL,                                 -- 状态
    "bank_class" TINYINT NOT NULL,                                  -- 分类
    "bank_identification" TINYINT NOT NULL,                         -- 标识类型
    "bank_tax_key_record" BIGINT UNSIGNED NOT NULL,                 -- 税务键值记录
    "bank_creation_date" DECIMAL(15,6) NOT NULL,                    -- 创建日期
    "bank_modification_date" DECIMAL(15,6) NOT NULL,                -- 修改日期
    "bank_expanded" BOOLEAN NOT NULL,                               -- 是否展开
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 索引
CREATE INDEX "idx_bank_name" ON "banks" ("bank_name");                         -- 银行名称索引
CREATE INDEX "idx_bank_id" ON "banks" ("bank_id");                             -- 银行ID索引
CREATE INDEX "idx_bank_swiftcode" ON "banks" ("bank_swiftcode");               -- SWIFT代码索引
CREATE INDEX "idx_bank_account_number" ON "banks" ("bank_account_number");     -- 银行账号索引
CREATE INDEX "idx_bank_iban" ON "banks" ("bank_iban");                         -- IBAN账号索引
CREATE INDEX "idx_bank_linked_to_table" ON "banks" ("bank_linked_to_table");   -- 关联表名索引
CREATE INDEX "idx_bank_linked_to_record" ON "banks" ("bank_linked_to_record"); -- 关联记录ID索引
CREATE INDEX "idx_bank_enabled" ON "banks" ("bank_enabled");                   -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "banks" ("is_deleted");


-- =====================================================
-- 20. trans_group 表 (交易分组表)
-- 说明: 将多笔交易分组管理，用于批量处理或关联交易
-- =====================================================
CREATE TABLE "trans_group" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 分组记录ID
    
    -- 业务字段
    --"trans_group_record" BIGINT UNSIGNED NOT NULL,                      -- 分组记录ID
    "trans_group_type" BIGINT UNSIGNED NOT NULL,                        -- 分组类型
    "trans_group_account_debited" BIGINT UNSIGNED NOT NULL,             -- 借方账户
    "trans_group_account_credited" BIGINT UNSIGNED NOT NULL,            -- 贷方账户
    "trans_group_amount" DECIMAL(15,6) NOT NULL,                        -- 分组总金额
    "trans_group_comment" VARCHAR(128) NOT NULL,                        -- 分组备注
    "trans_group_checked" BOOLEAN NOT NULL,                             -- 是否已核对
    "trans_group_detailed" BOOLEAN NOT NULL,                            -- 是否详细
    "trans_group_enabled" BOOLEAN NOT NULL,                             -- 是否启用
    "trans_group_status" TINYINT NOT NULL,                              -- 状态
    "trans_group_expanded" BOOLEAN NOT NULL,                            -- 是否展开
    "trans_group_day" BIGINT UNSIGNED NOT NULL,                         -- 日期(日)
    "trans_group_month" BIGINT UNSIGNED NOT NULL,                       -- 日期(月)
    "trans_group_year" BIGINT UNSIGNED NOT NULL,                        -- 日期(年)
    "trans_group_date" DATE NOT NULL,                                   -- 交易日期
    "trans_group_creation_date" BIGINT UNSIGNED NOT NULL,               -- 创建日期(时间戳)
    "trans_group_modification_date" BIGINT UNSIGNED NOT NULL,           -- 修改日期(时间戳)
    "trans_group_type_ref" VARCHAR(32) NOT NULL,                        -- 类型参考
    "trans_group_account_debited_alt" VARCHAR(64) NOT NULL,             -- 备选借方账户
    "trans_group_account_credited_alt" VARCHAR(64) NOT NULL,            -- 备选贷方账户
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX "idx_trans_group_type" ON "trans_group" ("trans_group_type");                     -- 分组类型索引
CREATE INDEX "idx_trans_group_account_debited" ON "trans_group" ("trans_group_account_debited"); -- 借方账户索引
CREATE INDEX "idx_trans_group_account_credited" ON "trans_group" ("trans_group_account_credited"); -- 贷方账户索引
CREATE INDEX "idx_trans_group_date" ON "trans_group" ("trans_group_date");                     -- 交易日期索引
CREATE INDEX "idx_trans_group_enabled" ON "trans_group" ("trans_group_enabled");               -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "trans_group" ("is_deleted");


-- =====================================================
-- 21. budgets 表 (预算表)
-- 说明: 存储财务预算主表，定义预算期间和比较设置
-- =====================================================
CREATE TABLE "budgets" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,
    
    -- 业务字段
    "budget_name" VARCHAR(64) NOT NULL,                              -- 预算名称
    "expenses_expanded" BOOLEAN NOT NULL,                            -- 支出是否展开
    "incomes_expanded" BOOLEAN NOT NULL,                             -- 收入是否展开
    "expenses_enabled" BOOLEAN NOT NULL,                             -- 支出预算是否启用
    "incomes_enabled" BOOLEAN NOT NULL,                              -- 收入预算是否启用
    "budget_compare_enabled" BOOLEAN NOT NULL,                       -- 是否启用预算比较
    "budget_compare_period" TINYINT NOT NULL,                        -- 比较周期(0:月 1:季 2:年)
    "budget_compare_from_date" DATE NOT NULL,                        -- 比较开始日期
    "budget_compare_to_date" DATE NOT NULL,                          -- 比较结束日期
    "liabilities_expanded" BOOLEAN NOT NULL,                         -- 负债是否展开
    "liabilities_enabled" BOOLEAN NOT NULL,                          -- 负债预算是否启用
    "budget_expenses_comment" VARCHAR(128) NOT NULL,                 -- 支出预算备注
    "budget_incomes_comment" VARCHAR(128) NOT NULL,                  -- 收入预算备注
    "budget_liabilities_comment" VARCHAR(128) NOT NULL,              -- 负债预算备注
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX "idx_budget_name" ON "budgets" ("budget_name");                     -- 预算名称索引
CREATE INDEX "idx_budget_compare_enabled" ON "budgets" ("budget_compare_enabled"); -- 比较启用索引
CREATE INDEX "idx_budget_compare_from_date" ON "budgets" ("budget_compare_from_date"); -- 比较开始日期索引
CREATE INDEX "idx_budget_compare_to_date" ON "budgets" ("budget_compare_to_date");     -- 比较结束日期索引
CREATE INDEX "idx_is_deleted" ON "budgets" ("is_deleted");


-- =====================================================
-- 22. budget_category 表 (预算类别关联表)
-- 说明: 将预算与收支类别进行关联，定义哪些类别纳入预算
-- =====================================================
CREATE TABLE "budget_category" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,
    
    -- 业务字段
    "budget_category_budget_id" BIGINT UNSIGNED NOT NULL,           -- 预算ID(关联budgets表)
    "budget_category_category_id" BIGINT UNSIGNED NOT NULL,         -- 类别ID(关联categories表)
    "budget_category_expanded" BOOLEAN NOT NULL,                    -- 是否展开显示
    "budget_category_enabled" BOOLEAN NOT NULL,                     -- 是否启用该类别预算
    "budget_category_comment" VARCHAR(128) NOT NULL,                -- 备注说明
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 索引
CREATE INDEX "idx_budget_category_budget_id" ON "budget_category" ("budget_category_budget_id");     -- 预算ID索引
CREATE INDEX "idx_budget_category_category_id" ON "budget_category" ("budget_category_category_id"); -- 类别ID索引
CREATE INDEX "idx_budget_category_enabled" ON "budget_category" ("budget_category_enabled");         -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "budget_category" ("is_deleted");

-- 组合索引(提升关联查询性能)
CREATE INDEX "idx_budget_category_budget_cate" ON "budget_category" ("budget_category_budget_id", "budget_category_category_id");


-- =====================================================
-- 23. budget_account 表 (预算账户关联表)
-- 说明: 将预算与账户进行关联，定义账户的预算金额和周期
-- =====================================================
CREATE TABLE "budget_account" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,
    
    -- 业务字段
    "budget_account_budget_id" BIGINT UNSIGNED NOT NULL,            -- 预算ID(关联budgets表)
    "budget_account_account_id" BIGINT UNSIGNED NOT NULL,           -- 账户ID(关联accounts表)
    "budget_account_amount" DECIMAL(15,6) NOT NULL,                 -- 预算金额
    "budget_account_interval" TINYINT NOT NULL,                     -- 预算周期(0:月 1:季 2:半年 3:年)
    "budget_account_enabled" BOOLEAN NOT NULL,                      -- 是否启用该账户预算
    "budget_account_comment" VARCHAR(128) NOT NULL,                 -- 备注说明
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 索引
CREATE INDEX "idx_budget_account_budget_id" ON "budget_account" ("budget_account_budget_id");     -- 预算ID索引
CREATE INDEX "idx_budget_account_account_id" ON "budget_account" ("budget_account_account_id");   -- 账户ID索引
CREATE INDEX "idx_budget_account_enabled" ON "budget_account" ("budget_account_enabled");         -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "budget_account" ("is_deleted");

-- 组合索引(提升关联查询性能)
CREATE INDEX "idx_budget_account_budget_acc" ON "budget_account" ("budget_account_budget_id", "budget_account_account_id");


-- =====================================================
-- 24. projects 表 (项目表)
-- 说明: 存储项目管理信息，用于按项目维度统计收支
-- =====================================================
CREATE TABLE "projects" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 项目记录ID
    
    -- 业务字段
    "project_name" VARCHAR(128) NOT NULL,                           -- 项目名称
    --"project_record" BIGINT UNSIGNED NOT NULL,                      -- 项目记录ID
    "project_enabled" BOOLEAN NOT NULL,                             -- 是否启用
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 索引
CREATE INDEX "idx_project_name" ON "projects" ("project_name");     -- 项目名称索引
CREATE INDEX "idx_project_enabled" ON "projects" ("project_enabled"); -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "projects" ("is_deleted");


-- =====================================================
-- 25. contact_types 表 (联系人类型表)
-- 说明: 定义联系人的分类类型，如客户、供应商、合作伙伴等
-- =====================================================
CREATE TABLE "contact_types" (
    -- 主键
    "id" BIGINT UNSIGNED NOT NULL PRIMARY KEY AUTOINCREMENT,-- 类型记录ID
    
    -- 业务字段
    "contact_type_name" VARCHAR(64) NOT NULL,                       -- 联系人类型名称
    --"contact_type_record" BIGINT UNSIGNED NOT NULL,                 -- 类型记录ID
    "contact_type_enabled" BOOLEAN NOT NULL,                        -- 是否启用
    
    -- 必备字段
    "is_deleted" BOOLEAN NOT NULL DEFAULT 0,
    "created_by" VARCHAR(64) NOT NULL DEFAULT '',
    "updated_by" VARCHAR(64) NOT NULL DEFAULT '',
    "created_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_time" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 索引
CREATE INDEX "idx_contact_type_name" ON "contact_types" ("contact_type_name");     -- 类型名称索引
CREATE INDEX "idx_contact_type_enabled" ON "contact_types" ("contact_type_enabled"); -- 启用状态索引
CREATE INDEX "idx_is_deleted" ON "contact_types" ("is_deleted");
