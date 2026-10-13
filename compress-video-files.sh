#!/usr/bin/env bash
# compress-video-files.sh - Visually lossless HEVC archiving for camera footage (Ubuntu)
# Usage: run from the folder containing your videos:  ./compress.sh

set -u
shopt -s nullglob nocaseglob

# ===== Settings =====
OUTPUT_DIR="compressed"
CRF=20          # lower = higher quality, bigger files (18-20 is visually lossless range)
PRESET="medium"   # "medium" is ~2x faster with slightly larger files

# ===== CPU usage: uncomment ONE line =====
CORES=$(nproc)
# THREADS=$(( CORES / 4 ))       # 1/4 - lightest, smooth for calls and playback
# THREADS=$(( CORES / 2 ))       # 1/2 - balanced
THREADS=$(( CORES * 3 / 4 ))     # 3/4 - faster, heavy apps may stutter
# THREADS=$(( CORES ))     # All cores
[ "$THREADS" -lt 1 ] && THREADS=1

# ===== Lowest priority for this script and everything it launches =====
renice -n 19 -p $$ >/dev/null 2>&1
ionice -c 2 -n 7 -p $$ >/dev/null 2>&1

# ===== Checks =====
if ! command -v ffmpeg >/dev/null 2>&1 || ! command -v ffprobe >/dev/null 2>&1; then
    echo "ffmpeg not found. Install it with: sudo apt install ffmpeg"
    exit 1
fi
if ! ffmpeg -hide_banner -encoders 2>/dev/null | grep -q libx265; then
    echo "Your ffmpeg build does not include libx265."
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

# ===== Helpers =====
fmt_time() {  # seconds -> "1h 23m"
    local s=$1
    if [ "$s" -ge 3600 ]; then
        printf '%dh %02dm' $(( s / 3600 )) $(( s % 3600 / 60 ))
    else
        printf '%dm %02ds' $(( s / 60 )) $(( s % 60 ))
    fi
}
video_secs() {  # video duration in whole seconds
    local d
    d=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$1" 2>/dev/null)
    printf '%.0f' "${d:-0}"
}

# ===== Remove partial output if interrupted (Ctrl+C) =====
tmp_file=""
cleanup() {
    [ -n "$tmp_file" ] && rm -f "$tmp_file"
    echo
    echo "Interrupted. Partial file removed; rerun to resume."
    exit 130
}
trap cleanup INT TERM

# ===== Find files and total footage to encode =====
files=( *.{mp4,mov,mkv,avi,m4v,mts,m2ts,webm,mxf} )
remaining_secs=0
pending=0
for file in "${files[@]}"; do
    [ -f "$file" ] || continue
    base="${file%.*}"; ext="${file##*.}"; ext="${ext,,}"
    [ -e "$OUTPUT_DIR/${base}-${ext}.mp4" ] && continue
    remaining_secs=$(( remaining_secs + $(video_secs "$file") ))
    pending=$(( pending + 1 ))
done

echo "Using $THREADS of $CORES CPU threads, CRF $CRF, preset $PRESET"
echo "To encode: $pending file(s), $(fmt_time "$remaining_secs") of footage"
echo "Time estimate will appear after the first file finishes."

done_list=()
failed=()
skipped=()
encoded_secs=0     # footage seconds encoded so far
encode_time=0      # wall-clock seconds spent encoding

for file in "${files[@]}"; do
    [ -f "$file" ] || continue

    base="${file%.*}"
    ext="${file##*.}"
    ext="${ext,,}"
    output_file="$OUTPUT_DIR/${base}-${ext}.mp4"
    tmp_file="$OUTPUT_DIR/${base}-${ext}.partial.mp4"

    if [ -e "$output_file" ]; then
        echo "Skipping (output exists): $file"
        skipped+=("$file")
        tmp_file=""
        continue
    fi

    dur=$(video_secs "$file")

    echo "----------------------------------------"
    echo "Processing: $file -> $output_file"
    echo "Length: $(fmt_time "$dur")"
    if [ "$encoded_secs" -gt 0 ]; then
        file_eta=$(( dur * encode_time / encoded_secs ))
        all_eta=$(( remaining_secs * encode_time / encoded_secs ))
        echo "Estimated: this file $(fmt_time "$file_eta"), all remaining $(fmt_time "$all_eta") (done around $(date -d "+$all_eta seconds" '+%a %H:%M'))"
    fi
    echo "----------------------------------------"

    start=$SECONDS
    if ffmpeg -nostdin -hide_banner -y \
            -threads "$THREADS" -i "$file" \
            -map '0:v:0' -map '0:a?' \
            -c:v libx265 -crf "$CRF" -preset "$PRESET" \
            -x265-params "pools=$THREADS" \
            -pix_fmt yuv420p10le -tag:v hvc1 \
            -c:a aac -b:a 256k \
            -map_metadata 0 -movflags +faststart+use_metadata_tags \
            "$tmp_file"; then
        mv "$tmp_file" "$output_file"
        done_list+=("$file")

        took=$(( SECONDS - start ))
        encode_time=$(( encode_time + took ))
        encoded_secs=$(( encoded_secs + dur ))
        echo "Finished in $(fmt_time "$took")"

        in_size=$(stat -c %s "$file")
        out_size=$(stat -c %s "$output_file")
        if [ "$out_size" -ge "$in_size" ]; then
            echo "Warning: $output_file is not smaller than the original"
        else
            echo "Saved $(( 100 - out_size * 100 / in_size ))% ($(( in_size / 1048576 )) MB -> $(( out_size / 1048576 )) MB)"
        fi
    else
        rm -f "$tmp_file"
        failed+=("$file")
    fi
    remaining_secs=$(( remaining_secs - dur ))
    [ "$remaining_secs" -lt 0 ] && remaining_secs=0
    tmp_file=""
done

echo "========================================"
echo "Processed: ${#done_list[@]}   Skipped: ${#skipped[@]}   Failed: ${#failed[@]}"
[ "$encode_time" -gt 0 ] && echo "Total encoding time: $(fmt_time "$encode_time")"
if [ ${#failed[@]} -gt 0 ]; then
    echo "Failed files:"
    printf '  %s\n' "${failed[@]}"
    echo "========================================"
    exit 1
fi
echo "All files processed successfully."
echo "========================================"
