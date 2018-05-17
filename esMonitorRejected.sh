#!/bin/sh
_index="maomao_es_rejected_monitor-"`date +"%Y-%m-%d"`
_type="maomao_es_rejected_monitor"
url="http://IP:port/"${_index}
url=${url}"/"${_type}
result=`curl -X GET 'http://IP:port/_cat/thread_pool/bulk?v&h=node_name,name,active,rejected,completed,size,type,queue,queue_size,largest,min,max'`
while read line
do
  arr[i++]=$line
done << EOF
$result
EOF
record_num=${#arr[@]}
time=`date +%s`000
for((j=1;j<$record_num;j++))
{
  k=0
  for data in ${arr[j]}
  do
    array[k++]=$data
  done
  json='{"node_name":"'${array[0]}'","name":"'${array[1]}'","active":'${array[2]}',"rejected":'${array[3]}',"completed":'${array[4]}',"size":'${array[5]}',"type":"'${array[6]}'","queue":'${array[7]}',"queue_size":'${array[8]}',"largest":'${array[9]}',"min":'${array[10]}',"max":'${array[11]}',"sendTime":'${time}',"postDate":'${time}'}'
  curl -X POST "$url" -H 'Content-Type: application/json' -d "$json"
}




