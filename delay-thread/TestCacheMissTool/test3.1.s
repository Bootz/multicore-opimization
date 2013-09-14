; ModuleID = 'test3.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__dt_currentposition = type { [256 x i8], i32, i32 }
%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.itimerspec = type { %struct.timespec, %struct.timespec }
%struct.timespec = type { i64, i64 }
%union.pthread_attr_t = type { i64, [48 x i8] }
%union.PAPI_option_t = type { %struct._papi_addr_range_option, [232 x i8] }
%struct._papi_addr_range_option = type { i32, i8*, i8*, i32, i32 }
%struct._papi_inherit_option = type { i32, i32 }

@events = global [3 x i32] [i32 -2147483589, i32 -2147483642, i32 -2147483641], align 4
@eventnum = global i32 3, align 4
@tempvalues = common global [3 x i64] zeroinitializer, align 16
@__dt_pos = external global %struct.__dt_currentposition
@__dt_curfilename = internal global [8 x i8] c"nihaoya\00", align 1
@eventset = common global i32 0, align 4
@values = common global [3 x i64] zeroinitializer, align 16
@gnuplotfile = common global %struct._IO_FILE* null, align 8
@.str = private unnamed_addr constant [25 x i8] c"%lld\09%lld\09%lld\09%s\09%u\09%u\0A\00", align 1
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
@__loopcounter0 = internal global i32 0, align 4
@__loopcounter1 = internal global i32 0, align 4
@__loopcounter2 = internal global i32 0, align 4
@__loopcounter3 = internal global i32 0, align 4
@__loopcounter4 = internal global i32 0, align 4
@__loopcounter5 = internal global i32 0, align 4
@__loopcounter6 = internal global i32 0, align 4
@__loopcounter7 = internal global i32 0, align 4
@__loopcounter8 = internal global i32 0, align 4
@str = internal unnamed_addr constant [29 x i8] c"Can't initiate PAPI library!\00"
@str16 = internal unnamed_addr constant [19 x i8] c"Can't thread init!\00"
@str17 = internal unnamed_addr constant [23 x i8] c"Can't create eventset!\00"
@str18 = internal unnamed_addr constant [30 x i8] c"Can't assign_event_component!\00"
@str19 = internal unnamed_addr constant [19 x i8] c"Can't set inherit!\00"
@__loopcounter9 = internal global i32 0, align 4

define noalias i8* @PapiKernel(i8* nocapture %Args) noreturn nounwind uwtable {
entry:
  %missed.i = alloca i64, align 8
  %itval.i = alloca %struct.itimerspec, align 8
  store i64 0, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i64 0, i64 0), align 16, !tbaa !0
  store i64 0, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i64 0, i64 1), align 8, !tbaa !0
  store i64 0, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i64 0, i64 2), align 16, !tbaa !0
  %call = call i8* @strcpy(i8* getelementptr inbounds (%struct.__dt_currentposition* @__dt_pos, i64 0, i32 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @__dt_curfilename, i64 0, i64 0)) nounwind
  %0 = bitcast %struct.itimerspec* %itval.i to i8*
  call void @llvm.lifetime.start(i64 -1, i8* %0) nounwind
  %call.i = call i32 @timerfd_create(i32 1, i32 0) nounwind
  %cmp.i = icmp eq i32 %call.i, -1
  br i1 %cmp.i, label %while.body.preheader, label %if.end.i

if.end.i:                                         ; preds = %entry
  %tv_sec.i = getelementptr inbounds %struct.itimerspec* %itval.i, i64 0, i32 0, i32 0
  store i64 0, i64* %tv_sec.i, align 8, !tbaa !3
  %tv_nsec.i = getelementptr inbounds %struct.itimerspec* %itval.i, i64 0, i32 0, i32 1
  store i64 10000000, i64* %tv_nsec.i, align 8, !tbaa !3
  %tv_sec5.i = getelementptr inbounds %struct.itimerspec* %itval.i, i64 0, i32 1, i32 0
  store i64 0, i64* %tv_sec5.i, align 8, !tbaa !3
  %tv_nsec8.i = getelementptr inbounds %struct.itimerspec* %itval.i, i64 0, i32 1, i32 1
  store i64 10000000, i64* %tv_nsec8.i, align 8, !tbaa !3
  %call9.i = call i32 @timerfd_settime(i32 %call.i, i32 0, %struct.itimerspec* %itval.i, %struct.itimerspec* null) nounwind
  br label %while.body.preheader

