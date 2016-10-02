program bubblesort;

var
  i,j,n:integer;
  num  :integer;
  ary  :array[0..100] of integer;

procedure swap(var a, b:integer);
var temp:integer;
begin
  temp := a;
  a    := b;
  b    := temp;
end;

begin

  i := 0;
  readln(num);
  while num > 0 do
    begin
      ary[i] := num;
      i := i + 1;
      readln(num);
    end;

  n := i;
  for i:=1 to n do
    begin
      for j:=1 to n-i do
      begin
        if ary[j-1] > ary[j] then
          swap(ary[j-1],ary[j]);
      end;
    end;

  for i:=0 to n-1 do writeln(ary[i]);

end.
