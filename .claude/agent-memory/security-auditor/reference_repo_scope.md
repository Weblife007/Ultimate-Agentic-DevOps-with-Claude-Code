---
name: reference-repo-scope
description: Where Terraform lives in this repo and what's out of scope for terraform-only audits
metadata:
  type: reference
---

This repo (`Ultimate-Agentic-DevOps-with-Claude-Code`) keeps all infrastructure-as-code in `terraform/` (files: `main.tf`, `variables.tf`, `outputs.tf`, `backend.tf`, `providers.tf`, `cloudfront-function.js`). There are no `aws_iam_*`, OIDC, or other AWS resources defined anywhere outside that directory (confirmed via repo-wide grep on 2026-07-09).

The site itself (`index.html`, `style.css`, `privacy.html`, `terms.html`, `images/`) is static HTML/CSS with no build step — not relevant to Terraform/IAM security review, per [[project-portfolio-terraform-baseline]].

GitHub Actions workflow files (`.github/workflows/`) were not read during the 2026-07-09 terraform-scoped audit — if a future task needs to confirm how CI/CD authenticates to AWS (OIDC vs static keys), read that directory explicitly; it's a separate concern from the Terraform IaC review.
