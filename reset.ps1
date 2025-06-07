$state = @(".terraform", "terraform.tfstate", "terraform.tfstate.backup", ".terraform.lock.hcl")
foreach ($file in $state) {    
        Remove-Item -Recurse -Force -Path $file -ErrorAction SilentlyContinue    
}
terraform init