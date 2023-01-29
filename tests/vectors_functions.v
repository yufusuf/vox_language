var a = [1,2,3,4,5];
fun f1(arg1){
  a[3] = arg1;
  return arg1;
}
fun f2(){
  var x = [10,20,30];
  return x;
}

print f2();
print a;
print f1(10);
print a;
