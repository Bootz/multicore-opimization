; ModuleID = 'test5.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.__dt_position = type { [256 x i8], [256 x i8], i32, i32 }
%struct.periodic_info = type { i32, i64 }
%struct.itimerspec = type { %struct.timespec, %struct.timespec }
%struct.timespec = type { i64, i64 }
%union.pthread_attr_t = type { i64, [48 x i8] }
%union.PAPI_option_t = type { %struct._papi_addr_range_option, [232 x i8] }
%struct._papi_addr_range_option = type { i32, i8*, i8*, i32, i32 }
%struct._papi_inherit_option = type { i32, i32 }

@events = global [3 x i32] [i32 -2147483589, i32 -2147483642, i32 -2147483641], align 4
@eventnum = global i32 3, align 4
@tempvalues = common global [3 x i64] zeroinitializer, align 16
@eventset = common global i32 0, align 4
@values = common global [3 x i64] zeroinitializer, align 16
@gnuplotfile = common global %struct._IO_FILE* null, align 8
@.str = private unnamed_addr constant [28 x i8] c"%lld\09%lld\09%lld\09%s\09%s\09%u\09%u\0A\00", align 1
@__dt_pos = common global [2 x %struct.__dt_position] zeroinitializer, align 16
@.str1 = private unnamed_addr constant [30 x i8] c"Can't initiate PAPI library!\0A\00", align 1
@.str2 = private unnamed_addr constant [20 x i8] c"Can't thread init!\0A\00", align 1
@.str3 = private unnamed_addr constant [24 x i8] c"Can't create eventset!\0A\00", align 1
@.str4 = private unnamed_addr constant [31 x i8] c"Can't assign_event_component!\0A\00", align 1
@.str5 = private unnamed_addr constant [20 x i8] c"Can't set inherit!\0A\00", align 1
@.str6 = private unnamed_addr constant [31 x i8] c"MEM_LOAD_MISC_RETIRED:LLC_MISS\00", align 1
@.str7 = private unnamed_addr constant [26 x i8] c"CPU_CLK_UNHALTED:THREAD_P\00", align 1
@.str8 = private unnamed_addr constant [10 x i8] c"error %d\0A\00", align 1
@.str9 = private unnamed_addr constant [10 x i8] c"test4.txt\00", align 1
@.str10 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str11 = private unnamed_addr constant [27 x i8] c"Wallclock time: %lld usec\0A\00", align 1
@.str12 = private unnamed_addr constant [19 x i8] c"Total Cycles\09%lld\0A\00", align 1
@.str13 = private unnamed_addr constant [37 x i8] c"MEM_LOAD_MISC_RETIRED:LLC_MISS\09%lld\0A\00", align 1
@.str14 = private unnamed_addr constant [32 x i8] c"CPU_CLK_UNHALTED:THREAD_P\09%lld\0A\00", align 1
@.str15 = private unnamed_addr constant [11 x i8] c"read timer\00", align 1

define i8* @PapiKernel(i8* %Args) nounwind uwtable {
entry:
  %retval = alloca i8*, align 8
  %Args.addr = alloca i8*, align 8
  %info = alloca %struct.periodic_info, align 8
  %i = alloca i64, align 8
  store i8* %Args, i8** %Args.addr, align 8
  store i64 0, i64* %i, align 8
  store i64 0, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 0), align 8
  store i64 0, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 1), align 8
  store i64 0, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 2), align 8
  %call = call i32 @make_periodic(i32 10000, %struct.periodic_info* %info)
  br label %while.body

