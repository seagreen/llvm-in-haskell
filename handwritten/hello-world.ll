@fmt = constant [4 x i8] c"%s\0A\00"
@hello = constant [12 x i8] c"hello world\00"

declare i64 @printf(i8*, ...)

define i64 @main() {
  %fmt_ptr = getelementptr [4 x i8], [4 x i8]* @fmt, i64 0, i64 0
  call i64 (i8*, ...) @printf(i8* %fmt_ptr, [12 x i8]* @hello)
  ret i64 0
}
