; ModuleID = 'lude2.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.periodic_info = type { i32, i64 }
%struct.itimerspec = type { %struct.timespec, %struct.timespec }
%struct.timespec = type { i64, i64 }
%struct.ThrdArg = type { double*, i32, i32* }
%union.pthread_attr_t = type { i64, [48 x i8] }
%union.PAPI_option_t = type { %struct._papi_addr_range_option, [232 x i8] }
%struct._papi_addr_range_option = type { i32, i8*, i8*, i32, i32 }
%struct._papi_inherit_option = type { i32, i32 }

@events = global [3 x i32] [i32 -2147483589, i32 -2147483642, i32 -2147483641], align 4
@eventnum = global i32 3, align 4
@eventset = common global i32 0, align 4
@values = common global [3 x i64] zeroinitializer, align 16
@gnuplotfile = common global %struct._IO_FILE* null, align 8
@.str = private unnamed_addr constant [19 x i8] c"%u\09%lld\09%lld\09%lld\0A\00", align 1
@.str1 = private unnamed_addr constant [8 x i8] c"%d: %f \00", align 1
@.str2 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str3 = private unnamed_addr constant [30 x i8] c"Can't initiate PAPI library!\0A\00", align 1
@.str4 = private unnamed_addr constant [20 x i8] c"Can't thread init!\0A\00", align 1
@.str5 = private unnamed_addr constant [24 x i8] c"Can't create eventset!\0A\00", align 1
@.str6 = private unnamed_addr constant [31 x i8] c"Can't assign_event_component!\0A\00", align 1
@.str7 = private unnamed_addr constant [20 x i8] c"Can't set inherit!\0A\00", align 1
@.str8 = private unnamed_addr constant [31 x i8] c"MEM_LOAD_MISC_RETIRED:LLC_MISS\00", align 1
@.str9 = private unnamed_addr constant [26 x i8] c"CPU_CLK_UNHALTED:THREAD_P\00", align 1
@.str10 = private unnamed_addr constant [10 x i8] c"error %d\0A\00", align 1
@.str11 = private unnamed_addr constant [24 x i8] c"ludecomp_%d_2thread.txt\00", align 1
@.str12 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str13 = private unnamed_addr constant [27 x i8] c"Wallclock time: %lld usec\0A\00", align 1
@.str14 = private unnamed_addr constant [19 x i8] c"Total Cycles\09%lld\0A\00", align 1
@.str15 = private unnamed_addr constant [37 x i8] c"MEM_LOAD_MISC_RETIRED:LLC_MISS\09%lld\0A\00", align 1
@.str16 = private unnamed_addr constant [32 x i8] c"CPU_CLK_UNHALTED:THREAD_P\09%lld\0A\00", align 1
@.str17 = private unnamed_addr constant [11 x i8] c"read timer\00", align 1

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

define i8* @PapiKernel(i8* %Args) nounwind uwtable {
entry:
  %retval = alloca i8*, align 8
  %Args.addr = alloca i8*, align 8
  %info = alloca %struct.periodic_info, align 8
  %i = alloca i32, align 4
  %tempvalues = alloca [3 x i64], align 16
  store i8* %Args, i8** %Args.addr, align 8
  store i32 0, i32* %i, align 4
  %arrayidx = getelementptr inbounds [3 x i64]* %tempvalues, i32 0, i64 0
  store i64 0, i64* %arrayidx, align 8
  %arrayidx1 = getelementptr inbounds [3 x i64]* %tempvalues, i32 0, i64 1
  store i64 0, i64* %arrayidx1, align 8
  %arrayidx2 = getelementptr inbounds [3 x i64]* %tempvalues, i32 0, i64 2
  store i64 0, i64* %arrayidx2, align 8
  %call = call i32 @make_periodic(i32 10000, %struct.periodic_info* %info)
  br label %while.body

while.body:                                       ; preds = %entry, %while.body
  %0 = load i32* %i, align 4
  %add = add i32 %0, 10
  store i32 %add, i32* %i, align 4
  %1 = load i32* @eventset, align 4
  %call3 = call i32 @PAPI_read(i32 %1, i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i32 0))
  %2 = load %struct._IO_FILE** @gnuplotfile, align 8
  %3 = load i32* %i, align 4
  %4 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 1), align 8
  %arrayidx4 = getelementptr inbounds [3 x i64]* %tempvalues, i32 0, i64 1
  %5 = load i64* %arrayidx4, align 8
  %sub = sub nsw i64 %4, %5
  %6 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 2), align 8
  %arrayidx5 = getelementptr inbounds [3 x i64]* %tempvalues, i32 0, i64 2
  %7 = load i64* %arrayidx5, align 8
  %sub6 = sub nsw i64 %6, %7
  %8 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 0), align 8
  %call7 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %2, i8* getelementptr inbounds ([19 x i8]* @.str, i32 0, i32 0), i32 %3, i64 %sub, i64 %sub6, i64 %8)
  %9 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 1), align 8
  %arrayidx8 = getelementptr inbounds [3 x i64]* %tempvalues, i32 0, i64 1
  store i64 %9, i64* %arrayidx8, align 8
  %10 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 2), align 8
  %arrayidx9 = getelementptr inbounds [3 x i64]* %tempvalues, i32 0, i64 2
  store i64 %10, i64* %arrayidx9, align 8
  call void @wait_period(%struct.periodic_info* %info)
  br label %while.body

