; ModuleID = 'test3.s'
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
@.str = private unnamed_addr constant [16 x i8] c"%lld\09%lld\09%lld\0A\00", align 1
@.str1 = private unnamed_addr constant [30 x i8] c"Can't initiate PAPI library!\0A\00", align 1
@.str2 = private unnamed_addr constant [20 x i8] c"Can't thread init!\0A\00", align 1
@.str3 = private unnamed_addr constant [24 x i8] c"Can't create eventset!\0A\00", align 1
@.str4 = private unnamed_addr constant [31 x i8] c"Can't assign_event_component!\0A\00", align 1
@.str5 = private unnamed_addr constant [20 x i8] c"Can't set inherit!\0A\00", align 1
@.str6 = private unnamed_addr constant [31 x i8] c"MEM_LOAD_MISC_RETIRED:LLC_MISS\00", align 1
@.str7 = private unnamed_addr constant [26 x i8] c"CPU_CLK_UNHALTED:THREAD_P\00", align 1
@.str8 = private unnamed_addr constant [10 x i8] c"error %d\0A\00", align 1
@.str9 = private unnamed_addr constant [14 x i8] c"test3_tcm.txt\00", align 1
@.str10 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str11 = private unnamed_addr constant [27 x i8] c"Wallclock time: %lld usec\0A\00", align 1
@.str12 = private unnamed_addr constant [19 x i8] c"Total Cycles\09%lld\0A\00", align 1
@.str13 = private unnamed_addr constant [37 x i8] c"MEM_LOAD_MISC_RETIRED:LLC_MISS\09%lld\0A\00", align 1
@.str14 = private unnamed_addr constant [32 x i8] c"CPU_CLK_UNHALTED:THREAD_P\09%lld\0A\00", align 1
@.str15 = private unnamed_addr constant [11 x i8] c"read timer\00", align 1
@__dt_dirname = internal unnamed_addr constant [53 x i8] c"/home/kula85/Research/delay-thread/testCacheMissTool\00"
@__dt_filename = internal unnamed_addr constant [8 x i8] c"test3.c\00"
@__dt_pos = external global %struct.__dt_position
@__dt_loopcounter0 = internal global i32 0, align 4
@__dt_loopcounter01 = internal global i32 0, align 4
@__dt_loopcounter02 = internal global i32 0, align 4
@__dt_loopcounter03 = internal global i32 0, align 4
@__dt_loopcounter04 = internal global i32 0, align 4
@__dt_loopcounter05 = internal global i32 0, align 4
@__dt_loopcounter06 = internal global i32 0, align 4
@__dt_loopcounter07 = internal global i32 0, align 4
@__dt_loopcounter08 = internal global i32 0, align 4
@__dt_loopcounter09 = internal global i32 0, align 4

define i8* @PapiKernel(i8* %Args) nounwind uwtable {
entry:
  %retval = alloca i8*, align 8
  %Args.addr = alloca i8*, align 8
  %info = alloca %struct.periodic_info, align 8
  %i = alloca i64, align 8
  store i8* %Args, i8** %Args.addr, align 8
  call void @llvm.dbg.declare(metadata !{i8** %Args.addr}, metadata !109), !dbg !110
  call void @llvm.dbg.declare(metadata !{%struct.periodic_info* %info}, metadata !111), !dbg !113
  call void @llvm.dbg.declare(metadata !{i64* %i}, metadata !114), !dbg !115
  store i64 0, i64* %i, align 8, !dbg !116
  store i64 0, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 0), align 8, !dbg !117
  store i64 0, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 1), align 8, !dbg !118
  store i64 0, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 2), align 8, !dbg !119
  %call = call i32 @make_periodic(i32 10000, %struct.periodic_info* %info), !dbg !120
  br label %while.body, !dbg !121

while.body:                                       ; preds = %while.body, %entry
  %0 = load i64* %i, align 8, !dbg !122
  %add = add nsw i64 %0, 10, !dbg !122
  store i64 %add, i64* %i, align 8, !dbg !122
  %1 = load i32* @eventset, align 4, !dbg !124
  %call1 = call i32 @PAPI_read(i32 %1, i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i32 0)), !dbg !124
  %2 = load %struct._IO_FILE** @gnuplotfile, align 8, !dbg !125
  %3 = load i64* %i, align 8, !dbg !125
  %4 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 1), align 8, !dbg !125
  %5 = load i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 1), align 8, !dbg !125
  %sub = sub nsw i64 %4, %5, !dbg !125
  %6 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 2), align 8, !dbg !125
  %7 = load i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 2), align 8, !dbg !125
  %sub2 = sub nsw i64 %6, %7, !dbg !125
  %call3 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %2, i8* getelementptr inbounds ([16 x i8]* @.str, i32 0, i32 0), i64 %3, i64 %sub, i64 %sub2), !dbg !125
  %8 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 1), align 8, !dbg !126
  store i64 %8, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 1), align 8, !dbg !126
  %9 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 2), align 8, !dbg !127
  store i64 %9, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 2), align 8, !dbg !127
  call void @wait_period(%struct.periodic_info* %info), !dbg !128
  br label %while.body, !dbg !129

return:                                           ; No predecessors!
  %10 = load i8** %retval, !dbg !130
  ret i8* %10, !dbg !130
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

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
  call void @llvm.dbg.declare(metadata !{i32* %period.addr}, metadata !131), !dbg !132
  store %struct.periodic_info* %info, %struct.periodic_info** %info.addr, align 8
  call void @llvm.dbg.declare(metadata !{%struct.periodic_info** %info.addr}, metadata !133), !dbg !134
  call void @llvm.dbg.declare(metadata !{i32* %ret}, metadata !135), !dbg !137
  call void @llvm.dbg.declare(metadata !{i32* %ns}, metadata !138), !dbg !139
  call void @llvm.dbg.declare(metadata !{i32* %sec}, metadata !140), !dbg !141
  call void @llvm.dbg.declare(metadata !{i32* %fd}, metadata !142), !dbg !143
  call void @llvm.dbg.declare(metadata !{%struct.itimerspec* %itval}, metadata !144), !dbg !155
  %call = call i32 @timerfd_create(i32 1, i32 0) nounwind, !dbg !156
  store i32 %call, i32* %fd, align 4, !dbg !156
  %0 = load %struct.periodic_info** %info.addr, align 8, !dbg !157
  %wakeups_missed = getelementptr inbounds %struct.periodic_info* %0, i32 0, i32 1, !dbg !157
  store i64 0, i64* %wakeups_missed, align 8, !dbg !157
  %1 = load i32* %fd, align 4, !dbg !158
  %2 = load %struct.periodic_info** %info.addr, align 8, !dbg !158
  %timer_fd = getelementptr inbounds %struct.periodic_info* %2, i32 0, i32 0, !dbg !158
  store i32 %1, i32* %timer_fd, align 4, !dbg !158
  %3 = load i32* %fd, align 4, !dbg !159
  %cmp = icmp eq i32 %3, -1, !dbg !159
  br i1 %cmp, label %if.then, label %if.end, !dbg !159

if.then:                                          ; preds = %entry
  %4 = load i32* %fd, align 4, !dbg !160
  store i32 %4, i32* %retval, !dbg !160
  br label %return, !dbg !160

if.end:                                           ; preds = %entry
  %5 = load i32* %period.addr, align 4, !dbg !161
  %div = udiv i32 %5, 1000000, !dbg !161
  store i32 %div, i32* %sec, align 4, !dbg !161
  %6 = load i32* %period.addr, align 4, !dbg !162
  %7 = load i32* %sec, align 4, !dbg !162
  %mul = mul i32 %7, 1000000, !dbg !162
  %sub = sub i32 %6, %mul, !dbg !162
  %mul1 = mul i32 %sub, 1000, !dbg !162
  store i32 %mul1, i32* %ns, align 4, !dbg !162
  %8 = load i32* %sec, align 4, !dbg !163
  %conv = zext i32 %8 to i64, !dbg !163
  %it_interval = getelementptr inbounds %struct.itimerspec* %itval, i32 0, i32 0, !dbg !163
  %tv_sec = getelementptr inbounds %struct.timespec* %it_interval, i32 0, i32 0, !dbg !163
  store i64 %conv, i64* %tv_sec, align 8, !dbg !163
  %9 = load i32* %ns, align 4, !dbg !164
  %conv2 = zext i32 %9 to i64, !dbg !164
  %it_interval3 = getelementptr inbounds %struct.itimerspec* %itval, i32 0, i32 0, !dbg !164
  %tv_nsec = getelementptr inbounds %struct.timespec* %it_interval3, i32 0, i32 1, !dbg !164
  store i64 %conv2, i64* %tv_nsec, align 8, !dbg !164
  %10 = load i32* %sec, align 4, !dbg !165
  %conv4 = zext i32 %10 to i64, !dbg !165
  %it_value = getelementptr inbounds %struct.itimerspec* %itval, i32 0, i32 1, !dbg !165
  %tv_sec5 = getelementptr inbounds %struct.timespec* %it_value, i32 0, i32 0, !dbg !165
  store i64 %conv4, i64* %tv_sec5, align 8, !dbg !165
  %11 = load i32* %ns, align 4, !dbg !166
  %conv6 = zext i32 %11 to i64, !dbg !166
  %it_value7 = getelementptr inbounds %struct.itimerspec* %itval, i32 0, i32 1, !dbg !166
  %tv_nsec8 = getelementptr inbounds %struct.timespec* %it_value7, i32 0, i32 1, !dbg !166
  store i64 %conv6, i64* %tv_nsec8, align 8, !dbg !166
  %12 = load i32* %fd, align 4, !dbg !167
  %call9 = call i32 @timerfd_settime(i32 %12, i32 0, %struct.itimerspec* %itval, %struct.itimerspec* null) nounwind, !dbg !167
  store i32 %call9, i32* %ret, align 4, !dbg !167
  %13 = load i32* %ret, align 4, !dbg !168
  store i32 %13, i32* %retval, !dbg !168
  br label %return, !dbg !168

return:                                           ; preds = %if.end, %if.then
  %14 = load i32* %retval, !dbg !169
  ret i32 %14, !dbg !169
}

declare i32 @PAPI_read(i32, i64*)

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...)

define internal void @wait_period(%struct.periodic_info* %info) nounwind uwtable {
entry:
  %info.addr = alloca %struct.periodic_info*, align 8
  %missed = alloca i64, align 8
  %ret = alloca i32, align 4
  store %struct.periodic_info* %info, %struct.periodic_info** %info.addr, align 8
  call void @llvm.dbg.declare(metadata !{%struct.periodic_info** %info.addr}, metadata !170), !dbg !171
  call void @llvm.dbg.declare(metadata !{i64* %missed}, metadata !172), !dbg !174
  call void @llvm.dbg.declare(metadata !{i32* %ret}, metadata !175), !dbg !176
  %0 = load %struct.periodic_info** %info.addr, align 8, !dbg !177
  %timer_fd = getelementptr inbounds %struct.periodic_info* %0, i32 0, i32 0, !dbg !177
  %1 = load i32* %timer_fd, align 4, !dbg !177
  %2 = bitcast i64* %missed to i8*, !dbg !177
  %call = call i64 @read(i32 %1, i8* %2, i64 8), !dbg !177
  %conv = trunc i64 %call to i32, !dbg !177
  store i32 %conv, i32* %ret, align 4, !dbg !177
  %3 = load i32* %ret, align 4, !dbg !178
  %cmp = icmp eq i32 %3, -1, !dbg !178
  br i1 %cmp, label %if.then, label %if.end, !dbg !178

if.then:                                          ; preds = %entry
  call void @perror(i8* getelementptr inbounds ([11 x i8]* @.str15, i32 0, i32 0)), !dbg !179
  br label %if.end5, !dbg !181

if.end:                                           ; preds = %entry
  %4 = load i64* %missed, align 8, !dbg !182
  %cmp2 = icmp ugt i64 %4, 0, !dbg !182
  br i1 %cmp2, label %if.then4, label %if.end5, !dbg !182

if.then4:                                         ; preds = %if.end
  %5 = load i64* %missed, align 8, !dbg !183
  %sub = sub i64 %5, 1, !dbg !183
  %6 = load %struct.periodic_info** %info.addr, align 8, !dbg !183
  %wakeups_missed = getelementptr inbounds %struct.periodic_info* %6, i32 0, i32 1, !dbg !183
  %7 = load i64* %wakeups_missed, align 8, !dbg !183
  %add = add i64 %7, %sub, !dbg !183
  store i64 %add, i64* %wakeups_missed, align 8, !dbg !183
  br label %if.end5, !dbg !183

if.end5:                                          ; preds = %if.then4, %if.end, %if.then
  ret void, !dbg !184
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
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !185), !dbg !187
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !188), !dbg !189
  call void @llvm.dbg.declare(metadata !{i32* %numInt}, metadata !190), !dbg !191
  call void @llvm.dbg.declare(metadata !{i32* %numCachelineUsed}, metadata !192), !dbg !193
  call void @llvm.dbg.declare(metadata !{i32** %a}, metadata !194), !dbg !196
  store i32 2097152, i32* %numInt, align 4, !dbg !197
  store i32 131072, i32* %numCachelineUsed, align 4, !dbg !198
  %0 = load i32* %numInt, align 4, !dbg !199
  %conv = sext i32 %0 to i64, !dbg !199
  %mul = mul i64 4, %conv, !dbg !199
  %call = call noalias i8* @malloc(i64 %mul) nounwind, !dbg !199
  %1 = bitcast i8* %call to i32*, !dbg !199
  store i32* %1, i32** %a, align 8, !dbg !199
  call void @llvm.dbg.declare(metadata !{%union.pthread_attr_t* %attr}, metadata !200), !dbg !210
  call void @llvm.dbg.declare(metadata !{i64* %Thread}, metadata !211), !dbg !213
  %call1 = call i32 @pthread_attr_init(%union.pthread_attr_t* %attr) nounwind, !dbg !214
  %call2 = call i32 @pthread_attr_setdetachstate(%union.pthread_attr_t* %attr, i32 0) nounwind, !dbg !215
  %call3 = call i32 @pthread_create(i64* %Thread, %union.pthread_attr_t* %attr, i8* (i8*)* @PapiKernel, i8* null) nounwind, !dbg !216
  store i32 0, i32* %j, align 4, !dbg !217
  br label %for.cond, !dbg !217

for.cond:                                         ; preds = %for.inc11, %entry
  %2 = load i32* %j, align 4, !dbg !217
  %cmp = icmp slt i32 %2, 16, !dbg !217
  br i1 %cmp, label %for.body, label %for.end13, !dbg !217

for.body:                                         ; preds = %for.cond
  %3 = load i32* @__dt_loopcounter0, !dbg !219
  %4 = add nsw i32 %3, 1, !dbg !219
  store i32 %4, i32* @__dt_loopcounter0, !dbg !219
  %5 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 0, i64 0), i8* getelementptr inbounds ([53 x i8]* @__dt_dirname, i64 0, i64 0)), !dbg !219
  %6 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 1, i64 0), i8* getelementptr inbounds ([8 x i8]* @__dt_filename, i64 0, i64 0)), !dbg !219
  store i32 127, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 2), !dbg !219
  %7 = load i32* @__dt_loopcounter0, !dbg !219
  store i32 %7, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 3), !dbg !219
  store i32 0, i32* %i, align 4, !dbg !219
  br label %for.cond5, !dbg !219