while.body:                                       ; preds = %entry, %while.body
  %0 = load i64* %i, align 8
  %add = add nsw i64 %0, 10
  store i64 %add, i64* %i, align 8
  %1 = load i32* @eventset, align 4
  %call1 = call i32 @PAPI_read(i32 %1, i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i32 0))
  %2 = load %struct._IO_FILE** @gnuplotfile, align 8
  %3 = load i64* %i, align 8
  %4 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 1), align 8
  %5 = load i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 1), align 8
  %sub = sub nsw i64 %4, %5
  %6 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 2), align 8
  %7 = load i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 2), align 8
  %sub2 = sub nsw i64 %6, %7
  %8 = load i32* getelementptr inbounds ([2 x %struct.__dt_position]* @__dt_pos, i32 0, i64 0, i32 2), align 4
  %9 = load i32* getelementptr inbounds ([2 x %struct.__dt_position]* @__dt_pos, i32 0, i64 1, i32 3), align 4
  %call3 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %2, i8* getelementptr inbounds ([28 x i8]* @.str, i32 0, i32 0), i64 %3, i64 %sub, i64 %sub2, i8* getelementptr inbounds ([2 x %struct.__dt_position]* @__dt_pos, i32 0, i64 0, i32 0, i32 0), i8* getelementptr inbounds ([2 x %struct.__dt_position]* @__dt_pos, i32 0, i64 1, i32 1, i32 0), i32 %8, i32 %9)
  %10 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 1), align 8
  store i64 %10, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 1), align 8
  %11 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 2), align 8
  store i64 %11, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 2), align 8
  call void @wait_period(%struct.periodic_info* %info)
  br label %while.body

return:                                           ; No predecessors!
  %12 = load i8** %retval
  ret i8* %12
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
  call void @perror(i8* getelementptr inbounds ([11 x i8]* @.str15, i32 0, i32 0))
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

