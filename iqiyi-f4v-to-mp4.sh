# parameter 1 is episode
for num in {1..12}; do
  # convert original .f4v file to common .mp4
  ffmpeg -i "$1-$num.f4v" -codec copy "$1-$num.mp4"
done
all=""
for num in {1..12}; do
  # concat all .mp4 files into single one
  all=$all"$1-$num.mp4 "
done
mencoder $all -oac pcm -ovc copy -o $1.mp4

