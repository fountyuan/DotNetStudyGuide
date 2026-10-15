-- =====================================================
-- 数据库设置
-- =====================================================
PRAGMA case_sensitive_like = false;
PRAGMA encoding = 'UTF-8';
PRAGMA page_size = 32768;

-- =====================================================
-- 删除所有表（按依赖关系倒序删除）
-- =====================================================
DROP TABLE IF EXISTS budget_account;
DROP TABLE IF EXISTS budget_category;
DROP TABLE IF EXISTS budget;
DROP TABLE IF EXISTS trans;
DROP TABLE IF EXISTS trans_group;
DROP TABLE IF EXISTS loan;
DROP TABLE IF EXISTS quote;
DROP TABLE IF EXISTS portfolio;
DROP TABLE IF EXISTS scheduling;
DROP TABLE IF EXISTS preset;
DROP TABLE IF EXISTS bank;
DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS favorite;
DROP TABLE IF EXISTS memo;
DROP TABLE IF EXISTS tax;
DROP TABLE IF EXISTS detail;
DROP TABLE IF EXISTS trans_type;
DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS account_category;
DROP TABLE IF EXISTS account_type;
DROP TABLE IF EXISTS preference;
DROP TABLE IF EXISTS currency;
DROP TABLE IF EXISTS contact;
DROP TABLE IF EXISTS contact_type;
DROP TABLE IF EXISTS project;

-- 然后执行建表语句...

-- =====================================================
-- 01. 项目表
-- 字段说明:
--   id            : 主键ID
--   project_name  : 项目名称
--   is_enabled    : 是否启用:1-是,0-否
--   created_by    : 创建人
--   created_time  : 创建时间
--   updated_by    : 更新人
--   updated_time  : 修改时间
--   deleted_by    : 删除人
--   deleted_time  : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "project" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    project_name VARCHAR(128) NOT NULL,
    is_enabled TINYINT NOT NULL DEFAULT 1,
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_project_name ON project(project_name);
CREATE INDEX idx_project_is_enabled ON project(is_enabled);
CREATE INDEX idx_project_deleted_time ON project(deleted_time);


-- =====================================================
-- 02. 联系人类型表 
-- 字段说明:
--   id            : 主键ID
--   type_name     : 联系人类型名称
--   is_enabled    : 是否启用:1-是,0-否
--   created_by    : 创建人
--   created_time  : 创建时间
--   updated_by    : 更新人
--   updated_time  : 修改时间
--   deleted_by    : 删除人
--   deleted_time  : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "contact_type" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type_name VARCHAR(64) NOT NULL,
    is_enabled TINYINT NOT NULL DEFAULT 1,
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,    
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_contact_type_type_name ON contact_type(type_name);
CREATE INDEX idx_contact_type_deleted_time ON contact_type(deleted_time);


-- =====================================================
-- 03. 联系人表
-- 字段说明:
--   id                : 主键ID
--   contact_name      : 联系人姓名
--   linked_to_table   : 关联表名
--   linked_to_record  : 关联记录ID
--   contact_type_id   : 联系人类型
--   tax_id            : 税号
--   street            : 街道
--   suburb            : 郊区/区
--   city              : 城市
--   state             : 州/省
--   zip               : 邮编
--   country           : 国家
--   phone             : 电话
--   mobile            : 手机
--   fax               : 传真
--   email             : 邮箱
--   web               : 网站
--   memo              : 备注
--   is_enabled        : 是否启用:1-是,0-否
--   is_deleted        : 是否删除:1-是,0-否
--   contact_status    : 联系人状态:0-正常,1-停用
--   class_type        : 类别
--   identification    : 标识
--   tax_key_record    : 税务键记录
--   is_expanded       : 是否展开:1-是,0-否
--   created_by        : 创建人
--   created_time      : 创建时间
--   updated_by        : 更新人
--   updated_time      : 修改时间
--   deleted_by        : 删除人
--   deleted_time      : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "contact" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    contact_name VARCHAR(128) NOT NULL,
    linked_to_table VARCHAR(32) NOT NULL,
    linked_to_record INTEGER NOT NULL,
    contact_type_id TINYINT NOT NULL,
    tax_id VARCHAR(64) NOT NULL DEFAULT '',
    street VARCHAR(256) NOT NULL DEFAULT '',
    suburb VARCHAR(128) NOT NULL DEFAULT '',
    city VARCHAR(128) NOT NULL DEFAULT '',
    state VARCHAR(128) NOT NULL DEFAULT '',
    zip VARCHAR(32) NOT NULL DEFAULT '',
    country VARCHAR(128) NOT NULL DEFAULT '',
    phone VARCHAR(64) NOT NULL DEFAULT '',
    mobile VARCHAR(64) NOT NULL DEFAULT '',
    fax VARCHAR(64) NOT NULL DEFAULT '',
    email VARCHAR(128) NOT NULL DEFAULT '',
    web VARCHAR(128) NOT NULL DEFAULT '',
    memo VARCHAR(256) NOT NULL DEFAULT '',
    is_enabled TINYINT NOT NULL DEFAULT 1,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    contact_status TINYINT NOT NULL DEFAULT 0,
    class_type TINYINT NOT NULL DEFAULT 0,
    identification TINYINT NOT NULL DEFAULT 0,
    tax_key_record INTEGER NOT NULL DEFAULT 0,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,    
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_contact_contact_name ON contact(contact_name);
CREATE INDEX idx_contact_linked ON contact(linked_to_table, linked_to_record);
CREATE INDEX idx_contact_contact_status ON contact(contact_status);
CREATE INDEX idx_contact_deleted_time ON contact(deleted_time);