return:                                           ; No predecessors!
  %11 = load i8** %retval
  ret i8* %11
}

define internal i32 @make_periodic(i32 %period, %struct.periodic_info* %info) nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %period.addr = alloca i32, align 4
  %info.addr = alloca %struct.periodic_info*, align 8
  %ret = alloca i32, align 4
  %ns = alloca i32, align 4
  %sec = alloca i32, align 4
  %fd = alloca i32, align 4
  %itval = alloca %struct.itimerspec, align 8
  store i32 %period, i32* %period.addr, align 4
  store %struct.periodic_info* %info, %struct.periodic_info** %info.addr, align 8
  %call = call i32 @timerfd_create(i32 1, i32 0) nounwind
  store i32 %call, i32* %fd, align 4
  %0 = load %struct.periodic_info** %info.addr, align 8
  %wakeups_missed = getelementptr inbounds %struct.periodic_info* %0, i32 0, i32 1
  store i64 0, i64* %wakeups_missed, align 8
  %1 = load i32* %fd, align 4
  %2 = load %struct.periodic_info** %info.addr, align 8
  %timer_fd = getelementptr inbounds %struct.periodic_info* %2, i32 0, i32 0
  store i32 %1, i32* %timer_fd, align 4
  %3 = load i32* %fd, align 4
  %cmp = icmp eq i32 %3, -1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %4 = load i32* %fd, align 4
  store i32 %4, i32* %retval
  br label %return

if.end:                                           ; preds = %entry
  %5 = load i32* %period.addr, align 4
  %div = udiv i32 %5, 1000000
  store i32 %div, i32* %sec, align 4
  %6 = load i32* %period.addr, align 4
  %7 = load i32* %sec, align 4
  %mul = mul i32 %7, 1000000
  %sub = sub i32 %6, %mul
  %mul1 = mul i32 %sub, 1000
  store i32 %mul1, i32* %ns, align 4
  %8 = load i32* %sec, align 4
  %conv = zext i32 %8 to i64
  %it_interval = getelementptr inbounds %struct.itimerspec* %itval, i32 0, i32 0
  %tv_sec = getelementptr inbounds %struct.timespec* %it_interval, i32 0, i32 0
  store i64 %conv, i64* %tv_sec, align 8
  %9 = load i32* %ns, align 4
  %conv2 = zext i32 %9 to i64
  %it_interval3 = getelementptr inbounds %struct.itimerspec* %itval, i32 0, i32 0
  %tv_nsec = getelementptr inbounds %struct.timespec* %it_interval3, i32 0, i32 1
  store i64 %conv2, i64* %tv_nsec, align 8
  %10 = load i32* %sec, align 4
  %conv4 = zext i32 %10 to i64
  %it_value = getelementptr inbounds %struct.itimerspec* %itval, i32 0, i32 1
  %tv_sec5 = getelementptr inbounds %struct.timespec* %it_value, i32 0, i32 0
  store i64 %conv4, i64* %tv_sec5, align 8
  %11 = load i32* %ns, align 4
  %conv6 = zext i32 %11 to i64
  %it_value7 = getelementptr inbounds %struct.itimerspec* %itval, i32 0, i32 1
  %tv_nsec8 = getelementptr inbounds %struct.timespec* %it_value7, i32 0, i32 1
  store i64 %conv6, i64* %tv_nsec8, align 8
  %12 = load i32* %fd, align 4
  %call9 = call i32 @timerfd_settime(i32 %12, i32 0, %struct.itimerspec* %itval, %struct.itimerspec* null) nounwind
  store i32 %call9, i32* %ret, align 4
  %13 = load i32* %ret, align 4
  store i32 %13, i32* %retval
  br label %return

