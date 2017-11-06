use DBI;

$dbh = DBI->connect('dbi:ODBC:adventureworks2014','','') || die $!;
$sth = $dbh->prepare("select * from information_schema.columns") || $!;

$sth->execute || die $dbh->errstr;
$length = $sth->{NUM_OF_FIELDS};
while(@row = $sth->fetchrow_array){
  for($i=0; $i<$length-1; $i++){
    print $sth->{NAME}->[$i]."=".$row[$i].",";
  }
  print $sth->{NAME}->[$length-1]."=".$row[$length-1]."\n";
}
$sth->finish();
$dbh->disconnect;