-- =====================================================
-- 04. 货币表
-- 字段说明:
--   id                         : 主键ID
--   symbol_code                : 货币符号
--   description                : 描述
--   formatting_symbol          : 格式化符号
--   formatting_symbol_pos      : 符号位置
--   is_show_formatting_symbol  : 是否显示格式符号:1-是,0-否
--   formatting_decimals        : 小数位数
--   is_formatting_t_separator  : 是否使用千位分隔符:1-是,0-否
--   rate                       : 汇率
--   direction                  : 方向
--   bid                        : 买入价
--   ask                        : 卖出价
--   rate_date                  : 汇率日期
--   reference_no               : 参考
--   class_type                 : 类别
--   identification             : 标识
--   is_enabled                 : 是否启用:1-是,0-否
--   is_deleted                 : 是否删除:1-是,0-否
--   currency_status            : 货币状态:0-正常,1-停用
--   is_expanded                : 是否展开:1-是,0-否
--   is_default                 : 是否默认货币:1-是,0-否
--   is_cryptocurrency          : 是否加密货币:1-是,0-否
--   cryptocurrency_icon_url    : 加密货币图标URL
--   created_by                 : 创建人
--   created_time               : 创建时间
--   updated_by                 : 更新人
--   updated_time               : 修改时间
--   deleted_by                 : 删除人
--   deleted_time               : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "currency" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    symbol_code VARCHAR(32) NOT NULL,
    description VARCHAR(128) NOT NULL DEFAULT '',
    formatting_symbol VARCHAR(32) NOT NULL DEFAULT '',
    formatting_symbol_pos TINYINT NOT NULL DEFAULT 0,
    is_show_formatting_symbol TINYINT NOT NULL DEFAULT 1,
    formatting_decimals TINYINT NOT NULL DEFAULT 2,
    is_formatting_t_separator TINYINT NOT NULL DEFAULT 1,
    rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000,
    direction TINYINT NOT NULL DEFAULT 0,
    bid DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    ask DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    rate_date DATE NOT NULL,
    reference_no INTEGER NOT NULL DEFAULT 0,
    class_type TINYINT NOT NULL DEFAULT 0,
    identification TINYINT NOT NULL DEFAULT 0,
    is_enabled TINYINT NOT NULL DEFAULT 1,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    currency_status TINYINT NOT NULL DEFAULT 0,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    is_default TINYINT NOT NULL DEFAULT 0,
    is_cryptocurrency TINYINT NOT NULL DEFAULT 0,
    cryptocurrency_icon_url VARCHAR(128) NOT NULL DEFAULT '',
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,    
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_currency_symbol_code ON currency(symbol_code);
CREATE INDEX idx_currency_is_default ON currency(is_default);
CREATE INDEX idx_currency_currency_status ON currency(currency_status);
CREATE INDEX idx_currency_deleted_time ON currency(deleted_time);

-- =====================================================
-- 05. 偏好设置表
-- 字段说明:
--   id               : 主键ID
--   preference_name  : 配置项名称
--   value            : 配置值
--   created_by       : 创建人
--   created_time     : 创建时间
--   updated_by       : 更新人
--   updated_time     : 修改时间
--   deleted_by       : 删除人
--   deleted_time     : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "preference" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    preference_name VARCHAR(64) NOT NULL,
    value VARCHAR(1024) NOT NULL DEFAULT '',
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,    
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE UNIQUE INDEX uk_preference_preference_name ON preference(preference_name);
CREATE INDEX idx_preference_deleted_time ON preference(deleted_time);


-- =====================================================
-- 06. 账目类型表
-- 字段说明:
--   id                     : 主键ID
--   type_name              : 类型名称
--   kind_id                : 种类
--   accounts_count         : 账户数量
--   categories_count       : 分类数量
--   balance                : 余额
--   reconciled             : 已对账金额
--   opening                : 期初
--   closing                : 期末
--   incoming               : 收入
--   outgoing               : 支出
--   is_enabled             : 是否启用:1-是,0-否
--   is_deleted             : 是否删除:1-是,0-否
--   type_status            : 类型状态:0-正常,1-禁用,2-归档
--   budget_amount          : 预算金额
--   budget_period          : 预算周期
--   max_limit              : 最大限额
--   min_authorized         : 最小授权额
--   min_expected           : 最小预期额
--   is_expanded            : 是否展开:1-是,0-否
--   is_balance_up_to_date  : 余额是否最新:1-是,0-否
--   balance_total_all      : 总余额
--   balance_total_rec      : 对账总额
--   balance_accounts       : 账户余额
--   memo                   : 备注
--   created_by             : 创建人
--   created_time           : 创建时间
--   updated_by             : 更新人
--   updated_time           : 修改时间
--   deleted_by             : 删除人
--   deleted_time           : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "account_type" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type_name VARCHAR(64) NOT NULL,
    kind_id INTEGER NOT NULL,
    accounts_count INTEGER NOT NULL DEFAULT 0,
    categories_count INTEGER NOT NULL DEFAULT 0,
    balance DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    reconciled DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    opening DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    closing DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    incoming DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    outgoing DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    is_enabled TINYINT NOT NULL DEFAULT 1,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    type_status TINYINT NOT NULL DEFAULT 0,
    budget_amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    budget_period TINYINT NOT NULL DEFAULT 0,
    max_limit DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    min_authorized DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    min_expected DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    is_balance_up_to_date TINYINT NOT NULL DEFAULT 0,
    balance_total_all DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    balance_total_rec DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    balance_accounts INTEGER NOT NULL DEFAULT 0,
    memo VARCHAR(128) NOT NULL DEFAULT '',
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,    
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_account_type_type_name ON account_type(type_name);
CREATE INDEX idx_account_type_kind_id ON account_type(kind_id);
CREATE INDEX idx_account_type_type_status ON account_type(type_status);
CREATE INDEX idx_account_type_deleted_time ON account_type(deleted_time);


-- =====================================================
-- 07. 账目分类表
-- 字段说明:
--   id                     : 主键ID
--   category_name          : 分类名称
--   account_type_id        : 类型ID
--   accounts_count         : 账户数量
--   balance                : 余额
--   reconciled             : 已对账金额
--   opening                : 期初
--   closing                : 期末
--   incoming               : 收入
--   outgoing               : 支出
--   is_enabled             : 是否启用:1-是,0-否
--   is_deleted             : 是否删除:1-是,0-否
--   category_status        : 分类状态:0-正常,1-禁用,2-归档
--   budget_amount          : 预算金额
--   budget_period          : 预算周期
--   max_limit              : 最大限额
--   min_authorized         : 最小授权额
--   min_expected           : 最小预期额
--   is_expanded            : 是否展开:1-是,0-否
--   is_balance_up_to_date  : 余额是否最新:1-是,0-否
--   balance_total_all      : 总余额
--   balance_total_rec      : 对账总额
--   balance_accounts       : 账户余额
--   memo                   : 备注
--   created_by             : 创建人
--   created_time           : 创建时间
--   updated_by             : 更新人
--   updated_time           : 修改时间
--   deleted_by             : 删除人
--   deleted_time           : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "account_category" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_name VARCHAR(64) NOT NULL,
    account_type_id INTEGER NOT NULL,
    accounts_count INTEGER NOT NULL DEFAULT 0,
    balance DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    reconciled DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    opening DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    closing DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    incoming DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    outgoing DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    is_enabled TINYINT NOT NULL DEFAULT 1,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    category_status TINYINT NOT NULL DEFAULT 0,
    budget_amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    budget_period TINYINT NOT NULL DEFAULT 0,
    max_limit DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    min_authorized DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    min_expected DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    is_balance_up_to_date TINYINT NOT NULL DEFAULT 0,
    balance_total_all DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    balance_total_rec DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    balance_accounts INTEGER NOT NULL DEFAULT 0,
    memo VARCHAR(128) NOT NULL DEFAULT '',
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,    
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_account_category_category_name ON account_category(category_name);
CREATE INDEX idx_account_category_account_type_id ON account_category(account_type_id);
CREATE INDEX idx_account_category_category_status ON account_category(category_status);
CREATE INDEX idx_account_category_deleted_time ON account_category(deleted_time);


