-- =====================================================
-- 数据库设置
-- =====================================================
PRAGMA case_sensitive_like = false;
PRAGMA encoding = 'UTF-16';
PRAGMA page_size = 32768;


-- =====================================================
-- 01. 项目表
-- =====================================================
CREATE TABLE "project" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    project_name VARCHAR(128) NOT NULL COMMENT '项目名称',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_project_name ON project(project_name);
CREATE INDEX idx_is_enabled ON project(is_enabled);
CREATE INDEX idx_deleted_time ON project(deleted_time);


-- =====================================================
-- 02. 联系人类型表 
-- =====================================================
CREATE TABLE "contact_type" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    type_name VARCHAR(64) NOT NULL COMMENT '联系人类型名称',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_type_name ON contact_type(type_name);
CREATE INDEX idx_deleted_time ON contact_type(deleted_time);

-- =====================================================
-- 03. 联系人表
-- =====================================================
CREATE TABLE "contact" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    contact_name VARCHAR(128) NOT NULL COMMENT '联系人姓名',
    linked_to_table VARCHAR(32) NOT NULL COMMENT '关联表名',
    linked_to_record INTEGER UNSIGNED NOT NULL COMMENT '关联记录ID',
    contact_type_id TINYINT UNSIGNED NOT NULL COMMENT '联系人类型',
    tax_id VARCHAR(64) NOT NULL DEFAULT '' COMMENT '税号',
    street VARCHAR(256) NOT NULL DEFAULT '' COMMENT '街道',
    suburb VARCHAR(128) NOT NULL DEFAULT '' COMMENT '郊区/区',
    city VARCHAR(128) NOT NULL DEFAULT '' COMMENT '城市',
    state VARCHAR(128) NOT NULL DEFAULT '' COMMENT '州/省',
    zip VARCHAR(32) NOT NULL DEFAULT '' COMMENT '邮编',
    country VARCHAR(128) NOT NULL DEFAULT '' COMMENT '国家',
    phone VARCHAR(64) NOT NULL DEFAULT '' COMMENT '电话',
    mobile VARCHAR(64) NOT NULL DEFAULT '' COMMENT '手机',
    fax VARCHAR(64) NOT NULL DEFAULT '' COMMENT '传真',
    email VARCHAR(128) NOT NULL DEFAULT '' COMMENT '邮箱',
    web VARCHAR(128) NOT NULL DEFAULT '' COMMENT '网站',
    memo VARCHAR(256) NOT NULL DEFAULT '' COMMENT '备注',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除:1-是,0-否',
    contact_status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '联系人状态:0-正常,1-停用',
    class_type TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '类别',
    identification TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '标识',
    tax_key_record INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '税务键记录',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_contact_name ON contact(contact_name);
CREATE INDEX idx_linked ON contact(linked_to_table, linked_to_record);
CREATE INDEX idx_contact_status ON contact(contact_status);
CREATE INDEX idx_deleted_time ON contact(deleted_time);


-- =====================================================
-- 04. 货币表
-- =====================================================
CREATE TABLE "currency" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    symbol_code VARCHAR(32) NOT NULL COMMENT '货币符号',
    description VARCHAR(128) NOT NULL DEFAULT '' COMMENT '描述',
    formatting_symbol VARCHAR(32) NOT NULL DEFAULT '' COMMENT '格式化符号',
    formatting_symbol_pos TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '符号位置',
    is_show_formatting_symbol TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否显示格式符号:1-是,0-否',
    formatting_decimals TINYINT UNSIGNED NOT NULL DEFAULT 2 COMMENT '小数位数',
    is_formatting_t_separator TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否使用千位分隔符:1-是,0-否',
    rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000 COMMENT '汇率',
    direction TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '方向',
    bid DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '买入价',
    ask DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '卖出价',
    rate_date DATE NOT NULL COMMENT '汇率日期',
    reference_no INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '参考',
    class_type TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '类别',
    identification TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '标识',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除:1-是,0-否',
    currency_status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '货币状态:0-正常,1-停用',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    is_default TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否默认货币:1-是,0-否',
    is_cryptocurrency TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否加密货币:1-是,0-否',
    cryptocurrency_icon_url VARCHAR(128) NOT NULL DEFAULT '' COMMENT '加密货币图标URL',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_symbol_code ON currency(symbol_code);
