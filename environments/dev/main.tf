module "vpc" {
    source  = "./modules/network/modules/vpc"
    project_id   = "smdainfra123"
    network_name = "smda-vpc"
    shared_vpc_host = false

}

module "network_subnets" {
  source  = "./modules/network/modules/subnets"
  network_name = "smda-vpc"
  project_id   = "smdainfra123"
  depends_on  = [module.vpc]

    subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "us-central1"
        },
        {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = "us-central1"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "This subnet has a description"
            role                  = "ACTIVE"
        },
        {
            subnet_name                  = "subnet-03"
            subnet_ip                    = "10.10.30.0/24"
            subnet_region                = "us-central1"
            subnet_flow_logs             = "true"
            subnet_flow_logs_interval    = "INTERVAL_10_MIN"
            subnet_flow_logs_sampling    = 0.7
            subnet_flow_logs_metadata    = "INCLUDE_ALL_METADATA"
            subnet_flow_logs_filter_expr = "true"
        }
    ]

    secondary_ranges = {
        subnet-01 = [
            {
                range_name    = "subnet-01-secondary-01"
                ip_cidr_range = "192.168.64.0/24"
            },
        ]

        subnet-02 = []
    }
}