while.body.preheader:                             ; preds = %entry, %if.end.i
  %1 = bitcast i64* %missed.i to i8*
  br label %while.body

while.body:                                       ; preds = %while.body, %if.then.i, %while.body.preheader
  %i.0 = phi i64 [ 0, %while.body.preheader ], [ %add, %if.then.i ], [ %add, %while.body ]
  %add = add nsw i64 %i.0, 10
  %2 = load i32* @eventset, align 4, !tbaa !4
  %call2 = call i32 @PAPI_read(i32 %2, i64* getelementptr inbounds ([3 x i64]* @values, i64 0, i64 0)) nounwind
  %3 = load %struct._IO_FILE** @gnuplotfile, align 8, !tbaa !5
  %4 = load i64* getelementptr inbounds ([3 x i64]* @values, i64 0, i64 1), align 8, !tbaa !0
  %5 = load i64* getelementptr inbounds ([3 x i64]* @tempvalues, i64 0, i64 1), align 8, !tbaa !0
  %sub = sub nsw i64 %4, %5
  %6 = load i64* getelementptr inbounds ([3 x i64]* @values, i64 0, i64 2), align 16, !tbaa !0
  %7 = load i64* getelementptr inbounds ([3 x i64]* @tempvalues, i64 0, i64 2), align 16, !tbaa !0
  %sub3 = sub nsw i64 %6, %7
  %8 = load i32* getelementptr inbounds (%struct.__dt_currentposition* @__dt_pos, i64 0, i32 1), align 4, !tbaa !4
  %9 = load i32* getelementptr inbounds (%struct.__dt_currentposition* @__dt_pos, i64 0, i32 2), align 4, !tbaa !4
  %call4 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %3, i8* getelementptr inbounds ([25 x i8]* @.str, i64 0, i64 0), i64 %add, i64 %sub, i64 %sub3, i8* getelementptr inbounds (%struct.__dt_currentposition* @__dt_pos, i64 0, i32 0, i64 0), i32 %8, i32 %9) nounwind
  %call5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @__dt_curfilename, i64 0, i64 0)) nounwind
  %10 = load i64* getelementptr inbounds ([3 x i64]* @values, i64 0, i64 1), align 8, !tbaa !0
  store i64 %10, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i64 0, i64 1), align 8, !tbaa !0
  %11 = load i64* getelementptr inbounds ([3 x i64]* @values, i64 0, i64 2), align 16, !tbaa !0
  store i64 %11, i64* getelementptr inbounds ([3 x i64]* @tempvalues, i64 0, i64 2), align 16, !tbaa !0
  call void @llvm.lifetime.start(i64 -1, i8* %1) nounwind
  %call.i7 = call i64 @read(i32 %call.i, i8* %1, i64 8) nounwind
  %conv.i = trunc i64 %call.i7 to i32
  %cmp.i8 = icmp eq i32 %conv.i, -1
  br i1 %cmp.i8, label %if.then.i, label %while.body

if.then.i:                                        ; preds = %while.body
  call void @perror(i8* getelementptr inbounds ([11 x i8]* @.str15, i64 0, i64 0)) nounwind
  br label %while.body
}

declare i8* @strcpy(i8*, i8* nocapture) nounwind

declare i32 @PAPI_read(i32, i64*)

declare i32 @fprintf(%struct._IO_FILE* nocapture, i8* nocapture, ...) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind

define i32 @test() nounwind uwtable {
entry:
  %attr = alloca %union.pthread_attr_t, align 8
  %Thread = alloca i64, align 8
  %call = call noalias i8* @malloc(i64 8388608) nounwind
  %0 = bitcast i8* %call to i32*
  %call1 = call i32 @pthread_attr_init(%union.pthread_attr_t* %attr) nounwind
  %call2 = call i32 @pthread_attr_setdetachstate(%union.pthread_attr_t* %attr, i32 0) nounwind
  %call3 = call i32 @pthread_create(i64* %Thread, %union.pthread_attr_t* %attr, i8* (i8*)* @PapiKernel, i8* null) nounwind
  %__loopcounter7.promoted108 = load i32* @__loopcounter7, align 4
  %__loopcounter8.promoted110 = load i32* @__loopcounter8, align 4
  %1 = add i32 %__loopcounter7.promoted108, 2097152
  br label %for.cond5.preheader

for.cond5.preheader:                              ; preds = %for.inc11, %entry
  %indvars.iv152 = phi i64 [ 0, %entry ], [ %indvars.iv.next153, %for.inc11 ]
  br label %for.body8

for.cond14.preheader:                             ; preds = %for.inc11
  %2 = add i32 %__loopcounter8.promoted110, 2097168
  store i32 %2, i32* @__loopcounter8, align 4
  store i32 %1, i32* @__loopcounter7, align 4
  %__loopcounter6.promoted = load i32* @__loopcounter6, align 4
  br label %for.body17

for.body8:                                        ; preds = %for.body8, %for.cond5.preheader
  %indvars.iv145 = phi i64 [ 0, %for.cond5.preheader ], [ %indvars.iv.next146, %for.body8 ]
  %3 = shl i64 %indvars.iv145, 4
  %4 = add nsw i64 %3, %indvars.iv152
  %arrayidx = getelementptr inbounds i32* %0, i64 %4
  %5 = load i32* %arrayidx, align 4, !tbaa !4
  %inc = add nsw i32 %5, 1
  store i32 %inc, i32* %arrayidx, align 4, !tbaa !4
  %indvars.iv.next146 = add i64 %indvars.iv145, 1
  %lftr.wideiv149 = trunc i64 %indvars.iv.next146 to i32
  %exitcond150 = icmp eq i32 %lftr.wideiv149, 131072
  br i1 %exitcond150, label %for.inc11, label %for.body8

for.inc11:                                        ; preds = %for.body8
  %indvars.iv.next153 = add i64 %indvars.iv152, 1
  %lftr.wideiv154 = trunc i64 %indvars.iv.next153 to i32
  %exitcond155 = icmp eq i32 %lftr.wideiv154, 16
  br i1 %exitcond155, label %for.cond14.preheader, label %for.cond5.preheader

for.cond24.preheader:                             ; preds = %for.body17
  %6 = add i32 %__loopcounter6.promoted, 2097152
  store i32 %6, i32* @__loopcounter6, align 4
  %__loopcounter4.promoted98 = load i32* @__loopcounter4, align 4
  %__loopcounter5.promoted100 = load i32* @__loopcounter5, align 4
  %7 = add i32 %__loopcounter4.promoted98, 2097152
  br label %for.cond28.preheader

for.body17:                                       ; preds = %for.body17, %for.cond14.preheader
  %indvars.iv140 = phi i64 [ 0, %for.cond14.preheader ], [ %indvars.iv.next141, %for.body17 ]
  %arrayidx19 = getelementptr inbounds i32* %0, i64 %indvars.iv140
  %8 = load i32* %arrayidx19, align 4, !tbaa !4
  %inc20 = add nsw i32 %8, 1
  store i32 %inc20, i32* %arrayidx19, align 4, !tbaa !4
  %indvars.iv.next141 = add i64 %indvars.iv140, 1
  %lftr.wideiv142 = trunc i64 %indvars.iv.next141 to i32
  %exitcond143 = icmp eq i32 %lftr.wideiv142, 2097152
  br i1 %exitcond143, label %for.cond24.preheader, label %for.body17

for.cond28.preheader:                             ; preds = %for.inc40, %for.cond24.preheader
  %indvars.iv136 = phi i64 [ 0, %for.cond24.preheader ], [ %indvars.iv.next137, %for.inc40 ]
  br label %for.body31

for.cond43.preheader:                             ; preds = %for.inc40
  %9 = add i32 %__loopcounter5.promoted100, 2097168
  store i32 %9, i32* @__loopcounter5, align 4
  store i32 %7, i32* @__loopcounter4, align 4
  %__loopcounter3.promoted = load i32* @__loopcounter3, align 4
  br label %for.body46

for.body31:                                       ; preds = %for.body31, %for.cond28.preheader
  %indvars.iv129 = phi i64 [ 0, %for.cond28.preheader ], [ %indvars.iv.next130, %for.body31 ]
  %10 = shl i64 %indvars.iv129, 4
  %11 = add nsw i64 %10, %indvars.iv136
  %arrayidx35 = getelementptr inbounds i32* %0, i64 %11
  %12 = load i32* %arrayidx35, align 4, !tbaa !4
  %inc36 = add nsw i32 %12, 1
  store i32 %inc36, i32* %arrayidx35, align 4, !tbaa !4
  %indvars.iv.next130 = add i64 %indvars.iv129, 1
  %lftr.wideiv133 = trunc i64 %indvars.iv.next130 to i32
  %exitcond134 = icmp eq i32 %lftr.wideiv133, 131072
  br i1 %exitcond134, label %for.inc40, label %for.body31

for.inc40:                                        ; preds = %for.body31
  %indvars.iv.next137 = add i64 %indvars.iv136, 1
  %lftr.wideiv138 = trunc i64 %indvars.iv.next137 to i32
  %exitcond139 = icmp eq i32 %lftr.wideiv138, 16
  br i1 %exitcond139, label %for.cond43.preheader, label %for.cond28.preheader

for.cond53.preheader:                             ; preds = %for.body46
  %13 = add i32 %__loopcounter3.promoted, 2097152
  store i32 %13, i32* @__loopcounter3, align 4
  %__loopcounter1.promoted88 = load i32* @__loopcounter1, align 4
  %__loopcounter2.promoted90 = load i32* @__loopcounter2, align 4
  %14 = add i32 %__loopcounter1.promoted88, 2097152
  br label %for.cond57.preheader

for.body46:                                       ; preds = %for.body46, %for.cond43.preheader
  %indvars.iv124 = phi i64 [ 0, %for.cond43.preheader ], [ %indvars.iv.next125, %for.body46 ]
  %arrayidx48 = getelementptr inbounds i32* %0, i64 %indvars.iv124
  %15 = load i32* %arrayidx48, align 4, !tbaa !4
  %inc49 = add nsw i32 %15, 1
  store i32 %inc49, i32* %arrayidx48, align 4, !tbaa !4
  %indvars.iv.next125 = add i64 %indvars.iv124, 1
  %lftr.wideiv126 = trunc i64 %indvars.iv.next125 to i32
  %exitcond127 = icmp eq i32 %lftr.wideiv126, 2097152
  br i1 %exitcond127, label %for.cond53.preheader, label %for.body46

for.cond57.preheader:                             ; preds = %for.inc69, %for.cond53.preheader
  %indvars.iv120 = phi i64 [ 0, %for.cond53.preheader ], [ %indvars.iv.next121, %for.inc69 ]
  br label %for.body60

for.cond72.preheader:                             ; preds = %for.inc69
  %16 = add i32 %__loopcounter2.promoted90, 2097168
  store i32 %16, i32* @__loopcounter2, align 4
  store i32 %14, i32* @__loopcounter1, align 4
  %__loopcounter0.promoted = load i32* @__loopcounter0, align 4
  br label %for.body75

for.body60:                                       ; preds = %for.body60, %for.cond57.preheader
  %indvars.iv113 = phi i64 [ 0, %for.cond57.preheader ], [ %indvars.iv.next114, %for.body60 ]
  %17 = shl i64 %indvars.iv113, 4
  %18 = add nsw i64 %17, %indvars.iv120
  %arrayidx64 = getelementptr inbounds i32* %0, i64 %18
  %19 = load i32* %arrayidx64, align 4, !tbaa !4
  %inc65 = add nsw i32 %19, 1
  store i32 %inc65, i32* %arrayidx64, align 4, !tbaa !4
  %indvars.iv.next114 = add i64 %indvars.iv113, 1
  %lftr.wideiv117 = trunc i64 %indvars.iv.next114 to i32
  %exitcond118 = icmp eq i32 %lftr.wideiv117, 131072
  br i1 %exitcond118, label %for.inc69, label %for.body60

for.inc69:                                        ; preds = %for.body60
  %indvars.iv.next121 = add i64 %indvars.iv120, 1
  %lftr.wideiv122 = trunc i64 %indvars.iv.next121 to i32
  %exitcond123 = icmp eq i32 %lftr.wideiv122, 16
  br i1 %exitcond123, label %for.cond72.preheader, label %for.cond57.preheader

for.body75:                                       ; preds = %for.body75, %for.cond72.preheader
  %indvars.iv = phi i64 [ 0, %for.cond72.preheader ], [ %indvars.iv.next, %for.body75 ]
  %arrayidx77 = getelementptr inbounds i32* %0, i64 %indvars.iv
  %20 = load i32* %arrayidx77, align 4, !tbaa !4
  %inc78 = add nsw i32 %20, 1
  store i32 %inc78, i32* %arrayidx77, align 4, !tbaa !4
  %indvars.iv.next = add i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, 2097152
  br i1 %exitcond, label %for.end81, label %for.body75

for.end81:                                        ; preds = %for.body75
  %21 = add i32 %__loopcounter0.promoted, 2097152
  store i32 %21, i32* @__loopcounter0, align 4
  %22 = load i64* %Thread, align 8, !tbaa !3
  %call82 = call i32 @pthread_cancel(i64 %22) nounwind
  ret i32 0
}

