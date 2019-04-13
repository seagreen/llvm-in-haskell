; ModuleID = 'Main'
source_filename = "<string>"

@fmt = unnamed_addr constant [4 x i8] c"%d\0A\00"

declare i64 @printf(i8*, ...)

define i64 @main() {
Entry:
  %0 = icmp eq i64 1, 2
  br i1 %0, label %IfEqual, label %IfUnequal

IfEqual:                                          ; preds = %Entry
  %1 = add i64 2, 2
  br label %End

IfUnequal:                                        ; preds = %Entry
  %2 = add i64 3, 3
  br label %End

End:                                              ; preds = %IfUnequal, %IfEqual
  %3 = phi i64 [ %1, %IfEqual ], [ %2, %IfUnequal ]
  %4 = getelementptr inbounds [4 x i8], [4 x i8]* @fmt, i32 0, i32 0
  %5 = call i64 (i8*, ...) @printf(i8* %4, i64 %3)
  ret i64 0
}
