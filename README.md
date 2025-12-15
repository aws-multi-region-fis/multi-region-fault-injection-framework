# AWS Multi-Region Fault Injection Simulator (FIS) Testing Framework
This repository provides a production-grade multi-region AWS testing framework
for validating **active-active architectures** using **AWS Fault Injection Simulator (FIS)**.

It automates:
- Multi-region Lambda + API Gateway deployment  
- Global failover testing across regions  
- Injecting controlled failures (Lambda kill, AZ outage, latency, region isolation)  
- Measuring resilience through Step Functions & CloudWatch dashboards  

---

# 1. Multi-Region Architecture

                  +------------------------+
                  | Amazon Route 53 (GSLB) |
                  +-----------+------------+
                              |
                +-------------+-------------+
                |                           |
     +----------v---------+       +----------v---------+
     |  Region A (us-east-1) |     | Region B (us-west-2) |
     +----------+---------+       +----------+---------+
                |                           |
        +-------v------+            +--------v-------+
        | API Gateway  |            | API Gateway    |
        +-------+------+            +--------+-------+
                |                           |
        +-------v------+            +--------v-------+
        | Lambda (A)   |            | Lambda (B)     |
        +--------------+            +-----------------+

Failure injection targets:
✓ Lambda kill  
✓ API latency  
✓ AZ failure  
✓ Region isolation  

---

# 2. Step Functions Orchestrator

Workflow:
1. Validate baseline health  
2. Trigger FIS experiment  
3. Monitor logs & metrics  
4. Validate automated failover  
5. Generate test summary
