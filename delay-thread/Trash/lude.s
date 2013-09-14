; ModuleID = 'lude.a.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%union.pthread_attr_t = type { i64, [48 x i8] }

@.str = private unnamed_addr constant [8 x i8] c"%d: %f \00", align 1
@.str1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str2 = private unnamed_addr constant [24 x i8] c"ludecomp_%d_1thread.txt\00", align 1

define double @frand() nounwind uwtable {
entry:
  %value = alloca double, align 8
  %call = call i32 @rand() nounwind
  %conv = sitofp i32 %call to double
  %div = fdiv double %conv, 0x41DFFFFFFFC00000
  store double %div, double* %value, align 8
  %0 = load double* %value, align 8
  ret double %0
}

declare i32 @rand() nounwind

define void @printMatrix(double* %dMatrix, i32 %nRows, i32 %nCols) nounwind uwtable {
entry:
  %dMatrix.addr = alloca double*, align 8
  %nRows.addr = alloca i32, align 4
  %nCols.addr = alloca i32, align 4
  %row = alloca i32, align 4
  %col = alloca i32, align 4
  store double* %dMatrix, double** %dMatrix.addr, align 8
  store i32 %nRows, i32* %nRows.addr, align 4
  store i32 %nCols, i32* %nCols.addr, align 4
  store i32 0, i32* %row, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc7, %entry
  %0 = load i32* %row, align 4
  %1 = load i32* %nRows.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end9

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %col, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %2 = load i32* %col, align 4
  %3 = load i32* %nCols.addr, align 4
  %cmp2 = icmp slt i32 %2, %3
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %4 = load i32* %col, align 4
  %5 = load i32* %nRows.addr, align 4
  %mul = mul nsw i32 %4, %5
  %6 = load i32* %row, align 4
  %add = add nsw i32 %mul, %6
  %7 = load i32* %col, align 4
  %8 = load i32* %nRows.addr, align 4
  %mul4 = mul nsw i32 %7, %8
  %9 = load i32* %row, align 4
  %add5 = add nsw i32 %mul4, %9
  %idxprom = sext i32 %add5 to i64
  %10 = load double** %dMatrix.addr, align 8
  %arrayidx = getelementptr inbounds double* %10, i64 %idxprom
  %11 = load double* %arrayidx
  %call = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i32 0, i32 0), i32 %add, double %11)
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %12 = load i32* %col, align 4
  %inc = add nsw i32 %12, 1
  store i32 %inc, i32* %col, align 4
  br label %for.cond1

for.end:                                          ; preds = %for.cond1
  %call6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([2 x i8]* @.str1, i32 0, i32 0))
  br label %for.inc7

for.inc7:                                         ; preds = %for.end
  %13 = load i32* %row, align 4
  %inc8 = add nsw i32 %13, 1
  store i32 %inc8, i32* %row, align 4
  br label %for.cond

for.end9:                                         ; preds = %for.cond
  ret void
}

declare i32 @printf(i8*, ...)

define i32 @test(i32 %argc, i8** %argv) nounwind uwtable {
entry:
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %i = alloca i64, align 8
  %j = alloca i64, align 8
  %MSIZE = alloca i64, align 8
  %dMatrix = alloca double*, align 8
  %nPivotIndices = alloca i64*, align 8
  %info = alloca i64*, align 8
  %nResult = alloca i32, align 4
  %seed = alloca i32, align 4
  %attr = alloca %union.pthread_attr_t, align 8
  %Thread = alloca i64, align 8
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 8
  store i32 123456789, i32* %seed, align 4
  %call = call i32 @pthread_attr_init(%union.pthread_attr_t* %attr) nounwind
  %call1 = call i32 @pthread_attr_setdetachstate(%union.pthread_attr_t* %attr, i32 0) nounwind
  %0 = load i32* %argc.addr, align 4
  %cmp = icmp eq i32 %0, 2
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  %1 = load i8*** %argv.addr, align 8
  %arrayidx = getelementptr inbounds i8** %1, i64 1
  %2 = load i8** %arrayidx
  %call2 = call i32 @atoi(i8* %2) nounwind readonly
  br label %cond.end

cond.false:                                       ; preds = %entry
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %call2, %cond.true ], [ 2048, %cond.false ]
  %conv = sext i32 %cond to i64
  store i64 %conv, i64* %MSIZE, align 8
  %3 = load i64* %MSIZE, align 8
  %mul = mul i64 8, %3
  %4 = load i64* %MSIZE, align 8
  %mul3 = mul i64 %mul, %4
  %call4 = call noalias i8* @malloc(i64 %mul3) nounwind
  %5 = bitcast i8* %call4 to double*
  store double* %5, double** %dMatrix, align 8
  %6 = load i32* %seed, align 4
  call void @srand(i32 %6) nounwind
  store i64 0, i64* %i, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc14, %cond.end
  %7 = load i64* %i, align 8
  %8 = load i64* %MSIZE, align 8
  %cmp5 = icmp slt i64 %7, %8
  br i1 %cmp5, label %for.body, label %for.end16

