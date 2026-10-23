---
description: Build the submission zip with the official generateZip.sh (keeps .chat-history)
---

1. Confirm the deploy is still PASS with `deploy-verifier` and list the PR URLs
   (one red run, one green run, the terraform PR, any devel -> stage PR).
2. Make sure `.chat-history/` at the repo root has the latest transcript (a hook syncs it;
   copy the current session file again if needed).
3. Scan `.chat-history/` and the tracked files for `github_pat_`, `AKIA` and
   `aws_secret_access_key`. If anything is found, redact it in place and tell the human.
   Make sure no `*.tfstate` or `.env` with secrets is in the tree.
4. Run `./generateZip.sh` from the repo root and show its self-check output.
5. Print the zip path and size.
