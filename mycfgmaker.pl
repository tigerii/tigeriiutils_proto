#!/usr/local/env perl

$snmpwalk = "/usr/local/bin/snmpwalk";
$rrddir   = "/usr/local/apache/htdocs/mrtg";
$icondir  = "/usr/local/mrtg-2/share/mrtg2/icons/";
$absmax  = "125000000";

$pathadd = "/usr/local/rrdtool/bin/";
$libadd  = "/usr/local/rrdtool/lib/perl\n";
$rrdrowcount = "12960";
$maxbytes = "12500000";

$usage =<<EOS;
usage : mycfgmaker.pl [-global]
                      [-interval min] 
                       -v 1|2c|3
                       -c community
                       -object octets|discards|errors|unicastpkts|broadcastpkts|multicastpkts
                        hostname
EOS

if($#ARGV < 6){ die $usage; }

$i = 0;
while($i < $#ARGV){
  if($ARGV[$i] =~ /^-global$/){
    $global++;
  }elsif($ARGV[$i] =~ /^-interval$/){
    $i++;
    $interval = $ARGV[$i];
  }elsif($ARGV[$i] =~ /^-v$/){
    $i++;
    $snmpversion = $ARGV[$i];
    if(!($snmpversion =~ /^1$|^2c$|^3$/)){
      die "invalid option $ARGV[$i-1] $ARGV[$i]\n";
    }
  }elsif($ARGV[$i] =~ /^-c$/){
    $i++;
    $community = $ARGV[$i];
  }elsif($ARGV[$i] =~ /^-object$/){
    $i++;
    $object = $ARGV[$i];
    if( $object =~ /^octets$/ ){
      @oid = ('ifInOctets','ifOutOctets');
    }elsif( $object =~ /^discards$/ ){
      @oid = ('ifInDiscards','ifOutDiscards');
    }elsif( $object =~ /^errors$/ ){
      @oid = ('ifInErrors','ifOutErrors');
    }elsif( $object =~ /^unicastpkts$/ ){
      @oid = ('ifInUcastPkts','ifOutUcastPkts');
    }elsif( $object =~ /^multicastpkts$/ ){
      @oid = ('ifInMulticastPkts','ifOutMulticastPkts');
    }elsif( $object =~ /^broadcastpkts$/ ){
      @oid = ('ifInBroadcastPkts','ifOutBroadcastPkts');
    }else{
      die "invalid option $ARGV[$i-1] $ARGV[$i]\n";
    }
  }elsif($ARGV[$i] =~ /^-\S+$/){
    die "invalid option $ARGV[$i]\n";
  }else{
    die $usage;
  }
  $i++;
}

$hostname = $ARGV[$#ARGV];
$title = "$hostname-$object";

if($global > 0){
  print "Title[_]: $title\n";
  print "WorkDir: $rrddir\n";
  print "IconDir: $icondir\n";
  print "AbsMax[_]: $absmax\n";
  print "Forks: 4\n";
  print "SnmpOptions: timeout => 10, retries => 3\n";

  print "LogFormat: rrdtool\n";
  print "PathAdd: $pathadd\n";
  print "LibAdd: $libadd\n";
  print "RRDRowCount[_]: $rrdrowcount\n";

  print "\n";
}

if($interval > 0){
  print "Interval: $interval\n\n";
}

open(IFINDEX, "$snmpwalk -v $snmpversion -c $community $hostname IF-MIB::ifIndex|");
open(IFDESCR, "$snmpwalk -v $snmpversion -c $community $hostname IF-MIB::ifDescr|");

while(($ifindex = <IFIDEX>) && ($ifdescr = <IFDESCR>)){
  $ifindex=~/^\S+ \= \w+: (\d+)/; $index = $1;
  $ifdescr=~/^\S+ \= \w+: (.+)$/; $descr = $1;
  print "\#$descr\n";

  #delete
  $descr =~ s/[\/\\\:\*\?\<\>\|\#\{\}\%\&\~\[\]]//g;

  $descr =~ s/-/_/g;

  #delete space, and join
  @temp = split(/\s+/,$descr);
  $descr = join("_",@temp);

  $target_name = $descr;

  @temp = @oid;
  grep(s/.*/$_."\.$index"/e,@temp);
  $oids = join("&",@temp);
  print "Target[$target_name]: $oids:$community\@$hostname\n";
  print "Directory[$target_name]: $hostname/$object\n";
  print "Maxbytes[$target_name]: $maxbytes\n";
  print "\n";
}

close(IFINDEX);
close(IFDESCR);
