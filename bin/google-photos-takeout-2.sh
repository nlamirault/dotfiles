#!/usr/bin/env bash

# configure shellscript
set -e
shopt -s globstar
IFS=$'\n'

# ensure dependencies are installed
for cmd in exiftool jq; do
  command -v "$cmd" >/dev/null 2>&1 || { echo >&2 "$cmd is not installed. Aborting."; exit 1; }
done

# create temporary file to store file paths
fullpaths=$(mktemp)
trap 'rm -f "$fullpaths"' EXIT

# find all JSON files and enumerate over them
files=(./**/*.json)

echo "Analyzing ${#files[@]} JSON files..."

for i in "${!files[@]}"; do
  file="${files[$i]}"

  # skip metadata files that are not for specific photos
  if [[ "$file" == *"metadata.json" ]] && [[ ! "$file" == *".jpg.supplemental-metadata.json" ]]; then
     # skipping general album metadata like "métadonnées.json"
     continue
  fi

  # read the filename from the JSON file
  filename=$(jq -r .title "$file" 2>/dev/null)

  # skip if filename is empty or null
  if [ -z "$filename" ] || [ "$filename" == "null" ]; then
	  continue
  fi

  # update filename with subscript if found (Google Takeout specific renaming)
  if [[ $file =~ \(([0-9]+)\)\.json$ ]]; then
    filename="${filename%.*}(${BASH_REMATCH[1]}).${filename##*.}"
  fi

  # read the timestamp from the JSON file
  timestamp=$(jq -r .photoTakenTime.timestamp "$file" 2>/dev/null)

  # get the directory of the JSON file
  directory=$(dirname "$file")

  # iterate over the original and edited file
  for f in "$filename" "${filename%.*}-edited.${filename##*.}"; do
    fullpath="$directory/$f"

    # skip if file does not exist
    if [ ! -f "$fullpath" ]; then
      continue
    fi

    # Create link for exiftool to find metadata easily
    # We link to .json so exiftool -tagsfromfile %d%f.%e.json works
    if [[ "$file" == *".supplemental-metadata.json" ]]; then
        linkname="${fullpath}.json"
        if [ ! -f "$linkname" ]; then
            ln "$file" "$linkname"
        fi
    fi

    # set modification time if timestamp exists
    if [ "$timestamp" != "null" ] && [ -n "$timestamp" ]; then
        touch -m -t "$(date -r "$timestamp" +%Y%m%d%H%M.%S)" "$fullpath"
    fi
    
    echo "$fullpath" >> "$fullpaths"
  done
done

# deduplicate fullpaths
sort -u "$fullpaths" -o "$fullpaths"

count=$(wc -l < "$fullpaths")
if [ "$count" -eq 0 ]; then
    echo "No matching images found."
    exit 0
fi

echo "Found $count unique files to process"
read -p "Apply metadata to images? [y/N] " -n 1 -r
printf "\n"

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit 1
fi

# run exiftool on all files
exiftool \
  -api LargeFileSupport=1 \
  -m \
  -q -q \
  -d %s \
  -tagsfromfile "%d%f.%e.supplemental-metadata.json" \
    "-GPSAltitude<GeoDataAltitude" \
    "-GPSLatitude<GeoDataLatitude" \
    "-GPSLongitude<GeoDataLongitude" \
    "-DateTimeOriginal<PhotoTakenTimeTimestamp" \
  -tagsfromfile "%d%f.%e.json" \
    "-GPSAltitude<GeoDataAltitude" \
    "-GPSLatitude<GeoDataLatitude" \
    "-GPSLongitude<GeoDataLongitude" \
    "-DateTimeOriginal<PhotoTakenTimeTimestamp" \
  "-GPSLatitudeRef<GPSLatitude" \
  "-GPSLongitudeRef<GPSLongitude" \
  "-GPSAltitudeRef<GPSAltitude" \
  "-GPSTimeStamp<DateTimeOriginal" \
  "-GPSDateStamp<DateTimeOriginal" \
  -overwrite_original \
  -preserve \
  -progress \
  -@ "$fullpaths"

echo "Done."