CREATE INDEX idx_is_default ON currency(is_default);
CREATE INDEX idx_currency_status ON currency(currency_status);
CREATE INDEX idx_deleted_time ON currency(deleted_time);


-- =====================================================
-- 05. 偏好设置表
-- =====================================================
CREATE TABLE "preference" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    preference_name VARCHAR(64) NOT NULL COMMENT '配置项名称',
    value VARCHAR(1024) NOT NULL DEFAULT '' COMMENT '配置值',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE UNIQUE INDEX uk_preference_name ON preference(preference_name);
CREATE INDEX idx_deleted_time ON preference(deleted_time);

-- =====================================================
-- 06. 账目类型表
-- =====================================================
CREATE TABLE "account_type" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    type_name VARCHAR(64) NOT NULL COMMENT '类型名称',
    kind_id INTEGER UNSIGNED NOT NULL COMMENT '种类',
    accounts_count INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '账户数量',
    categories_count INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '分类数量',
    balance DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '余额',
    reconciled DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '已对账金额',
    opening DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '期初',
    closing DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '期末',
    incoming DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '收入',
    outgoing DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '支出',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除:1-是,0-否',
    type_status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '类型状态:0-正常,1-禁用,2-归档',
    budget_amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '预算金额',
    budget_period TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '预算周期',
    max_limit DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '最大限额',
    min_authorized DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '最小授权额',
    min_expected DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '最小预期额',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    is_balance_up_to_date TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '余额是否最新:1-是,0-否',
    balance_total_all DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '总余额',
    balance_total_rec DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '对账总额',
    balance_accounts INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '账户余额',
    memo VARCHAR(128) NOT NULL DEFAULT '' COMMENT '备注',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_type_name ON account_type(type_name);
CREATE INDEX idx_kind_id ON account_type(kind_id);
CREATE INDEX idx_type_status ON account_type(type_status);
CREATE INDEX idx_deleted_time ON account_type(deleted_time);


-- =====================================================
-- 07. 账目分类表
-- =====================================================
CREATE TABLE "account_category" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    category_name VARCHAR(64) NOT NULL COMMENT '分类名称',
    account_type_id INTEGER UNSIGNED NOT NULL COMMENT '类型ID',
    accounts_count INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '账户数量',
    balance DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '余额',
    reconciled DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '已对账金额',
    opening DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '期初',
    closing DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '期末',
    incoming DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '收入',
    outgoing DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '支出',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除:1-是,0-否',
    category_status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '分类状态:0-正常,1-禁用,2-归档',
    budget_amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '预算金额',
    budget_period TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '预算周期',
    max_limit DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '最大限额',
    min_authorized DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '最小授权额',
    min_expected DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '最小预期额',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    is_balance_up_to_date TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '余额是否最新:1-是,0-否',
    balance_total_all DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '总余额',
    balance_total_rec DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '对账总额',
    balance_accounts INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '账户余额',
    memo VARCHAR(128) NOT NULL DEFAULT '' COMMENT '备注',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_category_name ON account_category(category_name);
CREATE INDEX idx_account_type_id ON account_category(account_type_id);
CREATE INDEX idx_category_status ON account_category(category_status);
CREATE INDEX idx_deleted_time ON account_category(deleted_time);

