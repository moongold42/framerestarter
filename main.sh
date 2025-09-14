export LC_NUMERIC=C

rm -rf tempry/*

cya="\e[34m"
cyan="\e[36m"
endcol="\e[0m"
i=1
echo "" > array.txt

echo -e "${cya}welcome to frameRestarter, you can make your own 'but every frame restarts'"
echo -e "video in there!${endcol}"
echo -e "${cyan}type in your video file name:${endcol}"
read input

frames=$(mediainfo --Output="Video;%FrameCount%" "$input")
fps=$(mediainfo --Output="Video;%FrameRate%" "$input")

while [ $i -le ${frames} ]; do
time=$(awk "BEGIN {print $i / $fps}")
ffmpeg -i "$input" -ss 0.0 -to "$time" -c:v libx264 -crf 20 -preset veryfast tempry/"$i".mp4
echo -e "file tempry/'$i'.mp4\n" >> array.txt
((i++))
done
ffmpeg -f concat -i array.txt -c:v copy -c:a copy output.mp4

echo "" > array.txt
rm -rf tempry/*
echo "VIDEO COMPLETED"

