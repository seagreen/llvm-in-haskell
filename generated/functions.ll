; ModuleID = 'Main'
source_filename = "<string>"

@fmt = unnamed_addr constant [4 x i8] c"%d\0A\00"

declare i64 @printf(i8*, ...)

define i64 @double(i64 %n) {
  %1 = add i64 %n, %n
  ret i64 %1
}

define i64 @plus_one(i64 %n) {
  %1 = add i64 %n, 1
  ret i64 %1
}

define i64 @main() {
  %1 = call i64 @double(i64 2)
  %2 = call i64 @plus_one(i64 %1)
  %3 = getelementptr inbounds [4 x i8], [4 x i8]* @fmt, i32 0, i32 0
  %4 = call i64 (i8*, ...) @printf(i8* %3, i64 %2)
  ret i64 0
}