return:                                           ; preds = %if.end, %if.then
  %14 = load i32* %retval
  ret i32 %14
}

declare i32 @PAPI_read(i32, i64*)

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...)

define internal void @wait_period(%struct.periodic_info* %info) nounwind uwtable {
entry:
  %info.addr = alloca %struct.periodic_info*, align 8
  %missed = alloca i64, align 8
  %ret = alloca i32, align 4
  store %struct.periodic_info* %info, %struct.periodic_info** %info.addr, align 8
  %0 = load %struct.periodic_info** %info.addr, align 8
  %timer_fd = getelementptr inbounds %struct.periodic_info* %0, i32 0, i32 0
  %1 = load i32* %timer_fd, align 4
  %2 = bitcast i64* %missed to i8*
  %call = call i64 @read(i32 %1, i8* %2, i64 8)
  %conv = trunc i64 %call to i32
  store i32 %conv, i32* %ret, align 4
  %3 = load i32* %ret, align 4
  %cmp = icmp eq i32 %3, -1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void @perror(i8* getelementptr inbounds ([11 x i8]* @.str17, i32 0, i32 0))
  br label %if.end5

if.end:                                           ; preds = %entry
  %4 = load i64* %missed, align 8
  %cmp2 = icmp ugt i64 %4, 0
  br i1 %cmp2, label %if.then4, label %if.end5

if.then4:                                         ; preds = %if.end
  %5 = load i64* %missed, align 8
  %sub = sub i64 %5, 1
  %6 = load %struct.periodic_info** %info.addr, align 8
  %wakeups_missed = getelementptr inbounds %struct.periodic_info* %6, i32 0, i32 1
  %7 = load i64* %wakeups_missed, align 8
  %add = add i64 %7, %sub
  store i64 %add, i64* %wakeups_missed, align 8
  br label %if.end5

if.end5:                                          ; preds = %if.then, %if.then4, %if.end
  ret void
}

define i8* @luKernel(i8* %Args) nounwind uwtable {
entry:
  %Args.addr = alloca i8*, align 8
  %Argument = alloca %struct.ThrdArg*, align 8
  %dMatrix = alloca double*, align 8
  %MSIZE = alloca i32, align 4
  %nPivotIndices = alloca i32*, align 8
  %nResult = alloca i32, align 4
  store i8* %Args, i8** %Args.addr, align 8
  %0 = load i8** %Args.addr, align 8
  %1 = bitcast i8* %0 to %struct.ThrdArg*
  store %struct.ThrdArg* %1, %struct.ThrdArg** %Argument, align 8
  %2 = load %struct.ThrdArg** %Argument, align 8
  %dMatrix1 = getelementptr inbounds %struct.ThrdArg* %2, i32 0, i32 0
  %3 = load double** %dMatrix1, align 8
  store double* %3, double** %dMatrix, align 8
  %4 = load %struct.ThrdArg** %Argument, align 8
  %MSIZE2 = getelementptr inbounds %struct.ThrdArg* %4, i32 0, i32 1
  %5 = load i32* %MSIZE2, align 4
  store i32 %5, i32* %MSIZE, align 4
  %6 = load %struct.ThrdArg** %Argument, align 8
  %nPivotIndices3 = getelementptr inbounds %struct.ThrdArg* %6, i32 0, i32 2
  %7 = load i32** %nPivotIndices3, align 8
  store i32* %7, i32** %nPivotIndices, align 8
  %8 = load i32* %MSIZE, align 4
  %9 = load i32* %MSIZE, align 4
  %10 = load double** %dMatrix, align 8
  %11 = load i32* %MSIZE, align 4
  %12 = load i32** %nPivotIndices, align 8
  %call = call i32 @clapack_dgetrf(i32 101, i32 %8, i32 %9, double* %10, i32 %11, i32* %12)
  store i32 %call, i32* %nResult, align 4
  ret i8* null
}

