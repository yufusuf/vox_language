var returnval;
var global = 42;
fun f(arg1, arg2){
  var course = 444;
  var tmp;
  print "course";
  print course;
  tmp = course;
  course = global;
  global = tmp;
  print "course";
  print course;
  if #arg2
    return course+arg1;
  else
    return global-arg1;
}

print "global";
print global;
returnval = f(10, 3 < 5);
print "global new";
print global;
print "returnval";
print returnval;