for.cond5:                                        ; preds = %for.inc, %for.body
  %8 = load i32* %i, align 4, !dbg !219
  %9 = load i32* %numCachelineUsed, align 4, !dbg !219
  %cmp6 = icmp slt i32 %8, %9, !dbg !219
  br i1 %cmp6, label %for.body8, label %for.end, !dbg !219

for.body8:                                        ; preds = %for.cond5
  %10 = load i32* @__dt_loopcounter01, !dbg !221
  %11 = add nsw i32 %10, 1, !dbg !221
  store i32 %11, i32* @__dt_loopcounter01, !dbg !221
  %12 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 0, i64 0), i8* getelementptr inbounds ([53 x i8]* @__dt_dirname, i64 0, i64 0)), !dbg !221
  %13 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 1, i64 0), i8* getelementptr inbounds ([8 x i8]* @__dt_filename, i64 0, i64 0)), !dbg !221
  store i32 128, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 2), !dbg !221
  %14 = load i32* @__dt_loopcounter01, !dbg !221
  store i32 %14, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 3), !dbg !221
  %15 = load i32* %i, align 4, !dbg !221
  %mul9 = mul nsw i32 %15, 16, !dbg !221
  %16 = load i32* %j, align 4, !dbg !221
  %add = add nsw i32 %mul9, %16, !dbg !221
  %idxprom = sext i32 %add to i64, !dbg !221
  %17 = load i32** %a, align 8, !dbg !221
  %arrayidx = getelementptr inbounds i32* %17, i64 %idxprom, !dbg !221
  %18 = load i32* %arrayidx, !dbg !221
  %inc = add nsw i32 %18, 1, !dbg !221
  store i32 %inc, i32* %arrayidx, !dbg !221
  br label %for.inc, !dbg !223

for.inc:                                          ; preds = %for.body8
  %19 = load i32* %i, align 4, !dbg !224
  %inc10 = add nsw i32 %19, 1, !dbg !224
  store i32 %inc10, i32* %i, align 4, !dbg !224
  br label %for.cond5, !dbg !224

for.end:                                          ; preds = %for.cond5
  br label %for.inc11, !dbg !225

for.inc11:                                        ; preds = %for.end
  %20 = load i32* %j, align 4, !dbg !226
  %inc12 = add nsw i32 %20, 1, !dbg !226
  store i32 %inc12, i32* %j, align 4, !dbg !226
  br label %for.cond, !dbg !226

for.end13:                                        ; preds = %for.cond
  store i32 0, i32* %i, align 4, !dbg !227
  br label %for.cond14, !dbg !227

for.cond14:                                       ; preds = %for.inc21, %for.end13
  %21 = load i32* %i, align 4, !dbg !227
  %22 = load i32* %numInt, align 4, !dbg !227
  %cmp15 = icmp slt i32 %21, %22, !dbg !227
  br i1 %cmp15, label %for.body17, label %for.end23, !dbg !227

for.body17:                                       ; preds = %for.cond14
  %23 = load i32* @__dt_loopcounter02, !dbg !229
  %24 = add nsw i32 %23, 1, !dbg !229
  store i32 %24, i32* @__dt_loopcounter02, !dbg !229
  %25 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 0, i64 0), i8* getelementptr inbounds ([53 x i8]* @__dt_dirname, i64 0, i64 0)), !dbg !229
  %26 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 1, i64 0), i8* getelementptr inbounds ([8 x i8]* @__dt_filename, i64 0, i64 0)), !dbg !229
  store i32 137, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 2), !dbg !229
  %27 = load i32* @__dt_loopcounter02, !dbg !229
  store i32 %27, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 3), !dbg !229
  %28 = load i32* %i, align 4, !dbg !229
  %idxprom18 = sext i32 %28 to i64, !dbg !229
  %29 = load i32** %a, align 8, !dbg !229
  %arrayidx19 = getelementptr inbounds i32* %29, i64 %idxprom18, !dbg !229
  %30 = load i32* %arrayidx19, !dbg !229
  %inc20 = add nsw i32 %30, 1, !dbg !229
  store i32 %inc20, i32* %arrayidx19, !dbg !229
  br label %for.inc21, !dbg !229

for.inc21:                                        ; preds = %for.body17
  %31 = load i32* %i, align 4, !dbg !230
  %inc22 = add nsw i32 %31, 1, !dbg !230
  store i32 %inc22, i32* %i, align 4, !dbg !230
  br label %for.cond14, !dbg !230

for.end23:                                        ; preds = %for.cond14
  store i32 0, i32* %j, align 4, !dbg !231
  br label %for.cond24, !dbg !231

for.cond24:                                       ; preds = %for.inc40, %for.end23
  %32 = load i32* %j, align 4, !dbg !231
  %cmp25 = icmp slt i32 %32, 16, !dbg !231
  br i1 %cmp25, label %for.body27, label %for.end42, !dbg !231

for.body27:                                       ; preds = %for.cond24
  %33 = load i32* @__dt_loopcounter03, !dbg !233
  %34 = add nsw i32 %33, 1, !dbg !233
  store i32 %34, i32* @__dt_loopcounter03, !dbg !233
  %35 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 0, i64 0), i8* getelementptr inbounds ([53 x i8]* @__dt_dirname, i64 0, i64 0)), !dbg !233
  %36 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 1, i64 0), i8* getelementptr inbounds ([8 x i8]* @__dt_filename, i64 0, i64 0)), !dbg !233
  store i32 141, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 2), !dbg !233
  %37 = load i32* @__dt_loopcounter03, !dbg !233
  store i32 %37, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 3), !dbg !233
  store i32 0, i32* %i, align 4, !dbg !233
  br label %for.cond28, !dbg !233

for.cond28:                                       ; preds = %for.inc37, %for.body27
  %38 = load i32* %i, align 4, !dbg !233
  %39 = load i32* %numCachelineUsed, align 4, !dbg !233
  %cmp29 = icmp slt i32 %38, %39, !dbg !233
  br i1 %cmp29, label %for.body31, label %for.end39, !dbg !233

for.body31:                                       ; preds = %for.cond28
  %40 = load i32* @__dt_loopcounter04, !dbg !235
  %41 = add nsw i32 %40, 1, !dbg !235
  store i32 %41, i32* @__dt_loopcounter04, !dbg !235
  %42 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 0, i64 0), i8* getelementptr inbounds ([53 x i8]* @__dt_dirname, i64 0, i64 0)), !dbg !235
  %43 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 1, i64 0), i8* getelementptr inbounds ([8 x i8]* @__dt_filename, i64 0, i64 0)), !dbg !235
  store i32 142, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 2), !dbg !235
  %44 = load i32* @__dt_loopcounter04, !dbg !235
  store i32 %44, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 3), !dbg !235
  %45 = load i32* %i, align 4, !dbg !235
  %mul32 = mul nsw i32 %45, 16, !dbg !235
  %46 = load i32* %j, align 4, !dbg !235
  %add33 = add nsw i32 %mul32, %46, !dbg !235
  %idxprom34 = sext i32 %add33 to i64, !dbg !235
  %47 = load i32** %a, align 8, !dbg !235
  %arrayidx35 = getelementptr inbounds i32* %47, i64 %idxprom34, !dbg !235
  %48 = load i32* %arrayidx35, !dbg !235
  %inc36 = add nsw i32 %48, 1, !dbg !235
  store i32 %inc36, i32* %arrayidx35, !dbg !235
  br label %for.inc37, !dbg !235

for.inc37:                                        ; preds = %for.body31
  %49 = load i32* %i, align 4, !dbg !236
  %inc38 = add nsw i32 %49, 1, !dbg !236
  store i32 %inc38, i32* %i, align 4, !dbg !236
  br label %for.cond28, !dbg !236

for.end39:                                        ; preds = %for.cond28
  br label %for.inc40, !dbg !237

for.inc40:                                        ; preds = %for.end39
  %50 = load i32* %j, align 4, !dbg !238
  %inc41 = add nsw i32 %50, 1, !dbg !238
  store i32 %inc41, i32* %j, align 4, !dbg !238
  br label %for.cond24, !dbg !238

for.end42:                                        ; preds = %for.cond24
  store i32 0, i32* %i, align 4, !dbg !239
  br label %for.cond43, !dbg !239

for.cond43:                                       ; preds = %for.inc50, %for.end42
  %51 = load i32* %i, align 4, !dbg !239
  %52 = load i32* %numInt, align 4, !dbg !239
  %cmp44 = icmp slt i32 %51, %52, !dbg !239
  br i1 %cmp44, label %for.body46, label %for.end52, !dbg !239

for.body46:                                       ; preds = %for.cond43
  %53 = load i32* @__dt_loopcounter05, !dbg !241
  %54 = add nsw i32 %53, 1, !dbg !241
  store i32 %54, i32* @__dt_loopcounter05, !dbg !241
  %55 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 0, i64 0), i8* getelementptr inbounds ([53 x i8]* @__dt_dirname, i64 0, i64 0)), !dbg !241
  %56 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 1, i64 0), i8* getelementptr inbounds ([8 x i8]* @__dt_filename, i64 0, i64 0)), !dbg !241
  store i32 146, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 2), !dbg !241
  %57 = load i32* @__dt_loopcounter05, !dbg !241
  store i32 %57, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 3), !dbg !241
  %58 = load i32* %i, align 4, !dbg !241
  %idxprom47 = sext i32 %58 to i64, !dbg !241
  %59 = load i32** %a, align 8, !dbg !241
  %arrayidx48 = getelementptr inbounds i32* %59, i64 %idxprom47, !dbg !241
  %60 = load i32* %arrayidx48, !dbg !241
  %inc49 = add nsw i32 %60, 1, !dbg !241
  store i32 %inc49, i32* %arrayidx48, !dbg !241
  br label %for.inc50, !dbg !241

for.inc50:                                        ; preds = %for.body46
  %61 = load i32* %i, align 4, !dbg !242
  %inc51 = add nsw i32 %61, 1, !dbg !242
  store i32 %inc51, i32* %i, align 4, !dbg !242
  br label %for.cond43, !dbg !242

for.end52:                                        ; preds = %for.cond43
  store i32 0, i32* %j, align 4, !dbg !243
  br label %for.cond53, !dbg !243

for.cond53:                                       ; preds = %for.inc69, %for.end52
  %62 = load i32* %j, align 4, !dbg !243
  %cmp54 = icmp slt i32 %62, 16, !dbg !243
  br i1 %cmp54, label %for.body56, label %for.end71, !dbg !243

for.body56:                                       ; preds = %for.cond53
  %63 = load i32* @__dt_loopcounter06, !dbg !245
  %64 = add nsw i32 %63, 1, !dbg !245
  store i32 %64, i32* @__dt_loopcounter06, !dbg !245
  %65 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 0, i64 0), i8* getelementptr inbounds ([53 x i8]* @__dt_dirname, i64 0, i64 0)), !dbg !245
  %66 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 1, i64 0), i8* getelementptr inbounds ([8 x i8]* @__dt_filename, i64 0, i64 0)), !dbg !245
  store i32 150, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 2), !dbg !245
  %67 = load i32* @__dt_loopcounter06, !dbg !245
  store i32 %67, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 3), !dbg !245
  store i32 0, i32* %i, align 4, !dbg !245
  br label %for.cond57, !dbg !245

for.cond57:                                       ; preds = %for.inc66, %for.body56
  %68 = load i32* %i, align 4, !dbg !245
  %69 = load i32* %numCachelineUsed, align 4, !dbg !245
  %cmp58 = icmp slt i32 %68, %69, !dbg !245
  br i1 %cmp58, label %for.body60, label %for.end68, !dbg !245

for.body60:                                       ; preds = %for.cond57
  %70 = load i32* @__dt_loopcounter07, !dbg !247
  %71 = add nsw i32 %70, 1, !dbg !247
  store i32 %71, i32* @__dt_loopcounter07, !dbg !247
  %72 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 0, i64 0), i8* getelementptr inbounds ([53 x i8]* @__dt_dirname, i64 0, i64 0)), !dbg !247
  %73 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 1, i64 0), i8* getelementptr inbounds ([8 x i8]* @__dt_filename, i64 0, i64 0)), !dbg !247
  store i32 151, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 2), !dbg !247
  %74 = load i32* @__dt_loopcounter07, !dbg !247
  store i32 %74, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 3), !dbg !247
  %75 = load i32* %i, align 4, !dbg !247
  %mul61 = mul nsw i32 %75, 16, !dbg !247
  %76 = load i32* %j, align 4, !dbg !247
  %add62 = add nsw i32 %mul61, %76, !dbg !247
  %idxprom63 = sext i32 %add62 to i64, !dbg !247
  %77 = load i32** %a, align 8, !dbg !247
  %arrayidx64 = getelementptr inbounds i32* %77, i64 %idxprom63, !dbg !247
  %78 = load i32* %arrayidx64, !dbg !247
  %inc65 = add nsw i32 %78, 1, !dbg !247
  store i32 %inc65, i32* %arrayidx64, !dbg !247
  br label %for.inc66, !dbg !247

for.inc66:                                        ; preds = %for.body60
  %79 = load i32* %i, align 4, !dbg !248
  %inc67 = add nsw i32 %79, 1, !dbg !248
  store i32 %inc67, i32* %i, align 4, !dbg !248
  br label %for.cond57, !dbg !248

for.end68:                                        ; preds = %for.cond57
  br label %for.inc69, !dbg !249

for.inc69:                                        ; preds = %for.end68
  %80 = load i32* %j, align 4, !dbg !250
  %inc70 = add nsw i32 %80, 1, !dbg !250
  store i32 %inc70, i32* %j, align 4, !dbg !250
  br label %for.cond53, !dbg !250

for.end71:                                        ; preds = %for.cond53
  store i32 0, i32* %i, align 4, !dbg !251
  br label %for.cond72, !dbg !251

for.cond72:                                       ; preds = %for.inc79, %for.end71
  %81 = load i32* %i, align 4, !dbg !251
  %82 = load i32* %numInt, align 4, !dbg !251
  %cmp73 = icmp slt i32 %81, %82, !dbg !251
  br i1 %cmp73, label %for.body75, label %for.end81, !dbg !251

for.body75:                                       ; preds = %for.cond72
  %83 = load i32* @__dt_loopcounter08, !dbg !253
  %84 = add nsw i32 %83, 1, !dbg !253
  store i32 %84, i32* @__dt_loopcounter08, !dbg !253
  %85 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 0, i64 0), i8* getelementptr inbounds ([53 x i8]* @__dt_dirname, i64 0, i64 0)), !dbg !253
  %86 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 1, i64 0), i8* getelementptr inbounds ([8 x i8]* @__dt_filename, i64 0, i64 0)), !dbg !253
  store i32 155, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 2), !dbg !253
  %87 = load i32* @__dt_loopcounter08, !dbg !253
  store i32 %87, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 3), !dbg !253
  %88 = load i32* %i, align 4, !dbg !253
  %idxprom76 = sext i32 %88 to i64, !dbg !253
  %89 = load i32** %a, align 8, !dbg !253
  %arrayidx77 = getelementptr inbounds i32* %89, i64 %idxprom76, !dbg !253
  %90 = load i32* %arrayidx77, !dbg !253
  %inc78 = add nsw i32 %90, 1, !dbg !253
  store i32 %inc78, i32* %arrayidx77, !dbg !253
  br label %for.inc79, !dbg !253