-- =====================================================
-- 08. 账目表
-- =====================================================
CREATE TABLE "account" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    account_name VARCHAR(64) NOT NULL COMMENT '账户名称',
    account_type_id TINYINT UNSIGNED NOT NULL COMMENT '记录类型',
    account_category_id TINYINT UNSIGNED NOT NULL COMMENT '账户类别',
    memo VARCHAR(128) NOT NULL DEFAULT '' COMMENT '备注',
    balance DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '余额',
    reconciled DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '已对账金额',
    opening DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '期初余额',
    closing DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '期末余额',
    incoming DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '收入',
    outgoing DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '支出',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除:1-是,0-否',
    is_closed TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否结账:1-是,0-否',
    account_status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '账户状态:0-正常,1-冻结,2-停用',
    budget_amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '预算金额',
    budget_period TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '预算周期',
    max_limit DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '最大限额',
    min_authorized DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '最小授权额',
    min_expected DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '最小预期额',
    class_type TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '类别',
    identification TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '标识',
    is_tax_related TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否关联税务:1-是,0-否',
    tax_key_record INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '税务键记录',
    tax_type TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '税务类型',
    currency_id INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '货币记录',
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000 COMMENT '汇率',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    is_balance_up_to_date TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '余额是否最新:1-是,0-否',
    balance_total_all DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '总余额',
    balance_total_rec DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '对账总额',
    balance_trans_qty INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '交易数量',
    is_limit_warning TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否限额警告:1-是,0-否',
    limit_when_at TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '限额触发条件',
    limit_period TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '限额周期',
    is_deductible TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否可抵扣:1-是,0-否',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_account_name ON account(account_name);
CREATE INDEX idx_account_category_id ON account(account_category_id);
CREATE INDEX idx_is_enabled ON account(is_enabled);
CREATE INDEX idx_account_status ON account(account_status);
CREATE INDEX idx_deleted_time ON account(deleted_time);


-- =====================================================
-- 09. 交易类型表 
-- =====================================================
CREATE TABLE "trans_type" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    type_name VARCHAR(64) NOT NULL COMMENT '交易类型名称',
    trans_type_category_id INTEGER UNSIGNED NOT NULL COMMENT '交易分类ID',
    balance DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '余额',
    internal_amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '内部金额',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除:1-是,0-否',
    trans_type_status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '交易类型状态:0-正常,1-禁用',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_type_name ON trans_type(type_name);
CREATE INDEX idx_trans_type_status ON trans_type(trans_type_status);
CREATE INDEX idx_deleted_time ON trans_type(deleted_time);
CREATE INDEX idx_trans_type_category_id ON trans_type(trans_type_category_id);

-- =====================================================
-- 10. 明细表
-- =====================================================
CREATE TABLE "detail" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    linked_to_table VARCHAR(32) NOT NULL COMMENT '关联表名',
    linked_to_record INTEGER UNSIGNED NOT NULL COMMENT '关联记录ID',
    quantity INTEGER UNSIGNED NOT NULL DEFAULT 1 COMMENT '数量',
    reference_no VARCHAR(32) NOT NULL DEFAULT '' COMMENT '参考号',
    description VARCHAR(128) NOT NULL DEFAULT '' COMMENT '描述',
    amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '金额',
    discount DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '折扣',
    currency_id INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '货币记录',
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000 COMMENT '汇率',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除:1-是,0-否',
    detail_status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '明细状态:0-正常,1-异常',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_linked ON detail(linked_to_table, linked_to_record);
CREATE INDEX idx_detail_status ON detail(detail_status);
CREATE INDEX idx_deleted_time ON detail(deleted_time);


-- =====================================================
-- 11. 税务表
-- =====================================================
CREATE TABLE "tax" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    tax_key VARCHAR(64) NOT NULL COMMENT '税务键(业务唯一标识)',
    linked_to_table VARCHAR(32) NOT NULL COMMENT '关联表名',
    linked_to_record INTEGER UNSIGNED NOT NULL COMMENT '关联记录ID',
    tax_type TINYINT UNSIGNED NOT NULL COMMENT '税务类型',
    tax_value DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '税额',
    percentage DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '百分比',
    tax_category TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '税务类别',
    account_id INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '账户ID',
    memo VARCHAR(128) NOT NULL DEFAULT '' COMMENT '备注',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除:1-是,0-否',
    tax_status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '税务状态:0-正常,1-停用',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_tax_key ON tax(tax_key);
CREATE INDEX idx_linked ON tax(linked_to_table, linked_to_record);
CREATE INDEX idx_tax_status ON tax(tax_status);
CREATE INDEX idx_deleted_time ON tax(deleted_time);


