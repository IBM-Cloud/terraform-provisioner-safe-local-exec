package main

import (
	exec "github.com/IBM-Cloud/terraform-provisioner-safe-local-exec/exec"
	"github.com/hashicorp/terraform/plugin"
	"github.com/hashicorp/terraform/terraform"
)

func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProvisionerFunc: func() terraform.ResourceProvisioner {
			return exec.Provisioner()
		},
	})
}
