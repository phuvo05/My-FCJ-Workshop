---
title: "Day 59 - SageMaker AI Platform"
weight: 4
chapter: false
pre: "<b> 1.12.4. </b>"
---

**Date:** 2025-11-27 (Thursday)  
**Status:** "Planned"  

---

# Serverless & Resilient Training

- SageMaker AI serverless MLflow for quick experimentation (zero infra, auto scale)
- HyperPod training adds checkpointless recovery and elastic scaling based on resource availability

## Benefits

- Faster experiment cycles without cluster setup
- Reduced failure recovery overhead; better utilization of heterogeneous capacity

## Action Items

- Set up a small MLflow serverless workspace for current experiments
- Test checkpointless/elastic training on a representative model; note cost/time deltas
- Update MLOps playbook to include new training modes and failure handling
