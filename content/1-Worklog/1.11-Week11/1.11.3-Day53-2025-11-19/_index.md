---
title: "Day 53 - Functions on LMI"
weight: 3
chapter: false
pre: "<b> 1.11.3. </b>"
---

**Date:** 2025-11-19 (Wednesday)  
**Status:** "Planned"  

---

# Creating and Publishing Functions

Create functions as usual, but bind them to a capacity provider and publish a version to launch instances.

## Supported Features

- Packaging: ZIP or OCI
- Runtimes: Java, Python, Node, .NET
- Layers, extensions, function URLs, response streaming, durable functions
- 15-minute timeout (longer via durable functions)

## Resource Settings

- Memory/CPU shapes influence instance type selection
- Multi-concurrency per instance available; plan for throughput vs. cost
- Multiple functions can share one capacity provider (shared pool)

## Workflow

1) Create capacity provider (VPC, role, instance rules)
2) Create function with provider ARN
3) Publish version to trigger instance provisioning and deploy execution environments
