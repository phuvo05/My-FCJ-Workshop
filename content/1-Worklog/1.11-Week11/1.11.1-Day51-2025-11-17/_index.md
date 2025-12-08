---
title: "Day 51 - Lambda Managed Instances Overview"
weight: 1
chapter: false
pre: "<b> 1.11.1. </b>"
---

**Date:** 2025-11-17 (Monday)  
**Status:** "Planned"  

---

# Why Lambda Managed Instances

LMI keeps the Lambda dev model while letting you pick EC2 instance families and pricing (SP/RI), remove cold starts, and allow multi-concurrency per instance.

## When to Use

- Steady, high-traffic workloads needing predictable cost
- Specialized compute/memory/network requirements
- Desire to apply EC2 pricing instruments to Lambda functions

## When to Stay on Default Lambda

- Spiky/unpredictable traffic
- Short, infrequent invocations where scale-to-zero is key

## Benefits Snapshot

- Same Lambda packaging/runtimes
- No cold starts; predictable capacity
- Cost control via EC2 constructs (savings plans, reserved instances)

## Notes from re:Invent CNS382

- Instances are AWS-managed: you can see but not SSH/edit
- Lifecycle, patching, routing handled by Lambda
- Multi-concurrency option changes price/perf profile
