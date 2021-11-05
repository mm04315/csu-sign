#!/bin/sh

USER_ID="02xxxxxxxxx%40zndx"
PASSWORD="xxxxxx"

logger -t web-login "开始检测网络认证状态"
KEYWORD=$(curl -s http://baidu.com | grep meta)
if [[ "$(printf '%s' "${KEYWORD}")" = '' ]]; then
  logger -t web-login "检测到尚未认证，尝试自动认证"
  LOGIN_STATUS=$(curl -s -X POST "http://119.39.119.2/a70.htm" \
  -H "Connection: keep-alive" \
  -H "Cache-Control: max-age=0" \
  -H "Upgrade-Insecure-Requests: 1" \
  -H "Origin: http://119.39.119.2" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36 Edg/94.0.992.50" \
  -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9" \
  -H "Referer: http://119.39.119.2/a70.htm" \
  -H "Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6" \
  --data-raw "DDDDD=${USER_ID}&upass=${PASSWORD}&R1=0&R2=&R3=0&R6=0&para=00&0MKKey=123456&buttonClicked=&redirect_url=&err_flag=&username=&password=&user=&cmd=&Login=&v6ip="
  )  # 含有变量时只能使用双引号
  SUCCESS=$(echo ${LOGIN_STATUS} | grep Dr.COMWebLoginID_3.htm )
  if [[ "$(printf '%s' "${SUCCESS}")" != '' ]]; then
    logger -t web-login "自动认证成功"
  else
    logger -t web-login "自动认证失败，请手动认证或检查配置文件"
  fi
else
  logger -t web-login "检测到Intenet连接状态正常"
fi