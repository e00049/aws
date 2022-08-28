
aws ec2 run-instances \
--image-id ami-04505e74c0741db8d \
--instance-type t2.micro \
--subnet-id subnet-09b6329eb1352c570 \
--security-group-ids sg-0f50181260f7efd67 \
--key-name e00049-DevOps-Tools-Key


aws ec2 describe-instances  \
    --filters Name=instance-state-code,Values=16

aws ec2 create-tags \
    --resources i-0dccf6fddde67da2c --tags Key=Name,Value=Day34InstanceCLI

aws ec2 describe-instances  \
   --filters Name=instance-state-name,Values=running


aws ec2 terminate-instances --instance-ids i-0ebca3b6a6a3dbedd
-------------------------------------------------------------------------------------------

aws ec2 describe-instances \
     --filters Name=instance-state-name,Values=terminated --max-items=1


aws ec2 describe-instances \
     --filters Name=instance-type,Values=t2.micro

--------------------------------------------------------------------------------------------

aws ec2 create-vpc --cidr-block 192.168.1.0/24 --query Vpc.VpcId --output text

vpc-01c4ff6d93fec2475

aws ec2 create-subnet --vpc-id vpc-01c4ff6d93fec2475 --cidr-block 192.168.1.0/26


aws ec2 create-internet-gateway --query InternetGateway.InternetGatewayId --output text

igw-06ed87419f7986e56


aws ec2 attach-internet-gateway --vpc-id vpc-01c4ff6d93fec2475 --internet-gateway-id igw-06ed87419f7986e56


aws ec2 create-route-table --vpc-id vpc-01c4ff6d93fec2475 --query RouteTable.RouteTableId --output text

rtb-05faa0e7b024440df

aws ec2 create-route --route-table-id rtb-05faa0e7b024440df --destination-cidr-block 0.0.0.0/0 --gateway-id igw-06ed87419f7986e56

aws ec2 describe-route-tables --route-table-id rtb-05faa0e7b024440df


aws ec2 describe-subnets --filters "Name=vpc-id,Values=vpc-01c4ff6d93fec2475" --query "Subnets[*].{ID:SubnetId,CIDR:CidrBlock}"

aws ec2 associate-route-table  --subnet-id subnet-077dde6fb21e817d4 --route-table-id rtb-05faa0e7b024440df


aws ec2 modify-subnet-attribute --subnet-id subnet-077dde6fb21e817d4  --map-public-ip-on-launch


aws ec2 create-security-group --group-name SSHAccess --description "Security group for SSH access" --vpc-id vpc-01c4ff6d93fec2475

sg-09dddc57559a8f34a

aws ec2 authorize-security-group-ingress --group-id sg-09dddc57559a8f34a --protocol tcp --port 22 --cidr 0.0.0.0/0


aws ec2 run-instances \
--image-id ami-04505e74c0741db8d \
--count 1 \
--instance-type t2.micro \
--key-name e00049-DevOps-Tools-Key \
--security-group-ids sg-09dddc57559a8f34a \
--subnet-id subnet-077dde6fb21e817d4

aws ec2 describe-instances --instance-id i-0dccf6fddde67da2c --query "Reservations[*].Instances[*].{State:State.Name,Address:PublicIpAddress}"

--------------------------------------------------------------------------------------------------------------------------------------

Deleting Resources

aws ec2 terminate-instances --instance-ids i-0dccf6fddde67da2c

aws ec2 delete-security-group --group-id sg-09dddc57559a8f34a

aws ec2 delete-subnet --subnet-id subnet-077dde6fb21e817d4


aws ec2 delete-route-table --route-table-id rtb-05faa0e7b024440df

aws ec2 detach-internet-gateway --internet-gateway-id igw-1ff7a07b --vpc-id vpc-2f09a348


aws ec2 detach-internet-gateway --internet-gateway-id igw-06ed87419f7986e56 --vpc-id vpc-01c4ff6d93fec2475


aws ec2 delete-internet-gateway --internet-gateway-id igw-06ed87419f7986e56

aws ec2 delete-vpc --vpc-id vpc-01c4ff6d93fec2475
---------------------------------------------------------------------------------------------------------------------------------------------------
