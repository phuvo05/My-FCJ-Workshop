---
title: "Week 12 - AWS re:Invent 2025 Announcements"
weight: 12
chapter: false
pre: "<b> 1.12. </b>"
---

**Week:** 2025-11-24 to 2025-11-28  
**Status:** "Planned"  

---

## Week 12 Overview

Highlights from AWS re:Invent 2025: new Nova foundation models (speech-to-speech, multimodal, cost-effective reasoning), Bedrock expansions (open-weight models, reinforcement fine-tuning), vector and AI infra updates (S3 Vectors GA), and compute launches like Graviton5 CPUs and Trainium3 UltraServers. Focus on mapping announcements to practical adoption plans.

### Key Topics

#### GenAI & Models
- Nova 2 family: Sonic (speech-to-speech), Lite (fast/cost-efficient), Omni (multimodal), Forge program for custom frontier models
- Nova Act for reliable UI agents; Bedrock AgentCore adds policy controls and quality evals
- Bedrock adds open-weight models (Mistral Large 3, Ministral 3) and reinforcement fine-tuning

#### Vector & Data
- Amazon S3 Vectors GA: up to 2B vectors/index, ~100ms queries, lower cost vs. specialty DBs
- Clean Rooms synthetic data for privacy-preserving ML collaboration

#### AI Dev Platform
- SageMaker AI serverless MLflow and new training features (checkpointless, elastic scaling)

#### Compute & Hardware
- Graviton5 CPUs for better price/perf on EC2
- Trainium3 UltraServers (3nm) for faster, cheaper training/inference

### Learning Objectives

- Identify which re:Invent AI/compute launches impact current workloads
- Plan pilot use cases for Nova models and Bedrock new capabilities
- Outline migration path to S3 Vectors for vector search storage
- Evaluate Graviton5/Trainium3 fit for cost/performance gains

---

## Daily Breakdown

| Day | Focus | Topics |
|-----|-------|--------|
| 56 | Model Announcements | Nova 2 variants (Sonic, Lite, Omni), Forge program, Nova Act agents |
| 57 | Bedrock & Agents | Open-weight additions, reinforcement fine-tuning, AgentCore policy/quality | 
| 58 | Vector & Data | S3 Vectors GA, Clean Rooms synthetic data, vector scale/cost planning |
| 59 | SageMaker Platform | Serverless MLflow, checkpointless & elastic training on HyperPod |
| 60 | Compute Launches | Graviton5 CPUs, Trainium3 UltraServers, workload fit & migration checklist |

---

## Prerequisites

- Familiarity with Bedrock model catalog and agent capabilities
- Basics of vector search architectures
- Understanding of EC2 instance families and accelerator choices

## Next Steps

- Select one pilot use case for Nova (speech, multimodal, or reasoning) and outline eval plan
- Draft migration/POC plan for S3 Vectors vs. current vector store
- Benchmark targets for Graviton5/Trainium3 against existing instances
- Define governance/policy needs before adopting AgentCore and Nova Act agents
