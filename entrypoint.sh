#!/bin/sh
# Assuming you have a folder called <folder>
# this script will check if you have changes in the migration folder
# and any other folder.
# fetch everything.
git fetch -q

isolate_folder=$1
from_ref=$2

echo "Isolate Folder: $isolate_folder";
echo "From: $from_ref";

# grep will exit with a 1 if no matches are found.
git diff --name-only origin/$from_ref.. | grep -s -q ^${isolate_folder}*
has_isolated_folder_changes=$?

# grep -v inverts the search.
git diff --name-only origin/$from_ref.. | grep -s -v -q ^$isolate_folder*
has_other_changes=$?

# add exit codes - should only be zero if matches were
# found in both cases.
changes=$((has_other_changes+has_isolated_folder_changes));

if [ $changes -eq 0 ]; then
  echo "Change touched files in ${isolate_folder} folder + some other folder."
  exit 1
else
  echo "Change is good."
  exit 0
fi
