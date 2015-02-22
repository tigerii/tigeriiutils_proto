#!/usr/bin/env perl

use DBI;
use Spreadsheet::WriteExcel;

$ENV{ORACLE_HOME}='/u01/app/oracle/product/11.2.0/xe';
$ENV{ORACLE_SID}='XE';
$ENV{NLS_LANG}='JAPANESE_JAPAN.AL32UTF8';
$ENV{NLS_DATE_FORMAT}='yyyy/mm/dd hh24:mi:ss';
$user = 'hr';
$password = '******';

$workbook = Spreadsheet::WriteExcel->new('table_info.xls');

$dbh = DBI->connect("dbi:Oracle:$ENV{ORACLE_SID}",$user,$password);

while(<>){
  chomp();
  
$sql = <<EOS;
select user_tab.column_name,
       user_tab.data_type,
       user_tab.data_length,
       user_col.comments
from user_tab_cols user_tab, user_col_comments user_col
where user_tab.table_name = '$_' and
      user_tab.table_name = user_col.table_name and
      user_tab.column_name = user_col.column_name
EOS

  $sth = $dbh->prepare($sql);
  $sth->execute();

  $worksheet = $workbook->add_worksheet($_);
  $format = $workbook->add_format();

  $i = 0;
  while(@row=$sth->fetchrow_array()){
    $j = 0;
    foreach(@row){
      $worksheet->write_string($i, $j, $_, $format);
      #print $worksheet->get_name,",$i,$j,$_\n";
      $j++;
    }
    $i++;
  }

  $sth->finish();
  
}

$dbh->disconnect();

$workbook->close();
