1. To include a terraform.tfvars file with DO key and private key

 NOTES
terraform init
terraform plan
terraform output
terraform destroy (destroy the statefile)

ssh -i opt/tmp/

tf graph | dot -Tpng > graph.png (create a pic of dependencies)
bat terraform.tfstate (to see whats in the tfstate)
tf plan 

to generate multiple copies (i.e. inbound rule), use dynamic inbound_rule 
iterator; use to change the naming (i.e. dont like each, can change to rule)

taint the resource -> means the resource mark as dirty
when type apply, will destroy and recreate that resource only
after tainting it and want to keep it, can untaint

terraform import -> to add items that existed but not in the state 

ssh -i ~/.ssh/workshop01 root@188.166.230.7 /206.189.158.127
