#!/bin/sh -l

set -e # if a command fails it stops the execution
set -u # script fails if trying to access to an undefined variable

echo "[+] Action start"

SOURCE_DIRECTORY="${1}"
DESTINATION_DIRECTORY="${2}"
NB_NOTES=0
NB_NOTES_FILE=$(mktemp) # Create a temporary file to store subshell information
echo " - Source directory: $SOURCE_DIRECTORY"
echo " - Destination directory: $DESTINATION_DIRECTORY"

echo "[+] Create destination folder"
mkdir "$DESTINATION_DIRECTORY"

echo "[+] Copy content"
# Copy all files from the source directory
find "$SOURCE_DIRECTORY" -type f -name "README.md" -not -path "$SOURCE_DIRECTORY/content/*" | while read -r FILE_NAME; do
  # Retrieve file info
  NOTE_DIR=$(dirname "$FILE_NAME")
  DIR_NAME=$(basename "$NOTE_DIR")

  # Skip if the directory is the root (i.e., ".")
  if [ "$DIR_NAME" = "." ]; then
    echo "  - Skipping root README.md at $FILE_NAME"
    continue
  fi

  echo "  - Create note: $DIR_NAME"
  echo "           from: $NOTE_DIR"

  # Make the directory that will contain the note and assets
  mkdir "$DESTINATION_DIRECTORY/$DIR_NAME" 2>/dev/null

  # Copy all files from the note directory
  find "$NOTE_DIR" -type f -exec cp {} "$DESTINATION_DIRECTORY/$DIR_NAME" \;

  # Rename README.md
  mv "$DESTINATION_DIRECTORY/$DIR_NAME/README.md" "$DESTINATION_DIRECTORY/$DIR_NAME/index.md"

  # Store the number of notes in a temporary file
  NB_NOTES=$((NB_NOTES + 1))
  echo "$NB_NOTES" >"$NB_NOTES_FILE"
done

# Read the value of NB_NOTES from the temporary file
NB_NOTES=$(cat "$NB_NOTES_FILE")

# Clean up the temporary file
rm "$NB_NOTES_FILE"

# Display the number of notes
echo "[v] $NB_NOTES notes have been created."
