## Q1
- Prediction / 预测:
PID0 runs 5 CPU instructions, then PID1 runs 5 CPU instructions. Total time = 10 ticks, CPU utilization = 100%.
- Reasoning / 理由:
The default policy SWITCH_ON_END switches CPU only when a process completes. Both processes are CPU-only, no I/O, so CPU is always busy.
- Verified result / 验证结果:
- Analysis / 分析:
## Q2
- Prediction / 预测:
Process 1 will run all 5 CPU instructions first, then Process 2 runs all 5 CPU instructions. Total time will be 10 ticks, CPU utilization is 100%.
- Reasoning / 理由:
Policy SWITCH_ON_END only switches when a process finishes. No I/O in either workload, so processes run one after another sequentially. CPU never idle.
- Verified result / 验证结果:
- Analysis / 分析:

## Q3
- Prediction / 预测:
Process 0 runs 1 IO instruction first, then Process 1 runs all 4 CPU instructions. After IO completes, Process 0 resumes. Total time will be longer than 5 ticks, CPU will idle during IO.
- Reasoning / 理由:
Policy SWITCH_ON_END will switch when IO is issued. When Process 0 issues IO, CPU switches to Process1. While waiting for IO, CPU can run other jobs, but during IO wait period there will be idle cycles if no other process ready.
- Verified result / 验证结果:
- Analysis / 分析:

## Q4
- Prediction / 预测:
When Process 0 starts I/O, SWITCH_ON_END policy will NOT switch context. CPU stays idle during I/O blocking period. After I/O finishes, Process 0 completes, then Process 1 can run. Total time will be long and CPU utilization low.
- Reasoning / 理由:
SWITCH_ON_END only switches when a process finishes completely. It will not switch out when process issues I/O. So CPU sits idle while waiting for I/O device.
- Verified result / 验证结果:
- Analysis / 分析:

## Q5
- Prediction / 预测:
When Process 0 starts I/O under SWITCH_ON_IO, the system switches to Process 1 immediately. Process 1 runs on the CPU while waiting for I/O. Total time will be shorter and CPU utilization higher than Q4
- Reasoning / 理由:
SWITCH_ON_IO triggers context switch when I/O starts. The OS uses the CPU to run another ready process during I/O waiting, overlapping computation and I/O to improve CPU usage.
- Verified result / 验证结果:
- Analysis / 分析:

## Q6
- Prediction / 预测:
When Process 0 finishes each I/O with IO_RUN_LATER, it will go to the ready queue instead of running immediately. CPU-bound processes will run first. Total runtime will be longer and I/O device utilization decreases.
- Reasoning / 理由:
IO_RUN_LATER means once I/O completes, the I/O process is placed in ready state. The scheduler picks other ready CPU-bound jobs first, so the I/O process cannot resume right away.
- Verified result / 验证结果:
- Analysis / 分析:

## Q7
- Prediction / 预测:
When Process 0’s I/O finishes under IO_RUN_IMMEDIATE, it will run on CPU immediately. The I/O device can start next I/O operation quickly. Total runtime becomes shorter and I/O device utilization improves.
- Reasoning / 理由:
IO_RUN_IMMEDIATE schedules the completed I/O process to run right after I/O finishes. It does not wait in ready queue, so the I/O process can continue and reuse I/O device faster.
- Verified result / 验证结果:
- Analysis / 分析:

## Q8
- Prediction / 预测:
Different random seeds produce different interleaving of two CPU-bound processes. Default scheduling will switch at fixed ticks. IO_RUN_IMMEDIATE and SWITCH_ON_END will change the sequence and total runtime.
- Reasoning / 理由:
The seed controls random scheduling choices. Different policies change when context switch occurs. SWITCH_ON_END only switches when a job finishes, which may change the completion order.
- Verified result / 验证结果:
- Analysis / 分析:

