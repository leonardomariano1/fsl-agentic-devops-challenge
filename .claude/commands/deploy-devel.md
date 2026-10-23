---
description: Part 2 - audit Terraform, push the image to ECR, apply devel and verify until stable
argument-hint: "[env, default devel]"
---

Run Part 2 of the challenge autonomously for environment `${ARGUMENTS:-devel}`.
Narrate each stage in English in 2-3 sentences so the human can read it aloud.

1. Preflight: `aws sts get-caller-identity`, region, `terraform version`, `docker info`.
   Stop and tell the human if any fails.
2. From `devel`, create `bugfix/terraform-ecs`.
3. Delegate to the `terraform-auditor` agent. Read its defect list back in the
   Observed / Root cause / Fix format.
4. Fix each defect, one commit each, message `fix(tf): <root cause>`.
5. Apply in two stages so the image exists before the service starts:
   a. `terraform init`, select or pass the env, `terraform apply -target` for the ECR repo
      (and anything it needs).
   b. `aws ecr get-login-password | docker login`, then
      `docker buildx build --platform linux/amd64 -t <ecr-uri>:<tag> --push .`
   c. Full `terraform apply`. If it errors, treat the error as a new defect: explain it,
      fix it, re-apply.
6. Delegate to `deploy-verifier`. While it says FAIL, diagnose from its evidence, fix,
   re-apply, verify again. Wait for stability (several minutes with no churn) before PASS.
7. Print the ALB URL clearly, open a PR `bugfix/terraform-ecs` -> `devel` and merge it.
8. If asked for stage: open a PR `devel` -> `stage`, merge, and repeat 5-6 with `stage`.
9. Summarize defect -> root cause -> fix as a short table.

Never run `terraform destroy` unless the human explicitly asks.
