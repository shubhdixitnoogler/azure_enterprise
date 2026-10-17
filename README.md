# 🚀 Azure Enterprise Infrastructure as Code (Terraform)

An enterprise-grade, modular Terraform framework for provisioning and managing secure virtual machine infrastructure across multiple environments (`dev` and `prod`) on Microsoft Azure.

---

## 📌 Architecture Overview

```text
                               ┌─────────────────────────────────────────────────────────────┐
                               │                    Azure Resource Group                     │
                               │                                                             │
                               │   ┌─────────────────────────────────────────────────────┐   │
                               │   │                   Virtual Network                   │   │
                               │   │                                                     │   │
                               │   │   ┌───────────────────────┐   ┌─────────────────┐   │   │
                               │   │   │     snet-vm-dev       │   │AzureBastionSubnet│  │   │
                               │   │   │  (NSG: SSH/HTTP/HTTPS)│   │   (Bastion Host)│   │   │
                               │   │   │           │           │   │        │        │   │
                               │   │   │     ┌─────┴─────┐     │   │  ┌─────┴─────┐  │   │
                               │   │   │     │  VM (NIC) │     │   │  │  Bastion  │  │   │
                               │   │   │     └─────┬─────┘     │   │  └─────┬─────┘  │   │
                               │   │   └───────────┼───────────┘   └────────┼────────┘   │   │
                               │   └───────────────┼────────────────────────┼────────────┘   │
                               │                   │                        │                │
                               │             ┌─────┴──────┐           ┌─────┴──────┐         │
                               │             │ Public IP  │           │ Public IP  │         │
                               │             │  (Dev VM)  │           │  (Bastion) │         │
                               │             └────────────┘           └────────────┘         │
                               │                                                             │
                               │   ┌───────────────────────┐   ┌─────────────────────────┐   │
                               │   │    Azure Key Vault    │   │     Storage Account     │   │
                               │   │ (Admin Secret Mgmt)   │   │   (Boot Diagnostics)    │   │
                               │   └───────────────────────┘   └─────────────────────────┘   │
                               └─────────────────────────────────────────────────────────────┘
```

---

## 📂 Repository Structure

The repository implements a **multi-environment modular architecture**:

```text
azure_enterprise/
├── .gitignore
├── README.md
│
├── env/
│   ├── dev/                          # Development Environment
│   │   ├── main.tf                   # Dev orchestration (Public IP, SSH enabled)
│   │   ├── variables.tf              # Input variable definitions
│   │   ├── terraform.tfvars          # Dev variable overrides
│   │   ├── outputs.tf                # IP addresses, SSH command, Key Vault URL
│   │   ├── provider.tf               # Azure provider block
│   │   └── versions.tf               # Terraform & provider constraints (~> 4.0)
│   │
│   └── prod/                         # Production Environment
│       ├── main.tf                   # Prod orchestration (Private-only, Azure Bastion)
│       ├── variables.tf              # Prod variable definitions
│       ├── terraform.tfvars          # Prod variable overrides
│       ├── outputs.tf                # Private IPs, Bastion FQDN, Key Vault URI
│       ├── provider.tf               # Azure provider with resource protection
│       └── versions.tf
│
└── module/                           # 10 Reusable Terraform Modules
    ├── resource_group/               # Azure Resource Group provisioning
    ├── vnet/                         # Virtual Network with custom address space
    ├── subnet/                       # VM subnet & optional AzureBastionSubnet
    ├── nsg/                          # Network Security Group & firewall rules
    ├── public_ip/                    # Standard SKU static public IPs
    ├── nic/                          # Network Interface Card with subnet/pip bindings
    ├── storage_account/              # Diagnostics & blob storage (TLS 1.2, LRS/GRS)
    ├── key_vault/                    # Azure Key Vault for secret management
    ├── vm/                           # Ubuntu Linux VM with boot diagnostics & SSH/password
    └── bastion/                      # Azure Bastion Host for zero-trust private access
```

---

## 🧩 Modules Reference

