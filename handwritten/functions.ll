@fmt = constant [4 x i8] c"%d\0A\00"

declare i64 @printf(i8*, ...)

define i64 @double(i64 %n) {
  %res = add i64 %n, %n
  ret i64 %res
}

define i64 @plus_one(i64 %n) {
  %res = add i64 %n, 1
  ret i64 %res
}

define i64 @main() {
  %res1 = call i64 @double(i64 2)
  %res2 = call i64 @plus_one(i64 %res1)
  %fmt_ptr = getelementptr [4 x i8], [4 x i8]* @fmt, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %fmt_ptr, i64 %res2)
  ret i64 0
}