for.inc79:                                        ; preds = %for.body75
  %91 = load i32* %i, align 4, !dbg !254
  %inc80 = add nsw i32 %91, 1, !dbg !254
  store i32 %inc80, i32* %i, align 4, !dbg !254
  br label %for.cond72, !dbg !254

for.end81:                                        ; preds = %for.cond72
  %92 = load i64* %Thread, align 8, !dbg !255
  %call82 = call i32 @pthread_cancel(i64 %92), !dbg !255
  ret i32 0, !dbg !256
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
  call void @llvm.dbg.declare(metadata !{i32* %argc.addr}, metadata !257), !dbg !258
  store i8** %argv, i8*** %argv.addr, align 8
  call void @llvm.dbg.declare(metadata !{i8*** %argv.addr}, metadata !259), !dbg !260
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !261), !dbg !263
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !264), !dbg !265
  call void @llvm.dbg.declare(metadata !{i64* %s}, metadata !266), !dbg !267
  call void @llvm.dbg.declare(metadata !{i64* %e}, metadata !268), !dbg !269
  call void @llvm.dbg.declare(metadata !{i32* %retval1}, metadata !270), !dbg !271
  call void @llvm.dbg.declare(metadata !{i32* %eventcode}, metadata !272), !dbg !273
  call void @llvm.dbg.declare(metadata !{%union.PAPI_option_t* %opt}, metadata !274), !dbg !498
  %call = call i32 @PAPI_library_init(i32 67239936), !dbg !499
  %cmp = icmp ne i32 67239936, %call, !dbg !499
  br i1 %cmp, label %if.then, label %if.end, !dbg !499

if.then:                                          ; preds = %entry
  %call2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([30 x i8]* @.str1, i32 0, i32 0)), !dbg !500
  call void @exit(i32 -1) noreturn nounwind, !dbg !502
  unreachable, !dbg !502

if.end:                                           ; preds = %entry
  %call3 = call i32 @PAPI_thread_init(i64 ()* @pthread_self), !dbg !503
  %cmp4 = icmp ne i32 %call3, 0, !dbg !503
  br i1 %cmp4, label %if.then5, label %if.end7, !dbg !503

if.then5:                                         ; preds = %if.end
  %call6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str2, i32 0, i32 0)), !dbg !504
  call void @exit(i32 -1) noreturn nounwind, !dbg !506
  unreachable, !dbg !506

if.end7:                                          ; preds = %if.end
  store i32 -1, i32* @eventset, align 4, !dbg !507
  %call8 = call i32 @PAPI_create_eventset(i32* @eventset), !dbg !508
  %cmp9 = icmp ne i32 %call8, 0, !dbg !508
  br i1 %cmp9, label %if.then10, label %if.end12, !dbg !508

if.then10:                                        ; preds = %if.end7
  %call11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([24 x i8]* @.str3, i32 0, i32 0)), !dbg !509
  call void @exit(i32 -3) noreturn nounwind, !dbg !511
  unreachable, !dbg !511

if.end12:                                         ; preds = %if.end7
  %0 = load i32* @eventset, align 4, !dbg !512
  %call13 = call i32 @PAPI_assign_eventset_component(i32 %0, i32 0), !dbg !512
  store i32 %call13, i32* %retval1, align 4, !dbg !512
  %cmp14 = icmp ne i32 %call13, 0, !dbg !512
  br i1 %cmp14, label %if.then15, label %if.end17, !dbg !512

if.then15:                                        ; preds = %if.end12
  %call16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([31 x i8]* @.str4, i32 0, i32 0)), !dbg !513
  call void @exit(i32 -3) noreturn nounwind, !dbg !515
  unreachable, !dbg !515

if.end17:                                         ; preds = %if.end12
  %1 = bitcast %union.PAPI_option_t* %opt to i8*, !dbg !516
  call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 264, i32 1, i1 false), !dbg !516
  %inherit = bitcast %union.PAPI_option_t* %opt to %struct._papi_inherit_option*, !dbg !517
  %inherit18 = getelementptr inbounds %struct._papi_inherit_option* %inherit, i32 0, i32 1, !dbg !517
  store i32 1, i32* %inherit18, align 4, !dbg !517
  %2 = load i32* @eventset, align 4, !dbg !518
  %inherit19 = bitcast %union.PAPI_option_t* %opt to %struct._papi_inherit_option*, !dbg !518
  %eventset = getelementptr inbounds %struct._papi_inherit_option* %inherit19, i32 0, i32 0, !dbg !518
  store i32 %2, i32* %eventset, align 4, !dbg !518
  %call20 = call i32 @PAPI_set_opt(i32 28, %union.PAPI_option_t* %opt), !dbg !519
  store i32 %call20, i32* %retval1, align 4, !dbg !519
  %cmp21 = icmp ne i32 %call20, 0, !dbg !519
  br i1 %cmp21, label %if.then22, label %if.end24, !dbg !519

if.then22:                                        ; preds = %if.end17
  %call23 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str5, i32 0, i32 0)), !dbg !520
  call void @exit(i32 -3) noreturn nounwind, !dbg !522
  unreachable, !dbg !522

if.end24:                                         ; preds = %if.end17
  %call25 = call i32 @PAPI_event_name_to_code(i8* getelementptr inbounds ([31 x i8]* @.str6, i32 0, i32 0), i32* %eventcode), !dbg !523
  %3 = load i32* %eventcode, align 4, !dbg !524
  store i32 %3, i32* getelementptr inbounds ([3 x i32]* @events, i32 0, i64 1), align 4, !dbg !524
  %call26 = call i32 @PAPI_event_name_to_code(i8* getelementptr inbounds ([26 x i8]* @.str7, i32 0, i32 0), i32* %eventcode), !dbg !525
  %4 = load i32* %eventcode, align 4, !dbg !526
  store i32 %4, i32* getelementptr inbounds ([3 x i32]* @events, i32 0, i64 2), align 4, !dbg !526
  store i32 0, i32* %i, align 4, !dbg !527
  br label %for.cond, !dbg !527

for.cond:                                         ; preds = %for.inc, %if.end24
  %5 = load i32* %i, align 4, !dbg !527
  %cmp27 = icmp slt i32 %5, 3, !dbg !527
  br i1 %cmp27, label %for.body, label %for.end, !dbg !527

for.body:                                         ; preds = %for.cond
  %6 = load i32* @__dt_loopcounter09, !dbg !529
  %7 = add nsw i32 %6, 1, !dbg !529
  store i32 %7, i32* @__dt_loopcounter09, !dbg !529
  %8 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 0, i64 0), i8* getelementptr inbounds ([53 x i8]* @__dt_dirname, i64 0, i64 0)), !dbg !529
  %9 = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 1, i64 0), i8* getelementptr inbounds ([8 x i8]* @__dt_filename, i64 0, i64 0)), !dbg !529
  store i32 207, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 2), !dbg !529
  %10 = load i32* @__dt_loopcounter09, !dbg !529
  store i32 %10, i32* getelementptr inbounds (%struct.__dt_position* @__dt_pos, i64 0, i32 3), !dbg !529
  %11 = load i32* @eventset, align 4, !dbg !529
  %12 = load i32* %i, align 4, !dbg !529
  %idxprom = sext i32 %12 to i64, !dbg !529
  %arrayidx = getelementptr inbounds [3 x i32]* @events, i32 0, i64 %idxprom, !dbg !529
  %13 = load i32* %arrayidx, align 4, !dbg !529
  %call28 = call i32 @PAPI_add_event(i32 %11, i32 %13), !dbg !529
  store i32 %call28, i32* %retval1, align 4, !dbg !529
  %14 = load i32* %retval1, align 4, !dbg !531
  %cmp29 = icmp ne i32 %14, 0, !dbg !531
  br i1 %cmp29, label %if.then30, label %if.end32, !dbg !531

if.then30:                                        ; preds = %for.body
  %15 = load i32* %retval1, align 4, !dbg !532
  %call31 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str8, i32 0, i32 0), i32 %15), !dbg !532
  call void @exit(i32 -4) noreturn nounwind, !dbg !534
  unreachable, !dbg !534

if.end32:                                         ; preds = %for.body
  br label %for.inc, !dbg !535

for.inc:                                          ; preds = %if.end32
  %16 = load i32* %i, align 4, !dbg !536
  %inc = add nsw i32 %16, 1, !dbg !536
  store i32 %inc, i32* %i, align 4, !dbg !536
  br label %for.cond, !dbg !536

for.end:                                          ; preds = %for.cond
  %call33 = call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([14 x i8]* @.str9, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8]* @.str10, i32 0, i32 0)), !dbg !537
  store %struct._IO_FILE* %call33, %struct._IO_FILE** @gnuplotfile, align 8, !dbg !537
  %call34 = call i64 @PAPI_get_real_usec(), !dbg !538
  store i64 %call34, i64* %s, align 8, !dbg !538
  %17 = load i32* @eventset, align 4, !dbg !539
  %call35 = call i32 @PAPI_start(i32 %17), !dbg !539
  %call36 = call i32 @test(), !dbg !540
  %18 = load i32* @eventset, align 4, !dbg !541
  %call37 = call i32 @PAPI_stop(i32 %18, i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i32 0)), !dbg !541
  %call38 = call i64 @PAPI_get_real_usec(), !dbg !542
  store i64 %call38, i64* %e, align 8, !dbg !542
  %19 = load %struct._IO_FILE** @gnuplotfile, align 8, !dbg !543
  %call39 = call i32 @fclose(%struct._IO_FILE* %19), !dbg !543
  %20 = load i64* %e, align 8, !dbg !544
  %21 = load i64* %s, align 8, !dbg !544
  %sub = sub nsw i64 %20, %21, !dbg !544
  %call40 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([27 x i8]* @.str11, i32 0, i32 0), i64 %sub), !dbg !544
  %22 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 0), align 8, !dbg !545
  %call41 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str12, i32 0, i32 0), i64 %22), !dbg !545
  %23 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 1), align 8, !dbg !546
  %call42 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([37 x i8]* @.str13, i32 0, i32 0), i64 %23), !dbg !546
  %24 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 2), align 8, !dbg !547
  %call43 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([32 x i8]* @.str14, i32 0, i32 0), i64 %24), !dbg !547
  ret i32 0, !dbg !548
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

