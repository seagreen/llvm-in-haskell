; ModuleID = 'Main'
source_filename = "<string>"

@fmt = unnamed_addr constant [4 x i8] c"%s\0A\00"
@hello = unnamed_addr constant [12 x i8] c"hello world\00"

declare i64 @printf(i8*, ...)

define i64 @main() {
  %1 = getelementptr inbounds [4 x i8], [4 x i8]* @fmt, i32 0, i32 0
  %2 = getelementptr inbounds [12 x i8], [12 x i8]* @hello, i32 0, i32 0
  %3 = call i64 (i8*, ...) @printf(i8* %1, i8* %2)
  ret i64 0
}
