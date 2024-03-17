#! /bin/bash
# menentukan alamat registry dan username pada environment variable
REGISTRY_URL="ghcr.io"
USERNAME="rikinfayed"

IMAGENAME="karsajobs:latest"

# build image dengan nama karsajobs:latest
docker build -t $IMAGENAME . && \
# melihat daftar image
docker image ls && \
# mengubah nama image agar sesuai dengan format docker hub
docker tag $IMAGENAME ghcr.io/rikinfayed/$IMAGENAME
# login ke github package
echo $PASSWORD_GHCR | docker login $REGISTRY_URL --username $USERNAME --password-stdin && \
# mengunggah image ke github packages
docker push ghcr.io/rikinfayed/$IMAGENAME                                                   