define i32 @test() nounwind uwtable {
entry:
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %numInt = alloca i32, align 4
  %numCachelineUsed = alloca i32, align 4
  %a = alloca i32*, align 8
  %attr = alloca %union.pthread_attr_t, align 8
  %Thread = alloca i64, align 8
  store i32 2097152, i32* %numInt, align 4
  store i32 131072, i32* %numCachelineUsed, align 4
  %0 = load i32* %numInt, align 4
  %conv = sext i32 %0 to i64
  %mul = mul i64 4, %conv
  %call = call noalias i8* @malloc(i64 %mul) nounwind
  %1 = bitcast i8* %call to i32*
  store i32* %1, i32** %a, align 8
  %call1 = call i32 @pthread_attr_init(%union.pthread_attr_t* %attr) nounwind
  %call2 = call i32 @pthread_attr_setdetachstate(%union.pthread_attr_t* %attr, i32 0) nounwind
  %call3 = call i32 @pthread_create(i64* %Thread, %union.pthread_attr_t* %attr, i8* (i8*)* @PapiKernel, i8* null) nounwind
  store i32 0, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc11, %entry
  %2 = load i32* %j, align 4
  %cmp = icmp slt i32 %2, 16
  br i1 %cmp, label %for.body, label %for.end13

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %i, align 4
  br label %for.cond5

for.cond5:                                        ; preds = %for.inc, %for.body
  %3 = load i32* %i, align 4
  %4 = load i32* %numCachelineUsed, align 4
  %cmp6 = icmp slt i32 %3, %4
  br i1 %cmp6, label %for.body8, label %for.end

for.body8:                                        ; preds = %for.cond5
  %5 = load i32* %i, align 4
  %mul9 = mul nsw i32 %5, 16
  %6 = load i32* %j, align 4
  %add = add nsw i32 %mul9, %6
  %idxprom = sext i32 %add to i64
  %7 = load i32** %a, align 8
  %arrayidx = getelementptr inbounds i32* %7, i64 %idxprom
  %8 = load i32* %arrayidx
  %inc = add nsw i32 %8, 1
  store i32 %inc, i32* %arrayidx
  br label %for.inc

for.inc:                                          ; preds = %for.body8
  %9 = load i32* %i, align 4
  %inc10 = add nsw i32 %9, 1
  store i32 %inc10, i32* %i, align 4
  br label %for.cond5

for.end:                                          ; preds = %for.cond5
  br label %for.inc11

for.inc11:                                        ; preds = %for.end
  %10 = load i32* %j, align 4
  %inc12 = add nsw i32 %10, 1
  store i32 %inc12, i32* %j, align 4
  br label %for.cond

for.end13:                                        ; preds = %for.cond
  store i32 0, i32* %i, align 4
  br label %for.cond14

for.cond14:                                       ; preds = %for.inc21, %for.end13
  %11 = load i32* %i, align 4
  %12 = load i32* %numInt, align 4
  %cmp15 = icmp slt i32 %11, %12
  br i1 %cmp15, label %for.body17, label %for.end23

for.body17:                                       ; preds = %for.cond14
  %13 = load i32* %i, align 4
  %idxprom18 = sext i32 %13 to i64
  %14 = load i32** %a, align 8
  %arrayidx19 = getelementptr inbounds i32* %14, i64 %idxprom18
  %15 = load i32* %arrayidx19
  %inc20 = add nsw i32 %15, 1
  store i32 %inc20, i32* %arrayidx19
  br label %for.inc21

for.inc21:                                        ; preds = %for.body17
  %16 = load i32* %i, align 4
  %inc22 = add nsw i32 %16, 1
  store i32 %inc22, i32* %i, align 4
  br label %for.cond14

for.end23:                                        ; preds = %for.cond14
  store i32 0, i32* %j, align 4
  br label %for.cond24

for.cond24:                                       ; preds = %for.inc40, %for.end23
  %17 = load i32* %j, align 4
  %cmp25 = icmp slt i32 %17, 16
  br i1 %cmp25, label %for.body27, label %for.end42

for.body27:                                       ; preds = %for.cond24
  store i32 0, i32* %i, align 4
  br label %for.cond28

for.cond28:                                       ; preds = %for.inc37, %for.body27
  %18 = load i32* %i, align 4
  %19 = load i32* %numCachelineUsed, align 4
  %cmp29 = icmp slt i32 %18, %19
  br i1 %cmp29, label %for.body31, label %for.end39

for.body31:                                       ; preds = %for.cond28
  %20 = load i32* %i, align 4
  %mul32 = mul nsw i32 %20, 16
  %21 = load i32* %j, align 4
  %add33 = add nsw i32 %mul32, %21
  %idxprom34 = sext i32 %add33 to i64
  %22 = load i32** %a, align 8
  %arrayidx35 = getelementptr inbounds i32* %22, i64 %idxprom34
  %23 = load i32* %arrayidx35
  %inc36 = add nsw i32 %23, 1
  store i32 %inc36, i32* %arrayidx35
  br label %for.inc37

for.inc37:                                        ; preds = %for.body31
  %24 = load i32* %i, align 4
  %inc38 = add nsw i32 %24, 1
  store i32 %inc38, i32* %i, align 4
  br label %for.cond28

for.end39:                                        ; preds = %for.cond28
  br label %for.inc40

for.inc40:                                        ; preds = %for.end39
  %25 = load i32* %j, align 4
  %inc41 = add nsw i32 %25, 1
  store i32 %inc41, i32* %j, align 4
  br label %for.cond24

for.end42:                                        ; preds = %for.cond24
  store i32 0, i32* %i, align 4
  br label %for.cond43

for.cond43:                                       ; preds = %for.inc50, %for.end42
  %26 = load i32* %i, align 4
  %27 = load i32* %numInt, align 4
  %cmp44 = icmp slt i32 %26, %27
  br i1 %cmp44, label %for.body46, label %for.end52

for.body46:                                       ; preds = %for.cond43
  %28 = load i32* %i, align 4
  %idxprom47 = sext i32 %28 to i64
  %29 = load i32** %a, align 8
  %arrayidx48 = getelementptr inbounds i32* %29, i64 %idxprom47
  %30 = load i32* %arrayidx48
  %inc49 = add nsw i32 %30, 1
  store i32 %inc49, i32* %arrayidx48
  br label %for.inc50

for.inc50:                                        ; preds = %for.body46
  %31 = load i32* %i, align 4
  %inc51 = add nsw i32 %31, 1
  store i32 %inc51, i32* %i, align 4
  br label %for.cond43

for.end52:                                        ; preds = %for.cond43
  store i32 0, i32* %j, align 4
  br label %for.cond53

for.cond53:                                       ; preds = %for.inc69, %for.end52
  %32 = load i32* %j, align 4
  %cmp54 = icmp slt i32 %32, 16
  br i1 %cmp54, label %for.body56, label %for.end71

for.body56:                                       ; preds = %for.cond53
  store i32 0, i32* %i, align 4
  br label %for.cond57

for.cond57:                                       ; preds = %for.inc66, %for.body56
  %33 = load i32* %i, align 4
  %34 = load i32* %numCachelineUsed, align 4
  %cmp58 = icmp slt i32 %33, %34
  br i1 %cmp58, label %for.body60, label %for.end68

for.body60:                                       ; preds = %for.cond57
  %35 = load i32* %i, align 4
  %mul61 = mul nsw i32 %35, 16
  %36 = load i32* %j, align 4
  %add62 = add nsw i32 %mul61, %36
  %idxprom63 = sext i32 %add62 to i64
  %37 = load i32** %a, align 8
  %arrayidx64 = getelementptr inbounds i32* %37, i64 %idxprom63
  %38 = load i32* %arrayidx64
  %inc65 = add nsw i32 %38, 1
  store i32 %inc65, i32* %arrayidx64
  br label %for.inc66

for.inc66:                                        ; preds = %for.body60
  %39 = load i32* %i, align 4
  %inc67 = add nsw i32 %39, 1
  store i32 %inc67, i32* %i, align 4
  br label %for.cond57

for.end68:                                        ; preds = %for.cond57
  br label %for.inc69

for.inc69:                                        ; preds = %for.end68
  %40 = load i32* %j, align 4
  %inc70 = add nsw i32 %40, 1
  store i32 %inc70, i32* %j, align 4
  br label %for.cond53

for.end71:                                        ; preds = %for.cond53
  store i32 0, i32* %i, align 4
  br label %for.cond72

for.cond72:                                       ; preds = %for.inc79, %for.end71
  %41 = load i32* %i, align 4
  %42 = load i32* %numInt, align 4
  %cmp73 = icmp slt i32 %41, %42
  br i1 %cmp73, label %for.body75, label %for.end81

for.body75:                                       ; preds = %for.cond72
  %43 = load i32* %i, align 4
  %idxprom76 = sext i32 %43 to i64
  %44 = load i32** %a, align 8
  %arrayidx77 = getelementptr inbounds i32* %44, i64 %idxprom76
  %45 = load i32* %arrayidx77
  %inc78 = add nsw i32 %45, 1
  store i32 %inc78, i32* %arrayidx77
  br label %for.inc79

for.inc79:                                        ; preds = %for.body75
  %46 = load i32* %i, align 4
  %inc80 = add nsw i32 %46, 1
  store i32 %inc80, i32* %i, align 4
  br label %for.cond72

for.end81:                                        ; preds = %for.cond72
  %47 = load i64* %Thread, align 8
  %call82 = call i32 @pthread_cancel(i64 %47)
  ret i32 0
}

