---
title: "Day 52 - Capacity Provider Setup"
weight: 2
chapter: false
pre: "<b> 1.11.2. </b>"
---

**Date:** 2025-11-18 (Tuesday)  
**Status:** "Planned"  

---

# Building a Capacity Provider

Step 1 for LMI: define the instance layer (capacity provider) with VPC, roles, and instance choices.

## Required Inputs

- Operator IAM role so Lambda can launch/manage instances
- VPC config (subnets + SG) where LMI instances live

## Instance Selection

- Supported: latest C/M/R families (x86/AMD/Graviton), large and above
- Override: allowed/excluded types; set architecture explicitly for ARM
- EBS encryption: default service key or your KMS

## Networking Notes

- Spread subnets across 3 AZs for resilience
- All egress/logs flow through instance ENI; no function-level VPC config
- Close inbound SG rules; ensure path to dependencies/CloudWatch endpoints

## Guardrails

- Max vCPU cap to bound spend
- Additional scaling knobs available per provider
