---
description: Run the whole challenge end to end without stopping (branches, CI, deploy devel, zip)
---

Run the full challenge autonomously, in this order, without waiting for confirmation
between stages. Only stop if a preflight fails or an action would be destructive.

Before each stage, print a header `## Stage N - <name>` and 2-3 sentences in English
saying what you are about to do and why, so the human can read it aloud.

0. Preflight: `gh auth status`, `aws sts get-caller-identity`, `docker info`,
   `terraform version`, `node -v`. Stop and say exactly what is missing if any fails.
1. Run the `/protect-branches` procedure.
2. Run the `/fix-ci` procedure (keep a red run on record, then reach green, merge to devel).
3. Run the `/deploy-devel` procedure for `devel`. Print the public ALB URL in bold.
4. Final verification with `deploy-verifier`; it must be PASS.
5. Run the `/package-submission` procedure.
6. Final summary for the recording: every defect found (CI and Terraform) as
   defect -> root cause -> fix, the PR links (red run, green run, terraform PR),
   the ALB URL and the zip path. Keep it under 25 lines.

Keep an eye on time: the recording should stay under 60 minutes. Prefer the shortest
correct path, do not over-investigate once a root cause is confirmed.