-- =====================================================
-- 12. 备忘录表 
-- =====================================================
CREATE TABLE "memo" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    memo_key VARCHAR(64) NOT NULL COMMENT '键名',
    memo_type TINYINT UNSIGNED NOT NULL COMMENT '备忘录类型',
    linked_to_table VARCHAR(32) NOT NULL COMMENT '关联表名',
    linked_to_record INTEGER UNSIGNED NOT NULL COMMENT '关联记录ID',
    memo_text TEXT COMMENT '文本内容',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除:1-是,0-否',
    memo_status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '备忘录状态:0-正常,1-归档',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_memo_key ON memo(memo_key);
CREATE INDEX idx_linked ON memo(linked_to_table, linked_to_record);
CREATE INDEX idx_deleted_time ON memo(deleted_time);

-- =====================================================
-- 13. 收藏表 
-- =====================================================
CREATE TABLE "favorite" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    favorite_name VARCHAR(64) NOT NULL COMMENT '收藏名称',
    favorite_type INTEGER UNSIGNED NOT NULL COMMENT '收藏类型',
    account_debited INTEGER UNSIGNED NOT NULL COMMENT '借方账户',
    account_credited INTEGER UNSIGNED NOT NULL COMMENT '贷方账户',
    amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '金额',
    memo VARCHAR(128) NOT NULL DEFAULT '' COMMENT '备注',
    is_auto_reconcile TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否自动对账:1-是,0-否',
    currency_id INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '货币记录',
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000 COMMENT '汇率',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除:1-是,0-否',
    is_checked TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否核对:1-是,0-否',
    favorite_status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '收藏状态:0-正常,1-停用',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    type_ref VARCHAR(32) NOT NULL DEFAULT '' COMMENT '类型参考',
    group_id INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '组ID',
    issuing INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '发行',
    project VARCHAR(64) NOT NULL DEFAULT '' COMMENT '项目',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_favorite_name ON favorite(favorite_name);
CREATE INDEX idx_favorite_status ON favorite(favorite_status);
CREATE INDEX idx_deleted_time ON favorite(deleted_time);


-- =====================================================
-- 14. 物品表
-- =====================================================
CREATE TABLE "item" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    linked_to_table VARCHAR(32) NOT NULL COMMENT '关联表名',
    linked_to_record INTEGER UNSIGNED NOT NULL COMMENT '关联记录ID',
    reference_no VARCHAR(32) NOT NULL DEFAULT '' COMMENT '参考号',
    description VARCHAR(128) NOT NULL DEFAULT '' COMMENT '描述',
    price DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '价格',
    discount DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '折扣',
    cost DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '成本',
    currency_id INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '货币记录',
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000 COMMENT '汇率',
    item_type INTEGER UNSIGNED NOT NULL COMMENT '物品类型',
    account_category_id INTEGER UNSIGNED NOT NULL COMMENT '分类ID',
    class_type TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '类别',
    identification TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '标识',
    tax_key_record INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '税务键记录',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除:1-是,0-否',
    item_status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '物品状态:0-正常,1-下架,2-缺货',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_linked ON item(linked_to_table, linked_to_record);
CREATE INDEX idx_account_category_id ON item(account_category_id);
CREATE INDEX idx_item_status ON item(item_status);
CREATE INDEX idx_deleted_time ON item(deleted_time);


-- =====================================================
-- 15. 银行表
-- =====================================================
CREATE TABLE "bank" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    bank_name VARCHAR(128) NOT NULL COMMENT '银行名称',
    linked_to_table VARCHAR(32) NOT NULL COMMENT '关联表名',
    linked_to_record INTEGER UNSIGNED NOT NULL COMMENT '关联记录ID',
    bank_type TINYINT UNSIGNED NOT NULL COMMENT '银行类型',
    swiftcode VARCHAR(32) NOT NULL DEFAULT '' COMMENT 'SWIFT代码',
    account_number VARCHAR(64) NOT NULL DEFAULT '' COMMENT '账号',
    iban VARCHAR(64) NOT NULL DEFAULT '' COMMENT 'IBAN国际银行账号',
    currency_id INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '货币记录',
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000 COMMENT '汇率',
    street VARCHAR(256) NOT NULL DEFAULT '' COMMENT '街道',
    suburb VARCHAR(128) NOT NULL DEFAULT '' COMMENT '郊区/区',
    city VARCHAR(128) NOT NULL DEFAULT '' COMMENT '城市',
    state VARCHAR(128) NOT NULL DEFAULT '' COMMENT '州/省',
    zip VARCHAR(32) NOT NULL DEFAULT '' COMMENT '邮编',
    country VARCHAR(128) NOT NULL DEFAULT '' COMMENT '国家',
    phone VARCHAR(64) NOT NULL DEFAULT '' COMMENT '电话',
    mobile VARCHAR(64) NOT NULL DEFAULT '' COMMENT '手机',
    fax VARCHAR(64) NOT NULL DEFAULT '' COMMENT '传真',
    email VARCHAR(128) NOT NULL DEFAULT '' COMMENT '邮箱',
    web VARCHAR(128) NOT NULL DEFAULT '' COMMENT '网站',
    memo VARCHAR(256) NOT NULL DEFAULT '' COMMENT '备注',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除:1-是,0-否',
    bank_status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '银行状态:0-正常,1-停用',
    class_type TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '类别',
    identification TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '标识',
    tax_key_record INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '税务键记录',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_bank_name ON bank(bank_name);