declare i32 @clapack_dgetrf(i32, i32, i32, double*, i32, i32*)

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
  %call = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 %add, double %11)
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %12 = load i32* %col, align 4
  %inc = add nsw i32 %12, 1
  store i32 %inc, i32* %col, align 4
  br label %for.cond1

for.end:                                          ; preds = %for.cond1
  %call6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([2 x i8]* @.str2, i32 0, i32 0))
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
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %MSIZE = alloca i32, align 4
  %status = alloca i32, align 4
  %dMatrix = alloca double*, align 8
  %dMatrix2 = alloca double*, align 8
  %nPivotIndices = alloca i32*, align 8
  %nPivotIndices2 = alloca i32*, align 8
  %nResult = alloca i32, align 4
  %seed = alloca i32, align 4
  %Argument = alloca %struct.ThrdArg, align 8
  %attr = alloca %union.pthread_attr_t, align 8
  %Thread = alloca [2 x i64], align 16
  %ptp = alloca i64, align 8
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
  store i32 %cond, i32* %MSIZE, align 4
  %3 = load i32* %MSIZE, align 4
  %conv = sext i32 %3 to i64
  %mul = mul i64 8, %conv
  %4 = load i32* %MSIZE, align 4
  %conv3 = sext i32 %4 to i64
  %mul4 = mul i64 %mul, %conv3
  %call5 = call noalias i8* @malloc(i64 %mul4) nounwind
  %5 = bitcast i8* %call5 to double*
  store double* %5, double** %dMatrix, align 8
  %6 = load i32* %MSIZE, align 4
  %conv6 = sext i32 %6 to i64
  %mul7 = mul i64 8, %conv6
  %7 = load i32* %MSIZE, align 4
  %conv8 = sext i32 %7 to i64
  %mul9 = mul i64 %mul7, %conv8
  %call10 = call noalias i8* @malloc(i64 %mul9) nounwind
  %8 = bitcast i8* %call10 to double*
  store double* %8, double** %dMatrix2, align 8
  %9 = load i32* %seed, align 4
  call void @srand(i32 %9) nounwind
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc25, %cond.end
  %10 = load i32* %i, align 4
  %11 = load i32* %MSIZE, align 4
  %cmp11 = icmp slt i32 %10, %11
  br i1 %cmp11, label %for.body, label %for.end27

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %j, align 4
  br label %for.cond13

for.cond13:                                       ; preds = %for.inc, %for.body
  %12 = load i32* %j, align 4
  %13 = load i32* %MSIZE, align 4
  %cmp14 = icmp slt i32 %12, %13
  br i1 %cmp14, label %for.body16, label %for.end

for.body16:                                       ; preds = %for.cond13
  %call17 = call double @frand()
  %14 = load i32* %i, align 4
  %15 = load i32* %MSIZE, align 4
  %mul18 = mul nsw i32 %14, %15
  %16 = load i32* %j, align 4
  %add = add nsw i32 %mul18, %16
  %idxprom = sext i32 %add to i64
  %17 = load double** %dMatrix, align 8
  %arrayidx19 = getelementptr inbounds double* %17, i64 %idxprom
  store double %call17, double* %arrayidx19
  %call20 = call double @frand()
  %18 = load i32* %i, align 4
  %19 = load i32* %MSIZE, align 4
  %mul21 = mul nsw i32 %18, %19
  %20 = load i32* %j, align 4
  %add22 = add nsw i32 %mul21, %20
  %idxprom23 = sext i32 %add22 to i64
  %21 = load double** %dMatrix2, align 8
  %arrayidx24 = getelementptr inbounds double* %21, i64 %idxprom23
  store double %call20, double* %arrayidx24
  br label %for.inc

for.inc:                                          ; preds = %for.body16
  %22 = load i32* %j, align 4
  %inc = add nsw i32 %22, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond13

for.end:                                          ; preds = %for.cond13
  br label %for.inc25

for.inc25:                                        ; preds = %for.end
  %23 = load i32* %i, align 4
  %inc26 = add nsw i32 %23, 1
  store i32 %inc26, i32* %i, align 4
  br label %for.cond

