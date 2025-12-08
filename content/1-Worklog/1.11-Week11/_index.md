---
title: "Week 11 - Lambda Managed Instances & AWS re:Invent Learnings"
weight: 11
chapter: false
pre: "<b> 1.11. </b>"
---

**Week:** 2025-11-17 to 2025-11-21  
**Status:** "Planned"  

---

## Week 11 Overview

Content from AWS re:Invent 2025 (session CNS382) on Lambda Managed Instances (LMI): running Lambda functions on EC2 capacity with full serverless programming model, better control over compute, and reuse of EC2 pricing models. Focus on when to choose LMI vs. default Lambda, how to configure capacity providers, and how testing/ops practices change for predictable high-traffic workloads.

### Key Topics

#### Why Lambda Managed Instances
- Keep Lambda dev experience while choosing EC2 instance families and pricing constructs
- Eliminate cold starts; support multi-concurrency per instance
- Apply EC2 Savings Plans/Reserved Instances; predictability for steady traffic

#### Architecture & Setup
- Capacity Provider: VPC config, instance types (C/M/R families, x86/Graviton), scaling guardrails
- Steps: create capacity provider -> create function bound to provider -> publish version to launch instances
- LMI-managed lifecycle: AWS patches OS/runtime, handles routing/auto scaling; instances visible but immutable

#### Networking & Security
- All egress via instance ENI in provider VPC; function-level VPC config disabled
- Close inbound SG rules; ensure paths to dependencies/CloudWatch (Internet or PrivateLink)
- EBS encryption (service key or custom KMS)

#### Function Features & Scaling
- Supports ZIP/OCI packaging; Java/Python/Node/.NET runtimes; layers, extensions, function URLs, response streaming, durable functions
- Memory/CPU settings influence instance choice; optional overrides for allowed/excluded instance types
- Instance-level scaling guardrails (e.g., max vCPU) to control cost

#### Workload Fit & Trade-offs
- Use LMI for high-traffic steady workloads, specialized compute/memory/network needs
- Keep default Lambda for spiky/short, unpredictable invocations
- Multi-concurrency and EC2 billing change cost/perf envelope

### Learning Objectives

- Explain when to prefer LMI vs. default Lambda for serverless apps
- Configure capacity providers with VPC, role, and instance constraints
- Describe LMI networking model and logging path
- Map Lambda features (packaging, runtimes, URLs, streaming, durable) to LMI
- Set scaling/cost guardrails and choose instance families for workload shapes

---

## Daily Breakdown

| Day | Focus | Topics |
|-----|-------|--------|
| 51 | LMI Overview & Use Cases | Why LMI, benefits, EC2 pricing reuse, when not to use it |
| 52 | Capacity Provider Setup | VPC config, IAM operator role, instance families, KMS, guardrails |
| 53 | Functions on LMI | Packaging/runtime support, memory/CPU mapping, multi-concurrency, publishing versions |
| 54 | Networking & Observability | Egress paths, CloudWatch access, security groups, logging, monitoring notes |
| 55 | Scaling & Ops Playbook | Max vCPU, steady traffic planning, cost controls, rollout checklist |

---

## Prerequisites

- Familiarity with Lambda programming model and transformer material from prior weeks
- Basic EC2/VPC, IAM roles/policies, and CloudWatch logging
- Understanding of Savings Plans/Reserved Instances for EC2

## Next Steps

- Draft a capacity provider for your target workload (VPC, instance shortlist, guardrails)
- Plan benchmarks comparing LMI vs. default Lambda on representative traffic
- Map monitoring and logging paths (CloudWatch endpoints, PrivateLink if needed)
- Decide pricing instruments (SP/RI) and multi-concurrency targets per function
