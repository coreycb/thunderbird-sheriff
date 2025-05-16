#!/usr/bin/bash
if [ -z "$1" ]; then
  echo Please give the DXXX as argument
  exit 1;
fi

DX=$1
echo "Landing $DX… Please update the patch comment with the actual approver and remove any review groups"
moz-phab patch "$DX" --no-bookmark --skip-dependencies --apply-to . && hg commit --amend --date now && hg wip
