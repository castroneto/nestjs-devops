variable "name" {
  type    = string
  description = "nome utilizado para nomear os recursos"
}

variable "subscription" {
  type    = string
  description = "id da subscription"
}

variable "location" {
  type    = string
  description = "location onde vai ser provisionado os recursos"
}

variable "resource_group" {
  type    = string
  description = "resource group ja existente"
}