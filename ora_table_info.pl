#!/usr/bin/env perl

use DBI;

$ENV{ORACLE_HOME}='/u01/app/oracle/product/11.2.0/xe';
$driver = 'Oracle';

if( $ARGV[0] =~ /(\S+)\/(\S+)\@(\S+):(\d+)\/(\S+)/ ){
  $user     = $1;
  $password = $2;
  $hostname = $3;
  $port     = $4;
  $sid      = $5;
}else{
  die "usage: ora_table_info.pl <user>/<password>@<hostname>:<port>/<sid> <owner>"
}

#dbi:$driver:database=$db;host=$host;port=$port
$dbh = DBI->connect("dbi:$driver:host=$hostname;sid=$sid;port=$port",$user,$password);

$sql_table_name = <<EOS;
select table_name
from all_tables where owner='$ARGV[1]'
order by table_name
EOS
$sth_table_name = $dbh->prepare($sql_table_name);
$sth_table_name->execute();

print "<owner name=\"$ARGV[1]\">\n";
while($table_name=$sth_table_name->fetchrow_array()){

$sql_table_info = <<EOS;
select utcol.column_name,
       utcol.data_type,
       utcol.data_length,
       uccom.comments
from user_tab_cols utcol, user_col_comments uccom
where utcol.table_name = '$table_name' and
      utcol.table_name = uccom.table_name and
      utcol.column_name = uccom.column_name
EOS

  $sth_table_info = $dbh->prepare($sql_table_info);
  $sth_table_info->execute();

  print "  <table name=\"$table_name\">\n";

  print "    <row><!--header-->\n";
  for($i=0; $i<$sth_table_info->{NUM_OF_FIELDS}; $i++){
    print "      <column name=\"$sth_table_info->{NAME}->[$i]\">$sth_table_info->{NAME}->[$i]<\/column>\n";
  }
  print "    <\/row><!--header-->\n";

  while(@row=$sth_table_info->fetchrow_array()){
    print "    <row>\n";
    for($i=0; $i<$sth_table_info->{NUM_OF_FIELDS}; $i++){
      print "      <column name=\"$sth_table_info->{NAME}->[$i]\">$row[$i]<\/column>\n";
    }
    print "    <\/row>\n";
  }

  print "  </table>\n";

  $sth_table_info->finish();

}
print "<\/owner>\n";

$sth_table_name->finish();
$dbh->disconnect();
