data "ibm_resource_group" "default" {
  name = "default"
}

resource "ibm_resource_instance" "secret_manager" {
  name              = "demo-secret-manager-1234abc"
  service           = "secrets-manager"
  plan              = "lite"
  location          = var.region
  resource_group_id = data.ibm_resource_group.default.id
  tags              = ["env:demo"]
}

resource "ibm_iam_service_id" "secret_manager_engine" {
  name        = "ServiceId-secret-manager-engine"
  description = "Service ID for Secret Manager IAM Credential Engine."
}

resource "ibm_iam_access_group" "secret_manager_engine" {
  name        = "SecretManagerEngine"
  description = "IAM Access Group to allow Secret Engine to issue IAM token."
}

resource "ibm_iam_access_group_members" "secret_manager_engine" {
  access_group_id = ibm_iam_access_group.secret_manager_engine.id
  iam_service_ids = [ibm_iam_service_id.secret_manager_engine.id]
}

resource "ibm_iam_access_group_policy" "iam_groups_editor" {
  access_group_id = ibm_iam_access_group.secret_manager_engine.id
  roles = ["Editor"]
  resources {
    service = "iam-groups"
  }
}

resource "ibm_iam_access_group_policy" "iam_identity_operator" {
  access_group_id = ibm_iam_access_group.secret_manager_engine.id
  roles = ["Operator"]
  resources {
    service = "iam-identity"
  }
}
