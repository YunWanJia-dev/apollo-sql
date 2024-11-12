# Create Database
# ------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS ApolloPortalDB DEFAULT CHARACTER SET = utf8mb4;

Use ApolloPortalDB;

# Dump of table app
# ------------------------------------------------------------

DROP TABLE IF EXISTS `App`;

CREATE TABLE `App` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `AppId` varchar(64) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `Name` varchar(500) NOT NULL DEFAULT 'default' COMMENT '应用名',
  `OrgId` varchar(32) NOT NULL DEFAULT 'default' COMMENT '部门Id',
  `OrgName` varchar(64) NOT NULL DEFAULT 'default' COMMENT '部门名字',
  `OwnerName` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerName',
  `OwnerEmail` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerEmail',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` BIGINT(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_AppId_DeletedAt` (`AppId`,`DeletedAt`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_Name` (`Name`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='应用表';



# Dump of table appnamespace
# ------------------------------------------------------------

DROP TABLE IF EXISTS `AppNamespace`;

CREATE TABLE `AppNamespace` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `Name` varchar(32) NOT NULL DEFAULT '' COMMENT 'namespace名字，注意，需要全局唯一',
  `AppId` varchar(64) NOT NULL DEFAULT '' COMMENT 'app id',
  `Format` varchar(32) NOT NULL DEFAULT 'properties' COMMENT 'namespace的format类型',
  `IsPublic` bit(1) NOT NULL DEFAULT b'0' COMMENT 'namespace是否为公共',
  `Comment` varchar(64) NOT NULL DEFAULT '' COMMENT '注释',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` BIGINT(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_AppId_Name_DeletedAt` (`AppId`,`Name`,`DeletedAt`),
  KEY `Name_AppId` (`Name`,`AppId`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='应用namespace定义';



# Dump of table consumer
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Consumer`;

CREATE TABLE `Consumer` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `AppId` varchar(64) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `Name` varchar(500) NOT NULL DEFAULT 'default' COMMENT '应用名',
  `OrgId` varchar(32) NOT NULL DEFAULT 'default' COMMENT '部门Id',
  `OrgName` varchar(64) NOT NULL DEFAULT 'default' COMMENT '部门名字',
  `OwnerName` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerName',
  `OwnerEmail` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerEmail',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` BIGINT(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_AppId_DeletedAt` (`AppId`,`DeletedAt`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='开放API消费者';



# Dump of table consumeraudit
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ConsumerAudit`;

CREATE TABLE `ConsumerAudit` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `ConsumerId` int(11) unsigned DEFAULT NULL COMMENT 'Consumer Id',
  `Uri` varchar(1024) NOT NULL DEFAULT '' COMMENT '访问的Uri',
  `Method` varchar(16) NOT NULL DEFAULT '' COMMENT '访问的Method',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_ConsumerId` (`ConsumerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='consumer审计表';



# Dump of table consumerrole
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ConsumerRole`;

CREATE TABLE `ConsumerRole` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `ConsumerId` int(11) unsigned DEFAULT NULL COMMENT 'Consumer Id',
  `RoleId` int(10) unsigned DEFAULT NULL COMMENT 'Role Id',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` BIGINT(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_ConsumerId_RoleId_DeletedAt` (`ConsumerId`,`RoleId`,`DeletedAt`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_RoleId` (`RoleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='consumer和role的绑定表';



# Dump of table consumertoken
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ConsumerToken`;

CREATE TABLE `ConsumerToken` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `ConsumerId` int(11) unsigned DEFAULT NULL COMMENT 'ConsumerId',
  `Token` varchar(128) NOT NULL DEFAULT '' COMMENT 'token',
  `Expires` datetime NOT NULL DEFAULT '2099-01-01 00:00:00' COMMENT 'token失效时间',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` BIGINT(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_Token_DeletedAt` (`Token`,`DeletedAt`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='consumer token表';

# Dump of table favorite
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Favorite`;

CREATE TABLE `Favorite` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `UserId` varchar(32) NOT NULL DEFAULT 'default' COMMENT '收藏的用户',
  `AppId` varchar(64) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `Position` int(32) NOT NULL DEFAULT '10000' COMMENT '收藏顺序',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` BIGINT(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_UserId_AppId_DeletedAt` (`UserId`,`AppId`,`DeletedAt`),
  KEY `AppId` (`AppId`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COMMENT='应用收藏表';

# Dump of table permission
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Permission`;

CREATE TABLE `Permission` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `PermissionType` varchar(32) NOT NULL DEFAULT '' COMMENT '权限类型',
  `TargetId` varchar(256) NOT NULL DEFAULT '' COMMENT '权限对象类型',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` BIGINT(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_TargetId_PermissionType_DeletedAt` (`TargetId`,`PermissionType`,`DeletedAt`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='permission表';



# Dump of table role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Role`;

CREATE TABLE `Role` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `RoleName` varchar(256) NOT NULL DEFAULT '' COMMENT 'Role name',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` BIGINT(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_RoleName_DeletedAt` (`RoleName`,`DeletedAt`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色表';



# Dump of table rolepermission
# ------------------------------------------------------------

DROP TABLE IF EXISTS `RolePermission`;

CREATE TABLE `RolePermission` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `RoleId` int(10) unsigned DEFAULT NULL COMMENT 'Role Id',
  `PermissionId` int(10) unsigned DEFAULT NULL COMMENT 'Permission Id',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` BIGINT(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_RoleId_PermissionId_DeletedAt` (`RoleId`,`PermissionId`,`DeletedAt`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_PermissionId` (`PermissionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和权限的绑定表';



# Dump of table serverconfig
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ServerConfig`;

CREATE TABLE `ServerConfig` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `Key` varchar(64) NOT NULL DEFAULT 'default' COMMENT '配置项Key',
  `Value` varchar(2048) NOT NULL DEFAULT 'default' COMMENT '配置项值',
  `Comment` varchar(1024) DEFAULT '' COMMENT '注释',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` BIGINT(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_Key_DeletedAt` (`Key`,`DeletedAt`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='配置服务自身配置';



# Dump of table userrole
# ------------------------------------------------------------

DROP TABLE IF EXISTS `UserRole`;

CREATE TABLE `UserRole` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `UserId` varchar(128) DEFAULT '' COMMENT '用户身份标识',
  `RoleId` int(10) unsigned DEFAULT NULL COMMENT 'Role Id',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` BIGINT(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_UserId_RoleId_DeletedAt` (`UserId`,`RoleId`,`DeletedAt`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_RoleId` (`RoleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户和role的绑定表';

# Dump of table Users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Users`;

CREATE TABLE `Users` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `Username` varchar(64) NOT NULL DEFAULT 'default' COMMENT '用户登录账户',
  `Password` varchar(512) NOT NULL DEFAULT 'default' COMMENT '密码',
  `UserDisplayName` varchar(512) NOT NULL DEFAULT 'default' COMMENT '用户名称',
  `Email` varchar(64) NOT NULL DEFAULT 'default' COMMENT '邮箱地址',
  `Enabled` tinyint(4) DEFAULT NULL COMMENT '是否有效',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UK_Username` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';


# Dump of table Authorities
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Authorities`;

CREATE TABLE `Authorities` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `Username` varchar(64) NOT NULL,
  `Authority` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

# -- spring session (https://github.com/spring-projects/spring-session/blob/faee8f1bdb8822a5653a81eba838dddf224d92d6/spring-session-jdbc/src/main/resources/org/springframework/session/jdbc/schema-mysql.sql)
# Dump of table SPRING_SESSION
# ------------------------------------------------------------

DROP TABLE IF EXISTS `SPRING_SESSION`;

CREATE TABLE `SPRING_SESSION` (
  `PRIMARY_ID` char(36) NOT NULL,
  `SESSION_ID` char(36) NOT NULL,
  `CREATION_TIME` bigint NOT NULL,
  `LAST_ACCESS_TIME` bigint NOT NULL,
  `MAX_INACTIVE_INTERVAL` int NOT NULL,
  `EXPIRY_TIME` bigint NOT NULL,
  `PRINCIPAL_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PRIMARY_ID`),
  UNIQUE KEY `SPRING_SESSION_IX1` (`SESSION_ID`),
  KEY `SPRING_SESSION_IX2` (`EXPIRY_TIME`),
  KEY `SPRING_SESSION_IX3` (`PRINCIPAL_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

# Dump of table SPRING_SESSION_ATTRIBUTES
# ------------------------------------------------------------

DROP TABLE IF EXISTS `SPRING_SESSION_ATTRIBUTES`;

CREATE TABLE `SPRING_SESSION_ATTRIBUTES` (
  `SESSION_PRIMARY_ID` char(36) NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) NOT NULL,
  `ATTRIBUTE_BYTES` blob NOT NULL,
  PRIMARY KEY (`SESSION_PRIMARY_ID`,`ATTRIBUTE_NAME`),
  CONSTRAINT `SPRING_SESSION_ATTRIBUTES_FK` FOREIGN KEY (`SESSION_PRIMARY_ID`) REFERENCES `SPRING_SESSION` (`PRIMARY_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

# Dump of table AuditLog
# ------------------------------------------------------------

DROP TABLE IF EXISTS `AuditLog`;

CREATE TABLE `AuditLog` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `TraceId` varchar(32) NOT NULL DEFAULT '' COMMENT '链路全局唯一ID',
  `SpanId` varchar(32) NOT NULL DEFAULT '' COMMENT '跨度ID',
  `ParentSpanId` varchar(32) DEFAULT NULL COMMENT '父跨度ID',
  `FollowsFromSpanId` varchar(32) DEFAULT NULL COMMENT '上一个兄弟跨度ID',
  `Operator` varchar(64) NOT NULL DEFAULT 'anonymous' COMMENT '操作人',
  `OpType` varchar(50) NOT NULL DEFAULT 'default' COMMENT '操作类型',
  `OpName` varchar(150) NOT NULL DEFAULT 'default' COMMENT '操作名称',
  `Description` varchar(200) DEFAULT NULL COMMENT '备注',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` BIGINT(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) DEFAULT NULL COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_TraceId` (`TraceId`),
  KEY `IX_OpName` (`OpName`),
  KEY `IX_DataChange_CreatedTime` (`DataChange_CreatedTime`),
  KEY `IX_Operator` (`Operator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='审计日志表';

# Dump of table AuditLogDataInfluence
# ------------------------------------------------------------

DROP TABLE IF EXISTS `AuditLogDataInfluence`;

CREATE TABLE `AuditLogDataInfluence` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `SpanId` char(32) NOT NULL DEFAULT '' COMMENT '跨度ID',
  `InfluenceEntityId` varchar(50) NOT NULL DEFAULT '0' COMMENT '记录ID',
  `InfluenceEntityName` varchar(50) NOT NULL DEFAULT 'default' COMMENT '表名',
  `FieldName` varchar(50) DEFAULT NULL COMMENT '字段名称',
  `FieldOldValue` varchar(500) DEFAULT NULL COMMENT '字段旧值',
  `FieldNewValue` varchar(500) DEFAULT NULL COMMENT '字段新值',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` BIGINT(20) NOT NULL DEFAULT '0' COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) DEFAULT NULL COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_SpanId` (`SpanId`),
  KEY `IX_DataChange_CreatedTime` (`DataChange_CreatedTime`),
  KEY `IX_EntityId` (`InfluenceEntityId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='审计日志数据变动表';

# Config
# ------------------------------------------------------------
INSERT INTO `ServerConfig` (`Key`, `Value`, `Comment`)
VALUES
    ('apollo.portal.envs', 'dev', '可支持的环境列表'),
    ('organizations', '[{\"orgId\":\"cloudpvp-dev\",\"orgName\":\"cloudpvp-dev\"}]', '部门列表'),
    ('superAdmin', 'apollo', 'Portal超级管理员'),
    ('api.readTimeout', '10000', 'http接口read timeout'),
    ('consumer.token.salt', 'someSalt', 'consumer token salt'),
    ('admin.createPrivateNamespace.switch', 'true', '是否允许项目管理员创建私有namespace'),
    ('configView.memberOnly.envs', 'dev', '只对项目成员显示配置信息的环境列表，多个env以英文逗号分隔'),
    ('apollo.portal.meta.servers', '{}', '各环境Meta Service列表');


INSERT INTO `Users` (`Username`, `Password`, `UserDisplayName`, `Email`, `Enabled`)
VALUES
  ('apollo', '$2a$10$7r20uS.BQ9uBpf3Baj3uQOZvMVvB1RN3PYoKE94gtz2.WAOuiiwXS', 'apollo', 'apollo@acme.com', 1);

INSERT INTO `Authorities` (`Username`, `Authority`) VALUES ('apollo', 'ROLE_user');

# Sample Data
# ------------------------------------------------------------
INSERT INTO `App` (`AppId`, `Name`, `OrgId`, `OrgName`, `OwnerName`, `OwnerEmail`)
VALUES
  ('public', 'public', 'cloudpvp-dev', 'cloudpvp-dev', 'apollo', 'apollo@acme.com'),
  ('auth', 'auth', 'cloudpvp-dev', 'cloudpvp-dev', 'apollo', 'apollo@acme.com'),
  ('gateway', 'gateway', 'cloudpvp-dev', 'cloudpvp-dev', 'apollo', 'apollo@acme.com'),
  ('lobby', 'lobby', 'cloudpvp-dev', 'cloudpvp-dev', 'apollo', 'apollo@acme.com'),
  ('play', 'play', 'cloudpvp-dev', 'cloudpvp-dev', 'apollo', 'apollo@acme.com'),
  ('state', 'state', 'cloudpvp-dev', 'cloudpvp-dev', 'apollo', 'apollo@acme.com'),
  ('user-summary', 'user-summary', 'cloudpvp-dev', 'cloudpvp-dev', 'apollo', 'apollo@acme.com');

INSERT INTO `AppNamespace` (`Name`, `AppId`, `Format`, `IsPublic`, `Comment`)
VALUES
  ('cloudpvp-dev.eureka.yml', 'public', 'yml', b'1', '全局服务注册配置'),
  ('cloudpvp-dev.redis-config.yml', 'public', 'yml', b'1', '全局Redis配置'),
  ('cloudpvp-dev.datasource.yml', 'public', 'yml', b'1', '全局数据源配置'),
  ('application.yml', 'auth', 'yml', b'0', ''),
  ('application.yml', 'gateway', 'yml', b'0', ''),
  ('application.yml', 'lobby', 'yml', b'0', ''),
  ('application.yml', 'play', 'yml', b'0', ''),
  ('application.yml', 'state', 'yml', b'0', ''),
  ('application.yml', 'user-summary', 'yml', b'0', '');

INSERT INTO `Permission` (`PermissionType`, `TargetId`)
VALUES
  ('CreateCluster', 'public'),
  ('AssignRole', 'public'),
  ('CreateNamespace', 'public'),
  ('ManageAppMaster', 'public'),
  ('ModifyNamespace', 'public+application.yml'),
  ('ReleaseNamespace', 'public+application.yml'),
  ('ModifyNamespace', 'public+application.yml+DEV'),
  ('ReleaseNamespace', 'public+application.yml+DEV'),
  ('ModifyNamespace', 'public+cloudpvp-dev.eureka.yml'),
  ('ReleaseNamespace', 'public+cloudpvp-dev.eureka.yml'),
  ('ModifyNamespace', 'public+cloudpvp-dev.eureka.yml+DEV'),
  ('ReleaseNamespace', 'public+cloudpvp-dev.eureka.yml+DEV'),
  ('ModifyNamespace', 'public+cloudpvp-dev.redis-config.yml'),
  ('ReleaseNamespace', 'public+cloudpvp-dev.redis-config.yml'),
  ('ModifyNamespace', 'public+cloudpvp-dev.redis-config.yml+DEV'),
  ('ReleaseNamespace', 'public+cloudpvp-dev.redis-config.yml+DEV'),
  ('Createapplication.yml', 'SystemRole'),
  ('ModifyNamespace', 'public+cloudpvp-dev.datasource.yml'),
  ('ReleaseNamespace', 'public+cloudpvp-dev.datasource.yml'),
  ('ModifyNamespace', 'public+cloudpvp-dev.datasource.yml+DEV'),
  ('ReleaseNamespace', 'public+cloudpvp-dev.datasource.yml+DEV'),
  ('CreateCluster', 'auth'),
  ('CreateNamespace', 'auth'),
  ('AssignRole', 'auth'),
  ('ManageAppMaster', 'auth'),
  ('ModifyNamespace', 'auth+application.yml'),
  ('ReleaseNamespace', 'auth+application.yml'),
  ('ModifyNamespace', 'auth+application.yml+DEV'),
  ('ReleaseNamespace', 'auth+application.yml+DEV'),
  ('CreateNamespace', 'gateway'),
  ('CreateCluster', 'gateway'),
  ('AssignRole', 'gateway'),
  ('ManageAppMaster', 'gateway'),
  ('ModifyNamespace', 'gateway+application.yml'),
  ('ReleaseNamespace', 'gateway+application.yml'),
  ('ModifyNamespace', 'gateway+application.yml+DEV'),
  ('ReleaseNamespace', 'gateway+application.yml+DEV'),
  ('CreateNamespace', 'lobby'),
  ('CreateCluster', 'lobby'),
  ('AssignRole', 'lobby'),
  ('ManageAppMaster', 'lobby'),
  ('ModifyNamespace', 'lobby+application.yml'),
  ('ReleaseNamespace', 'lobby+application.yml'),
  ('ModifyNamespace', 'lobby+application.yml+DEV'),
  ('ReleaseNamespace', 'lobby+application.yml+DEV'),
  ('CreateCluster', 'play'),
  ('CreateNamespace', 'play'),
  ('AssignRole', 'play'),
  ('ManageAppMaster', 'play'),
  ('ModifyNamespace', 'play+application.yml'),
  ('ReleaseNamespace', 'play+application.yml'),
  ('ModifyNamespace', 'play+application.yml+DEV'),
  ('ReleaseNamespace', 'play+application.yml+DEV'),
  ('CreateNamespace', 'state'),
  ('AssignRole', 'state'),
  ('CreateCluster', 'state'),
  ('ManageAppMaster', 'state'),
  ('ModifyNamespace', 'state+application.yml'),
  ('ReleaseNamespace', 'state+application.yml'),
  ('ModifyNamespace', 'state+application.yml+DEV'),
  ('ReleaseNamespace', 'state+application.yml+DEV'),
  ('CreateNamespace', 'user-summary'),
  ('CreateCluster', 'user-summary'),
  ('AssignRole', 'user-summary'),
  ('ManageAppMaster', 'user-summary'),
  ('ModifyNamespace', 'user-summary+application.yml'),
  ('ReleaseNamespace', 'user-summary+application.yml'),
  ('ModifyNamespace', 'user-summary+application.yml+DEV'),
  ('ReleaseNamespace', 'user-summary+application.yml+DEV');

INSERT INTO `Role` (`RoleName`)
VALUES
  ('Master+public'),
  ('ManageAppMaster+public'),
  ('ModifyNamespace+public+application.yml'),
  ('ReleaseNamespace+public+application.yml'),
  ('ModifyNamespace+public+application.yml+DEV'),
  ('ReleaseNamespace+public+application.yml+DEV'),
  ('ModifyNamespace+public+cloudpvp-dev.eureka.yml'),
  ('ReleaseNamespace+public+cloudpvp-dev.eureka.yml'),
  ('ModifyNamespace+public+cloudpvp-dev.eureka.yml+DEV'),
  ('ReleaseNamespace+public+cloudpvp-dev.eureka.yml+DEV'),
  ('ModifyNamespace+public+cloudpvp-dev.redis-config.yml'),
  ('ReleaseNamespace+public+cloudpvp-dev.redis-config.yml'),
  ('ModifyNamespace+public+cloudpvp-dev.redis-config.yml+DEV'),
  ('ReleaseNamespace+public+cloudpvp-dev.redis-config.yml+DEV'),
  ('Createapplication.yml+SystemRole'),
  ('ModifyNamespace+public+cloudpvp-dev.datasource.yml'),
  ('ReleaseNamespace+public+cloudpvp-dev.datasource.yml'),
  ('ModifyNamespace+public+cloudpvp-dev.datasource.yml+DEV'),
  ('ReleaseNamespace+public+cloudpvp-dev.datasource.yml+DEV'),
  ('Master+auth'),
  ('ManageAppMaster+auth'),
  ('ModifyNamespace+auth+application.yml'),
  ('ReleaseNamespace+auth+application.yml'),
  ('ModifyNamespace+auth+application.yml+DEV'),
  ('ReleaseNamespace+auth+application.yml+DEV'),
  ('Master+gateway'),
  ('ManageAppMaster+gateway'),
  ('ModifyNamespace+gateway+application.yml'),
  ('ReleaseNamespace+gateway+application.yml'),
  ('ModifyNamespace+gateway+application.yml+DEV'),
  ('ReleaseNamespace+gateway+application.yml+DEV'),
  ('Master+lobby'),
  ('ManageAppMaster+lobby'),
  ('ModifyNamespace+lobby+application.yml'),
  ('ReleaseNamespace+lobby+application.yml'),
  ('ModifyNamespace+lobby+application.yml+DEV'),
  ('ReleaseNamespace+lobby+application.yml+DEV'),
  ('Master+play'),
  ('ManageAppMaster+play'),
  ('ModifyNamespace+play+application.yml'),
  ('ReleaseNamespace+play+application.yml'),
  ('ModifyNamespace+play+application.yml+DEV'),
  ('ReleaseNamespace+play+application.yml+DEV'),
  ('Master+state'),
  ('ManageAppMaster+state'),
  ('ModifyNamespace+state+application.yml'),
  ('ReleaseNamespace+state+application.yml'),
  ('ModifyNamespace+state+application.yml+DEV'),
  ('ReleaseNamespace+state+application.yml+DEV'),
  ('Master+user-summary'),
  ('ManageAppMaster+user-summary'),
  ('ModifyNamespace+user-summary+application.yml'),
  ('ReleaseNamespace+user-summary+application.yml'),
  ('ModifyNamespace+user-summary+application.yml+DEV'),
  ('ReleaseNamespace+user-summary+application.yml+DEV');

-- INSERT INTO `RolePermission` (`RoleId`, `PermissionId`)
-- VALUES
--   (1, 1),
--   (1, 2),
--   (1, 3),
--   (2, 4),
--   (3, 5);

-- INSERT INTO `UserRole` (`UserId`, `RoleId`)
-- VALUES
--   ('apollo', 1),
--   ('apollo', 2),
--   ('apollo', 3);

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
