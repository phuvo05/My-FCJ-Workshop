---
title: "Day 55 - Scaling & Ops Playbook"
weight: 5
chapter: false
pre: "<b> 1.11.5. </b>"
---

**Date:** 2025-11-21 (Friday)  
**Status:** "Planned"  

---

# Scaling and Cost Controls

Plan instance-level scaling and multi-concurrency to match steady traffic while capping spend.

## Scaling Guardrails

- Max vCPU per capacity provider to bound total instances
- Choose instance families per workload (compute/memory/network)
- Steady traffic: prefer larger instances with multi-concurrency; spiky: reconsider default Lambda

## Cost & Pricing

- Apply EC2 Savings Plans/Reserved Instances to LMI capacity
- Monitor utilization vs. commitments; adjust instance mix as needed

## Rollout Checklist

- Capacity provider configured with correct role/VPC/instance allowlist
- Function versions published; warm paths verified (no cold starts)
- CloudWatch access validated; alerts on errors/latency/concurrency
- Run benchmark comparing LMI vs. default Lambda for your workload
