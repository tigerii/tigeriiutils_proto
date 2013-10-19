#!/usr/bin/env perl

use Encode;

open(FILE,"cyr2lat.txt") || die "cyr2lat.txt not found.";

while(<FILE>){
  chomp;
  ($cyr,$lat) = split(/,/);
  $cyr2lat{$cyr} = $lat;
}

foreach $word (@ARGV){
  print "$word\n";
  utf8::decode($word);
  foreach $char (split //, $word){
    utf8::encode($char);
    if( $cyr2lat{$char} ){
      print $cyr2lat{$char};
    }else{
      print $char;
    }
  }
  print "\n";
}
