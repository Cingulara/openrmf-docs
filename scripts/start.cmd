@echo off
REM Now run the latest development openRMF stack
docker compose up -d

REM tell them the URL
echo(
echo Run http://{ip-address}:8080/ to access OpenRMF
echo(