for.end27:                                        ; preds = %for.cond
  %24 = load i32* %MSIZE, align 4
  %conv28 = sext i32 %24 to i64
  %mul29 = mul i64 %conv28, 4
  %call30 = call noalias i8* @malloc(i64 %mul29) nounwind
  %25 = bitcast i8* %call30 to i32*
  store i32* %25, i32** %nPivotIndices, align 8
  %26 = load i32* %MSIZE, align 4
  %conv31 = sext i32 %26 to i64
  %mul32 = mul i64 %conv31, 4
  %call33 = call noalias i8* @malloc(i64 %mul32) nounwind
  %27 = bitcast i8* %call33 to i32*
  store i32* %27, i32** %nPivotIndices2, align 8
  %28 = load double** %dMatrix2, align 8
  %dMatrix34 = getelementptr inbounds %struct.ThrdArg* %Argument, i32 0, i32 0
  store double* %28, double** %dMatrix34, align 8
  %29 = load i32* %MSIZE, align 4
  %MSIZE35 = getelementptr inbounds %struct.ThrdArg* %Argument, i32 0, i32 1
  store i32 %29, i32* %MSIZE35, align 4
  %30 = load i32** %nPivotIndices2, align 8
  %nPivotIndices36 = getelementptr inbounds %struct.ThrdArg* %Argument, i32 0, i32 2
  store i32* %30, i32** %nPivotIndices36, align 8
  %arraydecay = getelementptr inbounds [2 x i64]* %Thread, i32 0, i32 0
  %call37 = call i32 @pthread_create(i64* %arraydecay, %union.pthread_attr_t* %attr, i8* (i8*)* @PapiKernel, i8* null) nounwind
  %arraydecay38 = getelementptr inbounds [2 x i64]* %Thread, i32 0, i32 0
  %add.ptr = getelementptr inbounds i64* %arraydecay38, i64 1
  %31 = bitcast %struct.ThrdArg* %Argument to i8*
  %call39 = call i32 @pthread_create(i64* %add.ptr, %union.pthread_attr_t* %attr, i8* (i8*)* @luKernel, i8* %31) nounwind
  %32 = load i32* %MSIZE, align 4
  %33 = load i32* %MSIZE, align 4
  %34 = load double** %dMatrix, align 8
  %35 = load i32* %MSIZE, align 4
  %36 = load i32** %nPivotIndices, align 8
  %call40 = call i32 @clapack_dgetrf(i32 101, i32 %32, i32 %33, double* %34, i32 %35, i32* %36)
  store i32 %call40, i32* %nResult, align 4
  %call41 = call i64 @pthread_self() nounwind readnone
  store i64 %call41, i64* %ptp, align 8
  %arrayidx42 = getelementptr inbounds [2 x i64]* %Thread, i32 0, i64 1
  %37 = load i64* %arrayidx42, align 8
  %38 = bitcast i32* %status to i8**
  %call43 = call i32 @pthread_join(i64 %37, i8** %38)
  %arrayidx44 = getelementptr inbounds [2 x i64]* %Thread, i32 0, i64 0
  %39 = load i64* %arrayidx44, align 8
  %call45 = call i32 @pthread_cancel(i64 %39)
  ret i32 0
}

declare i32 @pthread_attr_init(%union.pthread_attr_t*) nounwind

declare i32 @pthread_attr_setdetachstate(%union.pthread_attr_t*, i32) nounwind

declare i32 @atoi(i8*) nounwind readonly

declare noalias i8* @malloc(i64) nounwind

declare void @srand(i32) nounwind

declare i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) nounwind

declare i64 @pthread_self() nounwind readnone

declare i32 @pthread_join(i64, i8**)

declare i32 @pthread_cancel(i64)

define i32 @main(i32 %argc, i8** %argv) nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %MSIZE = alloca i32, align 4
  %s = alloca i64, align 8
  %e = alloca i64, align 8
  %retval1 = alloca i32, align 4
  %eventcode = alloca i32, align 4
  %opt = alloca %union.PAPI_option_t, align 8
  %filename = alloca [50 x i8], align 16
  store i32 0, i32* %retval
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 8
  %call = call i32 @PAPI_library_init(i32 67239936)
  %cmp = icmp ne i32 67239936, %call
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([30 x i8]* @.str3, i32 0, i32 0))
  call void @exit(i32 -1) noreturn nounwind
  unreachable

