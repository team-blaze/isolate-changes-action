#!/bin/bash
# Assuming you have a folder called <folder>
# this script will check if you have changes in the migration folder
# and any other folder.
#!/bin/sh
set -e

isolate_folder=$1
from_sha=$2
to_sha=$3


echo "Isolate Folder: $isolate_folder";
echo "From: $from_sha";
echo "To: $to_sha";

# grep will exit with a 1 if no matches are found.
git show --name-only --ancestry-path $from_sha^..$to_sha | grep -s -q ^$isolate_folder*
has_isolated_folder_changes=$?

# grep -v inverts the search.
git show --name-only --ancestry-path $from_sha^..$to_sha | grep -s -v -q ^$isolate_folder*
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
