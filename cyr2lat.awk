#!/usr/bin/gawk -f
BEGIN{

  FS = ",";
  while( getline < "cyr2lat.txt" ){
    cyr2lat[$1] = $2;
  }

  for(i=1;i<ARGC;i++){
    print ARGV[i];
    num = split(ARGV[i],word,"")
    for(j=1; j<=num; j++){
      printf cyr2lat[word[j]];
    }
    print "";
  }

}
