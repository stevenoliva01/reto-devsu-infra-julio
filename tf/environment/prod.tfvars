tenant_id       = "2a77e6f8-f1b5-4096-baf9-731e98e98b12"
client_id       = "7e111990-435e-4b2d-8611-9c29f9589a76"
subscription_id = "6c26738b-b5d9-4cb1-985e-51558f10f375"
location            = "East US"

#ResourceGroup
resource_group_name = "Devsu"
tags={Environment="dev"}

#virtualNetwork & subnetwork
virtual_network_name = "vnet01-prod"
virtual_network_address = ["10.0.0.0/16"]  
sub_network_name = "subnet01-prod"
sub_network_address = ["10.0.1.0/24"] 
network_interface_name ="nic01-prod"

#publicIp
public_ip_name = "ip01-prod"

#NetworkSecurityGroup
network_security_group_name="nsg01-prod"

#virtual_machine
virtual_machine_name ="vm01-prod"
virtual_machine_size="Standard D2s v3"
virtual_machine_admin="azureuser" 

#AKS
aks_location = "East US 2"
cluster_aks_name="aks01-prod"
cluster_aks_node_count="2"

#APIM
api_management_name="apim01-prod"
api_management_publisher_name="devsu"
api_management_publisher_email="steven_oner@hotmail.com"