declare i8* @strcpy(i8*, i8* nocapture) nounwind

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 720913, i32 0, i32 12, metadata !"test3.c", metadata !"/home/kula85/Research/delay-thread/testCacheMissTool", metadata !"clang version 3.1 (trunk 144408)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !8, metadata !17, metadata !42} ; [ DW_TAG_compile_unit ]
!1 = metadata !{metadata !2}
!2 = metadata !{metadata !3}
!3 = metadata !{i32 720900, null, metadata !"", metadata !4, i32 36, i64 32, i64 32, i32 0, i32 0, i32 0, metadata !5, i32 0, i32 0} ; [ DW_TAG_enumeration_type ]
!4 = metadata !{i32 720937, metadata !"/usr/include/pthread.h", metadata !"/home/kula85/Research/delay-thread/testCacheMissTool", null} ; [ DW_TAG_file_type ]
!5 = metadata !{metadata !6, metadata !7}
!6 = metadata !{i32 720936, metadata !"PTHREAD_CREATE_JOINABLE", i64 0} ; [ DW_TAG_enumerator ]
!7 = metadata !{i32 720936, metadata !"PTHREAD_CREATE_DETACHED", i64 1} ; [ DW_TAG_enumerator ]
!8 = metadata !{metadata !9}
!9 = metadata !{metadata !10}
!10 = metadata !{i32 720915, null, metadata !"periodic_info", metadata !11, i32 29, i64 128, i64 64, i32 0, i32 0, i32 0, metadata !12, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!11 = metadata !{i32 720937, metadata !"test3.c", metadata !"/home/kula85/Research/delay-thread/testCacheMissTool", null} ; [ DW_TAG_file_type ]
!12 = metadata !{metadata !13, metadata !15}
!13 = metadata !{i32 720909, metadata !10, metadata !"timer_fd", metadata !11, i32 31, i64 32, i64 32, i64 0, i32 0, metadata !14} ; [ DW_TAG_member ]
!14 = metadata !{i32 720932, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ]
!15 = metadata !{i32 720909, metadata !10, metadata !"wakeups_missed", metadata !11, i32 32, i64 64, i64 64, i64 64, i32 0, metadata !16} ; [ DW_TAG_member ]
!16 = metadata !{i32 720932, null, metadata !"long long unsigned int", null, i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ]
!17 = metadata !{metadata !18}
!18 = metadata !{metadata !19, metadata !25, metadata !28, metadata !34, metadata !38}
!19 = metadata !{i32 720942, i32 0, metadata !11, metadata !"PapiKernel", metadata !"PapiKernel", metadata !"", metadata !11, i32 80, metadata !20, i1 false, i1 true, i32 0, i32 0, i32 0, i32 256, i1 false, i8* (i8*)* @PapiKernel, null, null, metadata !23} ; [ DW_TAG_subprogram ]
!20 = metadata !{i32 720917, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i32 0, i32 0, i32 0, metadata !21, i32 0, i32 0} ; [ DW_TAG_subroutine_type ]
!21 = metadata !{metadata !22, metadata !22}
!22 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ]
!23 = metadata !{metadata !24}
!24 = metadata !{i32 720932}                      ; [ DW_TAG_base_type ]
!25 = metadata !{i32 720942, i32 0, metadata !11, metadata !"test", metadata !"test", metadata !"", metadata !11, i32 106, metadata !26, i1 false, i1 true, i32 0, i32 0, i32 0, i32 0, i1 false, i32 ()* @test, null, null, metadata !23} ; [ DW_TAG_subprogram ]
!26 = metadata !{i32 720917, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i32 0, i32 0, i32 0, metadata !27, i32 0, i32 0} ; [ DW_TAG_subroutine_type ]
!27 = metadata !{metadata !14}
!28 = metadata !{i32 720942, i32 0, metadata !11, metadata !"main", metadata !"main", metadata !"", metadata !11, i32 164, metadata !29, i1 false, i1 true, i32 0, i32 0, i32 0, i32 256, i1 false, i32 (i32, i8**)* @main, null, null, metadata !23} ; [ DW_TAG_subprogram ]
!29 = metadata !{i32 720917, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i32 0, i32 0, i32 0, metadata !30, i32 0, i32 0} ; [ DW_TAG_subroutine_type ]
!30 = metadata !{metadata !14, metadata !14, metadata !31}
!31 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !32} ; [ DW_TAG_pointer_type ]
!32 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !33} ; [ DW_TAG_pointer_type ]
!33 = metadata !{i32 720932, null, metadata !"char", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ]
!34 = metadata !{i32 720942, i32 0, metadata !11, metadata !"wait_period", metadata !"wait_period", metadata !"", metadata !11, i32 62, metadata !35, i1 true, i1 true, i32 0, i32 0, i32 0, i32 256, i1 false, void (%struct.periodic_info*)* @wait_period, null, null, metadata !23} ; [ DW_TAG_subprogram ]
!35 = metadata !{i32 720917, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i32 0, i32 0, i32 0, metadata !36, i32 0, i32 0} ; [ DW_TAG_subroutine_type ]
!36 = metadata !{null, metadata !37}
!37 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ]
!38 = metadata !{i32 720942, i32 0, metadata !11, metadata !"make_periodic", metadata !"make_periodic", metadata !"", metadata !11, i32 36, metadata !39, i1 true, i1 true, i32 0, i32 0, i32 0, i32 256, i1 false, i32 (i32, %struct.periodic_info*)* @make_periodic, null, null, metadata !23} ; [ DW_TAG_subprogram ]
!39 = metadata !{i32 720917, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i32 0, i32 0, i32 0, metadata !40, i32 0, i32 0} ; [ DW_TAG_subroutine_type ]
!40 = metadata !{metadata !14, metadata !41, metadata !37}
!41 = metadata !{i32 720932, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ]
!42 = metadata !{metadata !43}
!43 = metadata !{metadata !44, metadata !48, metadata !49, metadata !52, metadata !53, metadata !54}
!44 = metadata !{i32 720948, i32 0, null, metadata !"events", metadata !"events", metadata !"", metadata !11, i32 20, metadata !45, i32 0, i32 1, [3 x i32]* @events} ; [ DW_TAG_variable ]
!45 = metadata !{i32 720897, null, metadata !"", null, i32 0, i64 96, i64 32, i32 0, i32 0, metadata !14, metadata !46, i32 0, i32 0} ; [ DW_TAG_array_type ]
!46 = metadata !{metadata !47}
!47 = metadata !{i32 720929, i64 0, i64 2}        ; [ DW_TAG_subrange_type ]
!48 = metadata !{i32 720948, i32 0, null, metadata !"eventnum", metadata !"eventnum", metadata !"", metadata !11, i32 21, metadata !14, i32 0, i32 1, i32* @eventnum} ; [ DW_TAG_variable ]
!49 = metadata !{i32 720948, i32 0, null, metadata !"values", metadata !"values", metadata !"", metadata !11, i32 22, metadata !50, i32 0, i32 1, [3 x i64]* @values} ; [ DW_TAG_variable ]
!50 = metadata !{i32 720897, null, metadata !"", null, i32 0, i64 192, i64 64, i32 0, i32 0, metadata !51, metadata !46, i32 0, i32 0} ; [ DW_TAG_array_type ]
!51 = metadata !{i32 720932, null, metadata !"long long int", null, i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ]
!52 = metadata !{i32 720948, i32 0, null, metadata !"tempvalues", metadata !"tempvalues", metadata !"", metadata !11, i32 23, metadata !50, i32 0, i32 1, [3 x i64]* @tempvalues} ; [ DW_TAG_variable ]
!53 = metadata !{i32 720948, i32 0, null, metadata !"eventset", metadata !"eventset", metadata !"", metadata !11, i32 24, metadata !14, i32 0, i32 1, i32* @eventset} ; [ DW_TAG_variable ]
!54 = metadata !{i32 720948, i32 0, null, metadata !"gnuplotfile", metadata !"gnuplotfile", metadata !"", metadata !11, i32 25, metadata !55, i32 0, i32 1, %struct._IO_FILE** @gnuplotfile} ; [ DW_TAG_variable ]
!55 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !56} ; [ DW_TAG_pointer_type ]
!56 = metadata !{i32 720918, null, metadata !"FILE", metadata !11, i32 49, i64 0, i64 0, i64 0, i32 0, metadata !57} ; [ DW_TAG_typedef ]
!57 = metadata !{i32 720915, null, metadata !"_IO_FILE", metadata !58, i32 271, i64 1728, i64 64, i32 0, i32 0, i32 0, metadata !59, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!58 = metadata !{i32 720937, metadata !"/usr/include/libio.h", metadata !"/home/kula85/Research/delay-thread/testCacheMissTool", null} ; [ DW_TAG_file_type ]
!59 = metadata !{metadata !60, metadata !61, metadata !62, metadata !63, metadata !64, metadata !65, metadata !66, metadata !67, metadata !68, metadata !69, metadata !70, metadata !71, metadata !72, metadata !80, metadata !81, metadata !82, metadata !83, metadata !86, metadata !88, metadata !90, metadata !94, metadata !95, metadata !97, metadata !98, metadata !99, metadata !100, metadata !101, metadata !104, metadata !105}
!60 = metadata !{i32 720909, metadata !57, metadata !"_flags", metadata !58, i32 272, i64 32, i64 32, i64 0, i32 0, metadata !14} ; [ DW_TAG_member ]
!61 = metadata !{i32 720909, metadata !57, metadata !"_IO_read_ptr", metadata !58, i32 277, i64 64, i64 64, i64 64, i32 0, metadata !32} ; [ DW_TAG_member ]
!62 = metadata !{i32 720909, metadata !57, metadata !"_IO_read_end", metadata !58, i32 278, i64 64, i64 64, i64 128, i32 0, metadata !32} ; [ DW_TAG_member ]
!63 = metadata !{i32 720909, metadata !57, metadata !"_IO_read_base", metadata !58, i32 279, i64 64, i64 64, i64 192, i32 0, metadata !32} ; [ DW_TAG_member ]
!64 = metadata !{i32 720909, metadata !57, metadata !"_IO_write_base", metadata !58, i32 280, i64 64, i64 64, i64 256, i32 0, metadata !32} ; [ DW_TAG_member ]
!65 = metadata !{i32 720909, metadata !57, metadata !"_IO_write_ptr", metadata !58, i32 281, i64 64, i64 64, i64 320, i32 0, metadata !32} ; [ DW_TAG_member ]
!66 = metadata !{i32 720909, metadata !57, metadata !"_IO_write_end", metadata !58, i32 282, i64 64, i64 64, i64 384, i32 0, metadata !32} ; [ DW_TAG_member ]
!67 = metadata !{i32 720909, metadata !57, metadata !"_IO_buf_base", metadata !58, i32 283, i64 64, i64 64, i64 448, i32 0, metadata !32} ; [ DW_TAG_member ]
!68 = metadata !{i32 720909, metadata !57, metadata !"_IO_buf_end", metadata !58, i32 284, i64 64, i64 64, i64 512, i32 0, metadata !32} ; [ DW_TAG_member ]
!69 = metadata !{i32 720909, metadata !57, metadata !"_IO_save_base", metadata !58, i32 286, i64 64, i64 64, i64 576, i32 0, metadata !32} ; [ DW_TAG_member ]
!70 = metadata !{i32 720909, metadata !57, metadata !"_IO_backup_base", metadata !58, i32 287, i64 64, i64 64, i64 640, i32 0, metadata !32} ; [ DW_TAG_member ]
!71 = metadata !{i32 720909, metadata !57, metadata !"_IO_save_end", metadata !58, i32 288, i64 64, i64 64, i64 704, i32 0, metadata !32} ; [ DW_TAG_member ]
!72 = metadata !{i32 720909, metadata !57, metadata !"_markers", metadata !58, i32 290, i64 64, i64 64, i64 768, i32 0, metadata !73} ; [ DW_TAG_member ]
!73 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !74} ; [ DW_TAG_pointer_type ]
!74 = metadata !{i32 720915, null, metadata !"_IO_marker", metadata !58, i32 186, i64 192, i64 64, i32 0, i32 0, i32 0, metadata !75, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!75 = metadata !{metadata !76, metadata !77, metadata !79}
!76 = metadata !{i32 720909, metadata !74, metadata !"_next", metadata !58, i32 187, i64 64, i64 64, i64 0, i32 0, metadata !73} ; [ DW_TAG_member ]
!77 = metadata !{i32 720909, metadata !74, metadata !"_sbuf", metadata !58, i32 188, i64 64, i64 64, i64 64, i32 0, metadata !78} ; [ DW_TAG_member ]
!78 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !57} ; [ DW_TAG_pointer_type ]
!79 = metadata !{i32 720909, metadata !74, metadata !"_pos", metadata !58, i32 192, i64 32, i64 32, i64 128, i32 0, metadata !14} ; [ DW_TAG_member ]
!80 = metadata !{i32 720909, metadata !57, metadata !"_chain", metadata !58, i32 292, i64 64, i64 64, i64 832, i32 0, metadata !78} ; [ DW_TAG_member ]
!81 = metadata !{i32 720909, metadata !57, metadata !"_fileno", metadata !58, i32 294, i64 32, i64 32, i64 896, i32 0, metadata !14} ; [ DW_TAG_member ]
!82 = metadata !{i32 720909, metadata !57, metadata !"_flags2", metadata !58, i32 298, i64 32, i64 32, i64 928, i32 0, metadata !14} ; [ DW_TAG_member ]
!83 = metadata !{i32 720909, metadata !57, metadata !"_old_offset", metadata !58, i32 300, i64 64, i64 64, i64 960, i32 0, metadata !84} ; [ DW_TAG_member ]
!84 = metadata !{i32 720918, null, metadata !"__off_t", metadata !58, i32 141, i64 0, i64 0, i64 0, i32 0, metadata !85} ; [ DW_TAG_typedef ]
!85 = metadata !{i32 720932, null, metadata !"long int", null, i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ]
!86 = metadata !{i32 720909, metadata !57, metadata !"_cur_column", metadata !58, i32 304, i64 16, i64 16, i64 1024, i32 0, metadata !87} ; [ DW_TAG_member ]
!87 = metadata !{i32 720932, null, metadata !"unsigned short", null, i32 0, i64 16, i64 16, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ]
!88 = metadata !{i32 720909, metadata !57, metadata !"_vtable_offset", metadata !58, i32 305, i64 8, i64 8, i64 1040, i32 0, metadata !89} ; [ DW_TAG_member ]
!89 = metadata !{i32 720932, null, metadata !"signed char", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ]
!90 = metadata !{i32 720909, metadata !57, metadata !"_shortbuf", metadata !58, i32 306, i64 8, i64 8, i64 1048, i32 0, metadata !91} ; [ DW_TAG_member ]
!91 = metadata !{i32 720897, null, metadata !"", null, i32 0, i64 8, i64 8, i32 0, i32 0, metadata !33, metadata !92, i32 0, i32 0} ; [ DW_TAG_array_type ]
!92 = metadata !{metadata !93}
!93 = metadata !{i32 720929, i64 0, i64 0}        ; [ DW_TAG_subrange_type ]
!94 = metadata !{i32 720909, metadata !57, metadata !"_lock", metadata !58, i32 310, i64 64, i64 64, i64 1088, i32 0, metadata !22} ; [ DW_TAG_member ]
!95 = metadata !{i32 720909, metadata !57, metadata !"_offset", metadata !58, i32 319, i64 64, i64 64, i64 1152, i32 0, metadata !96} ; [ DW_TAG_member ]
!96 = metadata !{i32 720918, null, metadata !"__off64_t", metadata !58, i32 142, i64 0, i64 0, i64 0, i32 0, metadata !85} ; [ DW_TAG_typedef ]
!97 = metadata !{i32 720909, metadata !57, metadata !"__pad1", metadata !58, i32 328, i64 64, i64 64, i64 1216, i32 0, metadata !22} ; [ DW_TAG_member ]
!98 = metadata !{i32 720909, metadata !57, metadata !"__pad2", metadata !58, i32 329, i64 64, i64 64, i64 1280, i32 0, metadata !22} ; [ DW_TAG_member ]
!99 = metadata !{i32 720909, metadata !57, metadata !"__pad3", metadata !58, i32 330, i64 64, i64 64, i64 1344, i32 0, metadata !22} ; [ DW_TAG_member ]
!100 = metadata !{i32 720909, metadata !57, metadata !"__pad4", metadata !58, i32 331, i64 64, i64 64, i64 1408, i32 0, metadata !22} ; [ DW_TAG_member ]
!101 = metadata !{i32 720909, metadata !57, metadata !"__pad5", metadata !58, i32 332, i64 64, i64 64, i64 1472, i32 0, metadata !102} ; [ DW_TAG_member ]
!102 = metadata !{i32 720918, null, metadata !"size_t", metadata !58, i32 35, i64 0, i64 0, i64 0, i32 0, metadata !103} ; [ DW_TAG_typedef ]
!103 = metadata !{i32 720932, null, metadata !"long unsigned int", null, i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ]
!104 = metadata !{i32 720909, metadata !57, metadata !"_mode", metadata !58, i32 334, i64 32, i64 32, i64 1536, i32 0, metadata !14} ; [ DW_TAG_member ]
!105 = metadata !{i32 720909, metadata !57, metadata !"_unused2", metadata !58, i32 336, i64 160, i64 8, i64 1568, i32 0, metadata !106} ; [ DW_TAG_member ]
!106 = metadata !{i32 720897, null, metadata !"", null, i32 0, i64 160, i64 8, i32 0, i32 0, metadata !33, metadata !107, i32 0, i32 0} ; [ DW_TAG_array_type ]
!107 = metadata !{metadata !108}
!108 = metadata !{i32 720929, i64 0, i64 19}      ; [ DW_TAG_subrange_type ]
!109 = metadata !{i32 721153, metadata !19, metadata !"Args", metadata !11, i32 16777296, metadata !22, i32 0, i32 0} ; [ DW_TAG_arg_variable ]
!110 = metadata !{i32 80, i32 25, metadata !19, null}
!111 = metadata !{i32 721152, metadata !112, metadata !"info", metadata !11, i32 81, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!112 = metadata !{i32 720907, metadata !19, i32 80, i32 31, metadata !11, i32 0} ; [ DW_TAG_lexical_block ]
!113 = metadata !{i32 81, i32 24, metadata !112, null}
!114 = metadata !{i32 721152, metadata !112, metadata !"i", metadata !11, i32 82, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!115 = metadata !{i32 82, i32 13, metadata !112, null}
!116 = metadata !{i32 82, i32 16, metadata !112, null}
!117 = metadata !{i32 84, i32 3, metadata !112, null}
!118 = metadata !{i32 85, i32 3, metadata !112, null}
!119 = metadata !{i32 86, i32 3, metadata !112, null}
!120 = metadata !{i32 89, i32 3, metadata !112, null}
!121 = metadata !{i32 90, i32 3, metadata !112, null}
!122 = metadata !{i32 91, i32 5, metadata !123, null}
!123 = metadata !{i32 720907, metadata !112, i32 90, i32 13, metadata !11, i32 1} ; [ DW_TAG_lexical_block ]
!124 = metadata !{i32 93, i32 5, metadata !123, null}
!125 = metadata !{i32 94, i32 5, metadata !123, null}
!126 = metadata !{i32 99, i32 5, metadata !123, null}
!127 = metadata !{i32 100, i32 5, metadata !123, null}
!128 = metadata !{i32 101, i32 5, metadata !123, null}
!129 = metadata !{i32 102, i32 3, metadata !123, null}
!130 = metadata !{i32 104, i32 1, metadata !112, null}
!131 = metadata !{i32 721153, metadata !38, metadata !"period", metadata !11, i32 16777251, metadata !41, i32 0, i32 0} ; [ DW_TAG_arg_variable ]
!132 = metadata !{i32 35, i32 40, metadata !38, null}
!133 = metadata !{i32 721153, metadata !38, metadata !"info", metadata !11, i32 33554467, metadata !37, i32 0, i32 0} ; [ DW_TAG_arg_variable ]
!134 = metadata !{i32 35, i32 70, metadata !38, null}
!135 = metadata !{i32 721152, metadata !136, metadata !"ret", metadata !11, i32 37, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!136 = metadata !{i32 720907, metadata !38, i32 36, i32 1, metadata !11, i32 24} ; [ DW_TAG_lexical_block ]
!137 = metadata !{i32 37, i32 6, metadata !136, null}
!138 = metadata !{i32 721152, metadata !136, metadata !"ns", metadata !11, i32 38, metadata !41, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!139 = metadata !{i32 38, i32 15, metadata !136, null}
!140 = metadata !{i32 721152, metadata !136, metadata !"sec", metadata !11, i32 39, metadata !41, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!141 = metadata !{i32 39, i32 15, metadata !136, null}
!142 = metadata !{i32 721152, metadata !136, metadata !"fd", metadata !11, i32 40, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!143 = metadata !{i32 40, i32 6, metadata !136, null}
!144 = metadata !{i32 721152, metadata !136, metadata !"itval", metadata !11, i32 41, metadata !145, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!145 = metadata !{i32 720915, null, metadata !"itimerspec", metadata !146, i32 161, i64 256, i64 64, i32 0, i32 0, i32 0, metadata !147, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!146 = metadata !{i32 720937, metadata !"/usr/include/time.h", metadata !"/home/kula85/Research/delay-thread/testCacheMissTool", null} ; [ DW_TAG_file_type ]
!147 = metadata !{metadata !148, metadata !154}
!148 = metadata !{i32 720909, metadata !145, metadata !"it_interval", metadata !146, i32 163, i64 128, i64 64, i64 0, i32 0, metadata !149} ; [ DW_TAG_member ]
!149 = metadata !{i32 720915, null, metadata !"timespec", metadata !146, i32 120, i64 128, i64 64, i32 0, i32 0, i32 0, metadata !150, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!150 = metadata !{metadata !151, metadata !153}
!151 = metadata !{i32 720909, metadata !149, metadata !"tv_sec", metadata !146, i32 122, i64 64, i64 64, i64 0, i32 0, metadata !152} ; [ DW_TAG_member ]
!152 = metadata !{i32 720918, null, metadata !"__time_t", metadata !146, i32 149, i64 0, i64 0, i64 0, i32 0, metadata !85} ; [ DW_TAG_typedef ]
!153 = metadata !{i32 720909, metadata !149, metadata !"tv_nsec", metadata !146, i32 123, i64 64, i64 64, i64 64, i32 0, metadata !85} ; [ DW_TAG_member ]
!154 = metadata !{i32 720909, metadata !145, metadata !"it_value", metadata !146, i32 164, i64 128, i64 64, i64 128, i32 0, metadata !149} ; [ DW_TAG_member ]
!155 = metadata !{i32 41, i32 20, metadata !136, null}
!156 = metadata !{i32 44, i32 7, metadata !136, null}
!157 = metadata !{i32 45, i32 2, metadata !136, null}
!158 = metadata !{i32 46, i32 2, metadata !136, null}
!159 = metadata !{i32 47, i32 2, metadata !136, null}
!160 = metadata !{i32 48, i32 3, metadata !136, null}
!161 = metadata !{i32 51, i32 2, metadata !136, null}
!162 = metadata !{i32 52, i32 2, metadata !136, null}
!163 = metadata !{i32 53, i32 2, metadata !136, null}
!164 = metadata !{i32 54, i32 2, metadata !136, null}
!165 = metadata !{i32 55, i32 2, metadata !136, null}
!166 = metadata !{i32 56, i32 2, metadata !136, null}
!167 = metadata !{i32 57, i32 8, metadata !136, null}
!168 = metadata !{i32 58, i32 2, metadata !136, null}
!169 = metadata !{i32 59, i32 1, metadata !136, null}
!170 = metadata !{i32 721153, metadata !34, metadata !"info", metadata !11, i32 16777277, metadata !37, i32 0, i32 0} ; [ DW_TAG_arg_variable ]
!171 = metadata !{i32 61, i32 48, metadata !34, null}
!172 = metadata !{i32 721152, metadata !173, metadata !"missed", metadata !11, i32 63, metadata !16, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!173 = metadata !{i32 720907, metadata !34, i32 62, i32 1, metadata !11, i32 22} ; [ DW_TAG_lexical_block ]
!174 = metadata !{i32 63, i32 21, metadata !173, null}
!175 = metadata !{i32 721152, metadata !173, metadata !"ret", metadata !11, i32 64, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!176 = metadata !{i32 64, i32 6, metadata !173, null}
!177 = metadata !{i32 68, i32 8, metadata !173, null}
!178 = metadata !{i32 69, i32 2, metadata !173, null}
!179 = metadata !{i32 71, i32 3, metadata !180, null}
!180 = metadata !{i32 720907, metadata !173, i32 70, i32 2, metadata !11, i32 23} ; [ DW_TAG_lexical_block ]
!181 = metadata !{i32 72, i32 3, metadata !180, null}
!182 = metadata !{i32 76, i32 2, metadata !173, null}
!183 = metadata !{i32 77, i32 3, metadata !173, null}
!184 = metadata !{i32 78, i32 1, metadata !173, null}
!185 = metadata !{i32 721152, metadata !186, metadata !"i", metadata !11, i32 107, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!186 = metadata !{i32 720907, metadata !25, i32 106, i32 12, metadata !11, i32 2} ; [ DW_TAG_lexical_block ]
!187 = metadata !{i32 107, i32 7, metadata !186, null}
!188 = metadata !{i32 721152, metadata !186, metadata !"j", metadata !11, i32 107, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!189 = metadata !{i32 107, i32 9, metadata !186, null}
!190 = metadata !{i32 721152, metadata !186, metadata !"numInt", metadata !11, i32 108, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!191 = metadata !{i32 108, i32 7, metadata !186, null}
!192 = metadata !{i32 721152, metadata !186, metadata !"numCachelineUsed", metadata !11, i32 109, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!193 = metadata !{i32 109, i32 7, metadata !186, null}
!194 = metadata !{i32 721152, metadata !186, metadata !"a", metadata !11, i32 110, metadata !195, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!195 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !14} ; [ DW_TAG_pointer_type ]
!196 = metadata !{i32 110, i32 8, metadata !186, null}
!197 = metadata !{i32 112, i32 3, metadata !186, null}
!198 = metadata !{i32 114, i32 3, metadata !186, null}
!199 = metadata !{i32 116, i32 14, metadata !186, null}
!200 = metadata !{i32 721152, metadata !186, metadata !"attr", metadata !11, i32 118, metadata !201, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!201 = metadata !{i32 720918, null, metadata !"pthread_attr_t", metadata !11, i32 57, i64 0, i64 0, i64 0, i32 0, metadata !202} ; [ DW_TAG_typedef ]
!202 = metadata !{i32 720919, null, metadata !"", metadata !203, i32 53, i64 448, i64 64, i64 0, i32 0, i32 0, metadata !204, i32 0, i32 0} ; [ DW_TAG_union_type ]
!203 = metadata !{i32 720937, metadata !"/usr/include/bits/pthreadtypes.h", metadata !"/home/kula85/Research/delay-thread/testCacheMissTool", null} ; [ DW_TAG_file_type ]
!204 = metadata !{metadata !205, metadata !209}
!205 = metadata !{i32 720909, metadata !202, metadata !"__size", metadata !203, i32 55, i64 448, i64 8, i64 0, i32 0, metadata !206} ; [ DW_TAG_member ]
!206 = metadata !{i32 720897, null, metadata !"", null, i32 0, i64 448, i64 8, i32 0, i32 0, metadata !33, metadata !207, i32 0, i32 0} ; [ DW_TAG_array_type ]
!207 = metadata !{metadata !208}
!208 = metadata !{i32 720929, i64 0, i64 55}      ; [ DW_TAG_subrange_type ]
!209 = metadata !{i32 720909, metadata !202, metadata !"__align", metadata !203, i32 56, i64 64, i64 64, i64 0, i32 0, metadata !85} ; [ DW_TAG_member ]
!210 = metadata !{i32 118, i32 18, metadata !186, null}
!211 = metadata !{i32 721152, metadata !186, metadata !"Thread", metadata !11, i32 119, metadata !212, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!212 = metadata !{i32 720918, null, metadata !"pthread_t", metadata !11, i32 50, i64 0, i64 0, i64 0, i32 0, metadata !103} ; [ DW_TAG_typedef ]
!213 = metadata !{i32 119, i32 13, metadata !186, null}
!214 = metadata !{i32 121, i32 3, metadata !186, null}
!215 = metadata !{i32 122, i32 3, metadata !186, null}
!216 = metadata !{i32 124, i32 3, metadata !186, null}
!217 = metadata !{i32 127, i32 7, metadata !218, null}
!218 = metadata !{i32 720907, metadata !186, i32 127, i32 3, metadata !11, i32 3} ; [ DW_TAG_lexical_block ]
!219 = metadata !{i32 128, i32 9, metadata !220, null}
!220 = metadata !{i32 720907, metadata !218, i32 128, i32 5, metadata !11, i32 4} ; [ DW_TAG_lexical_block ]
!221 = metadata !{i32 133, i32 7, metadata !222, null}
!222 = metadata !{i32 720907, metadata !220, i32 128, i32 40, metadata !11, i32 5} ; [ DW_TAG_lexical_block ]
!223 = metadata !{i32 134, i32 5, metadata !222, null}
!224 = metadata !{i32 128, i32 35, metadata !220, null}
!225 = metadata !{i32 134, i32 5, metadata !220, null}
!226 = metadata !{i32 127, i32 18, metadata !218, null}
!227 = metadata !{i32 137, i32 7, metadata !228, null}
!228 = metadata !{i32 720907, metadata !186, i32 137, i32 3, metadata !11, i32 6} ; [ DW_TAG_lexical_block ]
!229 = metadata !{i32 138, i32 6, metadata !228, null}
!230 = metadata !{i32 137, i32 20, metadata !228, null}
!231 = metadata !{i32 141, i32 7, metadata !232, null}
!232 = metadata !{i32 720907, metadata !186, i32 141, i32 3, metadata !11, i32 7} ; [ DW_TAG_lexical_block ]
!233 = metadata !{i32 142, i32 9, metadata !234, null}
!234 = metadata !{i32 720907, metadata !232, i32 142, i32 5, metadata !11, i32 8} ; [ DW_TAG_lexical_block ]
!235 = metadata !{i32 143, i32 8, metadata !234, null}
!236 = metadata !{i32 142, i32 35, metadata !234, null}
!237 = metadata !{i32 143, i32 17, metadata !234, null}
!238 = metadata !{i32 141, i32 18, metadata !232, null}
!239 = metadata !{i32 146, i32 7, metadata !240, null}
!240 = metadata !{i32 720907, metadata !186, i32 146, i32 3, metadata !11, i32 9} ; [ DW_TAG_lexical_block ]
!241 = metadata !{i32 147, i32 6, metadata !240, null}
!242 = metadata !{i32 146, i32 20, metadata !240, null}
!243 = metadata !{i32 150, i32 7, metadata !244, null}
!244 = metadata !{i32 720907, metadata !186, i32 150, i32 3, metadata !11, i32 10} ; [ DW_TAG_lexical_block ]
!245 = metadata !{i32 151, i32 9, metadata !246, null}
!246 = metadata !{i32 720907, metadata !244, i32 151, i32 5, metadata !11, i32 11} ; [ DW_TAG_lexical_block ]
!247 = metadata !{i32 152, i32 8, metadata !246, null}
!248 = metadata !{i32 151, i32 35, metadata !246, null}
!249 = metadata !{i32 152, i32 17, metadata !246, null}
!250 = metadata !{i32 150, i32 18, metadata !244, null}
!251 = metadata !{i32 155, i32 7, metadata !252, null}
!252 = metadata !{i32 720907, metadata !186, i32 155, i32 3, metadata !11, i32 12} ; [ DW_TAG_lexical_block ]
!253 = metadata !{i32 156, i32 6, metadata !252, null}
!254 = metadata !{i32 155, i32 20, metadata !252, null}
!255 = metadata !{i32 158, i32 3, metadata !186, null}
!256 = metadata !{i32 160, i32 3, metadata !186, null}
!257 = metadata !{i32 721153, metadata !28, metadata !"argc", metadata !11, i32 16777379, metadata !14, i32 0, i32 0} ; [ DW_TAG_arg_variable ]
!258 = metadata !{i32 163, i32 15, metadata !28, null}
!259 = metadata !{i32 721153, metadata !28, metadata !"argv", metadata !11, i32 33554595, metadata !31, i32 0, i32 0} ; [ DW_TAG_arg_variable ]
!260 = metadata !{i32 163, i32 27, metadata !28, null}
!261 = metadata !{i32 721152, metadata !262, metadata !"i", metadata !11, i32 165, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!262 = metadata !{i32 720907, metadata !28, i32 164, i32 1, metadata !11, i32 13} ; [ DW_TAG_lexical_block ]
!263 = metadata !{i32 165, i32 7, metadata !262, null}
!264 = metadata !{i32 721152, metadata !262, metadata !"j", metadata !11, i32 165, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!265 = metadata !{i32 165, i32 10, metadata !262, null}
!266 = metadata !{i32 721152, metadata !262, metadata !"s", metadata !11, i32 168, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!267 = metadata !{i32 168, i32 13, metadata !262, null}
!268 = metadata !{i32 721152, metadata !262, metadata !"e", metadata !11, i32 169, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!269 = metadata !{i32 169, i32 13, metadata !262, null}
!270 = metadata !{i32 721152, metadata !262, metadata !"retval", metadata !11, i32 170, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!271 = metadata !{i32 170, i32 7, metadata !262, null}
!272 = metadata !{i32 721152, metadata !262, metadata !"eventcode", metadata !11, i32 171, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!273 = metadata !{i32 171, i32 7, metadata !262, null}
!274 = metadata !{i32 721152, metadata !262, metadata !"opt", metadata !11, i32 172, metadata !275, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!275 = metadata !{i32 720918, null, metadata !"PAPI_option_t", metadata !11, i32 862, i64 0, i64 0, i64 0, i32 0, metadata !276} ; [ DW_TAG_typedef ]
!276 = metadata !{i32 720919, null, metadata !"", metadata !277, i32 843, i64 2112, i64 64, i64 0, i32 0, i32 0, metadata !278, i32 0, i32 0} ; [ DW_TAG_union_type ]
!277 = metadata !{i32 720937, metadata !"/usr/local/include/papi.h", metadata !"/home/kula85/Research/delay-thread/testCacheMissTool", null} ; [ DW_TAG_file_type ]
!278 = metadata !{metadata !279, metadata !290, metadata !300, metadata !306, metadata !313, metadata !314, metadata !321, metadata !322, metadata !328, metadata !334, metadata !341, metadata !349, metadata !404, metadata !426, metadata !433, metadata !487, metadata !496}
!279 = metadata !{i32 720909, metadata !276, metadata !"preload", metadata !277, i32 845, i64 2064, i64 8, i64 0, i32 0, metadata !280} ; [ DW_TAG_member ]
!280 = metadata !{i32 720918, null, metadata !"PAPI_preload_info_t", metadata !277, i32 636, i64 0, i64 0, i64 0, i32 0, metadata !281} ; [ DW_TAG_typedef ]
!281 = metadata !{i32 720915, null, metadata !"_papi_preload_option", metadata !277, i32 631, i64 2064, i64 8, i32 0, i32 0, i32 0, metadata !282, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!282 = metadata !{metadata !283, metadata !287, metadata !288, metadata !289}
!283 = metadata !{i32 720909, metadata !281, metadata !"lib_preload_env", metadata !277, i32 632, i64 1024, i64 8, i64 0, i32 0, metadata !284} ; [ DW_TAG_member ]
!284 = metadata !{i32 720897, null, metadata !"", null, i32 0, i64 1024, i64 8, i32 0, i32 0, metadata !33, metadata !285, i32 0, i32 0} ; [ DW_TAG_array_type ]
!285 = metadata !{metadata !286}
!286 = metadata !{i32 720929, i64 0, i64 127}     ; [ DW_TAG_subrange_type ]
!287 = metadata !{i32 720909, metadata !281, metadata !"lib_preload_sep", metadata !277, i32 633, i64 8, i64 8, i64 1024, i32 0, metadata !33} ; [ DW_TAG_member ]
!288 = metadata !{i32 720909, metadata !281, metadata !"lib_dir_env", metadata !277, i32 634, i64 1024, i64 8, i64 1032, i32 0, metadata !284} ; [ DW_TAG_member ]
!289 = metadata !{i32 720909, metadata !281, metadata !"lib_dir_sep", metadata !277, i32 635, i64 8, i64 8, i64 2056, i32 0, metadata !33} ; [ DW_TAG_member ]
!290 = metadata !{i32 720909, metadata !276, metadata !"debug", metadata !277, i32 846, i64 128, i64 64, i64 0, i32 0, metadata !291} ; [ DW_TAG_member ]
!291 = metadata !{i32 720918, null, metadata !"PAPI_debug_option_t", metadata !277, i32 701, i64 0, i64 0, i64 0, i32 0, metadata !292} ; [ DW_TAG_typedef ]
!292 = metadata !{i32 720915, null, metadata !"_papi_debug_option", metadata !277, i32 698, i64 128, i64 64, i32 0, i32 0, i32 0, metadata !293, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!293 = metadata !{metadata !294, metadata !295}
!294 = metadata !{i32 720909, metadata !292, metadata !"level", metadata !277, i32 699, i64 32, i64 32, i64 0, i32 0, metadata !14} ; [ DW_TAG_member ]
!295 = metadata !{i32 720909, metadata !292, metadata !"handler", metadata !277, i32 700, i64 64, i64 64, i64 64, i32 0, metadata !296} ; [ DW_TAG_member ]
!296 = metadata !{i32 720918, null, metadata !"PAPI_debug_handler_t", metadata !277, i32 695, i64 0, i64 0, i64 0, i32 0, metadata !297} ; [ DW_TAG_typedef ]
!297 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !298} ; [ DW_TAG_pointer_type ]
!298 = metadata !{i32 720917, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i32 0, i32 0, i32 0, metadata !299, i32 0, i32 0} ; [ DW_TAG_subroutine_type ]
!299 = metadata !{metadata !14, metadata !14}
!300 = metadata !{i32 720909, metadata !276, metadata !"inherit", metadata !277, i32 847, i64 64, i64 32, i64 0, i32 0, metadata !301} ; [ DW_TAG_member ]
!301 = metadata !{i32 720918, null, metadata !"PAPI_inherit_option_t", metadata !277, i32 614, i64 0, i64 0, i64 0, i32 0, metadata !302} ; [ DW_TAG_typedef ]
!302 = metadata !{i32 720915, null, metadata !"_papi_inherit_option", metadata !277, i32 611, i64 64, i64 32, i32 0, i32 0, i32 0, metadata !303, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!303 = metadata !{metadata !304, metadata !305}
!304 = metadata !{i32 720909, metadata !302, metadata !"eventset", metadata !277, i32 612, i64 32, i64 32, i64 0, i32 0, metadata !14} ; [ DW_TAG_member ]
!305 = metadata !{i32 720909, metadata !302, metadata !"inherit", metadata !277, i32 613, i64 32, i64 32, i64 32, i32 0, metadata !14} ; [ DW_TAG_member ]
!306 = metadata !{i32 720909, metadata !276, metadata !"granularity", metadata !277, i32 848, i64 96, i64 32, i64 0, i32 0, metadata !307} ; [ DW_TAG_member ]
!307 = metadata !{i32 720918, null, metadata !"PAPI_granularity_option_t", metadata !277, i32 628, i64 0, i64 0, i64 0, i32 0, metadata !308} ; [ DW_TAG_typedef ]
!308 = metadata !{i32 720915, null, metadata !"_papi_granularity_option", metadata !277, i32 624, i64 96, i64 32, i32 0, i32 0, i32 0, metadata !309, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!309 = metadata !{metadata !310, metadata !311, metadata !312}
!310 = metadata !{i32 720909, metadata !308, metadata !"def_cidx", metadata !277, i32 625, i64 32, i64 32, i64 0, i32 0, metadata !14} ; [ DW_TAG_member ]
!311 = metadata !{i32 720909, metadata !308, metadata !"eventset", metadata !277, i32 626, i64 32, i64 32, i64 32, i32 0, metadata !14} ; [ DW_TAG_member ]
!312 = metadata !{i32 720909, metadata !308, metadata !"granularity", metadata !277, i32 627, i64 32, i64 32, i64 64, i32 0, metadata !14} ; [ DW_TAG_member ]
!313 = metadata !{i32 720909, metadata !276, metadata !"defgranularity", metadata !277, i32 849, i64 96, i64 32, i64 0, i32 0, metadata !307} ; [ DW_TAG_member ]
!314 = metadata !{i32 720909, metadata !276, metadata !"domain", metadata !277, i32 850, i64 96, i64 32, i64 0, i32 0, metadata !315} ; [ DW_TAG_member ]
!315 = metadata !{i32 720918, null, metadata !"PAPI_domain_option_t", metadata !277, i32 621, i64 0, i64 0, i64 0, i32 0, metadata !316} ; [ DW_TAG_typedef ]
!316 = metadata !{i32 720915, null, metadata !"_papi_domain_option", metadata !277, i32 617, i64 96, i64 32, i32 0, i32 0, i32 0, metadata !317, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!317 = metadata !{metadata !318, metadata !319, metadata !320}
!318 = metadata !{i32 720909, metadata !316, metadata !"def_cidx", metadata !277, i32 618, i64 32, i64 32, i64 0, i32 0, metadata !14} ; [ DW_TAG_member ]
!319 = metadata !{i32 720909, metadata !316, metadata !"eventset", metadata !277, i32 619, i64 32, i64 32, i64 32, i32 0, metadata !14} ; [ DW_TAG_member ]
!320 = metadata !{i32 720909, metadata !316, metadata !"domain", metadata !277, i32 620, i64 32, i64 32, i64 64, i32 0, metadata !14} ; [ DW_TAG_member ]
!321 = metadata !{i32 720909, metadata !276, metadata !"defdomain", metadata !277, i32 851, i64 96, i64 32, i64 0, i32 0, metadata !315} ; [ DW_TAG_member ]
!322 = metadata !{i32 720909, metadata !276, metadata !"attach", metadata !277, i32 852, i64 128, i64 64, i64 0, i32 0, metadata !323} ; [ DW_TAG_member ]
!323 = metadata !{i32 720918, null, metadata !"PAPI_attach_option_t", metadata !277, i32 814, i64 0, i64 0, i64 0, i32 0, metadata !324} ; [ DW_TAG_typedef ]
!324 = metadata !{i32 720915, null, metadata !"_papi_attach_option", metadata !277, i32 811, i64 128, i64 64, i32 0, i32 0, i32 0, metadata !325, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!325 = metadata !{metadata !326, metadata !327}
!326 = metadata !{i32 720909, metadata !324, metadata !"eventset", metadata !277, i32 812, i64 32, i64 32, i64 0, i32 0, metadata !14} ; [ DW_TAG_member ]
!327 = metadata !{i32 720909, metadata !324, metadata !"tid", metadata !277, i32 813, i64 64, i64 64, i64 64, i32 0, metadata !103} ; [ DW_TAG_member ]
!328 = metadata !{i32 720909, metadata !276, metadata !"cpu", metadata !277, i32 853, i64 64, i64 32, i64 0, i32 0, metadata !329} ; [ DW_TAG_member ]
!329 = metadata !{i32 720918, null, metadata !"PAPI_cpu_option_t", metadata !277, i32 820, i64 0, i64 0, i64 0, i32 0, metadata !330} ; [ DW_TAG_typedef ]
!330 = metadata !{i32 720915, null, metadata !"_papi_cpu_option", metadata !277, i32 817, i64 64, i64 32, i32 0, i32 0, i32 0, metadata !331, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!331 = metadata !{metadata !332, metadata !333}
!332 = metadata !{i32 720909, metadata !330, metadata !"eventset", metadata !277, i32 818, i64 32, i64 32, i64 0, i32 0, metadata !14} ; [ DW_TAG_member ]
!333 = metadata !{i32 720909, metadata !330, metadata !"cpu_num", metadata !277, i32 819, i64 32, i64 32, i64 32, i32 0, metadata !41} ; [ DW_TAG_member ]
!334 = metadata !{i32 720909, metadata !276, metadata !"multiplex", metadata !277, i32 854, i64 96, i64 32, i64 0, i32 0, metadata !335} ; [ DW_TAG_member ]
!335 = metadata !{i32 720918, null, metadata !"PAPI_multiplex_option_t", metadata !277, i32 827, i64 0, i64 0, i64 0, i32 0, metadata !336} ; [ DW_TAG_typedef ]
!336 = metadata !{i32 720915, null, metadata !"_papi_multiplex_option", metadata !277, i32 823, i64 96, i64 32, i32 0, i32 0, i32 0, metadata !337, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!337 = metadata !{metadata !338, metadata !339, metadata !340}
!338 = metadata !{i32 720909, metadata !336, metadata !"eventset", metadata !277, i32 824, i64 32, i64 32, i64 0, i32 0, metadata !14} ; [ DW_TAG_member ]
!339 = metadata !{i32 720909, metadata !336, metadata !"ns", metadata !277, i32 825, i64 32, i64 32, i64 32, i32 0, metadata !14} ; [ DW_TAG_member ]
!340 = metadata !{i32 720909, metadata !336, metadata !"flags", metadata !277, i32 826, i64 32, i64 32, i64 64, i32 0, metadata !14} ; [ DW_TAG_member ]
!341 = metadata !{i32 720909, metadata !276, metadata !"itimer", metadata !277, i32 855, i64 128, i64 32, i64 0, i32 0, metadata !342} ; [ DW_TAG_member ]
!342 = metadata !{i32 720918, null, metadata !"PAPI_itimer_option_t", metadata !277, i32 608, i64 0, i64 0, i64 0, i32 0, metadata !343} ; [ DW_TAG_typedef ]
!343 = metadata !{i32 720915, null, metadata !"_papi_itimer_option", metadata !277, i32 603, i64 128, i64 32, i32 0, i32 0, i32 0, metadata !344, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!344 = metadata !{metadata !345, metadata !346, metadata !347, metadata !348}
!345 = metadata !{i32 720909, metadata !343, metadata !"itimer_num", metadata !277, i32 604, i64 32, i64 32, i64 0, i32 0, metadata !14} ; [ DW_TAG_member ]
!346 = metadata !{i32 720909, metadata !343, metadata !"itimer_sig", metadata !277, i32 605, i64 32, i64 32, i64 32, i32 0, metadata !14} ; [ DW_TAG_member ]
!347 = metadata !{i32 720909, metadata !343, metadata !"ns", metadata !277, i32 606, i64 32, i64 32, i64 64, i32 0, metadata !14} ; [ DW_TAG_member ]
!348 = metadata !{i32 720909, metadata !343, metadata !"flags", metadata !277, i32 607, i64 32, i64 32, i64 96, i32 0, metadata !14} ; [ DW_TAG_member ]
!349 = metadata !{i32 720909, metadata !276, metadata !"hw_info", metadata !277, i32 856, i64 64, i64 64, i64 0, i32 0, metadata !350} ; [ DW_TAG_member ]
!350 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !351} ; [ DW_TAG_pointer_type ]
!351 = metadata !{i32 720918, null, metadata !"PAPI_hw_info_t", metadata !277, i32 808, i64 0, i64 0, i64 0, i32 0, metadata !352} ; [ DW_TAG_typedef ]
!352 = metadata !{i32 720915, null, metadata !"_papi_hw_info", metadata !277, i32 790, i64 9440, i64 32, i32 0, i32 0, i32 0, metadata !353, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!353 = metadata !{metadata !354, metadata !355, metadata !356, metadata !357, metadata !358, metadata !359, metadata !360, metadata !361, metadata !362, metadata !363, metadata !364, metadata !366, metadata !367, metadata !368, metadata !369, metadata !370, metadata !371}
!354 = metadata !{i32 720909, metadata !352, metadata !"ncpu", metadata !277, i32 791, i64 32, i64 32, i64 0, i32 0, metadata !14} ; [ DW_TAG_member ]
!355 = metadata !{i32 720909, metadata !352, metadata !"threads", metadata !277, i32 792, i64 32, i64 32, i64 32, i32 0, metadata !14} ; [ DW_TAG_member ]
!356 = metadata !{i32 720909, metadata !352, metadata !"cores", metadata !277, i32 793, i64 32, i64 32, i64 64, i32 0, metadata !14} ; [ DW_TAG_member ]
!357 = metadata !{i32 720909, metadata !352, metadata !"sockets", metadata !277, i32 794, i64 32, i64 32, i64 96, i32 0, metadata !14} ; [ DW_TAG_member ]
!358 = metadata !{i32 720909, metadata !352, metadata !"nnodes", metadata !277, i32 795, i64 32, i64 32, i64 128, i32 0, metadata !14} ; [ DW_TAG_member ]
!359 = metadata !{i32 720909, metadata !352, metadata !"totalcpus", metadata !277, i32 796, i64 32, i64 32, i64 160, i32 0, metadata !14} ; [ DW_TAG_member ]
!360 = metadata !{i32 720909, metadata !352, metadata !"vendor", metadata !277, i32 797, i64 32, i64 32, i64 192, i32 0, metadata !14} ; [ DW_TAG_member ]
!361 = metadata !{i32 720909, metadata !352, metadata !"vendor_string", metadata !277, i32 798, i64 1024, i64 8, i64 224, i32 0, metadata !284} ; [ DW_TAG_member ]
!362 = metadata !{i32 720909, metadata !352, metadata !"model", metadata !277, i32 799, i64 32, i64 32, i64 1248, i32 0, metadata !14} ; [ DW_TAG_member ]
!363 = metadata !{i32 720909, metadata !352, metadata !"model_string", metadata !277, i32 800, i64 1024, i64 8, i64 1280, i32 0, metadata !284} ; [ DW_TAG_member ]
!364 = metadata !{i32 720909, metadata !352, metadata !"revision", metadata !277, i32 801, i64 32, i64 32, i64 2304, i32 0, metadata !365} ; [ DW_TAG_member ]
!365 = metadata !{i32 720932, null, metadata !"float", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ]
!366 = metadata !{i32 720909, metadata !352, metadata !"cpuid_family", metadata !277, i32 802, i64 32, i64 32, i64 2336, i32 0, metadata !14} ; [ DW_TAG_member ]
!367 = metadata !{i32 720909, metadata !352, metadata !"cpuid_model", metadata !277, i32 803, i64 32, i64 32, i64 2368, i32 0, metadata !14} ; [ DW_TAG_member ]
!368 = metadata !{i32 720909, metadata !352, metadata !"cpuid_stepping", metadata !277, i32 804, i64 32, i64 32, i64 2400, i32 0, metadata !14} ; [ DW_TAG_member ]
!369 = metadata !{i32 720909, metadata !352, metadata !"mhz", metadata !277, i32 805, i64 32, i64 32, i64 2432, i32 0, metadata !365} ; [ DW_TAG_member ]
!370 = metadata !{i32 720909, metadata !352, metadata !"clock_mhz", metadata !277, i32 806, i64 32, i64 32, i64 2464, i32 0, metadata !14} ; [ DW_TAG_member ]
!371 = metadata !{i32 720909, metadata !352, metadata !"mem_hierarchy", metadata !277, i32 807, i64 6944, i64 32, i64 2496, i32 0, metadata !372} ; [ DW_TAG_member ]
!372 = metadata !{i32 720918, null, metadata !"PAPI_mh_info_t", metadata !277, i32 786, i64 0, i64 0, i64 0, i32 0, metadata !373} ; [ DW_TAG_typedef ]
!373 = metadata !{i32 720915, null, metadata !"_papi_mh_info", metadata !277, i32 783, i64 6944, i64 32, i32 0, i32 0, i32 0, metadata !374, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!374 = metadata !{metadata !375, metadata !376}
!375 = metadata !{i32 720909, metadata !373, metadata !"levels", metadata !277, i32 784, i64 32, i64 32, i64 0, i32 0, metadata !14} ; [ DW_TAG_member ]
!376 = metadata !{i32 720909, metadata !373, metadata !"level", metadata !277, i32 785, i64 6912, i64 32, i64 32, i32 0, metadata !377} ; [ DW_TAG_member ]
!377 = metadata !{i32 720897, null, metadata !"", null, i32 0, i64 6912, i64 32, i32 0, i32 0, metadata !378, metadata !402, i32 0, i32 0} ; [ DW_TAG_array_type ]
!378 = metadata !{i32 720918, null, metadata !"PAPI_mh_level_t", metadata !277, i32 779, i64 0, i64 0, i64 0, i32 0, metadata !379} ; [ DW_TAG_typedef ]
!379 = metadata !{i32 720915, null, metadata !"_papi_mh_level_info", metadata !277, i32 776, i64 1728, i64 32, i32 0, i32 0, i32 0, metadata !380, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!380 = metadata !{metadata !381, metadata !392}
!381 = metadata !{i32 720909, metadata !379, metadata !"tlb", metadata !277, i32 777, i64 768, i64 32, i64 0, i32 0, metadata !382} ; [ DW_TAG_member ]
!382 = metadata !{i32 720897, null, metadata !"", null, i32 0, i64 768, i64 32, i32 0, i32 0, metadata !383, metadata !390, i32 0, i32 0} ; [ DW_TAG_array_type ]
!383 = metadata !{i32 720918, null, metadata !"PAPI_mh_tlb_info_t", metadata !277, i32 764, i64 0, i64 0, i64 0, i32 0, metadata !384} ; [ DW_TAG_typedef ]
!384 = metadata !{i32 720915, null, metadata !"_papi_mh_tlb_info", metadata !277, i32 759, i64 128, i64 32, i32 0, i32 0, i32 0, metadata !385, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!385 = metadata !{metadata !386, metadata !387, metadata !388, metadata !389}
!386 = metadata !{i32 720909, metadata !384, metadata !"type", metadata !277, i32 760, i64 32, i64 32, i64 0, i32 0, metadata !14} ; [ DW_TAG_member ]
!387 = metadata !{i32 720909, metadata !384, metadata !"num_entries", metadata !277, i32 761, i64 32, i64 32, i64 32, i32 0, metadata !14} ; [ DW_TAG_member ]
!388 = metadata !{i32 720909, metadata !384, metadata !"page_size", metadata !277, i32 762, i64 32, i64 32, i64 64, i32 0, metadata !14} ; [ DW_TAG_member ]
!389 = metadata !{i32 720909, metadata !384, metadata !"associativity", metadata !277, i32 763, i64 32, i64 32, i64 96, i32 0, metadata !14} ; [ DW_TAG_member ]
!390 = metadata !{metadata !391}
!391 = metadata !{i32 720929, i64 0, i64 5}       ; [ DW_TAG_subrange_type ]
!392 = metadata !{i32 720909, metadata !379, metadata !"cache", metadata !277, i32 778, i64 960, i64 32, i64 768, i32 0, metadata !393} ; [ DW_TAG_member ]
!393 = metadata !{i32 720897, null, metadata !"", null, i32 0, i64 960, i64 32, i32 0, i32 0, metadata !394, metadata !390, i32 0, i32 0} ; [ DW_TAG_array_type ]
!394 = metadata !{i32 720918, null, metadata !"PAPI_mh_cache_info_t", metadata !277, i32 773, i64 0, i64 0, i64 0, i32 0, metadata !395} ; [ DW_TAG_typedef ]
!395 = metadata !{i32 720915, null, metadata !"_papi_mh_cache_info", metadata !277, i32 767, i64 160, i64 32, i32 0, i32 0, i32 0, metadata !396, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!396 = metadata !{metadata !397, metadata !398, metadata !399, metadata !400, metadata !401}
!397 = metadata !{i32 720909, metadata !395, metadata !"type", metadata !277, i32 768, i64 32, i64 32, i64 0, i32 0, metadata !14} ; [ DW_TAG_member ]
!398 = metadata !{i32 720909, metadata !395, metadata !"size", metadata !277, i32 769, i64 32, i64 32, i64 32, i32 0, metadata !14} ; [ DW_TAG_member ]
!399 = metadata !{i32 720909, metadata !395, metadata !"line_size", metadata !277, i32 770, i64 32, i64 32, i64 64, i32 0, metadata !14} ; [ DW_TAG_member ]
!400 = metadata !{i32 720909, metadata !395, metadata !"num_lines", metadata !277, i32 771, i64 32, i64 32, i64 96, i32 0, metadata !14} ; [ DW_TAG_member ]
!401 = metadata !{i32 720909, metadata !395, metadata !"associativity", metadata !277, i32 772, i64 32, i64 32, i64 128, i32 0, metadata !14} ; [ DW_TAG_member ]
!402 = metadata !{metadata !403}
!403 = metadata !{i32 720929, i64 0, i64 3}       ; [ DW_TAG_subrange_type ]
!404 = metadata !{i32 720909, metadata !276, metadata !"shlib_info", metadata !277, i32 857, i64 64, i64 64, i64 0, i32 0, metadata !405} ; [ DW_TAG_member ]
!405 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !406} ; [ DW_TAG_pointer_type ]
!406 = metadata !{i32 720918, null, metadata !"PAPI_shlib_info_t", metadata !277, i32 726, i64 0, i64 0, i64 0, i32 0, metadata !407} ; [ DW_TAG_typedef ]
!407 = metadata !{i32 720915, null, metadata !"_papi_shared_lib_info", metadata !277, i32 723, i64 128, i64 64, i32 0, i32 0, i32 0, metadata !408, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!408 = metadata !{metadata !409, metadata !425}
!409 = metadata !{i32 720909, metadata !407, metadata !"map", metadata !277, i32 724, i64 64, i64 64, i64 0, i32 0, metadata !410} ; [ DW_TAG_member ]
!410 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !411} ; [ DW_TAG_pointer_type ]
!411 = metadata !{i32 720918, null, metadata !"PAPI_address_map_t", metadata !277, i32 713, i64 0, i64 0, i64 0, i32 0, metadata !412} ; [ DW_TAG_typedef ]
!412 = metadata !{i32 720915, null, metadata !"_papi_address_map", metadata !277, i32 705, i64 8576, i64 64, i32 0, i32 0, i32 0, metadata !413, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!413 = metadata !{metadata !414, metadata !418, metadata !420, metadata !421, metadata !422, metadata !423, metadata !424}
!414 = metadata !{i32 720909, metadata !412, metadata !"name", metadata !277, i32 706, i64 8192, i64 8, i64 0, i32 0, metadata !415} ; [ DW_TAG_member ]
!415 = metadata !{i32 720897, null, metadata !"", null, i32 0, i64 8192, i64 8, i32 0, i32 0, metadata !33, metadata !416, i32 0, i32 0} ; [ DW_TAG_array_type ]
!416 = metadata !{metadata !417}
!417 = metadata !{i32 720929, i64 0, i64 1023}    ; [ DW_TAG_subrange_type ]
!418 = metadata !{i32 720909, metadata !412, metadata !"text_start", metadata !277, i32 707, i64 64, i64 64, i64 8192, i32 0, metadata !419} ; [ DW_TAG_member ]
!419 = metadata !{i32 720918, null, metadata !"caddr_t", metadata !277, i32 585, i64 0, i64 0, i64 0, i32 0, metadata !32} ; [ DW_TAG_typedef ]
!420 = metadata !{i32 720909, metadata !412, metadata !"text_end", metadata !277, i32 708, i64 64, i64 64, i64 8256, i32 0, metadata !419} ; [ DW_TAG_member ]
!421 = metadata !{i32 720909, metadata !412, metadata !"data_start", metadata !277, i32 709, i64 64, i64 64, i64 8320, i32 0, metadata !419} ; [ DW_TAG_member ]
!422 = metadata !{i32 720909, metadata !412, metadata !"data_end", metadata !277, i32 710, i64 64, i64 64, i64 8384, i32 0, metadata !419} ; [ DW_TAG_member ]
!423 = metadata !{i32 720909, metadata !412, metadata !"bss_start", metadata !277, i32 711, i64 64, i64 64, i64 8448, i32 0, metadata !419} ; [ DW_TAG_member ]
!424 = metadata !{i32 720909, metadata !412, metadata !"bss_end", metadata !277, i32 712, i64 64, i64 64, i64 8512, i32 0, metadata !419} ; [ DW_TAG_member ]
!425 = metadata !{i32 720909, metadata !407, metadata !"count", metadata !277, i32 725, i64 32, i64 32, i64 64, i32 0, metadata !14} ; [ DW_TAG_member ]
!426 = metadata !{i32 720909, metadata !276, metadata !"exe_info", metadata !277, i32 858, i64 64, i64 64, i64 0, i32 0, metadata !427} ; [ DW_TAG_member ]
!427 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !428} ; [ DW_TAG_pointer_type ]
!428 = metadata !{i32 720918, null, metadata !"PAPI_exe_info_t", metadata !277, i32 720, i64 0, i64 0, i64 0, i32 0, metadata !429} ; [ DW_TAG_typedef ]
!429 = metadata !{i32 720915, null, metadata !"_papi_program_info", metadata !277, i32 717, i64 16768, i64 64, i32 0, i32 0, i32 0, metadata !430, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!430 = metadata !{metadata !431, metadata !432}
!431 = metadata !{i32 720909, metadata !429, metadata !"fullname", metadata !277, i32 718, i64 8192, i64 8, i64 0, i32 0, metadata !415} ; [ DW_TAG_member ]
!432 = metadata !{i32 720909, metadata !429, metadata !"address_info", metadata !277, i32 719, i64 8576, i64 64, i64 8192, i32 0, metadata !411} ; [ DW_TAG_member ]
!433 = metadata !{i32 720909, metadata !276, metadata !"cmp_info", metadata !277, i32 859, i64 64, i64 64, i64 0, i32 0, metadata !434} ; [ DW_TAG_member ]
!434 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !435} ; [ DW_TAG_pointer_type ]
!435 = metadata !{i32 720918, null, metadata !"PAPI_component_info_t", metadata !277, i32 686, i64 0, i64 0, i64 0, i32 0, metadata !436} ; [ DW_TAG_typedef ]
!436 = metadata !{i32 720915, null, metadata !"_papi_component_option", metadata !277, i32 639, i64 3168, i64 32, i32 0, i32 0, i32 0, metadata !437, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!437 = metadata !{metadata !438, metadata !439, metadata !443, metadata !444, metadata !445, metadata !446, metadata !447, metadata !448, metadata !449, metadata !450, metadata !451, metadata !452, metadata !453, metadata !454, metadata !455, metadata !456, metadata !457, metadata !458, metadata !459, metadata !460, metadata !461, metadata !462, metadata !464, metadata !465, metadata !466, metadata !467, metadata !468, metadata !469, metadata !470, metadata !471, metadata !472, metadata !473, metadata !474, metadata !475, metadata !476, metadata !477, metadata !478, metadata !479, metadata !480, metadata !481, metadata !482, metadata !483, metadata !484, metadata !485, metadata !486}
!438 = metadata !{i32 720909, metadata !436, metadata !"name", metadata !277, i32 640, i64 1024, i64 8, i64 0, i32 0, metadata !284} ; [ DW_TAG_member ]
!439 = metadata !{i32 720909, metadata !436, metadata !"version", metadata !277, i32 641, i64 512, i64 8, i64 1024, i32 0, metadata !440} ; [ DW_TAG_member ]
!440 = metadata !{i32 720897, null, metadata !"", null, i32 0, i64 512, i64 8, i32 0, i32 0, metadata !33, metadata !441, i32 0, i32 0} ; [ DW_TAG_array_type ]
!441 = metadata !{metadata !442}
!442 = metadata !{i32 720929, i64 0, i64 63}      ; [ DW_TAG_subrange_type ]
!443 = metadata !{i32 720909, metadata !436, metadata !"support_version", metadata !277, i32 642, i64 512, i64 8, i64 1536, i32 0, metadata !440} ; [ DW_TAG_member ]
!444 = metadata !{i32 720909, metadata !436, metadata !"kernel_version", metadata !277, i32 643, i64 512, i64 8, i64 2048, i32 0, metadata !440} ; [ DW_TAG_member ]
!445 = metadata !{i32 720909, metadata !436, metadata !"CmpIdx", metadata !277, i32 644, i64 32, i64 32, i64 2560, i32 0, metadata !14} ; [ DW_TAG_member ]
!446 = metadata !{i32 720909, metadata !436, metadata !"num_cntrs", metadata !277, i32 645, i64 32, i64 32, i64 2592, i32 0, metadata !14} ; [ DW_TAG_member ]
!447 = metadata !{i32 720909, metadata !436, metadata !"num_mpx_cntrs", metadata !277, i32 646, i64 32, i64 32, i64 2624, i32 0, metadata !14} ; [ DW_TAG_member ]
!448 = metadata !{i32 720909, metadata !436, metadata !"num_preset_events", metadata !277, i32 647, i64 32, i64 32, i64 2656, i32 0, metadata !14} ; [ DW_TAG_member ]
!449 = metadata !{i32 720909, metadata !436, metadata !"num_native_events", metadata !277, i32 648, i64 32, i64 32, i64 2688, i32 0, metadata !14} ; [ DW_TAG_member ]
!450 = metadata !{i32 720909, metadata !436, metadata !"default_domain", metadata !277, i32 649, i64 32, i64 32, i64 2720, i32 0, metadata !14} ; [ DW_TAG_member ]
!451 = metadata !{i32 720909, metadata !436, metadata !"available_domains", metadata !277, i32 650, i64 32, i64 32, i64 2752, i32 0, metadata !14} ; [ DW_TAG_member ]
!452 = metadata !{i32 720909, metadata !436, metadata !"default_granularity", metadata !277, i32 651, i64 32, i64 32, i64 2784, i32 0, metadata !14} ; [ DW_TAG_member ]
!453 = metadata !{i32 720909, metadata !436, metadata !"available_granularities", metadata !277, i32 652, i64 32, i64 32, i64 2816, i32 0, metadata !14} ; [ DW_TAG_member ]
!454 = metadata !{i32 720909, metadata !436, metadata !"itimer_sig", metadata !277, i32 653, i64 32, i64 32, i64 2848, i32 0, metadata !14} ; [ DW_TAG_member ]
!455 = metadata !{i32 720909, metadata !436, metadata !"itimer_num", metadata !277, i32 654, i64 32, i64 32, i64 2880, i32 0, metadata !14} ; [ DW_TAG_member ]
!456 = metadata !{i32 720909, metadata !436, metadata !"itimer_ns", metadata !277, i32 655, i64 32, i64 32, i64 2912, i32 0, metadata !14} ; [ DW_TAG_member ]
!457 = metadata !{i32 720909, metadata !436, metadata !"itimer_res_ns", metadata !277, i32 656, i64 32, i64 32, i64 2944, i32 0, metadata !14} ; [ DW_TAG_member ]
!458 = metadata !{i32 720909, metadata !436, metadata !"hardware_intr_sig", metadata !277, i32 657, i64 32, i64 32, i64 2976, i32 0, metadata !14} ; [ DW_TAG_member ]
!459 = metadata !{i32 720909, metadata !436, metadata !"clock_ticks", metadata !277, i32 658, i64 32, i64 32, i64 3008, i32 0, metadata !14} ; [ DW_TAG_member ]
!460 = metadata !{i32 720909, metadata !436, metadata !"opcode_match_width", metadata !277, i32 659, i64 32, i64 32, i64 3040, i32 0, metadata !14} ; [ DW_TAG_member ]
!461 = metadata !{i32 720909, metadata !436, metadata !"os_version", metadata !277, i32 660, i64 32, i64 32, i64 3072, i32 0, metadata !14} ; [ DW_TAG_member ]
!462 = metadata !{i32 720909, metadata !436, metadata !"reserved", metadata !277, i32 661, i64 32, i64 32, i64 3104, i32 0, metadata !463} ; [ DW_TAG_member ]
!463 = metadata !{i32 720897, null, metadata !"", null, i32 0, i64 32, i64 32, i32 0, i32 0, metadata !14, metadata !92, i32 0, i32 0} ; [ DW_TAG_array_type ]
!464 = metadata !{i32 720909, metadata !436, metadata !"hardware_intr", metadata !277, i32 662, i64 1, i64 32, i64 3136, i32 0, metadata !41} ; [ DW_TAG_member ]
!465 = metadata !{i32 720909, metadata !436, metadata !"precise_intr", metadata !277, i32 663, i64 1, i64 32, i64 3137, i32 0, metadata !41} ; [ DW_TAG_member ]
!466 = metadata !{i32 720909, metadata !436, metadata !"posix1b_timers", metadata !277, i32 664, i64 1, i64 32, i64 3138, i32 0, metadata !41} ; [ DW_TAG_member ]
!467 = metadata !{i32 720909, metadata !436, metadata !"kernel_profile", metadata !277, i32 665, i64 1, i64 32, i64 3139, i32 0, metadata !41} ; [ DW_TAG_member ]
!468 = metadata !{i32 720909, metadata !436, metadata !"kernel_multiplex", metadata !277, i32 666, i64 1, i64 32, i64 3140, i32 0, metadata !41} ; [ DW_TAG_member ]
!469 = metadata !{i32 720909, metadata !436, metadata !"data_address_range", metadata !277, i32 667, i64 1, i64 32, i64 3141, i32 0, metadata !41} ; [ DW_TAG_member ]
!470 = metadata !{i32 720909, metadata !436, metadata !"instr_address_range", metadata !277, i32 668, i64 1, i64 32, i64 3142, i32 0, metadata !41} ; [ DW_TAG_member ]
!471 = metadata !{i32 720909, metadata !436, metadata !"fast_counter_read", metadata !277, i32 669, i64 1, i64 32, i64 3143, i32 0, metadata !41} ; [ DW_TAG_member ]
!472 = metadata !{i32 720909, metadata !436, metadata !"fast_real_timer", metadata !277, i32 670, i64 1, i64 32, i64 3144, i32 0, metadata !41} ; [ DW_TAG_member ]
!473 = metadata !{i32 720909, metadata !436, metadata !"fast_virtual_timer", metadata !277, i32 671, i64 1, i64 32, i64 3145, i32 0, metadata !41} ; [ DW_TAG_member ]
!474 = metadata !{i32 720909, metadata !436, metadata !"attach", metadata !277, i32 672, i64 1, i64 32, i64 3146, i32 0, metadata !41} ; [ DW_TAG_member ]
!475 = metadata !{i32 720909, metadata !436, metadata !"attach_must_ptrace", metadata !277, i32 673, i64 1, i64 32, i64 3147, i32 0, metadata !41} ; [ DW_TAG_member ]
!476 = metadata !{i32 720909, metadata !436, metadata !"edge_detect", metadata !277, i32 674, i64 1, i64 32, i64 3148, i32 0, metadata !41} ; [ DW_TAG_member ]
!477 = metadata !{i32 720909, metadata !436, metadata !"invert", metadata !277, i32 675, i64 1, i64 32, i64 3149, i32 0, metadata !41} ; [ DW_TAG_member ]
!478 = metadata !{i32 720909, metadata !436, metadata !"profile_ear", metadata !277, i32 676, i64 1, i64 32, i64 3150, i32 0, metadata !41} ; [ DW_TAG_member ]
!479 = metadata !{i32 720909, metadata !436, metadata !"cntr_groups", metadata !277, i32 677, i64 1, i64 32, i64 3151, i32 0, metadata !41} ; [ DW_TAG_member ]
!480 = metadata !{i32 720909, metadata !436, metadata !"cntr_umasks", metadata !277, i32 678, i64 1, i64 32, i64 3152, i32 0, metadata !41} ; [ DW_TAG_member ]
!481 = metadata !{i32 720909, metadata !436, metadata !"cntr_IEAR_events", metadata !277, i32 679, i64 1, i64 32, i64 3153, i32 0, metadata !41} ; [ DW_TAG_member ]
!482 = metadata !{i32 720909, metadata !436, metadata !"cntr_DEAR_events", metadata !277, i32 680, i64 1, i64 32, i64 3154, i32 0, metadata !41} ; [ DW_TAG_member ]
!483 = metadata !{i32 720909, metadata !436, metadata !"cntr_OPCM_events", metadata !277, i32 681, i64 1, i64 32, i64 3155, i32 0, metadata !41} ; [ DW_TAG_member ]
!484 = metadata !{i32 720909, metadata !436, metadata !"cpu", metadata !277, i32 683, i64 1, i64 32, i64 3156, i32 0, metadata !41} ; [ DW_TAG_member ]
!485 = metadata !{i32 720909, metadata !436, metadata !"inherit", metadata !277, i32 684, i64 1, i64 32, i64 3157, i32 0, metadata !41} ; [ DW_TAG_member ]
!486 = metadata !{i32 720909, metadata !436, metadata !"reserved_bits", metadata !277, i32 685, i64 10, i64 32, i64 3158, i32 0, metadata !41} ; [ DW_TAG_member ]
!487 = metadata !{i32 720909, metadata !276, metadata !"addr", metadata !277, i32 860, i64 256, i64 64, i64 0, i32 0, metadata !488} ; [ DW_TAG_member ]
!488 = metadata !{i32 720918, null, metadata !"PAPI_addr_range_option_t", metadata !277, i32 837, i64 0, i64 0, i64 0, i32 0, metadata !489} ; [ DW_TAG_typedef ]
!489 = metadata !{i32 720915, null, metadata !"_papi_addr_range_option", metadata !277, i32 831, i64 256, i64 64, i32 0, i32 0, i32 0, metadata !490, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!490 = metadata !{metadata !491, metadata !492, metadata !493, metadata !494, metadata !495}
!491 = metadata !{i32 720909, metadata !489, metadata !"eventset", metadata !277, i32 832, i64 32, i64 32, i64 0, i32 0, metadata !14} ; [ DW_TAG_member ]
!492 = metadata !{i32 720909, metadata !489, metadata !"start", metadata !277, i32 833, i64 64, i64 64, i64 64, i32 0, metadata !419} ; [ DW_TAG_member ]
!493 = metadata !{i32 720909, metadata !489, metadata !"end", metadata !277, i32 834, i64 64, i64 64, i64 128, i32 0, metadata !419} ; [ DW_TAG_member ]
!494 = metadata !{i32 720909, metadata !489, metadata !"start_off", metadata !277, i32 835, i64 32, i64 32, i64 192, i32 0, metadata !14} ; [ DW_TAG_member ]
!495 = metadata !{i32 720909, metadata !489, metadata !"end_off", metadata !277, i32 836, i64 32, i64 32, i64 224, i32 0, metadata !14} ; [ DW_TAG_member ]
!496 = metadata !{i32 720909, metadata !276, metadata !"events_file", metadata !277, i32 861, i64 64, i64 64, i64 0, i32 0, metadata !497} ; [ DW_TAG_member ]
!497 = metadata !{i32 720918, null, metadata !"PAPI_user_defined_events_file_t", metadata !277, i32 729, i64 0, i64 0, i64 0, i32 0, metadata !32} ; [ DW_TAG_typedef ]
!498 = metadata !{i32 172, i32 17, metadata !262, null}
!499 = metadata !{i32 174, i32 26, metadata !262, null}
!500 = metadata !{i32 175, i32 5, metadata !501, null}
!501 = metadata !{i32 720907, metadata !262, i32 174, i32 62, metadata !11, i32 14} ; [ DW_TAG_lexical_block ]
!502 = metadata !{i32 176, i32 5, metadata !501, null}
!503 = metadata !{i32 179, i32 7, metadata !262, null}
!504 = metadata !{i32 180, i32 5, metadata !505, null}
!505 = metadata !{i32 720907, metadata !262, i32 179, i32 50, metadata !11, i32 15} ; [ DW_TAG_lexical_block ]
!506 = metadata !{i32 181, i32 5, metadata !505, null}
!507 = metadata !{i32 184, i32 3, metadata !262, null}
!508 = metadata !{i32 185, i32 6, metadata !262, null}
!509 = metadata !{i32 186, i32 5, metadata !510, null}
!510 = metadata !{i32 720907, metadata !262, i32 185, i32 49, metadata !11, i32 16} ; [ DW_TAG_lexical_block ]
!511 = metadata !{i32 187, i32 5, metadata !510, null}
!512 = metadata !{i32 190, i32 19, metadata !262, null}
!513 = metadata !{i32 191, i32 5, metadata !514, null}
!514 = metadata !{i32 720907, metadata !262, i32 190, i32 80, metadata !11, i32 17} ; [ DW_TAG_lexical_block ]
!515 = metadata !{i32 192, i32 5, metadata !514, null}
!516 = metadata !{i32 195, i32 3, metadata !262, null}
!517 = metadata !{i32 196, i32 3, metadata !262, null}
!518 = metadata !{i32 197, i32 3, metadata !262, null}
!519 = metadata !{i32 198, i32 19, metadata !262, null}
!520 = metadata !{i32 199, i32 5, metadata !521, null}
!521 = metadata !{i32 720907, metadata !262, i32 198, i32 69, metadata !11, i32 18} ; [ DW_TAG_lexical_block ]
!522 = metadata !{i32 200, i32 5, metadata !521, null}
!523 = metadata !{i32 203, i32 3, metadata !262, null}
!524 = metadata !{i32 204, i32 3, metadata !262, null}
!525 = metadata !{i32 205, i32 3, metadata !262, null}
!526 = metadata !{i32 206, i32 3, metadata !262, null}
!527 = metadata !{i32 207, i32 7, metadata !528, null}
!528 = metadata !{i32 720907, metadata !262, i32 207, i32 3, metadata !11, i32 19} ; [ DW_TAG_lexical_block ]
!529 = metadata !{i32 208, i32 14, metadata !530, null}
!530 = metadata !{i32 720907, metadata !528, i32 207, i32 20, metadata !11, i32 20} ; [ DW_TAG_lexical_block ]
!531 = metadata !{i32 209, i32 5, metadata !530, null}
!532 = metadata !{i32 210, i32 7, metadata !533, null}
!533 = metadata !{i32 720907, metadata !530, i32 209, i32 26, metadata !11, i32 21} ; [ DW_TAG_lexical_block ]
!534 = metadata !{i32 211, i32 7, metadata !533, null}
!535 = metadata !{i32 213, i32 3, metadata !530, null}
!536 = metadata !{i32 207, i32 15, metadata !528, null}
!537 = metadata !{i32 218, i32 17, metadata !262, null}
!538 = metadata !{i32 220, i32 7, metadata !262, null}
!539 = metadata !{i32 221, i32 3, metadata !262, null}
!540 = metadata !{i32 222, i32 3, metadata !262, null}
!541 = metadata !{i32 223, i32 3, metadata !262, null}
!542 = metadata !{i32 224, i32 7, metadata !262, null}
!543 = metadata !{i32 225, i32 3, metadata !262, null}
!544 = metadata !{i32 229, i32 3, metadata !262, null}
!545 = metadata !{i32 230, i32 3, metadata !262, null}
!546 = metadata !{i32 231, i32 3, metadata !262, null}
!547 = metadata !{i32 232, i32 3, metadata !262, null}
!548 = metadata !{i32 234, i32 3, metadata !262, null}
