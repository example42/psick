CREATE DATABASE IF NOT EXISTS syslog;
USE syslog;
CREATE TABLE IF NOT EXISTS logs (
host varchar(32) default NULL,
facility varchar(10) default NULL,
priority varchar(10) default NULL,
level varchar(10) default NULL,
tag varchar(10) default NULL,
datetime datetime default NULL,
program varchar(15) default NULL,
msg text,
seq bigint(20) unsigned NOT NULL auto_increment,
PRIMARY KEY (seq), KEY host (host),
KEY program (program), KEY datetime (datetime),
KEY priority (priority), KEY facility (facility)
) TYPE=MyISAM;

CREATE TABLE IF NOT EXISTS users (
username varchar(32) default NULL,
pwhash char(40) default NULL,
sessionid char(32) default NULL,
exptime datetime default NULL,
PRIMARY KEY (username)
) TYPE=MyISAM;

CREATE TABLE IF NOT EXISTS  search_cache (
tablename varchar(32) DEFAULT NULL,
type ENUM('HOST','FACILITY'),
value varchar(32) DEFAULT NULL,
updatetime datetime DEFAULT NULL,
INDEX type_name (type, tablename)
) TYPE=MyISAM;

CREATE TABLE IF NOT EXISTS user_access (
username varchar(32) DEFAULT NULL,
actionname varchar(32) DEFAULT NULL,
access ENUM('TRUE','FALSE'),
INDEX user_action (username, actionname)
) TYPE=MyISAM;

CREATE TABLE IF NOT EXISTS actions (
actionname varchar(32) NOT NULL,
actiondescr varchar(64) DEFAULT NULL,
defaultaccess ENUM('TRUE','FALSE'),
PRIMARY KEY (actionname)
) TYPE=MyISAM;

INSERT INTO actions (actionname, actiondescr, defaultaccess) VALUES ('add_user', 'Add users', 'TRUE');
INSERT INTO actions (actionname, actiondescr, defaultaccess) VALUES ('edit_user', 'Edit users (delete and change password)', 'TRUE');
INSERT INTO actions (actionname, actiondescr, defaultaccess) VALUES ('reload_cache', 'Reload search cache', 'TRUE');
INSERT INTO actions (actionname, actiondescr, defaultaccess) VALUES ('edit_acl', 'Edit access control settings', 'TRUE');

INSERT INTO users (username, pwhash) VALUES('admin', 'd033e22ae348aeb5660fc2140aec35850c4da997');

COMMIT;
