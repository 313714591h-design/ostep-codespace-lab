## Q1
- Prediction / 预测:
```
time   PID 0   PID 1   CPU   IOs
1      RUN     REDAY   1     0
2      RUN     REDAY   1     0
3      RUN     READY   1     0
4      RUN     READY   1     0
5      RUN     REDAY   1     0
6      DONE    RUN     1     0
7      DONE    RUN     1     0
8      DONE    RUN     1     0
9      DONE    RUN     1     0
10     DONE    RUN     1     0
Toalt time=10
CPU Buys=10(100%)
IO Buys=0(0%)
```
- Reasoning / 理由: 总时间 10 ,cpu10占用率100%，io=0
- Verified result / 验证结果:
- Analysis / 分析:
## Q2
- Prediction / 预测:
```
time   PID 0   PID 1         CPU   IOs
1      RUN     REDAY         1     0
2      RUN     REDAY         1     0
3      RUN     REDAY         1     0
4      RUN     READY         1     0
5      DONE    RUN:io        1     0
6      DONE    BLOCKED       0     1
7      DONE    BLOCKED       0     1
8      DONE    BLOCKED       0     1
9      DONE    BLOCKED       0     1
10     DONE    BLOCKED       0     1
11*    DONE    RUN:io_done   1     0
Total time = 11
CPU Buys = 6 (54.55%)
IO Buys = 5（45.45%）
```
- Reasoning / 理由: 总时间 11 ,cpu6占用率54.55%,IO5占用率45.45%  
- Verified result / 验证结果:
- Analysis / 分析:

## Q3
- Prediction / 预测:
```
time   PID 0       PID 1         CPU   IOs
1      RUN:io      REDAY         1     0
2      BLOCKED     RUN           1     1
3      BLOCKED     RUN           1     1
4      BLOCKED     RUN           1     1
5      BLOCKED     RUN           1     1
6      BLOCKED     DONE          0     1
7*     RUN:io_done DONE          1     0
Total time = 7
CPU Busy = 6 (6/7)
IO Busy= 5 (5/7)
```
- Reasoning / 理由:总时间 ：7 ,cpu6占用率(85.71%),IO5占用率(71.43%)
- Verified result / 验证结果:
- Analysis / 分析:

## Q4
- Prediction / 预测 :
```
time   PID 0       PID 1         CPU   IOs
1      RUN:io      REDAY         1     0
2      BLOCKED     RUN           0     1
3      BLOCKED     RUN           0     1
4      BLOCKED     RUN           0     1
5      BLOCKED     RUN           0     1
6      BLOCKED     DONE          0     1
7*     RUN:io_done DONE          1     0
8      DONE        CPU           1     0
9      DONE        CPU           1     0
10     DONE        CPU           1     0
11     DONE        CPU           1     0
Total time=11
CPU Busy = 6(54.55%)
IO Busy= 5 (45.45%)
```
- Reasoning / 理由:总时间 ：11 ,cpu6占用率(54.55%),IO占用率(45.45%) 
- Verified result / 验证结果:
- Analysis / 分析:

## Q5
- Prediction / 预测:
```
time   PID 0        PID 1                     CPU             IOs
1      RUN:io       READY                      0               0
2      BLOCKED      RUN                        1               1
3      BLOCKED      RUN                        1               1
4      BLOCKED      RUN                        1               1
5      BLOCKED      RUN                        1               1
6      READY        RUN                        1               0
7*     READY        DONE                       0               0
Total time=7
CPU Busy =5(71.43%)
IO  Busy =4(57.14%)
```
- Reasoning / 理由:总时间：7，CPU占用率5(71.43%)，IO占用率4(57.14%)
- Verified result / 验证结果:
- Analysis / 分析:

## Q6
- Prediction / 预测:
```
time   PID 0        PID 1          PID2               PID3            CPU             IOs
1      RUN:io       READY          READY              READY            1               0
2      BLOCKED      RUN            READY              READY            1               1
3      BLOCKED      RUN            READY              READY            1               1
4      BLOCKED      RUN            READY              READY            1               1
5      BLOCKED      RUN            READY              READY            1               1
6      BLOCKED      RUN            READY              READY            1               0
7*     READY        DONE           RUN                READY            1               0
8      READY        DONE           RUN                READY            1               0
9      READY        DONE           RUN                READY            1               0
10     READY        DONE           RUN                READY            1               0
11     READY        DONE           RUN                READY            1               0
12     READY        DONE           DONE               RUN              1               0
13     READY        DONE           DONE               RUN              1               0
14     READY        DONE           DONE               RUN              1               0
15     READY        DONE           DONE               RUN              1               0 
16     READY        DONE           DONE               RUN              1               0
17     RUN:io_done  DONE           DONE               DONE             1               0
18     RUN:io       DONE           DONE               DONE             1               0
19     BLOCKED      DONE           DONE               DONE             1               1
20     BLOCKED      DONE           DONE               DONE             1               1
21     BLOCKED      DONE           DONE               DONE             1               1
22     BLOCKED      DONE           DONE               DONE             1               1
23     BLOCKED      DONE           DONE               DONE             1               1
24*    RUN:io_done  DONE           DONE               DONE             1               0
25     RUN:io       DONE           DONE               DONE             1               0
26     BLOCKED      DONE           DONE               DONE             1               1
27     BLOCKED      DONE           DONE               DONE             1               1
28     BLOCKED      DONE           DONE               DONE             1               1
29     BLOCKED      DONE           DONE               DONE             1               1
30     BLOCKED      DONE           DONE               DONE             1               1
31*    RUN:io_done  DONE           DONE               DONE             1               0
Total time=31
CPU Busy =21(67.74%)
IO  Busy =15(48.39%)
```
- Reasoning / 理由:总时间：31，CPU占用率21(67.74%)，IO占用率15(48.39%)
- Verified result / 验证结果:
- Analysis / 分析:

