# Terraform : Infrastructure as code
Using terraform to create infrastrucutre on AWS using code. In this code, we are trying to create a below items:

1. VPC with cidr range 10.1.0.0/16

2. Public subnet associated with VPC with cidr range 10.1.0.0/24

3. Internet gateway associated with VPC

4. Routing table which is associated with VPC

5. Basic security group which let traffic come from port 80

6. EC2 instance which is created inside public subnet

Using terraform we are able to make a immutable infrastructure which can be destroyed and created using single command.

Commands used:

./terraform init : Initialize a Terraform working directory

./terraform plan : Generate and show an execution plan

./terraform apply : Builds or changes infrastructure

./terraform destroy : Destroy Terraform-managed infrastructure
