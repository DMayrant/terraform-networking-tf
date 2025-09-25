# terraform-web-app
Here’s a architecture diagram of a VPC I deployed in us-east-1 using terraform 

There are a total of 37 AWS regions each region consist of 2-3 avialability zones (AZs)

AWS regions are located in geographical safe a resourceful locations, each region is connected via low latency networking links

There are over 200 services within the AWS cloud environment each with different functionalities. Some services are regional (global) specific while others are AZ specific. 

Global services include:

Cloud Front (CDN) 
s3 Object storage 
Global accelerator
Lambda 

These services have a regional blast radius (meaning a whole region will have to fail in order for these services to crash) 

AZ services include:

Compute Ec2
Virtual private Cloud (VPC)
Database instances 
Internet Gateway 

An AZ outage can affect these services 
Usually caused by natural disaster

This is why documentation is critical especially for disaster recovery so we can determine the root cause of analysis if anyone of these services becomes compromised this explains the s3 bucket I attached to Cloud Front

![image alt](https://github.com/DMayrant/terraform-networking-tf/blob/main/Cloud%20Architecture.jpeg?raw=true)