-- =====================================================
-- 08. 账目表
-- 字段说明:
--   id                     : 主键ID
--   account_name           : 账户名称
--   account_type_id        : 记录类型
--   account_category_id    : 账户类别
--   memo                   : 备注
--   balance                : 余额
--   reconciled             : 已对账金额
--   opening                : 期初余额
--   closing                : 期末余额
--   incoming               : 收入
--   outgoing               : 支出
--   is_enabled             : 是否启用:1-是,0-否
--   is_deleted             : 是否删除:1-是,0-否
--   is_closed              : 是否结账:1-是,0-否
--   account_status         : 账户状态:0-正常,1-冻结,2-停用
--   budget_amount          : 预算金额
--   budget_period          : 预算周期
--   max_limit              : 最大限额
--   min_authorized         : 最小授权额
--   min_expected           : 最小预期额
--   class_type             : 类别
--   identification         : 标识
--   is_tax_related         : 是否关联税务:1-是,0-否
--   tax_key_record         : 税务键记录
--   tax_type               : 税务类型
--   currency_id            : 货币记录
--   currency_rate          : 汇率
--   is_expanded            : 是否展开:1-是,0-否
--   is_balance_up_to_date  : 余额是否最新:1-是,0-否
--   balance_total_all      : 总余额
--   balance_total_rec      : 对账总额
--   balance_trans_qty      : 交易数量
--   is_limit_warning       : 是否限额警告:1-是,0-否
--   limit_when_at          : 限额触发条件
--   limit_period           : 限额周期
--   is_deductible          : 是否可抵扣:1-是,0-否
--   created_by             : 创建人
--   created_time           : 创建时间
--   updated_by             : 更新人
--   updated_time           : 修改时间
--   deleted_by             : 删除人
--   deleted_time           : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "account" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    account_name VARCHAR(64) NOT NULL,
    account_type_id TINYINT NOT NULL,
    account_category_id TINYINT NOT NULL,
    memo VARCHAR(128) NOT NULL DEFAULT '',
    balance DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    reconciled DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    opening DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    closing DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    incoming DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    outgoing DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    is_enabled TINYINT NOT NULL DEFAULT 1,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    is_closed TINYINT NOT NULL DEFAULT 0,
    account_status TINYINT NOT NULL DEFAULT 0,
    budget_amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    budget_period TINYINT NOT NULL DEFAULT 0,
    max_limit DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    min_authorized DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    min_expected DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    class_type TINYINT NOT NULL DEFAULT 0,
    identification TINYINT NOT NULL DEFAULT 0,
    is_tax_related TINYINT NOT NULL DEFAULT 0,
    tax_key_record INTEGER NOT NULL DEFAULT 0,
    tax_type TINYINT NOT NULL DEFAULT 0,
    currency_id INTEGER NOT NULL DEFAULT 0,
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    is_balance_up_to_date TINYINT NOT NULL DEFAULT 0,
    balance_total_all DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    balance_total_rec DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    balance_trans_qty INTEGER NOT NULL DEFAULT 0,
    is_limit_warning TINYINT NOT NULL DEFAULT 0,
    limit_when_at TINYINT NOT NULL DEFAULT 0,
    limit_period TINYINT NOT NULL DEFAULT 0,
    is_deductible TINYINT NOT NULL DEFAULT 0,
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,    
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_account_account_name ON account(account_name);
CREATE INDEX idx_account_account_category_id ON account(account_category_id);
CREATE INDEX idx_account_is_enabled ON account(is_enabled);
CREATE INDEX idx_account_account_status ON account(account_status);
CREATE INDEX idx_account_deleted_time ON account(deleted_time);


-- =====================================================
-- 09. 交易类型表 
-- 字段说明:
--   id                    : 主键ID
--   type_name             : 交易类型名称
--   trans_type_category_id: 交易分类ID
--   balance               : 余额
--   internal_amount       : 内部金额
--   is_enabled            : 是否启用:1-是,0-否
--   is_deleted            : 是否删除:1-是,0-否
--   trans_type_status     : 交易类型状态:0-正常,1-禁用
--   is_expanded           : 是否展开:1-是,0-否
--   created_by            : 创建人
--   created_time          : 创建时间
--   updated_by            : 更新人
--   updated_time          : 修改时间
--   deleted_by            : 删除人
--   deleted_time          : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "trans_type" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type_name VARCHAR(64) NOT NULL,
    trans_type_category_id INTEGER NOT NULL,
    balance DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    internal_amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    is_enabled TINYINT NOT NULL DEFAULT 1,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    trans_type_status TINYINT NOT NULL DEFAULT 0,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,    
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_trans_type_type_name ON trans_type(type_name);
CREATE INDEX idx_trans_type_trans_type_status ON trans_type(trans_type_status);
CREATE INDEX idx_trans_type_deleted_time ON trans_type(deleted_time);
CREATE INDEX idx_trans_type_trans_type_category_id ON trans_type(trans_type_category_id);


-- =====================================================
-- 10. 明细表
-- 字段说明:
--   id               : 主键ID
--   linked_to_table  : 关联表名
--   linked_to_record : 关联记录ID
--   quantity         : 数量
--   reference_no     : 参考号
--   description      : 描述
--   amount           : 金额
--   discount         : 折扣
--   currency_id      : 货币记录
--   currency_rate    : 汇率
--   is_enabled       : 是否启用:1-是,0-否
--   is_deleted       : 是否删除:1-是,0-否
--   detail_status    : 明细状态:0-正常,1-异常
--   is_expanded      : 是否展开:1-是,0-否
--   created_by       : 创建人
--   created_time     : 创建时间
--   updated_by       : 更新人
--   updated_time     : 修改时间
--   deleted_by       : 删除人
--   deleted_time     : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "detail" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    linked_to_table VARCHAR(32) NOT NULL,
    linked_to_record INTEGER NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 1,
    reference_no VARCHAR(32) NOT NULL DEFAULT '',
    description VARCHAR(128) NOT NULL DEFAULT '',
    amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    discount DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    currency_id INTEGER NOT NULL DEFAULT 0,
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000,
    is_enabled TINYINT NOT NULL DEFAULT 1,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    detail_status TINYINT NOT NULL DEFAULT 0,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,       
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_detail_linked ON detail(linked_to_table, linked_to_record);
CREATE INDEX idx_detail_detail_status ON detail(detail_status);
CREATE INDEX idx_detail_deleted_time ON detail(deleted_time);


