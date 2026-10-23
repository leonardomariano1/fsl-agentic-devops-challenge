---
description: Part 1 - run the CI loop until all four steps pass, keeping a failing PR on record
---

Run Part 1 of the challenge autonomously. Narrate each stage in English in 2-3 sentences
so the human can read it aloud. Do not stop to ask unless something is destructive.

1. From `devel`, create `bugfix/ci-pipeline`. Make one harmless commit if needed and open a
   PR into `devel` WITHOUT fixing anything yet, so a failing run is recorded.
   `gh run watch` it to completion.
2. Delegate to the `ci-investigator` agent. Read its defect list back to the human using
   the Observed / Root cause / Fix format.
3. Fix the defects one at a time, one commit each, message `fix(ci): <root cause>`.
   Push after each fix (or after a small related group) and `gh run watch`. If a new
   failure appears, go back to step 2 with the new log.
4. Done when all four jobs are green, in order, each gated by `needs:`. Show
   `gh pr checks` output. If the failing run ended up on the same PR, that is fine, but
   confirm both a red and a green run are visible; otherwise open a second PR.
5. Merge the PR into `devel` via `gh pr merge --merge` (never push to devel directly).
6. Summarize: defect -> root cause -> fix, as a short table.
