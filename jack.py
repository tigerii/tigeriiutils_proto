#!/usr/bin/env python

import sys
import re

str = "-1"

print "Hello!"
while not re.search("^[0-9]$",str):
  print "How many decks?(1-9)"
  str = raw_input('>')

print "Let's get started!"

decks = int(str)
cards = []
counter = {}

counter['1'] = 0
counter['2'] = 0
counter['3'] = 0
counter['4'] = 0
counter['5'] = 0
counter['6'] = 0
counter['7'] = 0
counter['8'] = 0
counter['9'] = 0
counter['10-13'] = 0

i = 0

while i < decks*52:

  str = raw_input('>')

  if re.search("^[sdchSDCH]1$",str):
    if cards.count(str) < decks:
      counter['1'] += 1
      cards.append(str)
      i+=1
    else:
      print "Invalid input!!"
  elif re.search("^[sdchSDCH]2$",str):
    if cards.count(str) < decks:
      counter['2'] += 1
      cards.append(str)
      i+=1
    else:
      print "Invalid input!!"
  elif re.search("^[sdchSDCH]3$",str):
    if cards.count(str) < decks:
      counter['3'] += 1
      cards.append(str)
      i+=1
    else:
      print "Invalid input!!"
  elif re.search("^[sdchSDCH]4$",str):
    if cards.count(str) < decks:
      counter['4'] += 1
      cards.append(str)
      i+=1
    else:
      print "Invalid input!!"
  elif re.search("^[sdchSDCH]5$",str):
    if cards.count(str) < decks:
      counter['5'] += 1
      cards.append(str)
      i+=1
    else:
      print "Invalid input!!"
  elif re.search("^[sdchSDCH]6$",str):
    if cards.count(str) < decks:
      counter['6'] += 1
      cards.append(str)
      i+=1
    else:
      print "Invalid input!!"
  elif re.search("^[sdchSDCH]7$",str):
    if cards.count(str) < decks:
      counter['7'] += 1
      cards.append(str)
      i+=1
    else:
      print "Invalid input!!"
  elif re.search("^[sdchSDCH]8$",str):
    if cards.count(str) < decks:
      counter['8'] += 1
      cards.append(str)
      i+=1
    else:
      print "Invalid input!!"
  elif re.search("^[sdchSDCH]9$",str):
    if cards.count(str) < decks:
      counter['9'] += 1
      cards.append(str)
      i+=1
    else:
      print "Invalid input!!"
  elif re.search("^[sdchSDCH]10$",str):
    if cards.count(str) < decks:
      counter['10-13'] += 1
      cards.append(str)
      i+=1
    else:
      print "Invalid input!!"
  elif re.search("^[sdchSDCH]11$",str):
    if cards.count(str) < decks:
      counter['10-13'] += 1
      cards.append(str)
      i+=1
    else:
      print "Invalid input!!"
  elif re.search("^[sdchSDCH]12$",str):
    if cards.count(str) < decks:
      counter['10-13'] += 1
      cards.append(str)
      i+=1
    else:
      print "Invalid input!!"
  elif re.search("^[sdchSDCH]13$",str):
    if cards.count(str) < decks:
      counter['10-13'] += 1
      cards.append(str)
      i+=1
    else:
      print "Invalid input!!"
  elif re.search("^bye$",str):
    sys.exit()
  elif re.search("^(c|car|card|cards)$",str):
    print cards
  elif re.search("^pop$",str):
    cards.pop()
    #kauntarkarakesu
  elif re.search("^(r|ra|rat|rate)$",str):
    print "1:",(4.*decks-counter['1'])/(52.*decks-i)
    print "2:",(4.*decks-counter['2'])/(52.*decks-i)
    print "3:",(4.*decks-counter['3'])/(52.*decks-i)
    print "4:",(4.*decks-counter['4'])/(52.*decks-i)
    print "5:",(4.*decks-counter['5'])/(52.*decks-i)
    print "6:",(4.*decks-counter['6'])/(52.*decks-i)
    print "7:",(4.*decks-counter['7'])/(52.*decks-i)
    print "8:",(4.*decks-counter['8'])/(52.*decks-i)
    print "9:",(4.*decks-counter['9'])/(52.*decks-i)
    print "10-13:",(16.*decks-counter['10-13'])/(52.*decks-i)
  else:
    print "Invalid input!"