## Q7
- Prediction / 预测:
```
time   PID 0        PID 1          PID2               PID3            CPU             IOs
1      RUN:io       READY          READY              READY            1               
2      BLOCKED      RUN:CPU        READY              READY            1               1
3      BLOCKED      RUN:CPU        READY              READY            1               1
4      BLOCKED      RUN:CPU        READY              READY            1               1
5      BLOCKED      RUN:CPU        READY              READY            1               1
6      BLOCKED      RUN:CPU        READY              READY            1               
7*     RUN:io_DONE  DONE           READY              READY            1               
8      RUN:io       DONE           READY              READY            1               
9      BLOCKED      DONE           RUN:CPU            READY            1               1
10     BLOCKED      DONE           RUN:CPU            READY            1               1
11     BLOCKED      DONE           RUN:CPU            READY            1               1
12     BLOCKED      DONE           RUN:CPU            READY            1               1
13     BLOCKED      DONE           RUN:CPU            READY            1               1
14*    RUN:io_DONE  DONE           DONE               READY            1               
15     RUN:io       DONE           DONE               READY            1                
16     BLOCKED      DONE           DONE               RUN:CPU          1               1
17     BLOCKED      DONE           DONE               RUN:CPU          1               1
18     BLOCKED      DONE           DONE               RUN:CPU          1               1
19     BLOCKED      DONE           DONE               RUN:CPU          1               1
20     BLOCKED      DONE           DONE               RUN:CPU          1               1
21*     RUN：io_DONE DONE           DONE               DONE            1               1
Total time：21
CPU Busy =21(100%）
IO  Busy =15(71.43%)
```
- Reasoning / 理由:总时间：21，CPU占用率21（100%），Io占用率15（71.43%）
- Verified result / 验证结果:
- Analysis / 分析:

## Q8
# Seed 1
- Prediction / 预测:
```
time   PID 0        PID 1            CPU             IOs
1      RUN:CPU      READY             1               
2      RUN:io       READY             1               1
3      BLOCKED      RUN:CPU           1               1
4      BLOCKED      RUN:CPU           1               1
5      BLOCKED      RUN:CPU           1               1
6      BLOCKED      RUN:CPU           1               1
7*     RUN:io_DONE  DONE              1               
8      RUN:io       DONE              1               1
9      BLOCKED      DONE                              1
10     BLOCKED      DONE                              1
11     BLOCKED      DONE                              1
12     BLOCKED      DONE                              1
13*    RUN:io_DONE  DONE              1                
Total time：13
CPU Busy =9(69.23%）
IO  Busy =10(76.92%)
```
- Reasoning / 理由:总时间：13，CPU占用率9(69.23%)，IO占用率10(76.92%)
- Verified result / 验证结果:
- Analysis / 分析:
# Seed 2
- Prediction / 预测:
```
time   PID 0        PID 1            CPU             IOs
1      RUN:io       READY             1               
2      BLOCKED      RUN:CPU           1               1
3*     RUN:io_done  RUN:CPU           1               
4      RUN:io       RUN:CPU           1               
5      BLOCKED      RUN:CPU           1               1
6*     RUN:io_done  RUN:CPU           1               1
7      RUN:CPU      BLOCKED           1               1
8      DONE         BLOCKED                           1
9*     DONE         RUN:io_done       1               
10     DONE         RUN:io            1               
11     DONE         BLOCKED                           1
12*    DONE         RUN:io_done       1                
Total time：12
CPU Busy =11(91.67%） 
IO  Busy =6(50%)
```
- Reasoning / 理由:总时间：12，CPU占用率11(91.67%)，IO占用率6(50%)
- Verified result / 验证结果:
- Analysis / 分析:
# Seed 3
- Prediction / 预测:
```
time   PID 0        PID 1            CPU             IOs
1      RUN:CPU      READY             1               
2      RUN:io       READY             1               
3      BLOCKED      RUN:io            1               1
4*     RUN:io_done  BLOCKED           1               1 
5      RUN:CPU      RUN:io_done       1
6      DONE         RUN:io            1               
7      DONE         BLOCKED                           1
8*     DONE         RUN:io_done       1          
9      DONE         RUN:io            1               
10     DONE         BLOCKED                           1               
11*    DONE         RUN:io_done       1
12     DONE         RUN:cpu           1                
Total time：12
CPU Busy =10(83.33%） 
IO  Busy =8(66.67%)
```
- Reasoning / 理由:总时间：12，CPU占用率10(83.33%)，IO占用率8(66.67%)
- Verified result / 验证结果:
- Analysis / 分析:

