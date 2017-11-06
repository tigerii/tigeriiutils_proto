#!/usr/bin/env ruby 

#s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13
#d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13
#c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13
#h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11.h12,h13

class String

  def suit
    return self[0]
  end

  def number
    return self[1..2].to_i
  end

end

cards = ARGV
print cards,"\n"

#is_flush
i = 1
cards[1..4].each do |c|
  if cards[0].suit == c.suit then
    i += 1
  end
end
if i == 5 then
  print "Flush!\n"
else
  print "Not Flush.\n"
end

#kinds
kinds = Hash.new{0}
cards.each do |c|
  kinds[c.number] += 1
end

pair=0
three=0
kinds.each do |num,count|
  print num, "\t", count, "\n"

  if count == 5 then
    print "Five of a kind!\n"
  elsif count == 4 then
    print "For of a kind!\n"
  elsif count == 3 then
    if pair == 1 then
      print "Full house!\n"
    else
      print "Three of a kind!\n"
    end
    three += 1
  elsif count == 2 then
    if three == 1 then
      print "Full house!\n"
    elsif pair == 1 then
      print "Two pair!\n"
    else
      print "One pair!\n"
    end
    pair += 1
  end
end

#is_straight
cards = cards.sort_by{|c| c.number}

if cards[0].number == 1 &&
   cards[1].number == 10 &&
   cards[2].number == 11 &&
   cards[3].number == 12 &&
   cards[4].number == 13 then

  print "Straight!\n"

elsif cards[0].number == cards[1].number-1 &&
      cards[1].number == cards[2].number-1 &&
      cards[2].number == cards[3].number-1 &&
      cards[3].number == cards[4].number-1 then

  print "Straight!\n"

else
  print "Not straight.\n"
end
