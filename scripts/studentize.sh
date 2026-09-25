#!/usr/bin/env bash
# Convert this teacher repository into the student handout, in place.
#
# The canonical repo always holds the WORKING teacher version (so its CI
# proves the lab is solvable). Student repos are produced by applying the
# `student/` overlay (the empty scaffold the students must fill) and removing
# everything teacher-only, then squashing history into a single root commit.
#
# Run it locally (./scripts/studentize.sh) or via the studentize.yml
# workflow_dispatch after forking/importing into the class organization.
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

CANONICAL="heig-tin-info/labo-01-first-steps"
origin=$(git remote get-url origin 2>/dev/null || echo "")
if [[ "$origin" == *"$CANONICAL"* && "${STUDENTIZE_FORCE:-}" != "1" ]]; then
  echo "Refusing to studentize the canonical teacher repo ($CANONICAL)." >&2
  echo "Fork/import it first, or set STUDENTIZE_FORCE=1 if you really mean it." >&2
  exit 1
fi

echo "Applying student overlay..."
cp -rv student/. .

echo "Removing teacher-only files..."
rm -rf student scripts .github/workflows/studentize.yml

echo "Squashing history into a single root commit..."
branch=$(git symbolic-ref --short HEAD)
git checkout --orphan student-handout
git add -A
git -c user.name="hgc-grader[bot]" -c user.email="grader@heig-vd.ch" \
  commit -q -m "Initial commit"
git branch -M "$branch"

echo "Done. Review the tree, then: git push --force origin HEAD"
