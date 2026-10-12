module "networking" {
  source = "./modules/networking"

  vpc_cidr        = var.vpc_cidr
  public_subnet_1 = var.public_subnet_1
  public_subnet_2 = var.public_subnet_2
  environment     = var.environment
}



module "compute" {
  source = "./modules/compute"

  vpc_id        = module.networking.vpc_id
  subnet_id     = module.networking.subnet_id
  instance_type = var.instance_type
  ami_id        = var.ami_id
}


# S3 bucket

resource "random_id" "bucket" {
  byte_length = 4
}

resource "aws_s3_bucket" "bucket" {
  bucket = "chandru04-project-${random_id.bucket.hex}"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
