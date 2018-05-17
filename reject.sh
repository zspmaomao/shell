#!/bin/sh
# 收集 ES reject 数量
#str=$(curl -X GET 'http://172.16.42.12:8200/_cat/thread_pool/bulk?v&h=node_name,name,active,rejected,completed,size,type,queue,queue_size,largest,min,max&format=json')

_index="maomao_es_monitor"`date +"%Y-%m-%d"`
_type="monitor"
url="http://IP:port/"${_index}
url=${url}"/"${_type}

time=`date +%s`
time=",\"timestamp\":"${time}"000"

arr=`curl -X GET 'http://IP:port/_cat/thread_pool/bulk?v&h=node_name,name,active,rejected,completed,size,type,queue,queue_size,largest,min,max&format=json' | grep -P '\{([^\}]+)\}' -o`

for s in ${arr[@]} 
do 
    
    s="{"${s}${time}"}"
    echo "-----------s:"${s}
    curl -X POST "$url" -H 'Content-Type: application/json' -d "$s"
done