CREATE INDEX idx_swiftcode ON bank(swiftcode);
CREATE INDEX idx_bank_status ON bank(bank_status);
CREATE INDEX idx_deleted_time ON bank(deleted_time);


-- =====================================================
-- 16. 预设表
-- =====================================================
CREATE TABLE "preset" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    preset_name VARCHAR(64) NOT NULL COMMENT '预设名称',
    preset_type VARCHAR(64) NOT NULL COMMENT '预设类型',
    value VARCHAR(256) NOT NULL DEFAULT '' COMMENT '预设值',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除:1-是,0-否',
    preset_status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '预设状态:0-正常,1-禁用',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_preset_name ON preset(preset_name);
CREATE INDEX idx_preset_type ON preset(preset_type);
CREATE INDEX idx_deleted_time ON preset(deleted_time);


-- =====================================================
-- 17. 计划任务表
-- =====================================================
CREATE TABLE "scheduling" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    scheduling_type INTEGER UNSIGNED NOT NULL COMMENT '计划类型',
    account_debited INTEGER UNSIGNED NOT NULL COMMENT '借方账户',
    account_credited INTEGER UNSIGNED NOT NULL COMMENT '贷方账户',
    amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '金额',
    memo VARCHAR(128) NOT NULL DEFAULT '' COMMENT '备注',
    issuing INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '发行',
    is_auto_reconcile TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否自动对账:1-是,0-否',
    currency_id INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '货币记录',
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000 COMMENT '汇率',
    start_date DATE NOT NULL COMMENT '开始日期',
    end_date DATE NOT NULL COMMENT '结束日期',
    period TINYINT UNSIGNED NOT NULL COMMENT '周期',
    schedule_count INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '执行次数',
    ending TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '结束方式',
    next_date DATE NOT NULL COMMENT '下次执行日期',
    last_date DATE NOT NULL COMMENT '上次执行日期',
    scheduling_day INTEGER UNSIGNED NOT NULL COMMENT '日',
    scheduling_month INTEGER UNSIGNED NOT NULL COMMENT '月',
    scheduling_year INTEGER UNSIGNED NOT NULL COMMENT '年',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除:1-是,0-否',
    is_checked TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否核对:1-是,0-否',
    schedule_status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '计划状态:0-待执行,1-执行中,2-已完成,3-已取消',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    is_budget TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否预算:1-是,0-否',
    project VARCHAR(64) NOT NULL DEFAULT '' COMMENT '项目',
    is_delete_when_done TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '完成后是否删除:1-是,0-否',
    tax_type TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '税务类型',
    tax_amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '税额',
    tax_rate DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '税率',
    amount_variation DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '金额变化',
    is_amount_variation_percentage TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '金额变化是否为百分比:1-是,0-否',
    amount_variation_direction TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '金额变化方向',
    amount_last DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '上次金额',
    amount_list TEXT COMMENT '金额列表(超长字段)',
    amount_list_pointer INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '金额列表指针',
    is_end_of_month TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否月末:1-是,0-否',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_next_date ON scheduling(next_date);