declare noalias i8* @malloc(i64) nounwind

declare i32 @pthread_attr_init(%union.pthread_attr_t*) nounwind

declare i32 @pthread_attr_setdetachstate(%union.pthread_attr_t*, i32) nounwind

declare i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) nounwind

declare i32 @pthread_cancel(i64)

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind uwtable {
entry:
  %eventcode = alloca i32, align 4
  %opt = alloca %union.PAPI_option_t, align 8
  %call = call i32 @PAPI_library_init(i32 67239936) nounwind
  %cmp = icmp eq i32 %call, 67239936
  br i1 %cmp, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  %puts = call i32 @puts(i8* getelementptr inbounds ([29 x i8]* @str, i64 0, i64 0))
  call void @exit(i32 -1) noreturn nounwind
  unreachable

if.end:                                           ; preds = %entry
  %call3 = call i32 @PAPI_thread_init(i64 ()* @pthread_self) nounwind
  %cmp4 = icmp eq i32 %call3, 0
  br i1 %cmp4, label %if.end7, label %if.then5

if.then5:                                         ; preds = %if.end
  %puts44 = call i32 @puts(i8* getelementptr inbounds ([19 x i8]* @str16, i64 0, i64 0))
  call void @exit(i32 -1) noreturn nounwind
  unreachable

if.end7:                                          ; preds = %if.end
  store i32 -1, i32* @eventset, align 4, !tbaa !4
  %call8 = call i32 @PAPI_create_eventset(i32* @eventset) nounwind
  %cmp9 = icmp eq i32 %call8, 0
  br i1 %cmp9, label %if.end12, label %if.then10

if.then10:                                        ; preds = %if.end7
  %puts45 = call i32 @puts(i8* getelementptr inbounds ([23 x i8]* @str17, i64 0, i64 0))
  call void @exit(i32 -3) noreturn nounwind
  unreachable

if.end12:                                         ; preds = %if.end7
  %0 = load i32* @eventset, align 4, !tbaa !4
  %call13 = call i32 @PAPI_assign_eventset_component(i32 %0, i32 0) nounwind
  %cmp14 = icmp eq i32 %call13, 0
  br i1 %cmp14, label %if.end17, label %if.then15

if.then15:                                        ; preds = %if.end12
  %puts46 = call i32 @puts(i8* getelementptr inbounds ([30 x i8]* @str18, i64 0, i64 0))
  call void @exit(i32 -3) noreturn nounwind
  unreachable

if.end17:                                         ; preds = %if.end12
  %1 = bitcast %union.PAPI_option_t* %opt to i8*
  call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 264, i32 8, i1 false)
  %inherit = bitcast %union.PAPI_option_t* %opt to %struct._papi_inherit_option*
  %inherit18 = getelementptr inbounds %struct._papi_inherit_option* %inherit, i64 0, i32 1
  store i32 1, i32* %inherit18, align 4, !tbaa !4
  %2 = load i32* @eventset, align 4, !tbaa !4
  %eventset = getelementptr inbounds %union.PAPI_option_t* %opt, i64 0, i32 0, i32 0
  store i32 %2, i32* %eventset, align 8, !tbaa !4
  %call20 = call i32 @PAPI_set_opt(i32 28, %union.PAPI_option_t* %opt) nounwind
  %cmp21 = icmp eq i32 %call20, 0
  br i1 %cmp21, label %if.end24, label %if.then22

