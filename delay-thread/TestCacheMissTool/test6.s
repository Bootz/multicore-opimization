; ModuleID = 'test6.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.periodic_info = type { i32, i64 }
%struct.itimerspec = type { %struct.timespec, %struct.timespec }
%struct.timespec = type { i64, i64 }
%union.pthread_attr_t = type { i64, [48 x i8] }

@events = global [3 x i32] [i32 -2147483589, i32 -2147483642, i32 -2147483641], align 4
@eventnum = global i32 3, align 4
@tempvalues = common global [3 x i64] zeroinitializer, align 16
@eventset = common global i32 0, align 4
@values = common global [3 x i64] zeroinitializer, align 16
@gnuplotfile = common global %struct._IO_FILE* null, align 8
@.str = private unnamed_addr constant [16 x i8] c"%lld\09%lld\09%lld\0A\00", align 1
@.str1 = private unnamed_addr constant [11 x i8] c"read timer\00", align 1

define i8* @PapiKernel(i8* %Args) nounwind uwtable {
entry:
  %retval = alloca i8*, align 8
  %Args.addr = alloca i8*, align 8
  %info = alloca %struct.periodic_info, align 8
  %i = alloca i64, align 8
  store i8* %Args, i8** %Args.addr, align 8
  call void @llvm.dbg.declare(metadata !{i8** %Args.addr}, metadata !111), !dbg !112
  call void @llvm.dbg.declare(metadata !{%struct.periodic_info* %info}, metadata !113), !dbg !115
  call void @llvm.dbg.declare(metadata !{i64* %i}, metadata !116), !dbg !117
  store i64 0, i64* %i, align 8, !dbg !118
  store i64 0, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 0), align 8, !dbg !119
  store i64 0, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 1), align 8, !dbg !120
  store i64 0, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 2), align 8, !dbg !121
  %call = call i32 @make_periodic(i32 10000, %struct.periodic_info* %info), !dbg !122
  br label %while.body, !dbg !123

while.body:                                       ; preds = %entry, %while.body
  %0 = load i64* %i, align 8, !dbg !124
  %add = add nsw i64 %0, 10, !dbg !124
  store i64 %add, i64* %i, align 8, !dbg !124
  %1 = load i32* @eventset, align 4, !dbg !126
  %call1 = call i32 @PAPI_read(i32 %1, i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i32 0)), !dbg !126
  %2 = load %struct._IO_FILE** @gnuplotfile, align 8, !dbg !127
  %3 = load i64* %i, align 8, !dbg !127
  %4 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 1), align 8, !dbg !127
  %5 = load i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 1), align 8, !dbg !127
  %sub = sub nsw i64 %4, %5, !dbg !127
  %6 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 2), align 8, !dbg !127
  %7 = load i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 2), align 8, !dbg !127
  %sub2 = sub nsw i64 %6, %7, !dbg !127
  %call3 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %2, i8* getelementptr inbounds ([16 x i8]* @.str, i32 0, i32 0), i64 %3, i64 %sub, i64 %sub2), !dbg !127
  %8 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 1), align 8, !dbg !128
  store i64 %8, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 1), align 8, !dbg !128
  %9 = load i64* getelementptr inbounds ([3 x i64]* @values, i32 0, i64 2), align 8, !dbg !129
  store i64 %9, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i32 0, i64 2), align 8, !dbg !129
  call void @wait_period(%struct.periodic_info* %info), !dbg !130
  br label %while.body, !dbg !131

return:                                           ; No predecessors!
  %10 = load i8** %retval, !dbg !132
  ret i8* %10, !dbg !132
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
  call void @llvm.dbg.declare(metadata !{i32* %period.addr}, metadata !133), !dbg !134
  store %struct.periodic_info* %info, %struct.periodic_info** %info.addr, align 8
  call void @llvm.dbg.declare(metadata !{%struct.periodic_info** %info.addr}, metadata !135), !dbg !136
  call void @llvm.dbg.declare(metadata !{i32* %ret}, metadata !137), !dbg !139
  call void @llvm.dbg.declare(metadata !{i32* %ns}, metadata !140), !dbg !141
  call void @llvm.dbg.declare(metadata !{i32* %sec}, metadata !142), !dbg !143
  call void @llvm.dbg.declare(metadata !{i32* %fd}, metadata !144), !dbg !145
  call void @llvm.dbg.declare(metadata !{%struct.itimerspec* %itval}, metadata !146), !dbg !157
  %call = call i32 @timerfd_create(i32 1, i32 0) nounwind, !dbg !158
  store i32 %call, i32* %fd, align 4, !dbg !158
  %0 = load %struct.periodic_info** %info.addr, align 8, !dbg !159
  %wakeups_missed = getelementptr inbounds %struct.periodic_info* %0, i32 0, i32 1, !dbg !159
  store i64 0, i64* %wakeups_missed, align 8, !dbg !159
  %1 = load i32* %fd, align 4, !dbg !160
  %2 = load %struct.periodic_info** %info.addr, align 8, !dbg !160
  %timer_fd = getelementptr inbounds %struct.periodic_info* %2, i32 0, i32 0, !dbg !160
  store i32 %1, i32* %timer_fd, align 4, !dbg !160
  %3 = load i32* %fd, align 4, !dbg !161
  %cmp = icmp eq i32 %3, -1, !dbg !161
  br i1 %cmp, label %if.then, label %if.end, !dbg !161

if.then:                                          ; preds = %entry
  %4 = load i32* %fd, align 4, !dbg !162
  store i32 %4, i32* %retval, !dbg !162
  br label %return, !dbg !162

