variable "instance_name" {
    description = "Value of the Name tag for the EC2 instance"
    type = string
    default = "ExampleAppServerInstance"
}

variable "deployment_region" {
    description = "Deployment Region"
    type = string
    default = "us-west-2"
}