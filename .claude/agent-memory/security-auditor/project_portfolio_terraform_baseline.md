---
name: project-portfolio-terraform-baseline
description: Known open security findings for the portfolio-site S3+CloudFront Terraform stack as of the 2026-07-09 audit
metadata:
  type: project
---

As of the 2026-07-09 audit of `terraform/` (S3 static site + CloudFront + OAC, `ap-south-1`, project `portfolio-site`), the following gaps were open. Re-check each on future audits to see if closed rather than re-deriving from scratch:

- No `aws_s3_bucket_server_side_encryption_configuration` on `aws_s3_bucket.website` (HIGH).
- No `aws_cloudfront_response_headers_policy` attached to `aws_cloudfront_distribution.s3_distribution` — missing CSP/X-Frame-Options/HSTS (HIGH).
- No `aws_s3_bucket_versioning` on the website bucket (MEDIUM).
- No CloudFront `logging_config` — no access logs (MEDIUM).
- `terraform/backend.tf` remote S3 backend is present but commented out; state is local (MEDIUM). Migration instructions are already written inline in that file.
- No IAM/OIDC resources exist anywhere in `terraform/`, despite CLAUDE.md stating deployment is automated via GitHub Actions — deployment credential method (long-lived keys vs OIDC) is not visible from Terraform alone and should be checked in `.github/workflows/` on a future audit (MEDIUM, unconfirmed).
- `var.domain_name` is declared in `variables.tf` but never referenced in `main.tf` (no `aliases` block) — if a custom domain is added later, must pair it with an ACM cert + `minimum_protocol_version = "TLSv1.2_2021"`, not just `cloudfront_default_certificate` (LOW, forward-looking).
- No WAFv2 Web ACL attached to CloudFront (LOW, optional for this low-risk static portfolio site).

**Why**: This is a recurring project (`portfolio-site`) — CLAUDE.md confirms it's a static HTML/CSS portfolio deployed via S3+CloudFront+Terraform+GitHub Actions, so the same Terraform files will likely be revisited across multiple audit sessions.
**How to apply**: On future security audits of this same `terraform/` directory, diff current resource blocks against this list first to report progress/regressions, then still re-verify each item against the live file (don't assume the memory is current — Terraform may have changed).

Things already done correctly here (don't flag as new findings unless removed): S3 public access block with all 4 flags true, CloudFront OAC (not legacy OAI), S3 bucket policy scoped via `AWS:SourceArn` condition to the specific distribution, `viewer_protocol_policy = redirect-to-https`, account ID sourced dynamically via `data.aws_caller_identity.current` (no hardcoded ARNs/account IDs).