CREATE INDEX idx_schedule_status ON scheduling(schedule_status);
CREATE INDEX idx_is_enabled ON scheduling(is_enabled);
CREATE INDEX idx_deleted_time ON scheduling(deleted_time);


-- =====================================================
-- 18. 投资组合表 
-- =====================================================
CREATE TABLE "portfolio" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    portfolio_type TINYINT UNSIGNED NOT NULL COMMENT '投资类型',
    linked_to_table VARCHAR(32) NOT NULL COMMENT '关联表名',
    linked_to_record INTEGER UNSIGNED NOT NULL COMMENT '关联记录ID',
    symbol_code VARCHAR(32) NOT NULL COMMENT '股票代码',
    description VARCHAR(128) NOT NULL DEFAULT '' COMMENT '描述',
    trans_type TINYINT UNSIGNED NOT NULL COMMENT '交易类型',
    purchase_date DATE NOT NULL COMMENT '购买日期',
    purchase_shares INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '购买股数',
    purchase_price DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '购买价格',
    entry_commission DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '买入佣金',
    sales_date DATE NOT NULL COMMENT '卖出日期',
    sales_shares INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '卖出股数',
    sales_price DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '卖出价格',
    exit_commission DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '卖出佣金',
    currency_id INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '货币记录',
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000 COMMENT '汇率',
    class_type TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '类别',
    identification TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '标识',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除:1-是,0-否',
    portfolio_status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '投资状态:0-持有,1-已卖出,2-已平仓',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_symbol_code ON portfolio(symbol_code);
CREATE INDEX idx_linked ON portfolio(linked_to_table, linked_to_record);
CREATE INDEX idx_portfolio_status ON portfolio(portfolio_status);
CREATE INDEX idx_deleted_time ON portfolio(deleted_time);

-- =====================================================
-- 19. 行情表
-- =====================================================
CREATE TABLE "quote" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    symbol_code VARCHAR(32) NOT NULL COMMENT '股票代码',
    description VARCHAR(128) NOT NULL DEFAULT '' COMMENT '描述',
    quote_date DATE NOT NULL COMMENT '行情日期',
    open_price DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '开盘价',
    high_price DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '最高价',
    low_price DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '最低价',
    close_price DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '收盘价',
    volume INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '成交量',
    quote_day INTEGER UNSIGNED NOT NULL COMMENT '日',
    quote_month INTEGER UNSIGNED NOT NULL COMMENT '月',
    quote_year INTEGER UNSIGNED NOT NULL COMMENT '年',
    currency_id INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '货币记录',
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000 COMMENT '汇率',
    class_type TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '类别',
    identification TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '标识',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除:1-是,0-否',
    quote_status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '行情状态:0-正常,1-停用',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_symbol_code ON quote(symbol_code);
CREATE INDEX idx_quote_date ON quote(quote_date);
CREATE INDEX idx_symbol_date ON quote(symbol_code, quote_date);
CREATE INDEX idx_deleted_time ON quote(deleted_time);

-- =====================================================
-- 20. 贷款表
-- =====================================================
CREATE TABLE "loan" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    loan_name VARCHAR(64) NOT NULL COMMENT '贷款名称',
    memo VARCHAR(256) NOT NULL DEFAULT '' COMMENT '备注',
    linked_to_table VARCHAR(32) NOT NULL COMMENT '关联表名',
    linked_to_record INTEGER UNSIGNED NOT NULL COMMENT '关联记录ID',
    amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '贷款金额',
    loan_length DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '贷款期限',
    period TINYINT UNSIGNED NOT NULL COMMENT '周期',
    rate DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '利率',
    loan_type TINYINT UNSIGNED NOT NULL COMMENT '贷款类型',
    compounding TINYINT UNSIGNED NOT NULL COMMENT '复利方式',
    start_date DATE NOT NULL COMMENT '开始日期',
    end_date DATE NOT NULL COMMENT '结束日期',
    period_begin_end TINYINT UNSIGNED NOT NULL COMMENT '周期起止',
    currency_id INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '货币记录',
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000 COMMENT '汇率',
    class_type TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '类别',
    identification TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '标识',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除:1-是,0-否',
    loan_status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '贷款状态:0-正常还款,1-逾期,2-已结清',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_loan_name ON loan(loan_name);
