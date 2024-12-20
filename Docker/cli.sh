#!/bin/bash

docker build -f Dockerfile.debug -t tag1 -t tag2  //specify a dockerfile and some tags...
docker run -it --entrypoint /bin/sh imagename:tag

docker-compose -f <filename> up -d (detatched)

# Mount current folder to a folder called /test 
docker run -v ${PWD}:/test -it --entrypoint sh imagename:tag

docker container ls # List containers to get a container ID
docker cp <container id>:/filepath /hostpath

$images = docker images --filter "{{json .}}" // Get the list of images as json.
ConvertFrom-Json ("["+[string]::Join(",", $test)+"]") // Convert that list into an actual JSON array using powershell... pretty janky..

# Show disk usage
docker system df