terraform {
  backend "s3" {
    bucket = "terraform-state-chandru04"
    key    = "terraform.tfstate"
    region = "us-east-1"

    use_lockfile = true
  }
}
