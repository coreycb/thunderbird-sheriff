## Initial Setup
```
python3 -m virtualenv .venv
source .venv/bin/activate
pip3 install MozPhab
```

## Ensuing Setup
```
source .venv/bin/activate
```

### Update Branches
```
hg up
hg pull -u
```

### Check Rust
Check if Rust changes needed. If needed, await message in Thunderbird CI channel with phab review.
```
../mach tb-rust check-upstream
```

### Land Patchs, Update TM, Add "leave-open" Keyword
* [checkin-needed-tb](https://mzl.la/3GSgSXO)
* If patch does not have tests, ask developer to open new bug for test coverage and assign to themself or include “good-first-test” in description
* Be sure to add add reviewer/approver (e.g. r=bob)
* Update TM in bug
* Check if there are any open patches for the bug and add "leave-open" keyword if there are
```
land-cc.sh DXXXX
```

### Fix Linting for Patch
Make sure no linting issues in each specific patch
```
export MOZLINT_NO_SUITE=1
../mach commlint --fix .
hg diff
```
If linting issues found and fixed, absorb into corresponding patch
```
hg absorb
```

### No Patches?
If no patches available to land, edit build/dummy file and commit with
```
hg commit -m "No bug, trigger build."
```

### Build Locally
```
../mach build
```

### Review Outgoing Patches
```
hg outgoing -r . comm-central
```

### Push to Repo
```
hg push -r . ssh://hg.mozilla.org/comm-central
```

### Revert a Patch?
If new failure due to c-c change, consider backout directly or if developer is around, ping to see if quick fix.
```
hg backout -r <revision_number>
hg commit -m "Backed out changeset <revision_number>(Bug <number>) for causing build bustage. r=backout"
```

### Failure Due to Mozilla-central?
* If new failure due to m-c change, track down what caused it, and if we need to port bug
* File a new bug for the issue, and try to get someone on the case (someone may be yourself)

### Check Push Build Health
* Check tree, classify failures, and file new bugs for new failures
* For one-off intermittent failure with no good suggestion, do not file bug immediately. Look at other similar tasks to see if same failure occurs, and/or see if it happens again on later pushes. File bug if same failure seen 4-5 times.