declare noalias i8* @malloc(i64) nounwind

declare i32 @pthread_attr_init(%union.pthread_attr_t*) nounwind

declare i32 @pthread_attr_setdetachstate(%union.pthread_attr_t*, i32) nounwind

declare i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) nounwind

declare i32 @pthread_cancel(i64)

define i32 @main(i32 %argc, i8** %argv) nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %s = alloca i64, align 8
  %e = alloca i64, align 8
  %retval1 = alloca i32, align 4
  %eventcode = alloca i32, align 4
  %opt = alloca %union.PAPI_option_t, align 8
  store i32 0, i32* %retval
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 8
  %call = call i32 @PAPI_library_init(i32 67239936)
  %cmp = icmp ne i32 67239936, %call
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([30 x i8]* @.str1, i32 0, i32 0))
  call void @exit(i32 -1) noreturn nounwind
  unreachable

if.end:                                           ; preds = %entry
  %call3 = call i32 @PAPI_thread_init(i64 ()* @pthread_self)
  %cmp4 = icmp ne i32 %call3, 0
  br i1 %cmp4, label %if.then5, label %if.end7

if.then5:                                         ; preds = %if.end
  %call6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str2, i32 0, i32 0))
  call void @exit(i32 -1) noreturn nounwind
  unreachable

if.end7:                                          ; preds = %if.end
  store i32 -1, i32* @eventset, align 4
  %call8 = call i32 @PAPI_create_eventset(i32* @eventset)
  %cmp9 = icmp ne i32 %call8, 0
  br i1 %cmp9, label %if.then10, label %if.end12