| Module | Description | Key Inputs | Key Outputs |
| :--- | :--- | :--- | :--- |
| **`resource_group`** | Creates and tags the resource group | `resource_group_name`, `location`, `tags` | `id`, `name`, `location` |
| **`vnet`** | Configures the virtual network | `virtual_network_name`, `address_space` | `id`, `name`, `address_space` |
| **`subnet`** | Manages VM and Bastion subnets | `vm_subnet_prefixes`, `enable_bastion_subnet` | `vm_subnet_id`, `bastion_subnet_id` |
| **`nsg`** | Firewall rules (SSH 22, HTTP 80, HTTPS 443) | `allow_ssh`, `allow_http`, `allow_https`, `subnet_id` | `id`, `name` |
| **`public_ip`** | Static Standard SKU public IP | `public_ip_name`, `allocation_method`, `sku` | `id`, `ip_address`, `name` |
| **`nic`** | Connects VM to subnet & public IP | `subnet_id`, `public_ip_id`, `network_interface_name` | `id`, `private_ip_address`, `name` |
| **`storage_account`** | Stores VM boot diagnostics & serial logs | `storage_account_name`, `account_replication_type` | `id`, `name`, `primary_blob_endpoint` |
| **`key_vault`** | Secrets store for VM credentials | `key_vault_name`, `admin_password`, `sku_name` | `id`, `vault_uri`, `secret_id` |
| **`vm`** | Ubuntu 22.04 LTS Linux Virtual Machine | `vm_name`, `vm_size`, `network_interface_id`, `os_disk_type` | `id`, `name`, `private_ip_address` |
| **`bastion`** | Managed PaaS jumpbox for private SSH/RDP | `bastion_name`, `subnet_id`, `public_ip_id`, `sku` | `id`, `dns_name` |

---

## 🔐 Security & Governance

1. **Secret Management with Azure Key Vault**:
   - VM administrator passwords are saved as secrets in **Azure Key Vault** rather than exposed in state plain text or configuration files.
2. **Environment Separation (`dev` vs `prod`)**:
   - **`dev`**: Configured with a Public IP and Port 22 SSH access for development and testing.
   - **`prod`**: **No public IP on the VM**. Access is restricted strictly through **Azure Bastion** over TLS, eliminating external attack surfaces.
3. **Boot Diagnostics**:
   - Dedicated storage account attached to inspect serial logs and console screenshots if the instance fails to boot.
4. **Network Segmentation**:
   - Strict CIDR subnet allocation with automated NSG association.

---

## 🛠️ Prerequisites

- **Terraform** >= `1.7.0`
- **Azure CLI (`az`)** >= `2.60.0`
- An active **Azure Subscription**

---

## 🚀 Deployment Guide

### 1. Authenticate with Azure CLI

```powershell
az login
```

If your account belongs to multiple tenants:
```powershell
az login --tenant <TENANT_ID>
```

Set your active subscription:
```powershell
az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"
```

---

### 2. Deploy Development (`env/dev`)

Navigate to the development directory:
```powershell
cd env/dev
```

Initialize Terraform and download provider plugins:
```powershell
terraform init
```

Format and validate the configuration:
```powershell
terraform fmt
terraform validate
```

Generate and review the execution plan:
```powershell
terraform plan
```

Apply the deployment:
```powershell
terraform apply -auto-approve
```

#### Viewing Outputs
After a successful apply, Terraform prints the connection details:
- `vm_public_ip`
- `ssh_login_command` (e.g. `ssh azureuser@<public-ip>`)
- `key_vault_uri`
- `storage_account_name`

---

### 3. Deploy Production (`env/prod`)

```powershell
cd env/prod
terraform init
terraform plan
terraform apply
```

To connect to the production VM without a public IP via Azure Bastion:
```powershell
az network bastion ssh \
  --name "bas-prod" \
  --resource-group "rg-enterprise-prod-eastus" \
  --target-resource-id "<VM_RESOURCE_ID>" \
  --auth-type password \
  --username azureuser
```

---

### 4. Cleanup / Teardown

To tear down all resources and avoid ongoing Azure charges:

```powershell
terraform -chdir=env/dev destroy
terraform -chdir=env/prod destroy
```

---

## 👨‍💻 Author

**Shubh Dixit**  
GitHub: [@shubhdixitnoogler](https://github.com/shubhdixitnoogler)