if.end:                                           ; preds = %entry
  %5 = load i32* %period.addr, align 4, !dbg !163
  %div = udiv i32 %5, 1000000, !dbg !163
  store i32 %div, i32* %sec, align 4, !dbg !163
  %6 = load i32* %period.addr, align 4, !dbg !164
  %7 = load i32* %sec, align 4, !dbg !164
  %mul = mul i32 %7, 1000000, !dbg !164
  %sub = sub i32 %6, %mul, !dbg !164
  %mul1 = mul i32 %sub, 1000, !dbg !164
  store i32 %mul1, i32* %ns, align 4, !dbg !164
  %8 = load i32* %sec, align 4, !dbg !165
  %conv = zext i32 %8 to i64, !dbg !165
  %it_interval = getelementptr inbounds %struct.itimerspec* %itval, i32 0, i32 0, !dbg !165
  %tv_sec = getelementptr inbounds %struct.timespec* %it_interval, i32 0, i32 0, !dbg !165
  store i64 %conv, i64* %tv_sec, align 8, !dbg !165
  %9 = load i32* %ns, align 4, !dbg !166
  %conv2 = zext i32 %9 to i64, !dbg !166
  %it_interval3 = getelementptr inbounds %struct.itimerspec* %itval, i32 0, i32 0, !dbg !166
  %tv_nsec = getelementptr inbounds %struct.timespec* %it_interval3, i32 0, i32 1, !dbg !166
  store i64 %conv2, i64* %tv_nsec, align 8, !dbg !166
  %10 = load i32* %sec, align 4, !dbg !167
  %conv4 = zext i32 %10 to i64, !dbg !167
  %it_value = getelementptr inbounds %struct.itimerspec* %itval, i32 0, i32 1, !dbg !167
  %tv_sec5 = getelementptr inbounds %struct.timespec* %it_value, i32 0, i32 0, !dbg !167
  store i64 %conv4, i64* %tv_sec5, align 8, !dbg !167
  %11 = load i32* %ns, align 4, !dbg !168
  %conv6 = zext i32 %11 to i64, !dbg !168
  %it_value7 = getelementptr inbounds %struct.itimerspec* %itval, i32 0, i32 1, !dbg !168
  %tv_nsec8 = getelementptr inbounds %struct.timespec* %it_value7, i32 0, i32 1, !dbg !168
  store i64 %conv6, i64* %tv_nsec8, align 8, !dbg !168
  %12 = load i32* %fd, align 4, !dbg !169
  %call9 = call i32 @timerfd_settime(i32 %12, i32 0, %struct.itimerspec* %itval, %struct.itimerspec* null) nounwind, !dbg !169
  store i32 %call9, i32* %ret, align 4, !dbg !169
  %13 = load i32* %ret, align 4, !dbg !170
  store i32 %13, i32* %retval, !dbg !170
  br label %return, !dbg !170

return:                                           ; preds = %if.end, %if.then
  %14 = load i32* %retval, !dbg !171
  ret i32 %14, !dbg !171
}

declare i32 @PAPI_read(i32, i64*)

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...)

define internal void @wait_period(%struct.periodic_info* %info) nounwind uwtable {
entry:
  %info.addr = alloca %struct.periodic_info*, align 8
  %missed = alloca i64, align 8
  %ret = alloca i32, align 4
  store %struct.periodic_info* %info, %struct.periodic_info** %info.addr, align 8
  call void @llvm.dbg.declare(metadata !{%struct.periodic_info** %info.addr}, metadata !172), !dbg !173
  call void @llvm.dbg.declare(metadata !{i64* %missed}, metadata !174), !dbg !176
  call void @llvm.dbg.declare(metadata !{i32* %ret}, metadata !177), !dbg !178
  %0 = load %struct.periodic_info** %info.addr, align 8, !dbg !179
  %timer_fd = getelementptr inbounds %struct.periodic_info* %0, i32 0, i32 0, !dbg !179
  %1 = load i32* %timer_fd, align 4, !dbg !179
  %2 = bitcast i64* %missed to i8*, !dbg !179
  %call = call i64 @read(i32 %1, i8* %2, i64 8), !dbg !179
  %conv = trunc i64 %call to i32, !dbg !179
  store i32 %conv, i32* %ret, align 4, !dbg !179
  %3 = load i32* %ret, align 4, !dbg !180
  %cmp = icmp eq i32 %3, -1, !dbg !180
  br i1 %cmp, label %if.then, label %if.end, !dbg !180

if.then:                                          ; preds = %entry
  call void @perror(i8* getelementptr inbounds ([11 x i8]* @.str1, i32 0, i32 0)), !dbg !181
  br label %if.end5, !dbg !183

if.end:                                           ; preds = %entry
  %4 = load i64* %missed, align 8, !dbg !184
  %cmp2 = icmp ugt i64 %4, 0, !dbg !184
  br i1 %cmp2, label %if.then4, label %if.end5, !dbg !184

if.then4:                                         ; preds = %if.end
  %5 = load i64* %missed, align 8, !dbg !185
  %sub = sub i64 %5, 1, !dbg !185
  %6 = load %struct.periodic_info** %info.addr, align 8, !dbg !185
  %wakeups_missed = getelementptr inbounds %struct.periodic_info* %6, i32 0, i32 1, !dbg !185
  %7 = load i64* %wakeups_missed, align 8, !dbg !185
  %add = add i64 %7, %sub, !dbg !185
  store i64 %add, i64* %wakeups_missed, align 8, !dbg !185
  br label %if.end5, !dbg !185

if.end5:                                          ; preds = %if.then, %if.then4, %if.end
  ret void, !dbg !186
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
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !187), !dbg !189
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !190), !dbg !191
  call void @llvm.dbg.declare(metadata !{i32* %numInt}, metadata !192), !dbg !193
  call void @llvm.dbg.declare(metadata !{i32* %numCachelineUsed}, metadata !194), !dbg !195
  call void @llvm.dbg.declare(metadata !{i32** %a}, metadata !196), !dbg !198
  store i32 2097152, i32* %numInt, align 4, !dbg !199
  store i32 131072, i32* %numCachelineUsed, align 4, !dbg !200
  %0 = load i32* %numInt, align 4, !dbg !201
  %conv = sext i32 %0 to i64, !dbg !201
  %mul = mul i64 4, %conv, !dbg !201
  %call = call noalias i8* @malloc(i64 %mul) nounwind, !dbg !201
  %1 = bitcast i8* %call to i32*, !dbg !201
  store i32* %1, i32** %a, align 8, !dbg !201
  call void @llvm.dbg.declare(metadata !{%union.pthread_attr_t* %attr}, metadata !202), !dbg !212
  call void @llvm.dbg.declare(metadata !{i64* %Thread}, metadata !213), !dbg !215
  %call1 = call i32 @pthread_attr_init(%union.pthread_attr_t* %attr) nounwind, !dbg !216
  %call2 = call i32 @pthread_attr_setdetachstate(%union.pthread_attr_t* %attr, i32 0) nounwind, !dbg !217
  %call3 = call i32 @pthread_create(i64* %Thread, %union.pthread_attr_t* %attr, i8* (i8*)* @PapiKernel, i8* null) nounwind, !dbg !218
  store i32 0, i32* %j, align 4, !dbg !219
  br label %for.cond, !dbg !219

for.cond:                                         ; preds = %for.inc11, %entry
  %2 = load i32* %j, align 4, !dbg !219
  %cmp = icmp slt i32 %2, 16, !dbg !219
  br i1 %cmp, label %for.body, label %for.end13, !dbg !219

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %i, align 4, !dbg !221
  br label %for.cond5, !dbg !221

for.cond5:                                        ; preds = %for.inc, %for.body
  %3 = load i32* %i, align 4, !dbg !221
  %4 = load i32* %numCachelineUsed, align 4, !dbg !221
  %cmp6 = icmp slt i32 %3, %4, !dbg !221
  br i1 %cmp6, label %for.body8, label %for.end, !dbg !221

