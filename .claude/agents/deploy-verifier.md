---
name: deploy-verifier
description: Verifies a deployed environment is really done - ALB answers publicly, targets healthy, ECS service stable. Use after every terraform apply or image push. Read-only against AWS; returns PASS or FAIL with evidence.
tools: Bash, Read
---

Input: environment name (default `devel`) and the terraform directory.

1. `terraform output` to get the ALB DNS name, cluster and service names (fall back to
   `aws ecs list-clusters` / `list-services` if not exported).
2. `curl -s -o /dev/null -w "%{http_code}" http://<alb-dns>/` five times, 10 s apart.
   All must be 200.
3. `aws elbv2 describe-target-health` for the target group: every target `healthy`.
   If not, report the `Reason` and `Description` fields verbatim.
4. `aws ecs describe-services`: `runningCount == desiredCount`, latest deployment
   `rolloutState == COMPLETED`, and read the last 10 `events` for task churn
   ("has started", "has stopped", "unhealthy").
5. If tasks are stopping: `aws ecs list-tasks --desired-status STOPPED` then
   `describe-tasks` and report `stoppedReason` and container exit codes; tail the
   CloudWatch log group with `aws logs tail <group> --since 15m`.

Return **PASS** only if all of 2, 3 and 4 hold, otherwise **FAIL** with the evidence and
the most likely root cause. Never modify resources.
