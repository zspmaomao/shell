#!/bin/sh
# 收集磁盘IO
#vmstat|sed -n '3p'
datas=`vmstat|sed -n '3p'`

time=`date +%s`
time=${time}"000"
nodeName=`hostname`
networkHost=`hostname -i`
#array=()
#for((i=1;i<=${size};i++));
# do
#    echo "node value is :"${datas[i]} 
# done


i=0
for data in ${datas[@]} 
do 
    array[${i}]=${data}
#    msg=${msg}
#    echo "-----------data:"${data}
     let i++
#    curl -X POST "$url" -H 'Content-Type: application/json' -d "$s"
done


json='{"r":'${array[0]}',"b":'${array[1]}',"swpd":'${array[2]}',"free":'${array[3]}',"buff":'${array[4]}',"cache":'${array[5]}',"si":'${array[6]}',"so":'${array[7]}',"bi":'${array[8]}',"bo":'${array[9]}',"in":'${array[10]}',"cs":'${array[11]}',"us":'${array[12]}',"sy":'${array[13]}',"id":'${array[14]}',"wa":'${array[15]}',"st":'${array[16]}',"@timestamp":'${time}',"nodeName":"'${nodeName}'","networkHost":"'${networkHost}'"}'

echo "json  is "${json}


_index="park_vmstat-"`date +"%Y-%m-%d"`
url="http://IP:port/"${_index}
_type="vmstat"
url=${url}"/"${_type}

curl -X POST "$url" -H 'Content-Type: application/json' -d "$json"

