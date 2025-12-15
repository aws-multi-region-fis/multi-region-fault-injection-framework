# Help Guide for Running FIS Experiments  
  
This guide explains how to deploy the multi‑region FIS testing framework and run a Fault Injection Simulator (FIS) experiment.  
  
## Prerequisites  
  
- AWS CLI installed and configured with credentials that have permission to deploy resources and run FIS experiments.  
- Terraform installed (version 1.0 or later).  
- Bash shell available for running scripts.  
  
## Deploying the Infrastructure  
  
1. Clone this repository.  
2. Navigate to the `terraform` directory.  
3. Initialize Terraform.  
4. Apply the Terraform configuration, supplying values for `primary_region`, `secondary_region` and `fis_role`.  
  
Example commands:  
  
```
git clone https://github.com/aws-multi-region-fis/multi-region-fault-injection-framework.git
cd multi-region-fault-injection-framework/terraform
terraform init
terraform apply -var="primary_region=us-east-1" -var="secondary_region=us-west-2" -var="fis_role=arn:aws:iam::<account-id>:role/FISRole"
```  
  
Terraform will deploy Lambda functions across regions, create API Gateway endpoints and set up FIS experiment templates. After it completes, Terraform outputs useful identifiers such as Lambda names.  
  
## Running an FIS Experiment  
  
After deploying the infrastructure, you can trigger a chaos test using the helper script:  
  
```
./scripts/invoke-tests.sh <experiment-id>
```  
  
Replace `<experiment-id>` with the ID of the FIS experiment you want to run. You can find experiment IDs in the AWS console under **Fault Injection Simulator**. The script will:  
  
- Invoke the API endpoint to verify baseline health.  
- Start the specified FIS experiment using the AWS CLI.  
  
## Choosing an Experiment  
  
The `fis` directory includes several example experiment templates:  
  
- `lambda-failure.json` – Deletes a Lambda function to simulate a failure.  
- `api-latency.json` – Injects latency into the API endpoint.  
- `az-outage.json` – Simulates an availability zone outage in the primary region.  
- `region-isolation.json` – Simulates network isolation of an entire region.  
  
You can create FIS experiments from these templates either in the AWS console or via the AWS CLI. After an experiment is created, pass its ID to the helper script to execute the test. 