if.then22:                                        ; preds = %if.end17
  %puts47 = call i32 @puts(i8* getelementptr inbounds ([19 x i8]* @str19, i64 0, i64 0))
  call void @exit(i32 -3) noreturn nounwind
  unreachable

if.end24:                                         ; preds = %if.end17
  %call25 = call i32 @PAPI_event_name_to_code(i8* getelementptr inbounds ([31 x i8]* @.str6, i64 0, i64 0), i32* %eventcode) nounwind
  %3 = load i32* %eventcode, align 4, !tbaa !4
  store i32 %3, i32* getelementptr inbounds ([3 x i32]* @events, i64 0, i64 1), align 4, !tbaa !4
  %call26 = call i32 @PAPI_event_name_to_code(i8* getelementptr inbounds ([26 x i8]* @.str7, i64 0, i64 0), i32* %eventcode) nounwind
  %4 = load i32* %eventcode, align 4, !tbaa !4
  store i32 %4, i32* getelementptr inbounds ([3 x i32]* @events, i64 0, i64 2), align 4, !tbaa !4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end24
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.inc ], [ 0, %if.end24 ]
  %5 = trunc i64 %indvars.iv to i32
  %cmp27 = icmp slt i32 %5, 3
  br i1 %cmp27, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %6 = load i32* @__loopcounter9, align 4
  %7 = add nsw i32 %6, 1
  store i32 %7, i32* @__loopcounter9, align 4
  %8 = load i32* @eventset, align 4, !tbaa !4
  %arrayidx = getelementptr inbounds [3 x i32]* @events, i64 0, i64 %indvars.iv
  %9 = load i32* %arrayidx, align 4, !tbaa !4
  %call28 = call i32 @PAPI_add_event(i32 %8, i32 %9) nounwind
  %cmp29 = icmp eq i32 %call28, 0
  br i1 %cmp29, label %for.inc, label %if.then30

