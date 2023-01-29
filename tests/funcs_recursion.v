fun fib(n){
  if n <= 1 return 1;
  return fib(n-1)+fib(n-2);
}

fun even(n){
  if n == 0 return true;
  else if n < 0 return false;
  return odd(n-1);
}

fun odd(n){
  return even(n-1);
}

print fib(5);
print even(10);
//print even(10000000);
