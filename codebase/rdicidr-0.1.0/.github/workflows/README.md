# CI workflow location

The CI pipeline for this app lives at the repository root, in
`.github/workflows/ci.yaml`. GitHub Actions only loads workflow files from
`.github/workflows/` at the root of the repository, so a copy in this folder
would never run. It was moved there as the first CI fix (see PR #1).
