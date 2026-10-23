---
description: Create devel/stage branches and enforce the challenge branching rules on GitHub
---

Set up the branching strategy on the GitHub repo for this folder:

1. Make sure `origin` points to the human's own GitHub repo (`gh repo view`). If it still
   points to the challenge repo, stop and ask before creating a new repo with
   `gh repo create --private --source . --push`.
2. Create `devel` and `stage` from `main` if missing and push them (this initial creation is
   the only direct push allowed).
3. Apply protection with `gh api` (rulesets or branch protection, whichever the account
   plan supports; consult docs.github.com only):
   - `devel` and `stage`: require a pull request, block force pushes and deletion.
   - `stage`: only accept PRs whose head is `devel`. If GitHub cannot enforce head branch
     natively, add a tiny workflow job `guard-stage-source` that fails when
     `github.head_ref != 'devel'` on PRs into `stage`, and make it a required check.
4. Print the resulting rules and explain each one in one sentence, in English.
