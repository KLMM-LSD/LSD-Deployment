#!/bin/bash
while true; do
	curl http://207.154.222.128:8080/latest/frontpage &> /dev/null
	curl http://207.154.222.128:8080/latest/ &> /dev/null
	sleep 300
done
