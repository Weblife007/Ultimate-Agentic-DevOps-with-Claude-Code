---
name: portfolio-cost-review
description: Cost optimization review of portfolio S3+CloudFront infrastructure deployed in ap-south-1
metadata:
  type: project
---

# Portfolio Site Cost Optimization Review

## Infrastructure Summary
- **S3 Bucket**: portfolio-site-{account_id} in ap-south-1
- **CloudFront**: PriceClass_200, default_ttl=3600s, max_ttl=86400s
- **Region**: ap-south-1 (Mumbai)
- **Traffic Profile**: Static HTML/CSS portfolio (low volume, minimal churn)
- **Estimated Current Cost**: $0.50–$2.00/month

## Top 3 Cost Optimizations (Quick Wins - 4 minutes total)

### 1. CloudFront Price Class Downgrade (HIGH IMPACT)
- **Current**: PriceClass_200 (200+ edge locations)
- **Recommended**: PriceClass_100 (52 edge locations, covers 99% of traffic)
- **Savings**: $0.15–$0.60/month (~25-30% reduction)
- **Effort**: 1 line change in terraform/main.tf:111
- **Status**: NOT IMPLEMENTED

### 2. Increase CloudFront Cache TTLs (MEDIUM IMPACT)
- **Current**: default_ttl=3600s (1 hour), max_ttl=86400s (24 hours)
- **Recommended**: default_ttl=86400s, max_ttl=604800s (7 days for static assets)
- **Savings**: $0.05–$0.25/month (20-40% fewer origin requests)
- **Effort**: 2 line changes in terraform/main.tf:84-85
- **Why**: Static content doesn't change during deployment cycles; longer TTL = fewer S3 GET requests
- **Status**: NOT IMPLEMENTED

### 3. Increase Error Cache TTL (LOW-MEDIUM IMPACT)
- **Current**: error_caching_min_ttl=300s (5 minutes)
- **Recommended**: error_caching_min_ttl=3600s (1 hour)
- **Savings**: $0.01–$0.10/month (prevents bot-driven 404 cascades)
- **Effort**: 1 line change in terraform/main.tf:98
- **Status**: NOT IMPLEMENTED

## Secondary Optimizations

### S3 Lifecycle Policies (LOW IMPACT, good practice)
- **Current**: No lifecycle policy
- **Recommendation**: Add automatic expiration of old object versions after 30 days
- **Prevents**: Accidental storage bloat from repeated deployments
- **Cost Impact**: Negligible for static site, but prevents future waste
- **Status**: NOT IMPLEMENTED

### Terraform Backend (OPERATIONAL SAFETY)
- **Current**: Local state file (single-user only, high risk for team collaboration)
- **Recommended**: Enable S3 + DynamoDB backend (uncomment terraform/backend.tf)
- **Cost**: +$1.50/month (S3 + DynamoDB)
- **Worth it**: Yes, prevents state conflicts in team workflows
- **Status**: COMMENTED OUT - NEEDS MIGRATION

## Resources Checked

### CloudFront Distribution
- IPv6 enabled: YES (good for modern web, minimal cost)
- Compression enabled: YES (good - reduces bandwidth)
- HTTP→HTTPS redirect: YES (enforces security)
- Custom domain: NOT configured (using CloudFront default cert, free)
- Origin Access Control: YES (secure, no public S3 access, good pattern)
- CloudFront Function: index_rewrite (cost: ~$0.10/1M requests - negligible)

### S3 Bucket
- Storage class: Standard (default - appropriate for static site)
- Versioning: NOT enabled (add if team collaboration needed)
- Encryption: NOT enabled (add for security - free with default encryption)
- Access logging: NOT enabled (add for audit trail)
- Lifecycle rules: NOT configured (add to prevent version bloat)
- Public access block: YES (all blocked - good security posture)

### Regional Choice
- Current: ap-south-1 (Mumbai)
- Assessment: Appropriate if audience is India/South Asia
- If audience is global/US-centric: us-east-1 has same CloudFront pricing but may be closer to team
- No cost difference for CloudFront pricing between regions for same PriceClass

## Cost Monitoring Gaps
- No CloudWatch Cost Anomaly Detection
- No AWS Budgets or spending alerts
- No S3 request rate monitoring
- No CloudFront cache hit ratio tracking

## Total Potential Savings
**Quick wins (4 minutes effort)**: $0.21–$0.95/month ($2.50–$11.40/year)
**All optimizations**: $0.21–$1.05/month ($2.50–$12.60/year)

## Notes
- This is a low-volume static site; absolute savings are small but percentage improvements are significant
- Prioritize PriceClass downgrade and TTL increases for highest ROI
- Backend migration to S3 is recommended for team safety, not cost
- No reserved capacity or savings plans applicable (CloudFront and S3 are pay-as-you-go for low-volume workloads)