for.body8:                                        ; preds = %for.cond5
  %5 = load i32* %i, align 4, !dbg !223
  %mul9 = mul nsw i32 %5, 16, !dbg !223
  %6 = load i32* %j, align 4, !dbg !223
  %add = add nsw i32 %mul9, %6, !dbg !223
  %idxprom = sext i32 %add to i64, !dbg !223
  %7 = load i32** %a, align 8, !dbg !223
  %arrayidx = getelementptr inbounds i32* %7, i64 %idxprom, !dbg !223
  %8 = load i32* %arrayidx, !dbg !223
  %inc = add nsw i32 %8, 1, !dbg !223
  store i32 %inc, i32* %arrayidx, !dbg !223
  br label %for.inc, !dbg !225

for.inc:                                          ; preds = %for.body8
  %9 = load i32* %i, align 4, !dbg !226
  %inc10 = add nsw i32 %9, 1, !dbg !226
  store i32 %inc10, i32* %i, align 4, !dbg !226
  br label %for.cond5, !dbg !226

for.end:                                          ; preds = %for.cond5
  br label %for.inc11, !dbg !227

for.inc11:                                        ; preds = %for.end
  %10 = load i32* %j, align 4, !dbg !228
  %inc12 = add nsw i32 %10, 1, !dbg !228
  store i32 %inc12, i32* %j, align 4, !dbg !228
  br label %for.cond, !dbg !228

for.end13:                                        ; preds = %for.cond
  store i32 0, i32* %i, align 4, !dbg !229
  br label %for.cond14, !dbg !229

for.cond14:                                       ; preds = %for.inc21, %for.end13
  %11 = load i32* %i, align 4, !dbg !229
  %12 = load i32* %numInt, align 4, !dbg !229
  %cmp15 = icmp slt i32 %11, %12, !dbg !229
  br i1 %cmp15, label %for.body17, label %for.end23, !dbg !229

for.body17:                                       ; preds = %for.cond14
  %13 = load i32* %i, align 4, !dbg !231
  %idxprom18 = sext i32 %13 to i64, !dbg !231
  %14 = load i32** %a, align 8, !dbg !231
  %arrayidx19 = getelementptr inbounds i32* %14, i64 %idxprom18, !dbg !231
  %15 = load i32* %arrayidx19, !dbg !231
  %inc20 = add nsw i32 %15, 1, !dbg !231
  store i32 %inc20, i32* %arrayidx19, !dbg !231
  br label %for.inc21, !dbg !231

for.inc21:                                        ; preds = %for.body17
  %16 = load i32* %i, align 4, !dbg !232
  %inc22 = add nsw i32 %16, 1, !dbg !232
  store i32 %inc22, i32* %i, align 4, !dbg !232
  br label %for.cond14, !dbg !232

for.end23:                                        ; preds = %for.cond14
  store i32 0, i32* %j, align 4, !dbg !233
  br label %for.cond24, !dbg !233

for.cond24:                                       ; preds = %for.inc40, %for.end23
  %17 = load i32* %j, align 4, !dbg !233
  %cmp25 = icmp slt i32 %17, 16, !dbg !233
  br i1 %cmp25, label %for.body27, label %for.end42, !dbg !233

for.body27:                                       ; preds = %for.cond24
  store i32 0, i32* %i, align 4, !dbg !235
  br label %for.cond28, !dbg !235

for.cond28:                                       ; preds = %for.inc37, %for.body27
  %18 = load i32* %i, align 4, !dbg !235
  %19 = load i32* %numCachelineUsed, align 4, !dbg !235
  %cmp29 = icmp slt i32 %18, %19, !dbg !235
  br i1 %cmp29, label %for.body31, label %for.end39, !dbg !235

for.body31:                                       ; preds = %for.cond28
  %20 = load i32* %i, align 4, !dbg !237
  %mul32 = mul nsw i32 %20, 16, !dbg !237
  %21 = load i32* %j, align 4, !dbg !237
  %add33 = add nsw i32 %mul32, %21, !dbg !237
  %idxprom34 = sext i32 %add33 to i64, !dbg !237
  %22 = load i32** %a, align 8, !dbg !237
  %arrayidx35 = getelementptr inbounds i32* %22, i64 %idxprom34, !dbg !237
  %23 = load i32* %arrayidx35, !dbg !237
  %inc36 = add nsw i32 %23, 1, !dbg !237
  store i32 %inc36, i32* %arrayidx35, !dbg !237
  br label %for.inc37, !dbg !237

for.inc37:                                        ; preds = %for.body31
  %24 = load i32* %i, align 4, !dbg !238
  %inc38 = add nsw i32 %24, 1, !dbg !238
  store i32 %inc38, i32* %i, align 4, !dbg !238
  br label %for.cond28, !dbg !238

for.end39:                                        ; preds = %for.cond28
  br label %for.inc40, !dbg !239

for.inc40:                                        ; preds = %for.end39
  %25 = load i32* %j, align 4, !dbg !240
  %inc41 = add nsw i32 %25, 1, !dbg !240
  store i32 %inc41, i32* %j, align 4, !dbg !240
  br label %for.cond24, !dbg !240

for.end42:                                        ; preds = %for.cond24
  store i32 0, i32* %i, align 4, !dbg !241
  br label %for.cond43, !dbg !241

for.cond43:                                       ; preds = %for.inc50, %for.end42
  %26 = load i32* %i, align 4, !dbg !241
  %27 = load i32* %numInt, align 4, !dbg !241
  %cmp44 = icmp slt i32 %26, %27, !dbg !241
  br i1 %cmp44, label %for.body46, label %for.end52, !dbg !241

for.body46:                                       ; preds = %for.cond43
  %28 = load i32* %i, align 4, !dbg !243
  %idxprom47 = sext i32 %28 to i64, !dbg !243
  %29 = load i32** %a, align 8, !dbg !243
  %arrayidx48 = getelementptr inbounds i32* %29, i64 %idxprom47, !dbg !243
  %30 = load i32* %arrayidx48, !dbg !243
  %inc49 = add nsw i32 %30, 1, !dbg !243
  store i32 %inc49, i32* %arrayidx48, !dbg !243
  br label %for.inc50, !dbg !243

for.inc50:                                        ; preds = %for.body46
  %31 = load i32* %i, align 4, !dbg !244
  %inc51 = add nsw i32 %31, 1, !dbg !244
  store i32 %inc51, i32* %i, align 4, !dbg !244
  br label %for.cond43, !dbg !244

for.end52:                                        ; preds = %for.cond43
  store i32 0, i32* %j, align 4, !dbg !245
  br label %for.cond53, !dbg !245

for.cond53:                                       ; preds = %for.inc69, %for.end52
  %32 = load i32* %j, align 4, !dbg !245
  %cmp54 = icmp slt i32 %32, 16, !dbg !245
  br i1 %cmp54, label %for.body56, label %for.end71, !dbg !245

