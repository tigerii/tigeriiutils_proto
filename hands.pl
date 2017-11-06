#!/usr/bin/env perl

#s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13
#d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13
#c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13
#h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11.h12,h13

@cards = @ARGV;
print "@cards\n";

#is_flush
$i = 1;
while( substr($cards[0],0,1) eq substr($cards[$i],0,1) ){
  $i++;
}
if( $i == 5 ){
  print "Flush!\n";
}else{
  print "Not Flush.\n";
}

#kinds
foreach(@cards){
  $kinds{substr($_,1,2)}++;
}

foreach $key ( keys %kinds ){
  print "$key, $kinds{$key}\n";

  if( $kinds{$key} == 5 ){
    print "Five of a kind!\n";
  }elsif( $kinds{$key} == 4 ){
    print "For of a kind!\n";
  }elsif( $kinds{$key} == 3 ){
    if( $pair == 1 ){
      print "Full house!\n";
    }else{
      print "Three of a kind!\n";
    }
    $three++;
  }elsif( $kinds{$key} == 2 ){
    if( $three == 1 ){
      print "Full house!\n";
    }elsif( $pair == 1 ){
      print "Two pair!\n";
    }else{
      print "One pair!\n";
    }
    $pair++;
  }
}

#is_straight
if( substr($cards[0],1,2) == 1 &&
    substr($cards[1],1,2) == 10 &&
    substr($cards[2],1,2) == 11 &&
    substr($cards[3],1,2) == 12 &&
    substr($cards[4],1,2) == 13 ){

  print "Straight!\n";

}elsif( substr($cards[0],1,2) == substr($cards[1],1,2)-1 &&
        substr($cards[1],1,2) == substr($cards[2],1,2)-1 &&
        substr($cards[2],1,2) == substr($cards[3],1,2)-1 &&
        substr($cards[3],1,2) == substr($cards[4],1,2)-1 ){

  print "Straight!\n";

}else{
  print "Not straight.\n";
}
