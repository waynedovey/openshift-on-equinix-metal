# Openshift on Equinix Metal

This collection of modules will deploy will deploy a bare metal [OpenShift] using the assisted installer 

## Install Terraform

Terraform is just a single binary. Visit their [download page](https://www.terraform.io/downloads.html), choose your operating system, make the binary executable, and move it into your path.

Here is an example for **macOS**:

```bash
curl -LO https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_darwin_amd64.zip
unzip terraform_0.14.7_darwin_amd64.zip
chmod +x terraform
sudo mv terraform /usr/local/bin/
```

Example for **Linux**:

```bash
wget https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_amd64.zip
unzip terraform_0.14.7_linux_amd64.zip
sudo install terraform /usr/local/bin/
```

### Additional requirements

`local-exec` provisioners require the use of:

- `curl`
- `jq`

To install `jq` on **RHEL/CentOS**:

```bash
wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
sudo install jq-linux64 /usr/local/bin/jq
```

## Download this project

To download this project, run the following command:

```bash
git clone https://github.com/equinix/terraform-metal-openshift-on-baremetal.git
cd terraform-metal-openshift
```

## Usage

1. Follow [this](EQUINIX.md) to configure your Equinix Metal project and collect required parameters.

1. Follow [this](CLOUDFLARE.md) to configure your Cloudflare account and collect required parameters.

1. [Obtain an OpenShift Cluster Manager API Token](https://cloud.redhat.com/openshift/token) for pullSecret generation.

1. Configure TF_VARs applicable to your Equinix Metal project, DNS settings, and OpenShift API Token:

    ```bash
    export TF_VAR_project_id="kajs886-l59-8488-19910kj"
    export TF_VAR_auth_token="lka6702KAmVAP8957Abny01051"

    export TF_VAR_cluster_basedomain="domain.com"
    export TF_VAR_ocp_cluster_manager_token="eyJhbGc...d8Agva"
    export TF_VAR_dns_provider="cloudflare" # aws and linode are also supported
    export TF_VAR_dns_options='{"email": "abc@xyz.com", "api_key": "...", "api_token": "..."}' # fields differ by DNS provider
    ```

1. Initialize and validate terraform:

    ```bash
    terraform init -upgrade
    terraform validate
    ```

1. Provision all resources and start the installation. This process takes between 30 and 50 minutes:

    ```bash
    terraform apply -target metal_spot_market_request.bastion -target metal_spot_market_request.master0
    terraform apply -target metal_spot_market_request.bastion -target metal_spot_market_request.master0
 -target metal_spot_market_request.master1 -target metal_spot_market_request.master2
    terraform apply
    ```

---