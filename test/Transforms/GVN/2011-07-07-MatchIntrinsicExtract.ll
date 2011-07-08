; RUN: opt < %s -gvn -S | FileCheck %s
;

%0 = type { i64, i1 }

define i64 @test1(i64 %a, i64 %b) nounwind ssp {
entry:
  %uadd = tail call %0 @llvm.uadd.with.overflow.i64(i64 %a, i64 %b)
  %uadd.0 = extractvalue %0 %uadd, 0
  %add1 = add i64 %a, %b
  ret i64 %add1
}

; CHECK: @test1
; CHECK-NOT: add1
; CHECK: ret

define i64 @test2(i64 %a, i64 %b) nounwind ssp {
entry:
  %usub = tail call %0 @llvm.usub.with.overflow.i64(i64 %a, i64 %b)
  %usub.0 = extractvalue %0 %usub, 0
  %sub1 = sub i64 %a, %b
  ret i64 %sub1
}

; CHECK: @test2
; CHECK-NOT: sub1
; CHECK: ret

define i64 @test3(i64 %a, i64 %b) nounwind ssp {
entry:
  %umul = tail call %0 @llvm.umul.with.overflow.i64(i64 %a, i64 %b)
  %umul.0 = extractvalue %0 %umul, 0
  %mul1 = mul i64 %a, %b
  ret i64 %mul1
}

; CHECK: @test3
; CHECK-NOT: mul1
; CHECK: ret


declare void @exit(i32) noreturn
declare %0 @llvm.uadd.with.overflow.i64(i64, i64) nounwind readnone
declare %0 @llvm.usub.with.overflow.i64(i64, i64) nounwind readnone
declare %0 @llvm.umul.with.overflow.i64(i64, i64) nounwind readnone

