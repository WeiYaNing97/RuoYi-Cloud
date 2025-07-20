@echo off
title redis服务
set ENV_HOME="D:\Program Files\Redis-x64-3.2.100"
D:
cd %ENV_HOME%
redis-server.exe redis.windows.conf
exit