-- =====================================================
-- 11. 税务表
-- 字段说明:
--   id               : 主键ID
--   tax_key          : 税务键(业务唯一标识)
--   linked_to_table  : 关联表名
--   linked_to_record : 关联记录ID
--   tax_type         : 税务类型
--   tax_value        : 税额
--   percentage       : 百分比
--   tax_category     : 税务类别
--   account_id       : 账户ID
--   memo             : 备注
--   is_enabled       : 是否启用:1-是,0-否
--   is_deleted       : 是否删除:1-是,0-否
--   tax_status       : 税务状态:0-正常,1-停用
--   is_expanded      : 是否展开:1-是,0-否
--   created_by       : 创建人
--   created_time     : 创建时间
--   updated_by       : 更新人
--   updated_time     : 修改时间
--   deleted_by       : 删除人
--   deleted_time     : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "tax" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tax_key VARCHAR(64) NOT NULL,
    linked_to_table VARCHAR(32) NOT NULL,
    linked_to_record INTEGER NOT NULL,
    tax_type TINYINT NOT NULL,
    tax_value DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    percentage DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    tax_category TINYINT NOT NULL DEFAULT 0,
    account_id INTEGER NOT NULL DEFAULT 0,
    memo VARCHAR(128) NOT NULL DEFAULT '',
    is_enabled TINYINT NOT NULL DEFAULT 1,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    tax_status TINYINT NOT NULL DEFAULT 0,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,       
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_tax_tax_key ON tax(tax_key);
CREATE INDEX idx_tax_linked ON tax(linked_to_table, linked_to_record);
CREATE INDEX idx_tax_tax_status ON tax(tax_status);
CREATE INDEX idx_tax_deleted_time ON tax(deleted_time);


-- =====================================================
-- 12. 备忘录表 
-- 字段说明:
--   id               : 主键ID
--   memo_key         : 键名
--   memo_type        : 备忘录类型
--   linked_to_table  : 关联表名
--   linked_to_record : 关联记录ID
--   memo_text        : 文本内容
--   is_enabled       : 是否启用:1-是,0-否
--   is_deleted       : 是否删除:1-是,0-否
--   memo_status      : 备忘录状态:0-正常,1-归档
--   is_expanded      : 是否展开:1-是,0-否
--   created_by       : 创建人
--   created_time     : 创建时间
--   updated_by       : 更新人
--   updated_time     : 修改时间
--   deleted_by       : 删除人
--   deleted_time     : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "memo" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    memo_key VARCHAR(64) NOT NULL,
    memo_type TINYINT NOT NULL,
    linked_to_table VARCHAR(32) NOT NULL,
    linked_to_record INTEGER NOT NULL,
    memo_text TEXT,
    is_enabled TINYINT NOT NULL DEFAULT 1,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    memo_status TINYINT NOT NULL DEFAULT 0,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,       
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_memo_memo_key ON memo(memo_key);
CREATE INDEX idx_memo_linked ON memo(linked_to_table, linked_to_record);
CREATE INDEX idx_memo_deleted_time ON memo(deleted_time);

-- =====================================================
-- 13. 收藏表 
-- 字段说明:
--   id                 : 主键ID
--   favorite_name      : 收藏名称
--   favorite_type      : 收藏类型
--   account_debited    : 借方账户
--   account_credited   : 贷方账户
--   amount             : 金额
--   memo               : 备注
--   is_auto_reconcile  : 是否自动对账:1-是,0-否
--   currency_id        : 货币记录
--   currency_rate      : 汇率
--   is_enabled         : 是否启用:1-是,0-否
--   is_deleted         : 是否删除:1-是,0-否
--   is_checked         : 是否核对:1-是,0-否
--   favorite_status    : 收藏状态:0-正常,1-停用
--   is_expanded        : 是否展开:1-是,0-否
--   type_ref           : 类型参考
--   group_id           : 组ID
--   issuing            : 发行
--   project            : 项目
--   created_by         : 创建人
--   created_time       : 创建时间
--   updated_by         : 更新人
--   updated_time       : 修改时间
--   deleted_by         : 删除人
--   deleted_time       : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "favorite" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    favorite_name VARCHAR(64) NOT NULL,
    favorite_type INTEGER NOT NULL,
    account_debited INTEGER NOT NULL,
    account_credited INTEGER NOT NULL,
    amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    memo VARCHAR(128) NOT NULL DEFAULT '',
    is_auto_reconcile TINYINT NOT NULL DEFAULT 0,
    currency_id INTEGER NOT NULL DEFAULT 0,
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000,
    is_enabled TINYINT NOT NULL DEFAULT 1,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    is_checked TINYINT NOT NULL DEFAULT 0,
    favorite_status TINYINT NOT NULL DEFAULT 0,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    type_ref VARCHAR(32) NOT NULL DEFAULT '',
    group_id INTEGER NOT NULL DEFAULT 0,
    issuing INTEGER NOT NULL DEFAULT 0,
    project VARCHAR(64) NOT NULL DEFAULT '',
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,       
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_favorite_favorite_name ON favorite(favorite_name);
CREATE INDEX idx_favorite_favorite_status ON favorite(favorite_status);
CREATE INDEX idx_favorite_deleted_time ON favorite(deleted_time);


-- =====================================================
-- 14. 物品表
-- 字段说明:
--   id                  : 主键ID
--   linked_to_table     : 关联表名
--   linked_to_record    : 关联记录ID
--   reference_no        : 参考号
--   description         : 描述
--   price               : 价格
--   discount            : 折扣
--   cost                : 成本
--   currency_id         : 货币记录
--   currency_rate       : 汇率
--   item_type           : 物品类型
--   account_category_id : 分类ID
--   class_type          : 类别
--   identification      : 标识
--   tax_key_record      : 税务键记录
--   is_enabled          : 是否启用:1-是,0-否
--   is_deleted          : 是否删除:1-是,0-否
--   item_status         : 物品状态:0-正常,1-下架,2-缺货
--   is_expanded         : 是否展开:1-是,0-否
--   created_by          : 创建人
--   created_time        : 创建时间
--   updated_by          : 更新人
--   updated_time        : 修改时间
--   deleted_by          : 删除人
--   deleted_time        : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "item" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    linked_to_table VARCHAR(32) NOT NULL,
    linked_to_record INTEGER NOT NULL,
    reference_no VARCHAR(32) NOT NULL DEFAULT '',
    description VARCHAR(128) NOT NULL DEFAULT '',
    price DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    discount DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    cost DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    currency_id INTEGER NOT NULL DEFAULT 0,
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000,
    item_type INTEGER NOT NULL,
    account_category_id INTEGER NOT NULL,
    class_type TINYINT NOT NULL DEFAULT 0,
    identification TINYINT NOT NULL DEFAULT 0,
    tax_key_record INTEGER NOT NULL DEFAULT 0,
    is_enabled TINYINT NOT NULL DEFAULT 1,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    item_status TINYINT NOT NULL DEFAULT 0,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,       
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_item_linked ON item(linked_to_table, linked_to_record);
CREATE INDEX idx_item_account_category_id ON item(account_category_id);
CREATE INDEX idx_item_item_status ON item(item_status);
CREATE INDEX idx_item_deleted_time ON item(deleted_time);


