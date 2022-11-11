build:
	sudo docker run --rm -v `pwd`:/usr/src/app -w /usr/src/app nimlang/nim nim c -r -d:ssl -d:release main.nim