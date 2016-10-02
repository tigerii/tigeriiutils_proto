#!/usr/bin/env perl

use DBD::Oracle;

$ENV{ORACLE_HOME} = "/u01/app/oracle/product/11.2.0/xe";

$driver = 'Oracle';
$host = 'localhost';
$sid = 'xe';

$dbh = DBI->connect("dbi:$driver:host=$host;sid=$sid","hr","hr");
$sth = $dbh->prepare("select * from jobs");
$sth->execute;
while(@row = $sth->fetchrow){
  print "@row\n";
}