CREATE INDEX idx_loan_status ON loan(loan_status);
CREATE INDEX idx_start_date ON loan(start_date);
CREATE INDEX idx_deleted_time ON loan(deleted_time);


-- =====================================================
-- 21. 交易组表
-- =====================================================
CREATE TABLE "trans_group" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    group_type INTEGER UNSIGNED NOT NULL COMMENT '组类型',
    account_debited INTEGER UNSIGNED NOT NULL COMMENT '借方账户',
    account_credited INTEGER UNSIGNED NOT NULL COMMENT '贷方账户',
    amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '金额',
    memo VARCHAR(128) NOT NULL DEFAULT '' COMMENT '备注',
    is_checked TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否核对:1-是,0-否',
    is_detailed TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否详细:1-是,0-否',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除:1-是,0-否',
    group_status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '交易组状态:0-正常,1-已处理',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    group_date_day INTEGER UNSIGNED NOT NULL COMMENT '日',
    group_date_month INTEGER UNSIGNED NOT NULL COMMENT '月',
    group_date_year INTEGER UNSIGNED NOT NULL COMMENT '年',
    group_date DATE NOT NULL COMMENT '组日期',
    type_ref VARCHAR(32) NOT NULL DEFAULT '' COMMENT '类型参考',
    account_debited_alt VARCHAR(64) NOT NULL DEFAULT '' COMMENT '备选借方账户',
    account_credited_alt VARCHAR(64) NOT NULL DEFAULT '' COMMENT '备选贷方账户',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_group_date ON trans_group(group_date);
CREATE INDEX idx_group_status ON trans_group(group_status);
CREATE INDEX idx_deleted_time ON trans_group(deleted_time);


-- =====================================================
-- 22. 交易表
-- =====================================================
CREATE TABLE "trans" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    reference_no INTEGER UNSIGNED NOT NULL COMMENT '参考号',
    trans_day INTEGER UNSIGNED NOT NULL COMMENT '日',
    trans_month INTEGER UNSIGNED NOT NULL COMMENT '月',
    trans_year INTEGER UNSIGNED NOT NULL COMMENT '年',
    trans_date DATE NOT NULL COMMENT '交易日期',
    trans_type_id INTEGER UNSIGNED NOT NULL COMMENT '交易类型ID',
    account_debited INTEGER UNSIGNED NOT NULL COMMENT '借方账户',
    account_credited INTEGER UNSIGNED NOT NULL COMMENT '贷方账户',
    account_debited_type INTEGER UNSIGNED NOT NULL COMMENT '借方账户类型',
    account_credited_type INTEGER UNSIGNED NOT NULL COMMENT '贷方账户类型',
    account_debited_category INTEGER UNSIGNED NOT NULL COMMENT '借方账户分类',
    account_credited_category INTEGER UNSIGNED NOT NULL COMMENT '贷方账户分类',
    amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '金额',
    memo VARCHAR(128) NOT NULL DEFAULT '' COMMENT '备注',
    invoice_num VARCHAR(32) NOT NULL DEFAULT '' COMMENT '发票号',
    issuing INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '发行',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    is_deleted TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除:1-是,0-否',
    is_checked TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否核对:1-是,0-否',
    trans_status TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '交易状态:0-待处理,1-已完成,2-已取消,3-异常',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    is_detailed TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否详细:1-是,0-否',
    tax_type TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '税务类型',
    tax_amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '税额',
    tax_rate DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '税率',
    link_to_trans INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '关联交易',
    currency_id INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '货币记录',
    currency_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000 COMMENT '汇率',
    is_hold TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否挂起:1-是,0-否',
    term_date DATE COMMENT '到期日',
    type_ref VARCHAR(32) NOT NULL DEFAULT '' COMMENT '类型参考',
    group_id INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT '组ID',
    project VARCHAR(64) NOT NULL DEFAULT '' COMMENT '项目',
    currency_to_def_rate DECIMAL(15,6) NOT NULL DEFAULT 1.000000 COMMENT '默认汇率',
    currency_direction1 TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '货币方向1',
    currency_direction2 TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '货币方向2',
    attachment_name VARCHAR(128) NOT NULL DEFAULT '' COMMENT '附件名称',
    attachment_type VARCHAR(32) NOT NULL DEFAULT '' COMMENT '附件类型',
    attachment_mac_info VARCHAR(10) NOT NULL DEFAULT '' COMMENT '附件MAC信息',
    is_flagged TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否标记:1-是,0-否',
    is_deductible TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否可抵扣:1-是,0-否',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_trans_date ON trans(trans_date);
