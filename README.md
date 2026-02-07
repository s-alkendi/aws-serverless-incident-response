# aws-serverless-incident-response
An enterprise-grade, serverless security pipeline utilizing Amazon Rekognition and AWS Lambda for real-time automated weapon detection and autonomous incident response.

# GuardPoint AI: Serverless Visual Threat Intelligence 🛡️
![Status](https://img.shields.io/badge/Status-Production--Ready-green)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=flat&logo=amazon-aws&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.12-3776AB?style=flat&logo=python&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

## 📌 Executive Summary
**GuardPoint AI** is a cloud-native, automated security engine designed to identify physical threats in real time. By leveraging **Event-Driven Architecture (EDA)**, the system autonomously audits visual telemetry uploaded to cloud storage to detect unauthorized weaponry (knives/weapons) and initiates an immediate incident response protocol.

---

## 🏗️ Technical Architecture
The system is built on a **Serverless, Zero-Trust** framework, ensuring maximum scalability and minimal operational overhead.

<p align="center">
  <img src="src/Architecture%20Diagram.png" alt="System Architecture Diagram" width="800">
</p>

### **The Engineering Workflow:**
1.  **Ingestion Layer:** Data is securely ingested via **Amazon S3**.
2.  **Orchestration Layer:** An S3 `PutObject` event triggers an **AWS Lambda** execution environment.
3.  **Inference Layer:** **Amazon Rekognition** performs deep-learning-based object detection and label analysis.
4.  **Action Layer:** **Amazon SNS** (Simple Notification Service) disseminates high-priority incident alerts to the Security Operations Center (SOC).

---

## 📊 Proof of Concept (Validation)

### **1. Backend Execution Telemetry**
The following logs demonstrate the seamless transition from file ingestion to threat identification, with a total processing time of **< 800ms**.

<p align="center">
  <img src="src/CloudWatch%20Logs.png" alt="CloudWatch Execution Logs" width="800">
</p>
### **2. Automated Incident Notification**
The final output of the pipeline: an automated, high-priority security alert delivered to the administration.

<p align="center">
  <img src="src/Email%20Alert.png" alt="Automated Email Alert Notification" width="800">
</p>
---

## 🛡️ Security & Governance
- **IAM Least Privilege:** Dedicated execution roles with restricted access policies to ensure data sovereignty.
- **Automated Governance:** Removes the risk of human error in visual security audits.
- **Cost Optimization:** 100% pay-as-you-go model, utilizing AWS serverless pricing to reduce TCO (Total Cost of Ownership).

