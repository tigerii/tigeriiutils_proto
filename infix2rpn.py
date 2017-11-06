#!/usr/bin/env python

import re

precedence = {
  '^' : 4,
  '*' : 3,
  '/' : 3,
  '+' : 2,
  '-' : 2,
  '(' : 1,
  ')' : 1
}

associativity = {
  '^' : "right",
  '*' : "left",
  '/' : "left",
  '+' : "left",
  '-' : "left"
}

stack = []

formula = raw_input('formula:')

for token in formula.split():
  if re.match('\d+',token):
    print token,
  elif re.match('[\+\-\*\/]',token):
    while len(stack) > 0 and \
          ((associativity[token] == "left" and \
            precedence[token] == precedence[stack[-1]]) or \
           (precedence[token] <  precedence[stack[-1]])):
      print stack.pop(),
    stack.append(token)
  elif re.match('\(',token):
    stack.append(token)
  elif re.match('\)',token):
    while stack[-1]!="(":
      print stack.pop(),
    stack.pop()
  else:
    print "Incorrect data:", token

for token in reversed(stack):
  print token,
