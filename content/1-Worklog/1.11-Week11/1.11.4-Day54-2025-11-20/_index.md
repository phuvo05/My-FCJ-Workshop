---
title: "Day 54 - Networking & Observability"
weight: 4
chapter: false
pre: "<b> 1.11.4. </b>"
---

**Date:** 2025-11-20 (Thursday)  
**Status:** "Planned"  

---

# Traffic Paths and Logging

All traffic from LMI functions egresses through the instance ENI in the provider VPC; plan connectivity and monitoring accordingly.

## Egress & Destinations

- Dependency access must route from provider VPC (NAT/Transit/VPC peering/PrivateLink)
- CloudWatch logs also traverse the instance ENI; allow path to endpoint (public or PrivateLink)

## Security Groups

- No inbound needed; keep SG inbound closed
- Outbound rules must cover dependencies + CloudWatch

## Observability

- CloudWatch logging remains native; ensure endpoint reachability
- Monitor instance metrics (EC2 billing, vCPU usage) + Lambda metrics (invokes, errors)

## Gotchas

- Function-level VPC settings are ignored for LMI
- Instance-level limits (bandwidth/ENI) still apply; size instances accordingly
