@fmt = constant [4 x i8] c"%d\0A\00"

declare i64 @printf(i8*, ...)

define i64 @main() {
Entry:
  %cond = icmp eq i64 1, 2
  br i1 %cond, label %IfEqual, label %IfUnequal
IfEqual:
  %a = add i64 2, 2
  br label %End
IfUnequal:
  %b = add i64 3, 3
  br label %End
End:
  %res = phi i64 [ %a, %IfEqual ], [ %b, %IfUnequal ]
  %fmt_ptr = getelementptr [4 x i8], [4 x i8]* @fmt, i32 0, i32 0
  call i64 (i8*, ...) @printf(i8* %fmt_ptr, i64 %res)
  ret i64 0
}