-- =====================================================
-- 15. 银行表
-- 字段说明:
--   id               : 主键ID
--   bank_name        : 银行名称
--   linked_to_table  : 关联表名
--   linked_to_record : 关联记录ID
--   bank_type        : 银行类型
--   swiftcode        : SWIFT代码
--   account_number   : 账号
--   iban             : IBAN国际银行账号
--   currency_id      : 货币记录
--   currency_rate    : 汇率
--   street           : 街道
--   suburb           : 郊区/区
--   city             : 城市
--   state            : 州/省
--   zip              : 邮编
--   country          : 国家
--   phone            : 电话
--   mobile           : 手机
--   fax              : 传真
--   email            : 邮箱
--   web              : 网站
--   memo             : 备注
--   is_enabled       : 是否启用:1-是,0-否
--   is_deleted       : 是否删除:1-是,0-否
--   bank_status      : 银行状态:0-正常,1-停用
--   class_type       : 类别
--   identification   : 标识
--   tax_key_record   : 税务键记录
--   is_expanded      : 是否展开:1-是,0-否
--   created_by       : 创建人
--   created_time     : 创建时间
--   updated_by       : 更新人
--   updated_time     : 修改时间
--   deleted_by       : 删除人
--   deleted_time     : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "bank" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    bank_name VARCHAR(128) NOT NULL,
    linked_to_table VARCHAR(32) NOT NULL,
    linked_to_record INTEGER NOT NULL,
    bank_type TINYINT NOT NULL,
    swiftcode VARCHAR(32) NOT NULL DEFAULT '',
    account_number VARCHAR(64) NOT NULL DEFAULT '',
    iban VARCHAR(64) NOT NULL DEFAULT '',
    currency_id INTEGER NOT NULL DEFAULT 0,
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000,
    street VARCHAR(256) NOT NULL DEFAULT '',
    suburb VARCHAR(128) NOT NULL DEFAULT '',
    city VARCHAR(128) NOT NULL DEFAULT '',
    state VARCHAR(128) NOT NULL DEFAULT '',
    zip VARCHAR(32) NOT NULL DEFAULT '',
    country VARCHAR(128) NOT NULL DEFAULT '',
    phone VARCHAR(64) NOT NULL DEFAULT '',
    mobile VARCHAR(64) NOT NULL DEFAULT '',
    fax VARCHAR(64) NOT NULL DEFAULT '',
    email VARCHAR(128) NOT NULL DEFAULT '',
    web VARCHAR(128) NOT NULL DEFAULT '',
    memo VARCHAR(256) NOT NULL DEFAULT '',
    is_enabled TINYINT NOT NULL DEFAULT 1,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    bank_status TINYINT NOT NULL DEFAULT 0,
    class_type TINYINT NOT NULL DEFAULT 0,
    identification TINYINT NOT NULL DEFAULT 0,
    tax_key_record INTEGER NOT NULL DEFAULT 0,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,       
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_bank_bank_name ON bank(bank_name);
CREATE INDEX idx_bank_swiftcode ON bank(swiftcode);
CREATE INDEX idx_bank_bank_status ON bank(bank_status);
CREATE INDEX idx_bank_deleted_time ON bank(deleted_time);


-- =====================================================
-- 16. 预设表
-- 字段说明:
--   id            : 主键ID
--   preset_name   : 预设名称
--   preset_type   : 预设类型
--   value         : 预设值
--   is_enabled    : 是否启用:1-是,0-否
--   is_deleted    : 是否删除:1-是,0-否
--   preset_status : 预设状态:0-正常,1-禁用
--   is_expanded   : 是否展开:1-是,0-否
--   created_by    : 创建人
--   created_time  : 创建时间
--   updated_by    : 更新人
--   updated_time  : 修改时间
--   deleted_by    : 删除人
--   deleted_time  : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "preset" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    preset_name VARCHAR(64) NOT NULL,
    preset_type VARCHAR(64) NOT NULL,
    value VARCHAR(256) NOT NULL DEFAULT '',
    is_enabled TINYINT NOT NULL DEFAULT 1,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    preset_status TINYINT NOT NULL DEFAULT 0,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,       
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_preset_preset_name ON preset(preset_name);
CREATE INDEX idx_preset_preset_type ON preset(preset_type);
CREATE INDEX idx_preset_deleted_time ON preset(deleted_time);


-- =====================================================
-- 17. 计划任务表
-- 字段说明:
--   id                               : 主键ID
--   scheduling_type                  : 计划类型
--   account_debited                  : 借方账户
--   account_credited                 : 贷方账户
--   amount                           : 金额
--   memo                             : 备注
--   issuing                          : 发行
--   is_auto_reconcile                : 是否自动对账:1-是,0-否
--   currency_id                      : 货币记录
--   currency_rate                    : 汇率
--   start_date                       : 开始日期
--   end_date                         : 结束日期
--   period                           : 周期
--   schedule_count                   : 执行次数
--   ending                           : 结束方式
--   next_date                        : 下次执行日期
--   last_date                        : 上次执行日期
--   scheduling_day                   : 日
--   scheduling_month                 : 月
--   scheduling_year                  : 年
--   is_enabled                       : 是否启用:1-是,0-否
--   is_deleted                       : 是否删除:1-是,0-否
--   is_checked                       : 是否核对:1-是,0-否
--   schedule_status                  : 计划状态:0-待执行,1-执行中,2-已完成,3-已取消
--   is_expanded                      : 是否展开:1-是,0-否
--   is_budget                        : 是否预算:1-是,0-否
--   project                          : 项目
--   is_delete_when_done              : 完成后是否删除:1-是,0-否
--   tax_type                         : 税务类型
--   tax_amount                       : 税额
--   tax_rate                         : 税率
--   amount_variation                 : 金额变化
--   is_amount_variation_percentage   : 金额变化是否为百分比:1-是,0-否
--   amount_variation_direction       : 金额变化方向
--   amount_last                      : 上次金额
--   amount_list                      : 金额列表(超长字段)
--   amount_list_pointer              : 金额列表指针
--   is_end_of_month                  : 是否月末:1-是,0-否
--   created_by                       : 创建人
--   created_time                     : 创建时间
--   updated_by                       : 更新人
--   updated_time                     : 修改时间
--   deleted_by                       : 删除人
--   deleted_time                     : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "scheduling" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    scheduling_type INTEGER NOT NULL,
    account_debited INTEGER NOT NULL,
    account_credited INTEGER NOT NULL,
    amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    memo VARCHAR(128) NOT NULL DEFAULT '',
    issuing INTEGER NOT NULL DEFAULT 0,
    is_auto_reconcile TINYINT NOT NULL DEFAULT 0,
    currency_id INTEGER NOT NULL DEFAULT 0,
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    period TINYINT NOT NULL,
    schedule_count INTEGER NOT NULL DEFAULT 0,
    ending TINYINT NOT NULL DEFAULT 0,
    next_date DATE NOT NULL,
    last_date DATE NOT NULL,
    scheduling_day INTEGER NOT NULL,
    scheduling_month INTEGER NOT NULL,
    scheduling_year INTEGER NOT NULL,
    is_enabled TINYINT NOT NULL DEFAULT 1,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    is_checked TINYINT NOT NULL DEFAULT 0,
    schedule_status TINYINT NOT NULL DEFAULT 0,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    is_budget TINYINT NOT NULL DEFAULT 0,
    project VARCHAR(64) NOT NULL DEFAULT '',
    is_delete_when_done TINYINT NOT NULL DEFAULT 0,
    tax_type TINYINT NOT NULL DEFAULT 0,
    tax_amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    tax_rate DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    amount_variation DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    is_amount_variation_percentage TINYINT NOT NULL DEFAULT 0,
    amount_variation_direction TINYINT NOT NULL DEFAULT 0,
    amount_last DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    amount_list TEXT,
    amount_list_pointer INTEGER NOT NULL DEFAULT 0,
    is_end_of_month TINYINT NOT NULL DEFAULT 0,
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,       
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_scheduling_next_date ON scheduling(next_date);
CREATE INDEX idx_scheduling_schedule_status ON scheduling(schedule_status);
CREATE INDEX idx_scheduling_is_enabled ON scheduling(is_enabled);
CREATE INDEX idx_scheduling_deleted_time ON scheduling(deleted_time);


