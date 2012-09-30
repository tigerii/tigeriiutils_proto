#!/usr/bin/env perl

use Time::Piece;

@value = (0, 0, 2, 0, 2, 2, 4, 5, 6, 7, 8, 9, 10);

$time = localtime;

print $time->strftime(),"\n";

$the_age_of_the_moon = ((($time->year - 11) % 19) * 11 + $value[$time->mon] + $time->mday) % 30;

print "The age of the moon: $the_age_of_the_moon\n";
