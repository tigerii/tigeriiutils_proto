#!/usr/bin/perl

use LWP::UserAgent;
use URI;
use utf8;

my $id = '909253';
my $uri = URI->new('https://itunes.apple.com/lookup');
my $params = {
    id => $id
};

$uri->query_form(%$params);
my $ua = LWP::UserAgent->new;
#my $res = $ua->get($uri);
my $res = $ua->post($uri,\@params);

print $uri;
if($res->is_success){
  print $res->content;
}else{
  die $res->status_line;
}