-- =====================================================
-- 18. 投资组合表 
-- 字段说明:
--   id               : 主键ID
--   portfolio_type   : 投资类型
--   linked_to_table  : 关联表名
--   linked_to_record : 关联记录ID
--   symbol_code      : 股票代码
--   description      : 描述
--   trans_type       : 交易类型
--   purchase_date    : 购买日期
--   purchase_shares  : 购买股数
--   purchase_price   : 购买价格
--   entry_commission : 买入佣金
--   sales_date       : 卖出日期
--   sales_shares     : 卖出股数
--   sales_price      : 卖出价格
--   exit_commission  : 卖出佣金
--   currency_id      : 货币记录
--   currency_rate    : 汇率
--   class_type       : 类别
--   identification   : 标识
--   is_enabled       : 是否启用:1-是,0-否
--   is_deleted       : 是否删除:1-是,0-否
--   portfolio_status : 投资状态:0-持有,1-已卖出,2-已平仓
--   is_expanded      : 是否展开:1-是,0-否
--   created_by       : 创建人
--   created_time     : 创建时间
--   updated_by       : 更新人
--   updated_time     : 修改时间
--   deleted_by       : 删除人
--   deleted_time     : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "portfolio" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    portfolio_type TINYINT NOT NULL,
    linked_to_table VARCHAR(32) NOT NULL,
    linked_to_record INTEGER NOT NULL,
    symbol_code VARCHAR(32) NOT NULL,
    description VARCHAR(128) NOT NULL DEFAULT '',
    trans_type TINYINT NOT NULL,
    purchase_date DATE NOT NULL,
    purchase_shares INTEGER NOT NULL DEFAULT 0,
    purchase_price DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    entry_commission DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    sales_date DATE NOT NULL,
    sales_shares INTEGER NOT NULL DEFAULT 0,
    sales_price DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    exit_commission DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    currency_id INTEGER NOT NULL DEFAULT 0,
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000,
    class_type TINYINT NOT NULL DEFAULT 0,
    identification TINYINT NOT NULL DEFAULT 0,
    is_enabled TINYINT NOT NULL DEFAULT 1,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    portfolio_status TINYINT NOT NULL DEFAULT 0,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,       
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_portfolio_symbol_code ON portfolio(symbol_code);
CREATE INDEX idx_portfolio_linked ON portfolio(linked_to_table, linked_to_record);
CREATE INDEX idx_portfolio_portfolio_status ON portfolio(portfolio_status);
CREATE INDEX idx_portfolio_deleted_time ON portfolio(deleted_time);


-- =====================================================
-- 19. 行情表
-- 字段说明:
--   id             : 主键ID
--   symbol_code    : 股票代码
--   description    : 描述
--   quote_date     : 行情日期
--   open_price     : 开盘价
--   high_price     : 最高价
--   low_price      : 最低价
--   close_price    : 收盘价
--   volume         : 成交量
--   quote_day      : 日
--   quote_month    : 月
--   quote_year     : 年
--   currency_id    : 货币记录
--   currency_rate  : 汇率
--   class_type     : 类别
--   identification : 标识
--   is_enabled     : 是否启用:1-是,0-否
--   is_deleted     : 是否删除:1-是,0-否
--   quote_status   : 行情状态:0-正常,1-停用
--   is_expanded    : 是否展开:1-是,0-否
--   created_by     : 创建人
--   created_time   : 创建时间
--   updated_by     : 更新人
--   updated_time   : 修改时间
--   deleted_by     : 删除人
--   deleted_time   : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "quote" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    symbol_code VARCHAR(32) NOT NULL,
    description VARCHAR(128) NOT NULL DEFAULT '',
    quote_date DATE NOT NULL,
    open_price DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    high_price DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    low_price DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    close_price DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    volume INTEGER NOT NULL DEFAULT 0,
    quote_day INTEGER NOT NULL,
    quote_month INTEGER NOT NULL,
    quote_year INTEGER NOT NULL,
    currency_id INTEGER NOT NULL DEFAULT 0,
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000,
    class_type TINYINT NOT NULL DEFAULT 0,
    identification TINYINT NOT NULL DEFAULT 0,
    is_enabled TINYINT NOT NULL DEFAULT 1,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    quote_status TINYINT NOT NULL DEFAULT 0,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,       
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_quote_symbol_code ON quote(symbol_code);
CREATE INDEX idx_quote_quote_date ON quote(quote_date);
CREATE INDEX idx_quote_symbol_date ON quote(symbol_code, quote_date);
CREATE INDEX idx_quote_deleted_time ON quote(deleted_time);


