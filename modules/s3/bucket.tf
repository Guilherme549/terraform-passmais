resource "aws_s3_bucket" "private_bucket" {
  bucket = var.bucket_name
}

# Bloqueio de acesso público
resource "aws_s3_bucket_public_access_block" "private_bucket" {
  bucket = aws_s3_bucket.private_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Versionamento do bucket
resource "aws_s3_bucket_versioning" "private_bucket_versioning" {
  bucket = aws_s3_bucket.private_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Lifecycle: remover versões antigas e abortar uploads incompletos
resource "aws_s3_bucket_lifecycle_configuration" "private_bucket_lifecycle" {
  bucket = aws_s3_bucket.private_bucket.id

  rule {
    id     = "RemoveOldVersions"
    status = "Enabled"
    filter {}

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }

  rule {
    id     = "AbortIncompleteMultipartUploads"
    status = "Enabled"
    filter {}

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
  }
}


data "aws_iam_policy_document" "bucket_policy" {
  # 1) Nega qualquer acesso sem HTTPS
  statement {
    sid     = "DenyInsecureTransport"
    effect  = "Deny"
    actions = ["s3:GetObject", "s3:PutObject"]
    resources = [
      aws_s3_bucket.private_bucket.arn,
      "${aws_s3_bucket.private_bucket.arn}/*"
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }

  # (Opcional) Outras negações úteis podem ser adicionadas aqui, ex:
  # - Exigir SSE (server-side encryption)
  # - Restringir por conta/role específica (com Allow + Deny).
}

resource "aws_s3_bucket_policy" "private_bucket_policy" {
  bucket = aws_s3_bucket.private_bucket.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}


resource "aws_s3_bucket_cors_configuration" "this" {
  bucket = aws_s3_bucket.private_bucket.id

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["http://localhost:3000", "https://codexgo.com.br"]
    allowed_headers = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 300
  }
}