for.body:                                         ; preds = %for.cond
  store i64 0, i64* %j, align 8
  br label %for.cond7

for.cond7:                                        ; preds = %for.inc, %for.body
  %9 = load i64* %j, align 8
  %10 = load i64* %MSIZE, align 8
  %cmp8 = icmp slt i64 %9, %10
  br i1 %cmp8, label %for.body10, label %for.end

for.body10:                                       ; preds = %for.cond7
  %call11 = call double @frand()
  %11 = load i64* %i, align 8
  %12 = load i64* %MSIZE, align 8
  %mul12 = mul nsw i64 %11, %12
  %13 = load i64* %j, align 8
  %add = add nsw i64 %mul12, %13
  %14 = load double** %dMatrix, align 8
  %arrayidx13 = getelementptr inbounds double* %14, i64 %add
  store double %call11, double* %arrayidx13
  br label %for.inc

for.inc:                                          ; preds = %for.body10
  %15 = load i64* %j, align 8
  %inc = add nsw i64 %15, 1
  store i64 %inc, i64* %j, align 8
  br label %for.cond7

for.end:                                          ; preds = %for.cond7
  br label %for.inc14

for.inc14:                                        ; preds = %for.end
  %16 = load i64* %i, align 8
  %inc15 = add nsw i64 %16, 1
  store i64 %inc15, i64* %i, align 8
  br label %for.cond

for.end16:                                        ; preds = %for.cond
  %17 = load i64* %MSIZE, align 8
  %mul17 = mul i64 %17, 8
  %call18 = call noalias i8* @malloc(i64 %mul17) nounwind
  %18 = bitcast i8* %call18 to i64*
  store i64* %18, i64** %nPivotIndices, align 8
  %call19 = call noalias i8* @malloc(i64 8) nounwind
  %19 = bitcast i8* %call19 to i64*
  store i64* %19, i64** %info, align 8
  %call20 = call i32 @pthread_create(i64* %Thread, %union.pthread_attr_t* %attr, i8* (i8*)* @__dt_papi_kernel2, i8* null) nounwind
  %20 = load double** %dMatrix, align 8
  %21 = load i64** %nPivotIndices, align 8
  %22 = load i64** %info, align 8
  %call21 = call i32 @dgetrf_(i64* %MSIZE, i64* %MSIZE, double* %20, i64* %MSIZE, i64* %21, i64* %22)
  store i32 %call21, i32* %nResult, align 4
  %23 = load i64* %Thread, align 8
  %call22 = call i32 @pthread_cancel(i64 %23)
  %24 = load double** %dMatrix, align 8
  %25 = bitcast double* %24 to i8*
  call void @free(i8* %25) nounwind
  %26 = load i64** %nPivotIndices, align 8
  %27 = bitcast i64* %26 to i8*
  call void @free(i8* %27) nounwind
  %28 = load i64** %info, align 8
  %29 = bitcast i64* %28 to i8*
  call void @free(i8* %29) nounwind
  ret i32 0
}

declare i32 @pthread_attr_init(%union.pthread_attr_t*) nounwind

declare i32 @pthread_attr_setdetachstate(%union.pthread_attr_t*, i32) nounwind

declare i32 @atoi(i8*) nounwind readonly

declare noalias i8* @malloc(i64) nounwind

declare void @srand(i32) nounwind

declare i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) nounwind

declare i8* @__dt_papi_kernel2(i8*)

declare i32 @dgetrf_(i64*, i64*, double*, i64*, i64*, i64*)

declare i32 @pthread_cancel(i64)

declare void @free(i8*) nounwind

define i32 @main(i32 %argc, i8** %argv) nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %filename = alloca [50 x i8], align 16
  %MSIZE = alloca i32, align 4
  store i32 0, i32* %retval
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 8
  %0 = load i32* %argc.addr, align 4
  %cmp = icmp eq i32 %0, 2
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  %1 = load i8*** %argv.addr, align 8
  %arrayidx = getelementptr inbounds i8** %1, i64 1
  %2 = load i8** %arrayidx
  %call = call i32 @atoi(i8* %2) nounwind readonly
  br label %cond.end

cond.false:                                       ; preds = %entry
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %call, %cond.true ], [ 2048, %cond.false ]
  store i32 %cond, i32* %MSIZE, align 4
  %arraydecay = getelementptr inbounds [50 x i8]* %filename, i32 0, i32 0
  %3 = load i32* %MSIZE, align 4
  %call1 = call i32 (i8*, i8*, ...)* @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([24 x i8]* @.str2, i32 0, i32 0), i32 %3) nounwind
  %arraydecay2 = getelementptr inbounds [50 x i8]* %filename, i32 0, i32 0
  call void @__dt_papi_prolog(i8* %arraydecay2)
  %4 = load i32* %argc.addr, align 4
  %5 = load i8*** %argv.addr, align 8
  %call3 = call i32 @test(i32 %4, i8** %5)
  call void (...)* @__dt_papi_epilog()
  ret i32 0
}

declare i32 @sprintf(i8*, i8*, ...) nounwind

declare void @__dt_papi_prolog(i8*)

declare void @__dt_papi_epilog(...)
