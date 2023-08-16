#!/bin/bash
echo "Hello!"
sleep 10
while true
do

for i in 1 2 3 4 
do
    echo "Welcome $i times"
    frameA=$(tail /home/ubunut/html/b/camera/c$i/camera.log -n 1 | sed -nr 's/.*frame=(.*)fps.*/\1/p')
    echo "$frameA"
    sleep 5
    frameA=$(tail /home/ubunut/html/b/camera/c$i/camera.log -n 1 | sed -nr 's/.*frame=(.*)fps.*/\1/p')
    echo "$frameB"

    if [ "$frameA" = "$frameB" ]
    then
        echo "Camera $i is hanging"
	printf "%s - Camera $i has hung\n" "$(date)" >> stream.log
        pkill ffmpeg
        echo "killed ffmpeg..."
	printf "%s - Killed ffmpeg...\n" "$(date)" >> stream.log
        echo "Waiting 5 secs"
        sleep 5
        bash /home/pi/ffmpeg.sh &
        echo "started ffpmeg.."
	printf "%s - Started ffmpeg..\n" "$(date)" >> stream.log
        echo "Waiting 15 secs"
        sleep 15
    else 
        echo "Stream looks ok."
    fi

    sleep 2
done
    
done



ffmpeg -reconnect 1 -reconnect_at_eof 1 -reconnect_streamed 1 -reconnect_delay_max 10 -t 100 -i http://192.168.2.128/mjpeg/1 -filter:v fps=15 -c:v flv test.flv