for.body56:                                       ; preds = %for.cond53
  store i32 0, i32* %i, align 4, !dbg !247
  br label %for.cond57, !dbg !247

for.cond57:                                       ; preds = %for.inc66, %for.body56
  %33 = load i32* %i, align 4, !dbg !247
  %34 = load i32* %numCachelineUsed, align 4, !dbg !247
  %cmp58 = icmp slt i32 %33, %34, !dbg !247
  br i1 %cmp58, label %for.body60, label %for.end68, !dbg !247

for.body60:                                       ; preds = %for.cond57
  %35 = load i32* %i, align 4, !dbg !249
  %mul61 = mul nsw i32 %35, 16, !dbg !249
  %36 = load i32* %j, align 4, !dbg !249
  %add62 = add nsw i32 %mul61, %36, !dbg !249
  %idxprom63 = sext i32 %add62 to i64, !dbg !249
  %37 = load i32** %a, align 8, !dbg !249
  %arrayidx64 = getelementptr inbounds i32* %37, i64 %idxprom63, !dbg !249
  %38 = load i32* %arrayidx64, !dbg !249
  %inc65 = add nsw i32 %38, 1, !dbg !249
  store i32 %inc65, i32* %arrayidx64, !dbg !249
  br label %for.inc66, !dbg !249

for.inc66:                                        ; preds = %for.body60
  %39 = load i32* %i, align 4, !dbg !250
  %inc67 = add nsw i32 %39, 1, !dbg !250
  store i32 %inc67, i32* %i, align 4, !dbg !250
  br label %for.cond57, !dbg !250

for.end68:                                        ; preds = %for.cond57
  br label %for.inc69, !dbg !251

for.inc69:                                        ; preds = %for.end68
  %40 = load i32* %j, align 4, !dbg !252
  %inc70 = add nsw i32 %40, 1, !dbg !252
  store i32 %inc70, i32* %j, align 4, !dbg !252
  br label %for.cond53, !dbg !252

for.end71:                                        ; preds = %for.cond53
  store i32 0, i32* %i, align 4, !dbg !253
  br label %for.cond72, !dbg !253

for.cond72:                                       ; preds = %for.inc79, %for.end71
  %41 = load i32* %i, align 4, !dbg !253
  %42 = load i32* %numInt, align 4, !dbg !253
  %cmp73 = icmp slt i32 %41, %42, !dbg !253
  br i1 %cmp73, label %for.body75, label %for.end81, !dbg !253

for.body75:                                       ; preds = %for.cond72
  %43 = load i32* %i, align 4, !dbg !255
  %idxprom76 = sext i32 %43 to i64, !dbg !255
  %44 = load i32** %a, align 8, !dbg !255
  %arrayidx77 = getelementptr inbounds i32* %44, i64 %idxprom76, !dbg !255
  %45 = load i32* %arrayidx77, !dbg !255
  %inc78 = add nsw i32 %45, 1, !dbg !255
  store i32 %inc78, i32* %arrayidx77, !dbg !255
  br label %for.inc79, !dbg !255

for.inc79:                                        ; preds = %for.body75
  %46 = load i32* %i, align 4, !dbg !256
  %inc80 = add nsw i32 %46, 1, !dbg !256
  store i32 %inc80, i32* %i, align 4, !dbg !256
  br label %for.cond72, !dbg !256

for.end81:                                        ; preds = %for.cond72
  %47 = load i64* %Thread, align 8, !dbg !257
  %call82 = call i32 @pthread_cancel(i64 %47), !dbg !257
  ret i32 0, !dbg !258
}

declare noalias i8* @malloc(i64) nounwind

declare i32 @pthread_attr_init(%union.pthread_attr_t*) nounwind

declare i32 @pthread_attr_setdetachstate(%union.pthread_attr_t*, i32) nounwind

declare i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) nounwind

declare i32 @pthread_cancel(i64)

declare i64 @read(i32, i8*, i64)

declare void @perror(i8*)

declare i32 @timerfd_create(i32, i32) nounwind

