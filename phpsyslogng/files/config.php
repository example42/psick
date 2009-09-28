<?php
// Copyright (C) 2005 Claus Lund, clauslund@gmail.com

//========================================================================
// BEGIN: MISC FUNCTIONALITY
//========================================================================
define('PAGETITLE', 'php-syslog-ng');
define('VERSION', '2.8');

// COUNT_ROWS determines if results also display the number of total
// entries in the query. You need to have MySQL 4.0.0 or later for this
// to work. If you are using an older version of MySQL then disable this
// feature.
define('COUNT_ROWS', TRUE);

// DEFAULTLOGTABLE is the name of the table where new syslog entries are
// stored.
define('DEFAULTLOGTABLE', 'logs');

// MERGELOGTABLE is the name of the merge table. This feature should
// generally only be used in combination with the logrotate script.
// If it is enabled then the logrotate script will create a merge table
// of all the log tables. Be aware that you need to be a little careful
// when using merge tables so it is recommended that you only use it with
// the logrotate script. The merge table will also be the one used to
// populate the HOSTS and FACILITY fields on the search form.
define('MERGELOGTABLE', 'all_logs');

// If LOGROTATERETENTION is defined then it determines how many days logs
// are kept. Old log tables with a datestamp older than LOGROTATERETENTION
// days will be dropped.
define('LOGROTATERETENTION', 90);
//========================================================================
// END: MISC FUNCTIONALITY
//========================================================================


//========================================================================
// BEGIN: DATABASE CONNECTION INFO
//========================================================================
// DBUSER is the name of the basic user.
define('DBUSER', 'sysloguser');

// DBUSERPW is DBUSER's database password.
define('DBUSERPW', 'password');

// DBADMIN is the name of the admin user.
define('DBADMIN', 'syslogadmin');

// DBADMINPW is DBADMIN's database password.
define('DBADMINPW', 'password');

// DBNAME is the name of the database you are using.
define('DBNAME', 'syslog');

// DBHOST is the host where the MySQL server is running.
define('DBHOST', 'localhost');

// DBPORT is the port where the MySQL server is listening.
// The default port is 3306.
define('DBPORT', '3306');
//========================================================================
// END: DATABASE CONNECTION INFO
//========================================================================


//========================================================================
// BEGIN: AUTHENTICATION
//========================================================================
define('REQUIRE_AUTH', TRUE);
define('AUTHTABLENAME', 'users');

// Authentication has two modes:
// 1) You renew the session on every page view. This means you can have a
//    tail screen running and the session will never expire as long as you
//    refresh the screen before SESSION_EXP_TIME. This is the default.
// 2) The session is timed from the time you login. The session is only
//    refreshed on login.
define('RENEW_SESSION_ON_EACH_PAGE', TRUE);

// SESSION_EXP_TIME is seconds until the session expires.
define('SESSION_EXP_TIME', '3600');

// Set the URL to php-syslog-ng. If you don't then the login screen will
// not be able to redirect users automatically after a successful login.
define('URL', 'http://s01spy1.tenax.spa/phpsyslogng/');
//========================================================================
// END: AUTHENTICATION
//========================================================================


//========================================================================
// BEGIN: ACCESS CONTROL
//========================================================================
// Access Control Lists allows you to specify what individual users have
// access to. Access Control requires Authentication to have any effect.
// Currently only the Configure screen uses this options.
define('USE_ACL', TRUE);
define('USER_ACCESS_TABLE', 'user_access');
define('ACTION_TABLE', 'actions');
//========================================================================
// BEGIN: ACCESS CONTROL
//========================================================================


//========================================================================
// BEGIN: SEARCH CACHE
//========================================================================
// Enabling the search cache will create a small table with the values
// needed to fill in the HOSTS and FACILITY fields on the search page.
// The cache table has to filled/updated by either clicking the refresh
// cache option or periodically running the updateCache.php script (from
// cron).
// If you use the MERGELOGTABLE then the cache will be updated using that
// table. If you do not use MERGELOGTABLE then the cache is updated for
// each table with log data.
define('USE_CACHE', TRUE);
define('CACHETABLENAME', 'search_cache');
//========================================================================
// END: SEARCH CACHE
//========================================================================


//========================================================================
// BEGIN: REG EXP ARRAY USED FOR INPUT VALIDATION
//========================================================================
$regExpArray = array(
	"username"=>"(^\\w{4,}\$)",
	"password"=>"(^.{4,}\$)",
	"pageId"=>"(^\\w+$)",
	"sessionId"=>"(^\\w{32}\$)",
	"date"=>"/^yesterday$|^today$|^now$|^(\\d){4}-([01]*\\d)-([0123]*\\d)$/i",
	"time"=>"/^now$|^([012]*\\d):([012345]*\\d):([012345]*\\d)$/i",
	"limit"=>"(^\\d+$)",
	"orderby"=>"/^seq$|^host$|^facility$|^priority$|^datetime$/i",
	"order"=>"/^asc$|^desc$/i",
	"offset"=>"(^\\d+$)",
	"collapse"=>"/^1$/",
	"table"=>"(^\\w+$)",
	"excludeX"=>"(^[01]$)",
	"host"=>"(^[\\w-.]+$)",
	"facility"=>"(^\\w+$)",
	"priority"=>"/^debug$|^info$|^notice$|^warning$|^err$|^crit$|^alert$|^emerg$/i",
);
//========================================================================
// END: REG EXP ARRAY USED FOR INPUT VALIDATION
//========================================================================
?>