if.end:                                           ; preds = %entry
  %call3 = call i32 @PAPI_thread_init(i64 ()* @pthread_self)
  %cmp4 = icmp ne i32 %call3, 0
  br i1 %cmp4, label %if.then5, label %if.end7

if.then5:                                         ; preds = %if.end
  %call6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str4, i32 0, i32 0))
  call void @exit(i32 -1) noreturn nounwind
  unreachable

if.end7:                                          ; preds = %if.end
  store i32 -1, i32* @eventset, align 4
  %call8 = call i32 @PAPI_create_eventset(i32* @eventset)
  %cmp9 = icmp ne i32 %call8, 0
  br i1 %cmp9, label %if.then10, label %if.end12

if.then10:                                        ; preds = %if.end7
  %call11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([24 x i8]* @.str5, i32 0, i32 0))
  call void @exit(i32 -3) noreturn nounwind
  unreachable

if.end12:                                         ; preds = %if.end7
  %0 = load i32* @eventset, align 4
  %call13 = call i32 @PAPI_assign_eventset_component(i32 %0, i32 0)
  store i32 %call13, i32* %retval1, align 4
  %cmp14 = icmp ne i32 %call13, 0
  br i1 %cmp14, label %if.then15, label %if.end17

if.then15:                                        ; preds = %if.end12
  %call16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([31 x i8]* @.str6, i32 0, i32 0))
  call void @exit(i32 -3) noreturn nounwind
  unreachable

if.end17:                                         ; preds = %if.end12
  %1 = bitcast %union.PAPI_option_t* %opt to i8*
  call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 264, i32 1, i1 false)
  %inherit = bitcast %union.PAPI_option_t* %opt to %struct._papi_inherit_option*
  %inherit18 = getelementptr inbounds %struct._papi_inherit_option* %inherit, i32 0, i32 1
  store i32 1, i32* %inherit18, align 4
  %2 = load i32* @eventset, align 4
  %inherit19 = bitcast %union.PAPI_option_t* %opt to %struct._papi_inherit_option*
  %eventset = getelementptr inbounds %struct._papi_inherit_option* %inherit19, i32 0, i32 0
  store i32 %2, i32* %eventset, align 4
  %call20 = call i32 @PAPI_set_opt(i32 28, %union.PAPI_option_t* %opt)
  store i32 %call20, i32* %retval1, align 4
  %cmp21 = icmp ne i32 %call20, 0
  br i1 %cmp21, label %if.then22, label %if.end24

if.then22:                                        ; preds = %if.end17
  %call23 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str7, i32 0, i32 0))
  call void @exit(i32 -3) noreturn nounwind
  unreachable

if.end24:                                         ; preds = %if.end17
  %call25 = call i32 @PAPI_event_name_to_code(i8* getelementptr inbounds ([31 x i8]* @.str8, i32 0, i32 0), i32* %eventcode)
  %3 = load i32* %eventcode, align 4
  store i32 %3, i32* getelementptr inbounds ([3 x i32]* @events, i32 0, i64 1), align 4
  %call26 = call i32 @PAPI_event_name_to_code(i8* getelementptr inbounds ([26 x i8]* @.str9, i32 0, i32 0), i32* %eventcode)
  %4 = load i32* %eventcode, align 4
  store i32 %4, i32* getelementptr inbounds ([3 x i32]* @events, i32 0, i64 2), align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end24
  %5 = load i32* %i, align 4
  %cmp27 = icmp slt i32 %5, 3
  br i1 %cmp27, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %6 = load i32* @eventset, align 4
  %7 = load i32* %i, align 4
  %idxprom = sext i32 %7 to i64
  %arrayidx = getelementptr inbounds [3 x i32]* @events, i32 0, i64 %idxprom
  %8 = load i32* %arrayidx, align 4
  %call28 = call i32 @PAPI_add_event(i32 %6, i32 %8)
  store i32 %call28, i32* %retval1, align 4
  %9 = load i32* %retval1, align 4
  %cmp29 = icmp ne i32 %9, 0
  br i1 %cmp29, label %if.then30, label %if.end32