declare i32 @timerfd_settime(i32, i32, %struct.itimerspec*, %struct.itimerspec*) nounwind

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 720913, i32 0, i32 12, metadata !"test6.c", metadata !"/home/kula85/Research/delay-thread/testCacheMissTool", metadata !"clang version 3.1 (trunk 144408)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !8, metadata !17, metadata !42} ; [ DW_TAG_compile_unit ]
!1 = metadata !{metadata !2}
!2 = metadata !{metadata !3}
!3 = metadata !{i32 720900, null, metadata !"", metadata !4, i32 36, i64 32, i64 32, i32 0, i32 0, i32 0, metadata !5, i32 0, i32 0} ; [ DW_TAG_enumeration_type ]
!4 = metadata !{i32 720937, metadata !"/usr/include/pthread.h", metadata !"/home/kula85/Research/delay-thread/testCacheMissTool", null} ; [ DW_TAG_file_type ]
!5 = metadata !{metadata !6, metadata !7}
!6 = metadata !{i32 720936, metadata !"PTHREAD_CREATE_JOINABLE", i64 0} ; [ DW_TAG_enumerator ]
!7 = metadata !{i32 720936, metadata !"PTHREAD_CREATE_DETACHED", i64 1} ; [ DW_TAG_enumerator ]
!8 = metadata !{metadata !9}
!9 = metadata !{metadata !10}
!10 = metadata !{i32 720915, null, metadata !"periodic_info", metadata !11, i32 27, i64 128, i64 64, i32 0, i32 0, i32 0, metadata !12, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!11 = metadata !{i32 720937, metadata !"test6.c", metadata !"/home/kula85/Research/delay-thread/testCacheMissTool", null} ; [ DW_TAG_file_type ]
!12 = metadata !{metadata !13, metadata !15}
!13 = metadata !{i32 720909, metadata !10, metadata !"timer_fd", metadata !11, i32 29, i64 32, i64 32, i64 0, i32 0, metadata !14} ; [ DW_TAG_member ]
!14 = metadata !{i32 720932, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ]
!15 = metadata !{i32 720909, metadata !10, metadata !"wakeups_missed", metadata !11, i32 30, i64 64, i64 64, i64 64, i32 0, metadata !16} ; [ DW_TAG_member ]
!16 = metadata !{i32 720932, null, metadata !"long long unsigned int", null, i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ]
!17 = metadata !{metadata !18}
!18 = metadata !{metadata !19, metadata !25, metadata !30, metadata !36}
!19 = metadata !{i32 720942, i32 0, metadata !11, metadata !"PapiKernel", metadata !"PapiKernel", metadata !"", metadata !11, i32 78, metadata !20, i1 false, i1 true, i32 0, i32 0, i32 0, i32 256, i1 false, i8* (i8*)* @PapiKernel, null, null, metadata !23} ; [ DW_TAG_subprogram ]
!20 = metadata !{i32 720917, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i32 0, i32 0, i32 0, metadata !21, i32 0, i32 0} ; [ DW_TAG_subroutine_type ]
!21 = metadata !{metadata !22, metadata !22}
!22 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ]
!23 = metadata !{metadata !24}
!24 = metadata !{i32 720932}                      ; [ DW_TAG_base_type ]
!25 = metadata !{i32 720942, i32 0, metadata !11, metadata !"test", metadata !"test", metadata !"", metadata !11, i32 102, metadata !26, i1 false, i1 true, i32 0, i32 0, i32 0, i32 0, i1 false, i32 ()* @test, null, null, metadata !28} ; [ DW_TAG_subprogram ]
!26 = metadata !{i32 720917, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i32 0, i32 0, i32 0, metadata !27, i32 0, i32 0} ; [ DW_TAG_subroutine_type ]
!27 = metadata !{metadata !14}
!28 = metadata !{metadata !29}
!29 = metadata !{i32 720932}                      ; [ DW_TAG_base_type ]
!30 = metadata !{i32 720942, i32 0, metadata !11, metadata !"wait_period", metadata !"wait_period", metadata !"", metadata !11, i32 60, metadata !31, i1 true, i1 true, i32 0, i32 0, i32 0, i32 256, i1 false, void (%struct.periodic_info*)* @wait_period, null, null, metadata !34} ; [ DW_TAG_subprogram ]
!31 = metadata !{i32 720917, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i32 0, i32 0, i32 0, metadata !32, i32 0, i32 0} ; [ DW_TAG_subroutine_type ]
!32 = metadata !{null, metadata !33}
!33 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ]
!34 = metadata !{metadata !35}
!35 = metadata !{i32 720932}                      ; [ DW_TAG_base_type ]
!36 = metadata !{i32 720942, i32 0, metadata !11, metadata !"make_periodic", metadata !"make_periodic", metadata !"", metadata !11, i32 34, metadata !37, i1 true, i1 true, i32 0, i32 0, i32 0, i32 256, i1 false, i32 (i32, %struct.periodic_info*)* @make_periodic, null, null, metadata !40} ; [ DW_TAG_subprogram ]
!37 = metadata !{i32 720917, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i32 0, i32 0, i32 0, metadata !38, i32 0, i32 0} ; [ DW_TAG_subroutine_type ]
!38 = metadata !{metadata !14, metadata !39, metadata !33}
!39 = metadata !{i32 720932, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ]
!40 = metadata !{metadata !41}
!41 = metadata !{i32 720932}                      ; [ DW_TAG_base_type ]
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
!59 = metadata !{metadata !60, metadata !61, metadata !64, metadata !65, metadata !66, metadata !67, metadata !68, metadata !69, metadata !70, metadata !71, metadata !72, metadata !73, metadata !74, metadata !82, metadata !83, metadata !84, metadata !85, metadata !88, metadata !90, metadata !92, metadata !96, metadata !97, metadata !99, metadata !100, metadata !101, metadata !102, metadata !103, metadata !106, metadata !107}
!60 = metadata !{i32 720909, metadata !57, metadata !"_flags", metadata !58, i32 272, i64 32, i64 32, i64 0, i32 0, metadata !14} ; [ DW_TAG_member ]
!61 = metadata !{i32 720909, metadata !57, metadata !"_IO_read_ptr", metadata !58, i32 277, i64 64, i64 64, i64 64, i32 0, metadata !62} ; [ DW_TAG_member ]
!62 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !63} ; [ DW_TAG_pointer_type ]
!63 = metadata !{i32 720932, null, metadata !"char", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ]
!64 = metadata !{i32 720909, metadata !57, metadata !"_IO_read_end", metadata !58, i32 278, i64 64, i64 64, i64 128, i32 0, metadata !62} ; [ DW_TAG_member ]
!65 = metadata !{i32 720909, metadata !57, metadata !"_IO_read_base", metadata !58, i32 279, i64 64, i64 64, i64 192, i32 0, metadata !62} ; [ DW_TAG_member ]
!66 = metadata !{i32 720909, metadata !57, metadata !"_IO_write_base", metadata !58, i32 280, i64 64, i64 64, i64 256, i32 0, metadata !62} ; [ DW_TAG_member ]
!67 = metadata !{i32 720909, metadata !57, metadata !"_IO_write_ptr", metadata !58, i32 281, i64 64, i64 64, i64 320, i32 0, metadata !62} ; [ DW_TAG_member ]
!68 = metadata !{i32 720909, metadata !57, metadata !"_IO_write_end", metadata !58, i32 282, i64 64, i64 64, i64 384, i32 0, metadata !62} ; [ DW_TAG_member ]
!69 = metadata !{i32 720909, metadata !57, metadata !"_IO_buf_base", metadata !58, i32 283, i64 64, i64 64, i64 448, i32 0, metadata !62} ; [ DW_TAG_member ]
!70 = metadata !{i32 720909, metadata !57, metadata !"_IO_buf_end", metadata !58, i32 284, i64 64, i64 64, i64 512, i32 0, metadata !62} ; [ DW_TAG_member ]
!71 = metadata !{i32 720909, metadata !57, metadata !"_IO_save_base", metadata !58, i32 286, i64 64, i64 64, i64 576, i32 0, metadata !62} ; [ DW_TAG_member ]
!72 = metadata !{i32 720909, metadata !57, metadata !"_IO_backup_base", metadata !58, i32 287, i64 64, i64 64, i64 640, i32 0, metadata !62} ; [ DW_TAG_member ]
!73 = metadata !{i32 720909, metadata !57, metadata !"_IO_save_end", metadata !58, i32 288, i64 64, i64 64, i64 704, i32 0, metadata !62} ; [ DW_TAG_member ]
!74 = metadata !{i32 720909, metadata !57, metadata !"_markers", metadata !58, i32 290, i64 64, i64 64, i64 768, i32 0, metadata !75} ; [ DW_TAG_member ]
!75 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !76} ; [ DW_TAG_pointer_type ]
!76 = metadata !{i32 720915, null, metadata !"_IO_marker", metadata !58, i32 186, i64 192, i64 64, i32 0, i32 0, i32 0, metadata !77, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!77 = metadata !{metadata !78, metadata !79, metadata !81}
!78 = metadata !{i32 720909, metadata !76, metadata !"_next", metadata !58, i32 187, i64 64, i64 64, i64 0, i32 0, metadata !75} ; [ DW_TAG_member ]
!79 = metadata !{i32 720909, metadata !76, metadata !"_sbuf", metadata !58, i32 188, i64 64, i64 64, i64 64, i32 0, metadata !80} ; [ DW_TAG_member ]
!80 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !57} ; [ DW_TAG_pointer_type ]
!81 = metadata !{i32 720909, metadata !76, metadata !"_pos", metadata !58, i32 192, i64 32, i64 32, i64 128, i32 0, metadata !14} ; [ DW_TAG_member ]
!82 = metadata !{i32 720909, metadata !57, metadata !"_chain", metadata !58, i32 292, i64 64, i64 64, i64 832, i32 0, metadata !80} ; [ DW_TAG_member ]
!83 = metadata !{i32 720909, metadata !57, metadata !"_fileno", metadata !58, i32 294, i64 32, i64 32, i64 896, i32 0, metadata !14} ; [ DW_TAG_member ]
!84 = metadata !{i32 720909, metadata !57, metadata !"_flags2", metadata !58, i32 298, i64 32, i64 32, i64 928, i32 0, metadata !14} ; [ DW_TAG_member ]
!85 = metadata !{i32 720909, metadata !57, metadata !"_old_offset", metadata !58, i32 300, i64 64, i64 64, i64 960, i32 0, metadata !86} ; [ DW_TAG_member ]
!86 = metadata !{i32 720918, null, metadata !"__off_t", metadata !58, i32 141, i64 0, i64 0, i64 0, i32 0, metadata !87} ; [ DW_TAG_typedef ]
!87 = metadata !{i32 720932, null, metadata !"long int", null, i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ]
!88 = metadata !{i32 720909, metadata !57, metadata !"_cur_column", metadata !58, i32 304, i64 16, i64 16, i64 1024, i32 0, metadata !89} ; [ DW_TAG_member ]
!89 = metadata !{i32 720932, null, metadata !"unsigned short", null, i32 0, i64 16, i64 16, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ]
!90 = metadata !{i32 720909, metadata !57, metadata !"_vtable_offset", metadata !58, i32 305, i64 8, i64 8, i64 1040, i32 0, metadata !91} ; [ DW_TAG_member ]
!91 = metadata !{i32 720932, null, metadata !"signed char", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ]
!92 = metadata !{i32 720909, metadata !57, metadata !"_shortbuf", metadata !58, i32 306, i64 8, i64 8, i64 1048, i32 0, metadata !93} ; [ DW_TAG_member ]
!93 = metadata !{i32 720897, null, metadata !"", null, i32 0, i64 8, i64 8, i32 0, i32 0, metadata !63, metadata !94, i32 0, i32 0} ; [ DW_TAG_array_type ]
!94 = metadata !{metadata !95}
!95 = metadata !{i32 720929, i64 0, i64 0}        ; [ DW_TAG_subrange_type ]
!96 = metadata !{i32 720909, metadata !57, metadata !"_lock", metadata !58, i32 310, i64 64, i64 64, i64 1088, i32 0, metadata !22} ; [ DW_TAG_member ]
!97 = metadata !{i32 720909, metadata !57, metadata !"_offset", metadata !58, i32 319, i64 64, i64 64, i64 1152, i32 0, metadata !98} ; [ DW_TAG_member ]
!98 = metadata !{i32 720918, null, metadata !"__off64_t", metadata !58, i32 142, i64 0, i64 0, i64 0, i32 0, metadata !87} ; [ DW_TAG_typedef ]
!99 = metadata !{i32 720909, metadata !57, metadata !"__pad1", metadata !58, i32 328, i64 64, i64 64, i64 1216, i32 0, metadata !22} ; [ DW_TAG_member ]
!100 = metadata !{i32 720909, metadata !57, metadata !"__pad2", metadata !58, i32 329, i64 64, i64 64, i64 1280, i32 0, metadata !22} ; [ DW_TAG_member ]
!101 = metadata !{i32 720909, metadata !57, metadata !"__pad3", metadata !58, i32 330, i64 64, i64 64, i64 1344, i32 0, metadata !22} ; [ DW_TAG_member ]
!102 = metadata !{i32 720909, metadata !57, metadata !"__pad4", metadata !58, i32 331, i64 64, i64 64, i64 1408, i32 0, metadata !22} ; [ DW_TAG_member ]
!103 = metadata !{i32 720909, metadata !57, metadata !"__pad5", metadata !58, i32 332, i64 64, i64 64, i64 1472, i32 0, metadata !104} ; [ DW_TAG_member ]
!104 = metadata !{i32 720918, null, metadata !"size_t", metadata !58, i32 35, i64 0, i64 0, i64 0, i32 0, metadata !105} ; [ DW_TAG_typedef ]
!105 = metadata !{i32 720932, null, metadata !"long unsigned int", null, i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ]
!106 = metadata !{i32 720909, metadata !57, metadata !"_mode", metadata !58, i32 334, i64 32, i64 32, i64 1536, i32 0, metadata !14} ; [ DW_TAG_member ]
!107 = metadata !{i32 720909, metadata !57, metadata !"_unused2", metadata !58, i32 336, i64 160, i64 8, i64 1568, i32 0, metadata !108} ; [ DW_TAG_member ]
!108 = metadata !{i32 720897, null, metadata !"", null, i32 0, i64 160, i64 8, i32 0, i32 0, metadata !63, metadata !109, i32 0, i32 0} ; [ DW_TAG_array_type ]
!109 = metadata !{metadata !110}
!110 = metadata !{i32 720929, i64 0, i64 19}      ; [ DW_TAG_subrange_type ]
!111 = metadata !{i32 721153, metadata !19, metadata !"Args", metadata !11, i32 16777294, metadata !22, i32 0, i32 0} ; [ DW_TAG_arg_variable ]
!112 = metadata !{i32 78, i32 25, metadata !19, null}
!113 = metadata !{i32 721152, metadata !114, metadata !"info", metadata !11, i32 79, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!114 = metadata !{i32 720907, metadata !19, i32 78, i32 31, metadata !11, i32 0} ; [ DW_TAG_lexical_block ]
!115 = metadata !{i32 79, i32 24, metadata !114, null}
!116 = metadata !{i32 721152, metadata !114, metadata !"i", metadata !11, i32 80, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!117 = metadata !{i32 80, i32 13, metadata !114, null}
!118 = metadata !{i32 80, i32 16, metadata !114, null}
!119 = metadata !{i32 82, i32 3, metadata !114, null}
!120 = metadata !{i32 83, i32 3, metadata !114, null}
!121 = metadata !{i32 84, i32 3, metadata !114, null}
!122 = metadata !{i32 87, i32 3, metadata !114, null}
!123 = metadata !{i32 88, i32 3, metadata !114, null}
!124 = metadata !{i32 89, i32 5, metadata !125, null}
!125 = metadata !{i32 720907, metadata !114, i32 88, i32 13, metadata !11, i32 1} ; [ DW_TAG_lexical_block ]
!126 = metadata !{i32 91, i32 5, metadata !125, null}
!127 = metadata !{i32 92, i32 5, metadata !125, null}
!128 = metadata !{i32 95, i32 5, metadata !125, null}
!129 = metadata !{i32 96, i32 5, metadata !125, null}
!130 = metadata !{i32 97, i32 5, metadata !125, null}
!131 = metadata !{i32 98, i32 3, metadata !125, null}
!132 = metadata !{i32 100, i32 1, metadata !114, null}
!133 = metadata !{i32 721153, metadata !36, metadata !"period", metadata !11, i32 16777249, metadata !39, i32 0, i32 0} ; [ DW_TAG_arg_variable ]
!134 = metadata !{i32 33, i32 40, metadata !36, null}
!135 = metadata !{i32 721153, metadata !36, metadata !"info", metadata !11, i32 33554465, metadata !33, i32 0, i32 0} ; [ DW_TAG_arg_variable ]
!136 = metadata !{i32 33, i32 70, metadata !36, null}
!137 = metadata !{i32 721152, metadata !138, metadata !"ret", metadata !11, i32 35, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!138 = metadata !{i32 720907, metadata !36, i32 34, i32 1, metadata !11, i32 15} ; [ DW_TAG_lexical_block ]
!139 = metadata !{i32 35, i32 6, metadata !138, null}
!140 = metadata !{i32 721152, metadata !138, metadata !"ns", metadata !11, i32 36, metadata !39, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!141 = metadata !{i32 36, i32 15, metadata !138, null}
!142 = metadata !{i32 721152, metadata !138, metadata !"sec", metadata !11, i32 37, metadata !39, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!143 = metadata !{i32 37, i32 15, metadata !138, null}
!144 = metadata !{i32 721152, metadata !138, metadata !"fd", metadata !11, i32 38, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!145 = metadata !{i32 38, i32 6, metadata !138, null}
!146 = metadata !{i32 721152, metadata !138, metadata !"itval", metadata !11, i32 39, metadata !147, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!147 = metadata !{i32 720915, null, metadata !"itimerspec", metadata !148, i32 161, i64 256, i64 64, i32 0, i32 0, i32 0, metadata !149, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!148 = metadata !{i32 720937, metadata !"/usr/include/time.h", metadata !"/home/kula85/Research/delay-thread/testCacheMissTool", null} ; [ DW_TAG_file_type ]
!149 = metadata !{metadata !150, metadata !156}
!150 = metadata !{i32 720909, metadata !147, metadata !"it_interval", metadata !148, i32 163, i64 128, i64 64, i64 0, i32 0, metadata !151} ; [ DW_TAG_member ]
!151 = metadata !{i32 720915, null, metadata !"timespec", metadata !148, i32 120, i64 128, i64 64, i32 0, i32 0, i32 0, metadata !152, i32 0, i32 0} ; [ DW_TAG_structure_type ]
!152 = metadata !{metadata !153, metadata !155}
!153 = metadata !{i32 720909, metadata !151, metadata !"tv_sec", metadata !148, i32 122, i64 64, i64 64, i64 0, i32 0, metadata !154} ; [ DW_TAG_member ]
!154 = metadata !{i32 720918, null, metadata !"__time_t", metadata !148, i32 149, i64 0, i64 0, i64 0, i32 0, metadata !87} ; [ DW_TAG_typedef ]
!155 = metadata !{i32 720909, metadata !151, metadata !"tv_nsec", metadata !148, i32 123, i64 64, i64 64, i64 64, i32 0, metadata !87} ; [ DW_TAG_member ]
!156 = metadata !{i32 720909, metadata !147, metadata !"it_value", metadata !148, i32 164, i64 128, i64 64, i64 128, i32 0, metadata !151} ; [ DW_TAG_member ]
!157 = metadata !{i32 39, i32 20, metadata !138, null}
!158 = metadata !{i32 42, i32 7, metadata !138, null}
!159 = metadata !{i32 43, i32 2, metadata !138, null}
!160 = metadata !{i32 44, i32 2, metadata !138, null}
!161 = metadata !{i32 45, i32 2, metadata !138, null}
!162 = metadata !{i32 46, i32 3, metadata !138, null}
!163 = metadata !{i32 49, i32 2, metadata !138, null}
!164 = metadata !{i32 50, i32 2, metadata !138, null}
!165 = metadata !{i32 51, i32 2, metadata !138, null}
!166 = metadata !{i32 52, i32 2, metadata !138, null}
!167 = metadata !{i32 53, i32 2, metadata !138, null}
!168 = metadata !{i32 54, i32 2, metadata !138, null}
!169 = metadata !{i32 55, i32 8, metadata !138, null}
!170 = metadata !{i32 56, i32 2, metadata !138, null}
!171 = metadata !{i32 57, i32 1, metadata !138, null}
!172 = metadata !{i32 721153, metadata !30, metadata !"info", metadata !11, i32 16777275, metadata !33, i32 0, i32 0} ; [ DW_TAG_arg_variable ]
!173 = metadata !{i32 59, i32 48, metadata !30, null}
!174 = metadata !{i32 721152, metadata !175, metadata !"missed", metadata !11, i32 61, metadata !16, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!175 = metadata !{i32 720907, metadata !30, i32 60, i32 1, metadata !11, i32 13} ; [ DW_TAG_lexical_block ]
!176 = metadata !{i32 61, i32 21, metadata !175, null}
!177 = metadata !{i32 721152, metadata !175, metadata !"ret", metadata !11, i32 62, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!178 = metadata !{i32 62, i32 6, metadata !175, null}
!179 = metadata !{i32 66, i32 8, metadata !175, null}
!180 = metadata !{i32 67, i32 2, metadata !175, null}
!181 = metadata !{i32 69, i32 3, metadata !182, null}
!182 = metadata !{i32 720907, metadata !175, i32 68, i32 2, metadata !11, i32 14} ; [ DW_TAG_lexical_block ]
!183 = metadata !{i32 70, i32 3, metadata !182, null}
!184 = metadata !{i32 74, i32 2, metadata !175, null}
!185 = metadata !{i32 75, i32 3, metadata !175, null}
!186 = metadata !{i32 76, i32 1, metadata !175, null}
!187 = metadata !{i32 721152, metadata !188, metadata !"i", metadata !11, i32 103, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!188 = metadata !{i32 720907, metadata !25, i32 102, i32 12, metadata !11, i32 2} ; [ DW_TAG_lexical_block ]
!189 = metadata !{i32 103, i32 7, metadata !188, null}
!190 = metadata !{i32 721152, metadata !188, metadata !"j", metadata !11, i32 103, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!191 = metadata !{i32 103, i32 9, metadata !188, null}
!192 = metadata !{i32 721152, metadata !188, metadata !"numInt", metadata !11, i32 104, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!193 = metadata !{i32 104, i32 7, metadata !188, null}
!194 = metadata !{i32 721152, metadata !188, metadata !"numCachelineUsed", metadata !11, i32 105, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!195 = metadata !{i32 105, i32 7, metadata !188, null}
!196 = metadata !{i32 721152, metadata !188, metadata !"a", metadata !11, i32 106, metadata !197, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!197 = metadata !{i32 720911, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !14} ; [ DW_TAG_pointer_type ]
!198 = metadata !{i32 106, i32 8, metadata !188, null}
!199 = metadata !{i32 108, i32 3, metadata !188, null}
!200 = metadata !{i32 110, i32 3, metadata !188, null}
!201 = metadata !{i32 112, i32 14, metadata !188, null}
!202 = metadata !{i32 721152, metadata !188, metadata !"attr", metadata !11, i32 114, metadata !203, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!203 = metadata !{i32 720918, null, metadata !"pthread_attr_t", metadata !11, i32 57, i64 0, i64 0, i64 0, i32 0, metadata !204} ; [ DW_TAG_typedef ]
!204 = metadata !{i32 720919, null, metadata !"", metadata !205, i32 53, i64 448, i64 64, i64 0, i32 0, i32 0, metadata !206, i32 0, i32 0} ; [ DW_TAG_union_type ]
!205 = metadata !{i32 720937, metadata !"/usr/include/bits/pthreadtypes.h", metadata !"/home/kula85/Research/delay-thread/testCacheMissTool", null} ; [ DW_TAG_file_type ]
!206 = metadata !{metadata !207, metadata !211}
!207 = metadata !{i32 720909, metadata !204, metadata !"__size", metadata !205, i32 55, i64 448, i64 8, i64 0, i32 0, metadata !208} ; [ DW_TAG_member ]
!208 = metadata !{i32 720897, null, metadata !"", null, i32 0, i64 448, i64 8, i32 0, i32 0, metadata !63, metadata !209, i32 0, i32 0} ; [ DW_TAG_array_type ]
!209 = metadata !{metadata !210}
!210 = metadata !{i32 720929, i64 0, i64 55}      ; [ DW_TAG_subrange_type ]
!211 = metadata !{i32 720909, metadata !204, metadata !"__align", metadata !205, i32 56, i64 64, i64 64, i64 0, i32 0, metadata !87} ; [ DW_TAG_member ]
!212 = metadata !{i32 114, i32 18, metadata !188, null}
!213 = metadata !{i32 721152, metadata !188, metadata !"Thread", metadata !11, i32 115, metadata !214, i32 0, i32 0} ; [ DW_TAG_auto_variable ]
!214 = metadata !{i32 720918, null, metadata !"pthread_t", metadata !11, i32 50, i64 0, i64 0, i64 0, i32 0, metadata !105} ; [ DW_TAG_typedef ]
!215 = metadata !{i32 115, i32 13, metadata !188, null}
!216 = metadata !{i32 117, i32 3, metadata !188, null}
!217 = metadata !{i32 118, i32 3, metadata !188, null}
!218 = metadata !{i32 120, i32 3, metadata !188, null}
!219 = metadata !{i32 123, i32 7, metadata !220, null}
!220 = metadata !{i32 720907, metadata !188, i32 123, i32 3, metadata !11, i32 3} ; [ DW_TAG_lexical_block ]
!221 = metadata !{i32 124, i32 9, metadata !222, null}
!222 = metadata !{i32 720907, metadata !220, i32 124, i32 5, metadata !11, i32 4} ; [ DW_TAG_lexical_block ]
!223 = metadata !{i32 125, i32 7, metadata !224, null}
!224 = metadata !{i32 720907, metadata !222, i32 124, i32 40, metadata !11, i32 5} ; [ DW_TAG_lexical_block ]
!225 = metadata !{i32 126, i32 5, metadata !224, null}
!226 = metadata !{i32 124, i32 35, metadata !222, null}
!227 = metadata !{i32 126, i32 5, metadata !222, null}
!228 = metadata !{i32 123, i32 18, metadata !220, null}
!229 = metadata !{i32 129, i32 7, metadata !230, null}
!230 = metadata !{i32 720907, metadata !188, i32 129, i32 3, metadata !11, i32 6} ; [ DW_TAG_lexical_block ]
!231 = metadata !{i32 130, i32 6, metadata !230, null}
!232 = metadata !{i32 129, i32 20, metadata !230, null}
!233 = metadata !{i32 133, i32 7, metadata !234, null}
!234 = metadata !{i32 720907, metadata !188, i32 133, i32 3, metadata !11, i32 7} ; [ DW_TAG_lexical_block ]
!235 = metadata !{i32 134, i32 9, metadata !236, null}
!236 = metadata !{i32 720907, metadata !234, i32 134, i32 5, metadata !11, i32 8} ; [ DW_TAG_lexical_block ]
!237 = metadata !{i32 135, i32 8, metadata !236, null}
!238 = metadata !{i32 134, i32 35, metadata !236, null}
!239 = metadata !{i32 135, i32 17, metadata !236, null}
!240 = metadata !{i32 133, i32 18, metadata !234, null}
!241 = metadata !{i32 138, i32 7, metadata !242, null}
!242 = metadata !{i32 720907, metadata !188, i32 138, i32 3, metadata !11, i32 9} ; [ DW_TAG_lexical_block ]
!243 = metadata !{i32 139, i32 6, metadata !242, null}
!244 = metadata !{i32 138, i32 20, metadata !242, null}
!245 = metadata !{i32 142, i32 7, metadata !246, null}
!246 = metadata !{i32 720907, metadata !188, i32 142, i32 3, metadata !11, i32 10} ; [ DW_TAG_lexical_block ]
!247 = metadata !{i32 143, i32 9, metadata !248, null}
!248 = metadata !{i32 720907, metadata !246, i32 143, i32 5, metadata !11, i32 11} ; [ DW_TAG_lexical_block ]
!249 = metadata !{i32 144, i32 8, metadata !248, null}
!250 = metadata !{i32 143, i32 35, metadata !248, null}
!251 = metadata !{i32 144, i32 17, metadata !248, null}
!252 = metadata !{i32 142, i32 18, metadata !246, null}
!253 = metadata !{i32 147, i32 7, metadata !254, null}
!254 = metadata !{i32 720907, metadata !188, i32 147, i32 3, metadata !11, i32 12} ; [ DW_TAG_lexical_block ]
!255 = metadata !{i32 148, i32 6, metadata !254, null}
!256 = metadata !{i32 147, i32 20, metadata !254, null}
!257 = metadata !{i32 150, i32 3, metadata !188, null}
!258 = metadata !{i32 152, i32 3, metadata !188, null}
