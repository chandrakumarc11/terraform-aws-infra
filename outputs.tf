output "vpc_id" {
  value = module.networking.vpc_id
}

output "instance_id" {
  value = module.compute.instance_id
}

output "elastic_ip" {
  value = module.compute.elastic_ip
}

output "application_url" {
  value = "http://${module.compute.elastic_ip}"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}