if.then30:                                        ; preds = %for.body
  %10 = load i32* %retval1, align 4
  %call31 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str10, i32 0, i32 0), i32 %10)
  call void @exit(i32 -4) noreturn nounwind
  unreachable

if.end32:                                         ; preds = %for.body
  br label %for.inc

for.inc:                                          ; preds = %if.end32
  %11 = load i32* %i, align 4
  %inc = add nsw i32 %11, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %12 = load i32* %argc.addr, align 4
  %cmp33 = icmp eq i32 %12, 2
  br i1 %cmp33, label %cond.true, label %cond.false

cond.true:                                        ; preds = %for.end
  %13 = load i8*** %argv.addr, align 8
  %arrayidx34 = getelementptr inbounds i8** %13, i64 1
  %14 = load i8** %arrayidx34
  %call35 = call i32 @atoi(i8* %14) nounwind readonly
  br label %cond.end

cond.false:                                       ; preds = %for.end
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %call35, %cond.true ], [ 2048, %cond.false ]
  store i32 %cond, i32* %MSIZE, align 4
  %arraydecay = getelementptr inbounds [50 x i8]* %filename, i32 0, i32 0
  %15 = load i32* %MSIZE, align 4
  %call36 = call i32 (i8*, i8*, ...)* @sprintf(i8* %arraydecay, i8* getelementptr inbounds ([24 x i8]* @.str11, i32 0, i32 0), i32 %15) nounwind
  %arraydecay37 = getelementptr inbounds [50 x i8]* %filename, i32 0, i32 0
  %call38 = call %struct._IO_FILE* @fopen(i8* %arraydecay37, i8* getelementptr inbounds ([2 x i8]* @.str12, i32 0, i32 0))
  store %struct._IO_FILE* %call38, %struct._IO_FILE** @gnuplotfile, align 8
  %call39 = call i64 @PAPI_get_real_usec()
  store i64 %call39, i64* %s, align 8
  %16 = load i32* @eventset, align 4
  %call40 = call i32 @PAPI_start(i32 %16)
  %17 = load i32* %argc.addr, align 4
  %18 = load i8*** %argv.addr, align 8
  %call41 = call i32 @test(i32 %17, i8** %18)
  %19 = load i32* @eventset, align 4
  %call42 = call i32 @PAPI_stop(i32 %19, i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i32 0))
  %call43 = call i64 @PAPI_get_real_usec()
  store i64 %call43, i64* %e, align 8
  %20 = load %struct._IO_FILE** @gnuplotfile, align 8
  %call44 = call i32 @fclose(%struct._IO_FILE* %20)
  %21 = load i64* %e, align 8
  %22 = load i64* %s, align 8
  %sub = sub nsw i64 %21, %22
  %call45 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([27 x i8]* @.str13, i32 0, i32 0), i64 %sub)
  %23 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 0), align 8
  %call46 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str14, i32 0, i32 0), i64 %23)
  %24 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 1), align 8
  %call47 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([37 x i8]* @.str15, i32 0, i32 0), i64 %24)
  %25 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 2), align 8
  %call48 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([32 x i8]* @.str16, i32 0, i32 0), i64 %25)
  ret i32 0
}

declare i32 @PAPI_library_init(i32)

declare void @exit(i32) noreturn nounwind

declare i32 @PAPI_thread_init(i64 ()*)

declare i32 @PAPI_create_eventset(i32*)

declare i32 @PAPI_assign_eventset_component(i32, i32)

declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) nounwind

declare i32 @PAPI_set_opt(i32, %union.PAPI_option_t*)

declare i32 @PAPI_event_name_to_code(i8*, i32*)

declare i32 @PAPI_add_event(i32, i32)

declare i32 @sprintf(i8*, i8*, ...) nounwind

declare %struct._IO_FILE* @fopen(i8*, i8*)

declare i64 @PAPI_get_real_usec()

declare i32 @PAPI_start(i32)

declare i32 @PAPI_stop(i32, i64*)

declare i32 @fclose(%struct._IO_FILE*)

declare i64 @read(i32, i8*, i64)

declare void @perror(i8*)

declare i32 @timerfd_create(i32, i32) nounwind

declare i32 @timerfd_settime(i32, i32, %struct.itimerspec*, %struct.itimerspec*) nounwind