if.then10:                                        ; preds = %if.end7
  %call11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([24 x i8]* @.str3, i32 0, i32 0))
  call void @exit(i32 -3) noreturn nounwind
  unreachable

if.end12:                                         ; preds = %if.end7
  %0 = load i32* @eventset, align 4
  %call13 = call i32 @PAPI_assign_eventset_component(i32 %0, i32 0)
  store i32 %call13, i32* %retval1, align 4
  %cmp14 = icmp ne i32 %call13, 0
  br i1 %cmp14, label %if.then15, label %if.end17

if.then15:                                        ; preds = %if.end12
  %call16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([31 x i8]* @.str4, i32 0, i32 0))
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
  %call23 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str5, i32 0, i32 0))
  call void @exit(i32 -3) noreturn nounwind
  unreachable

if.end24:                                         ; preds = %if.end17
  %call25 = call i32 @PAPI_event_name_to_code(i8* getelementptr inbounds ([31 x i8]* @.str6, i32 0, i32 0), i32* %eventcode)
  %3 = load i32* %eventcode, align 4
  store i32 %3, i32* getelementptr inbounds ([3 x i32]* @events, i32 0, i64 1), align 4
  %call26 = call i32 @PAPI_event_name_to_code(i8* getelementptr inbounds ([26 x i8]* @.str7, i32 0, i32 0), i32* %eventcode)
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
  %call31 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str8, i32 0, i32 0), i32 %10)
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
  %call33 = call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([10 x i8]* @.str9, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8]* @.str10, i32 0, i32 0))
  store %struct._IO_FILE* %call33, %struct._IO_FILE** @gnuplotfile, align 8
  %call34 = call i64 @PAPI_get_real_usec()
  store i64 %call34, i64* %s, align 8
  %12 = load i32* @eventset, align 4
  %call35 = call i32 @PAPI_start(i32 %12)
  %call36 = call i32 @test()
  %13 = load i32* @eventset, align 4
  %call37 = call i32 @PAPI_stop(i32 %13, i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i32 0))
  %call38 = call i64 @PAPI_get_real_usec()
  store i64 %call38, i64* %e, align 8
  %14 = load %struct._IO_FILE** @gnuplotfile, align 8
  %call39 = call i32 @fclose(%struct._IO_FILE* %14)
  %15 = load i64* %e, align 8
  %16 = load i64* %s, align 8
  %sub = sub nsw i64 %15, %16
  %call40 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([27 x i8]* @.str11, i32 0, i32 0), i64 %sub)
  %17 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 0), align 8
  %call41 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str12, i32 0, i32 0), i64 %17)
  %18 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 1), align 8
  %call42 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([37 x i8]* @.str13, i32 0, i32 0), i64 %18)
  %19 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 2), align 8
  %call43 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([32 x i8]* @.str14, i32 0, i32 0), i64 %19)
  ret i32 0
}

declare i32 @PAPI_library_init(i32)

declare i32 @printf(i8*, ...)

declare void @exit(i32) noreturn nounwind

declare i32 @PAPI_thread_init(i64 ()*)

declare i64 @pthread_self() nounwind readnone

declare i32 @PAPI_create_eventset(i32*)

declare i32 @PAPI_assign_eventset_component(i32, i32)

declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) nounwind

declare i32 @PAPI_set_opt(i32, %union.PAPI_option_t*)

declare i32 @PAPI_event_name_to_code(i8*, i32*)

declare i32 @PAPI_add_event(i32, i32)

declare %struct._IO_FILE* @fopen(i8*, i8*)

declare i64 @PAPI_get_real_usec()

declare i32 @PAPI_start(i32)

declare i32 @PAPI_stop(i32, i64*)

declare i32 @fclose(%struct._IO_FILE*)

declare i64 @read(i32, i8*, i64)

declare void @perror(i8*)

declare i32 @timerfd_create(i32, i32) nounwind

declare i32 @timerfd_settime(i32, i32, %struct.itimerspec*, %struct.itimerspec*) nounwind
