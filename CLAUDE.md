# FSL Agentic DevOps Challenge (AWS + Terraform)

You are the primary engineer on this challenge. The human guides, reviews and narrates;
you diagnose, explain and apply every fix. Do not ask the human to edit files by hand.

## Repo layout
- The React app, its Dockerfile, its workflow file and the Terraform config live under
  `codebase/rdicidr-0.1.0/` (app dir). Paths below such as `ci.yaml` or `terraform/` are
  relative to wherever they actually are; confirm locations before acting.
- `generateZip.sh` at the repo root is the official packager. `.chat-history/` at the repo
  root holds the interaction logs and must end up in the zip.

## Ground rules
- The repo is partially broken on purpose: defects are seeded in `.github/workflows/ci.yaml`
  and in `terraform/`. Find them from evidence (logs, plan output, AWS state), never guess.
- For every defect, report in this exact shape before touching code, in English, short
  enough to be read aloud:
  - **Observed:** what the log / plan / AWS output shows
  - **Root cause:** the line(s) responsible and why
  - **Fix:** what changes and why it solves it
- One defect = one focused commit with a message that names the root cause.
- Only official documentation may be consulted (docs.github.com, developer.hashicorp.com,
  registry.terraform.io, docs.aws.amazon.com, jestjs.io, eslint.org, react docs).
  No StackOverflow, blogs or forums.

## Branching (mandatory)
- Long-lived branches: `main`, `devel`, `stage`.
- All work happens in `feature/<topic>` or `bugfix/<topic>` branched from `devel`.
- Merge into `devel` only via PR. Only `devel` may be merged into `stage` (via PR).
- Never `git push` to `devel` or `stage` directly. Never force-push.
- Use `gh` for PRs, runs and logs: `gh pr create`, `gh run watch`, `gh run view --log-failed`.

## CI requirements (Part 1)
- Trigger: `pull_request` (opened, synchronize, reopened) targeting `devel` and `stage`,
  from correctly named branches (`feature/**`, `bugfix/**`, and `devel` into `stage`).
- Steps in order, each gated on the previous with `needs:`:
  `npm install` -> `npm run lint` -> `CI=true npm run test` -> `npm run build`.
- Keep at least one PR with a failing run and one with a fully green run.

## CD requirements (Part 2)
- ECS Fargate behind an ALB with a passing health check, image in ECR.
- Environments: `devel` (required) and `stage`. Keep state/vars isolated per env.
- Done means: ALB DNS answers HTTP 200 publicly, all targets `healthy`,
  ECS service `runningCount == desiredCount` with no task churn for several minutes.
- Build images for `linux/amd64` (this Mac may be Apple Silicon).
- AWS account constraint: the IAM user is restricted by a Service Control Policy. Only
  `us-east-2` accepts ECS/ECR/ELB/EC2 calls; `us-east-1`, `us-west-2` and `sa-east-1` return
  AccessDenied. The CLI default region is already `us-east-2`; pass the region explicitly to
  Terraform instead of trusting defaults in the repo.
- Never print AWS secret keys or the GitHub token. Never commit `*.tfstate`, `.terraform/`,
  `*.tfvars` with secrets, or `node_modules/`.

## Agents available
- `ci-investigator`: reproduces CI locally + reads Actions logs, returns defects.
- `terraform-auditor`: static review of `terraform/` for runtime defects, returns defects.
- `deploy-verifier`: checks ALB, target health and ECS stability, returns a verdict.

Slash commands: `/fix-ci`, `/deploy-devel`, `/protect-branches`, `/package-submission`.