-- =====================================================
-- 20. 贷款表
-- 字段说明:
--   id               : 主键ID
--   loan_name        : 贷款名称
--   memo             : 备注
--   linked_to_table  : 关联表名
--   linked_to_record : 关联记录ID
--   amount           : 贷款金额
--   loan_length      : 贷款期限
--   period           : 周期
--   rate             : 利率
--   loan_type        : 贷款类型
--   compounding      : 复利方式
--   start_date       : 开始日期
--   end_date         : 结束日期
--   period_begin_end : 周期起止
--   currency_id      : 货币记录
--   currency_rate    : 汇率
--   class_type       : 类别
--   identification   : 标识
--   is_enabled       : 是否启用:1-是,0-否
--   is_deleted       : 是否删除:1-是,0-否
--   loan_status      : 贷款状态:0-正常还款,1-逾期,2-已结清
--   is_expanded      : 是否展开:1-是,0-否
--   created_by       : 创建人
--   created_time     : 创建时间
--   updated_by       : 更新人
--   updated_time     : 修改时间
--   deleted_by       : 删除人
--   deleted_time     : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "loan" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    loan_name VARCHAR(64) NOT NULL,
    memo VARCHAR(256) NOT NULL DEFAULT '',
    linked_to_table VARCHAR(32) NOT NULL,
    linked_to_record INTEGER NOT NULL,
    amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    loan_length DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    period TINYINT NOT NULL,
    rate DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    loan_type TINYINT NOT NULL,
    compounding TINYINT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    period_begin_end TINYINT NOT NULL,
    currency_id INTEGER NOT NULL DEFAULT 0,
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000,
    class_type TINYINT NOT NULL DEFAULT 0,
    identification TINYINT NOT NULL DEFAULT 0,
    is_enabled TINYINT NOT NULL DEFAULT 1,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    loan_status TINYINT NOT NULL DEFAULT 0,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,       
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_loan_loan_name ON loan(loan_name);
CREATE INDEX idx_loan_loan_status ON loan(loan_status);
CREATE INDEX idx_loan_start_date ON loan(start_date);
CREATE INDEX idx_loan_deleted_time ON loan(deleted_time);


-- =====================================================
-- 21. 交易组表
-- 字段说明:
--   id                  : 主键ID
--   group_type          : 组类型
--   account_debited     : 借方账户
--   account_credited    : 贷方账户
--   amount              : 金额
--   memo                : 备注
--   is_checked          : 是否核对:1-是,0-否
--   is_detailed         : 是否详细:1-是,0-否
--   is_enabled          : 是否启用:1-是,0-否
--   is_deleted          : 是否删除:1-是,0-否
--   group_status        : 交易组状态:0-正常,1-已处理
--   is_expanded         : 是否展开:1-是,0-否
--   group_date_day      : 日
--   group_date_month    : 月
--   group_date_year     : 年
--   group_date          : 组日期
--   type_ref            : 类型参考
--   account_debited_alt : 备选借方账户
--   account_credited_alt: 备选贷方账户
--   created_by          : 创建人
--   created_time        : 创建时间
--   updated_by          : 更新人
--   updated_time        : 修改时间
--   deleted_by          : 删除人
--   deleted_time        : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "trans_group" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    group_type INTEGER NOT NULL,
    account_debited INTEGER NOT NULL,
    account_credited INTEGER NOT NULL,
    amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    memo VARCHAR(128) NOT NULL DEFAULT '',
    is_checked TINYINT NOT NULL DEFAULT 0,
    is_detailed TINYINT NOT NULL DEFAULT 0,
    is_enabled TINYINT NOT NULL DEFAULT 1,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    group_status TINYINT NOT NULL DEFAULT 0,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    group_date_day INTEGER NOT NULL,
    group_date_month INTEGER NOT NULL,
    group_date_year INTEGER NOT NULL,
    group_date DATE NOT NULL,
    type_ref VARCHAR(32) NOT NULL DEFAULT '',
    account_debited_alt VARCHAR(64) NOT NULL DEFAULT '',
    account_credited_alt VARCHAR(64) NOT NULL DEFAULT '',
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,       
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_trans_group_group_date ON trans_group(group_date);
CREATE INDEX idx_trans_group_group_status ON trans_group(group_status);
CREATE INDEX idx_trans_group_deleted_time ON trans_group(deleted_time);

-- =====================================================
-- 22. 交易表
-- 字段说明:
--   id                      : 主键ID
--   reference_no            : 参考号
--   trans_day               : 日
--   trans_month             : 月
--   trans_year              : 年
--   trans_date              : 交易日期
--   trans_type_id           : 交易类型ID
--   account_debited         : 借方账户
--   account_credited        : 贷方账户
--   account_debited_type    : 借方账户类型
--   account_credited_type   : 贷方账户类型
--   account_debited_category: 借方账户分类
--   account_credited_category: 贷方账户分类
--   amount                  : 金额
--   memo                    : 备注
--   invoice_num             : 发票号
--   issuing                 : 发行
--   is_enabled              : 是否启用:1-是,0-否
--   is_deleted              : 是否删除:1-是,0-否
--   is_checked              : 是否核对:1-是,0-否
--   trans_status            : 交易状态:0-待处理,1-已完成,2-已取消,3-异常
--   is_expanded             : 是否展开:1-是,0-否
--   is_detailed             : 是否详细:1-是,0-否
--   tax_type                : 税务类型
--   tax_amount              : 税额
--   tax_rate                : 税率
--   link_to_trans           : 关联交易
--   currency_id             : 货币记录
--   currency_rate           : 汇率
--   is_hold                 : 是否挂起:1-是,0-否
--   term_date               : 到期日
--   type_ref                : 类型参考
--   group_id                : 组ID
--   project                 : 项目
--   currency_to_def_rate    : 默认汇率
--   currency_direction1     : 货币方向1
--   currency_direction2     : 货币方向2
--   attachment_name         : 附件名称
--   attachment_type         : 附件类型
--   attachment_mac_info     : 附件MAC信息
--   is_flagged              : 是否标记:1-是,0-否
--   is_deductible           : 是否可抵扣:1-是,0-否
--   created_by              : 创建人
--   created_time            : 创建时间
--   updated_by              : 更新人
--   updated_time            : 修改时间
--   deleted_by              : 删除人
--   deleted_time            : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "trans" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    reference_no INTEGER NOT NULL,
    trans_day INTEGER NOT NULL,
    trans_month INTEGER NOT NULL,
    trans_year INTEGER NOT NULL,
    trans_date DATE NOT NULL,
    trans_type_id INTEGER NOT NULL,
    account_debited INTEGER NOT NULL,
    account_credited INTEGER NOT NULL,
    account_debited_type INTEGER NOT NULL,
    account_credited_type INTEGER NOT NULL,
    account_debited_category INTEGER NOT NULL,
    account_credited_category INTEGER NOT NULL,
    amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    memo VARCHAR(128) NOT NULL DEFAULT '',
    invoice_num VARCHAR(32) NOT NULL DEFAULT '',
    issuing INTEGER NOT NULL DEFAULT 0,
    is_enabled TINYINT NOT NULL DEFAULT 1,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    is_checked TINYINT NOT NULL DEFAULT 0,
    trans_status TINYINT NOT NULL DEFAULT 0,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    is_detailed TINYINT NOT NULL DEFAULT 0,
    tax_type TINYINT NOT NULL DEFAULT 0,
    tax_amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    tax_rate DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    link_to_trans INTEGER NOT NULL DEFAULT 0,
    currency_id INTEGER NOT NULL DEFAULT 0,
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000,
    is_hold TINYINT NOT NULL DEFAULT 0,
    term_date DATE,
    type_ref VARCHAR(32) NOT NULL DEFAULT '',
    group_id INTEGER NOT NULL DEFAULT 0,
    project VARCHAR(64) NOT NULL DEFAULT '',
    currency_to_def_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000,
    currency_direction1 TINYINT NOT NULL DEFAULT 0,
    currency_direction2 TINYINT NOT NULL DEFAULT 0,
    attachment_name VARCHAR(128) NOT NULL DEFAULT '',
    attachment_type VARCHAR(32) NOT NULL DEFAULT '',
    attachment_mac_info VARCHAR(10) NOT NULL DEFAULT '',
    is_flagged TINYINT NOT NULL DEFAULT 0,
    is_deductible TINYINT NOT NULL DEFAULT 0,
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,       
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_trans_trans_date ON trans(trans_date);
CREATE INDEX idx_trans_trans_type_id ON trans(trans_type_id);
CREATE INDEX idx_trans_account_debited ON trans(account_debited);
CREATE INDEX idx_trans_account_credited ON trans(account_credited);
CREATE INDEX idx_trans_trans_status ON trans(trans_status);
CREATE INDEX idx_trans_memo ON trans(memo);
CREATE INDEX idx_trans_deleted_time ON trans(deleted_time);