if.then30:                                        ; preds = %for.body
  %call31 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str8, i64 0, i64 0), i32 %call28) nounwind
  call void @exit(i32 -4) noreturn nounwind
  unreachable

for.inc:                                          ; preds = %for.body
  %indvars.iv.next = add i64 %indvars.iv, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %call33 = call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([14 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str10, i64 0, i64 0)) nounwind
  store %struct._IO_FILE* %call33, %struct._IO_FILE** @gnuplotfile, align 8, !tbaa !5
  %call34 = call i64 @PAPI_get_real_usec() nounwind
  %10 = load i32* @eventset, align 4, !tbaa !4
  %call35 = call i32 @PAPI_start(i32 %10) nounwind
  %call36 = call i32 @test()
  %11 = load i32* @eventset, align 4, !tbaa !4
  %call37 = call i32 @PAPI_stop(i32 %11, i64* getelementptr inbounds ([3 x i64]* @values, i64 0, i64 0)) nounwind
  %call38 = call i64 @PAPI_get_real_usec() nounwind
  %12 = load %struct._IO_FILE** @gnuplotfile, align 8, !tbaa !5
  %call39 = call i32 @fclose(%struct._IO_FILE* %12) nounwind
  %sub = sub nsw i64 %call38, %call34
  %call40 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([27 x i8]* @.str11, i64 0, i64 0), i64 %sub) nounwind
  %13 = load i64* getelementptr inbounds ([3 x i64]* @values, i64 0, i64 0), align 16, !tbaa !0
  %call41 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str12, i64 0, i64 0), i64 %13) nounwind
  %14 = load i64* getelementptr inbounds ([3 x i64]* @values, i64 0, i64 1), align 8, !tbaa !0
  %call42 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([37 x i8]* @.str13, i64 0, i64 0), i64 %14) nounwind
  %15 = load i64* getelementptr inbounds ([3 x i64]* @values, i64 0, i64 2), align 16, !tbaa !0
  %call43 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([32 x i8]* @.str14, i64 0, i64 0), i64 %15) nounwind
  ret i32 0
}

declare i32 @PAPI_library_init(i32)

declare void @exit(i32) noreturn nounwind

declare i32 @PAPI_thread_init(i64 ()*)

declare i64 @pthread_self() nounwind readnone

declare i32 @PAPI_create_eventset(i32*)

declare i32 @PAPI_assign_eventset_component(i32, i32)

declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) nounwind

declare i32 @PAPI_set_opt(i32, %union.PAPI_option_t*)

declare i32 @PAPI_event_name_to_code(i8*, i32*)

declare i32 @PAPI_add_event(i32, i32)

declare noalias %struct._IO_FILE* @fopen(i8* nocapture, i8* nocapture) nounwind

declare i64 @PAPI_get_real_usec()

declare i32 @PAPI_start(i32)

declare i32 @PAPI_stop(i32, i64*)

declare i32 @fclose(%struct._IO_FILE* nocapture) nounwind

declare i64 @read(i32, i8* nocapture, i64)

declare void @perror(i8* nocapture) nounwind

declare i32 @timerfd_create(i32, i32) nounwind

declare i32 @timerfd_settime(i32, i32, %struct.itimerspec*, %struct.itimerspec*) nounwind

declare void @llvm.lifetime.start(i64, i8* nocapture) nounwind

declare i32 @puts(i8* nocapture) nounwind

!0 = metadata !{metadata !"long long", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
!3 = metadata !{metadata !"long", metadata !1}
!4 = metadata !{metadata !"int", metadata !1}
!5 = metadata !{metadata !"any pointer", metadata !1}