CREATE INDEX idx_trans_type_id ON trans(trans_type_id);
CREATE INDEX idx_account_debited ON trans(account_debited);
CREATE INDEX idx_account_credited ON trans(account_credited);
CREATE INDEX idx_trans_status ON trans(trans_status);
CREATE INDEX idx_memo ON trans(memo);
CREATE INDEX idx_deleted_time ON trans(deleted_time);


-- =====================================================
-- 23. 预算表
-- =====================================================
CREATE TABLE "budget" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    budget_name VARCHAR(64) NOT NULL COMMENT '预算名称',
    is_expenses_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '费用是否展开:1-是,0-否',
    is_incomes_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '收入是否展开:1-是,0-否',
    is_expenses_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '费用是否启用:1-是,0-否',
    is_incomes_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '收入是否启用:1-是,0-否',
    is_compare_enabled TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否启用对比:1-是,0-否',
    compare_period TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '对比周期',
    compare_from_date DATE NOT NULL COMMENT '对比开始日期',
    compare_to_date DATE NOT NULL COMMENT '对比结束日期',
    is_liabilities_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '负债是否展开:1-是,0-否',
    is_liabilities_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '负债是否启用:1-是,0-否',
    expenses_memo VARCHAR(128) NOT NULL DEFAULT '' COMMENT '费用备注',
    incomes_memo VARCHAR(128) NOT NULL DEFAULT '' COMMENT '收入备注',
    liabilities_memo VARCHAR(128) NOT NULL DEFAULT '' COMMENT '负债备注',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_budget_name ON budget(budget_name);
CREATE INDEX idx_delete_time ON budget(deleted_time);

-- =====================================================
-- 24. 预算分类关联表
-- =====================================================
CREATE TABLE "budget_category" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    budget_id INTEGER UNSIGNED NOT NULL COMMENT '预算ID',
    account_category_id INTEGER UNSIGNED NOT NULL COMMENT '分类ID',
    is_expanded TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否展开:1-是,0-否',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    memo VARCHAR(128) NOT NULL DEFAULT '' COMMENT '备注',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_budget_id ON budget_category(budget_id);
CREATE INDEX idx_account_category_id ON budget_category(account_category_id);
CREATE UNIQUE INDEX uk_budget_category ON budget_category(budget_id, account_category_id);
CREATE INDEX idx_deleted_time ON budget_category(deleted_time);


-- =====================================================
-- 25. 预算账户关联表 
-- =====================================================
CREATE TABLE "budget_account" (
    id INTEGER PRIMARY KEY AUTOINCREMENT COMMENT '主键ID',
    budget_id INTEGER UNSIGNED NOT NULL COMMENT '预算ID',
    account_id INTEGER UNSIGNED NOT NULL COMMENT '账户ID',
    amount DECIMAL(15,6) NOT NULL DEFAULT 0.000000 COMMENT '金额',
    interval_period TINYINT UNSIGNED NOT NULL COMMENT '间隔周期',
    is_enabled TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用:1-是,0-否',
    memo VARCHAR(128) NOT NULL DEFAULT '' COMMENT '备注',
    created_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '创建人',
    created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_by VARCHAR(64) NOT NULL DEFAULT '' COMMENT '更新人',
    updated_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    deleted_by VARCHAR(64) DEFAULT '' COMMENT '删除人',
    deleted_time TIMESTAMP DEFAULT NULL COMMENT '删除时间'
);

CREATE INDEX idx_budget_id ON budget_account(budget_id);
CREATE INDEX idx_account_id ON budget_account(account_id);
CREATE UNIQUE INDEX uk_budget_account ON budget_account(budget_id, account_id);
CREATE INDEX idx_deleted_time ON budget_account(deleted_time);