-- =====================================================
-- 23. 预算表
-- 字段说明:
--   id                     : 主键ID
--   budget_name            : 预算名称
--   is_expenses_expanded   : 费用是否展开:1-是,0-否
--   is_incomes_expanded    : 收入是否展开:1-是,0-否
--   is_expenses_enabled    : 费用是否启用:1-是,0-否
--   is_incomes_enabled     : 收入是否启用:1-是,0-否
--   is_compare_enabled     : 是否启用对比:1-是,0-否
--   compare_period         : 对比周期
--   compare_from_date      : 对比开始日期
--   compare_to_date        : 对比结束日期
--   is_liabilities_expanded: 负债是否展开:1-是,0-否
--   is_liabilities_enabled : 负债是否启用:1-是,0-否
--   expenses_memo          : 费用备注
--   incomes_memo           : 收入备注
--   liabilities_memo       : 负债备注
--   created_by             : 创建人
--   created_time           : 创建时间
--   updated_by             : 更新人
--   updated_time           : 修改时间
--   deleted_by             : 删除人
--   deleted_time           : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "budget" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    budget_name VARCHAR(64) NOT NULL,
    is_expenses_expanded TINYINT NOT NULL DEFAULT 0,
    is_incomes_expanded TINYINT NOT NULL DEFAULT 0,
    is_expenses_enabled TINYINT NOT NULL DEFAULT 1,
    is_incomes_enabled TINYINT NOT NULL DEFAULT 1,
    is_compare_enabled TINYINT NOT NULL DEFAULT 0,
    compare_period TINYINT NOT NULL DEFAULT 0,
    compare_from_date DATE NOT NULL,
    compare_to_date DATE NOT NULL,
    is_liabilities_expanded TINYINT NOT NULL DEFAULT 0,
    is_liabilities_enabled TINYINT NOT NULL DEFAULT 1,
    expenses_memo VARCHAR(128) NOT NULL DEFAULT '',
    incomes_memo VARCHAR(128) NOT NULL DEFAULT '',
    liabilities_memo VARCHAR(128) NOT NULL DEFAULT '',
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,       
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_budget_budget_name ON budget(budget_name);
CREATE INDEX idx_budget_deleted_time ON budget(deleted_time);


-- =====================================================
-- 24. 预算分类关联表
-- 字段说明:
--   id                  : 主键ID
--   budget_id           : 预算ID
--   account_category_id : 分类ID
--   is_expanded         : 是否展开:1-是,0-否
--   is_enabled          : 是否启用:1-是,0-否
--   memo                : 备注
--   created_by          : 创建人
--   created_time        : 创建时间
--   updated_by          : 更新人
--   updated_time        : 修改时间
--   deleted_by          : 删除人
--   deleted_time        : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "budget_category" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    budget_id INTEGER NOT NULL,
    account_category_id INTEGER NOT NULL,
    is_expanded TINYINT NOT NULL DEFAULT 0,
    is_enabled TINYINT NOT NULL DEFAULT 1,
    memo VARCHAR(128) NOT NULL DEFAULT '',
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,       
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_budget_category_budget_id ON budget_category(budget_id);
CREATE INDEX idx_budget_category_account_category_id ON budget_category(account_category_id);
CREATE UNIQUE INDEX uk_budget_category_budget_category ON budget_category(budget_id, account_category_id);
CREATE INDEX idx_budget_category_deleted_time ON budget_category(deleted_time);


-- =====================================================
-- 25. 预算账户关联表 
-- 字段说明:
--   id              : 主键ID
--   budget_id       : 预算ID
--   account_id      : 账户ID
--   amount          : 金额
--   interval_period : 间隔周期
--   is_enabled      : 是否启用:1-是,0-否
--   memo            : 备注
--   created_by      : 创建人
--   created_time    : 创建时间
--   updated_by      : 更新人
--   updated_time    : 修改时间
--   deleted_by      : 删除人
--   deleted_time    : 删除时间
-- =====================================================
CREATE TABLE IF NOT EXISTS "budget_account" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    budget_id INTEGER NOT NULL,
    account_id INTEGER NOT NULL,
    amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    interval_period TINYINT NOT NULL,
    is_enabled TINYINT NOT NULL DEFAULT 1,
    memo VARCHAR(128) NOT NULL DEFAULT '',
    created_by VARCHAR(64) NOT NULL DEFAULT '',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(64) DEFAULT NULL,
    updated_time TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(64) DEFAULT '',
    created_by_name VARCHAR(64) NOT NULL DEFAULT '',
    deleted_by_name VARCHAR(64)  DEFAULT NULL,
    updated_by_name VARCHAR(64)  DEFAULT NULL,       
    deleted_time TIMESTAMP DEFAULT NULL
);

CREATE INDEX idx_budget_account_budget_id ON budget_account(budget_id);
CREATE INDEX idx_budget_account_account_id ON budget_account(account_id);
CREATE UNIQUE INDEX uk_budget_account_budget_account ON budget_account(budget_id, account_id);
CREATE INDEX idx_budget_account_deleted_time ON budget_account(deleted_time);