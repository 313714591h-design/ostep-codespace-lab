]633;E;for i in 1 2 3 4 5 6 7 8;43b99d88-0734-4880-a99d-8b1150e36f27]633;C## Q1
- Prediction / 预测:
PID0 runs 5 CPU instructions, then PID1 runs 5 CPU instructions. Total time = 10 ticks, CPU utilization = 100%.
- Reasoning / 理由:
The default policy SWITCH_ON_END switches CPU only when a process completes. Both processes are CPU-only, no I/O, so CPU is always busy.
- Verified result / 验证结果:
Total time = 10 ticks, CPU utilization = 100%.
- Analysis / 分析:
Simulation matches prediction exactly. Processes run sequentially without preemption, no idle CPU cycles.

## Q2
- Prediction / 预测:
Process 1 will run all 5 CPU instructions first, then Process 2 runs all 5 CPU instructions. Total time will be 10 ticks, CPU utilization is 100%.
- Reasoning / 理由:
Policy SWITCH_ON_END only switches when a process finishes. No I/O in either workload, so processes run one after another sequentially. CPU never idle.
- Verified result / 验证结果:
Total time = 10 ticks, CPU utilization = 100%.
- Analysis / 分析:
Simulation matches prediction. SWITCH_ON_END does not preempt running processes. Processes run sequentially, no idle CPU cycles

## Q3
- Prediction / 预测:
- Reasoning / 理由:
- Verified result / 验证结果:
- Analysis / 分析:

## Q4
- Prediction / 预测:
- Reasoning / 理由:
- Verified result / 验证结果:
- Analysis / 分析:

## Q5
- Prediction / 预测:
- Reasoning / 理由:
- Verified result / 验证结果:
- Analysis / 分析:

## Q6
- Prediction / 预测:
- Reasoning / 理由:
- Verified result / 验证结果:
- Analysis / 分析:

## Q7
- Prediction / 预测:
- Reasoning / 理由:
- Verified result / 验证结果:
- Analysis / 分析:

## Q8
- Prediction / 预测:
- Reasoning / 理由:
- Verified result / 验证结果:
- Analysis / 分析:

