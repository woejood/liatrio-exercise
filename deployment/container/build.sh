# build file for Docker container
NAME="liatrio-api"
VER="1.0.0"
REPO="woejood"

docker build ../../app/ -t liatrio-api:1.0.0 --label liatrio-api:1.0.0
docker run --name liatrio-api:1.0.0 -p 5000:5000 -d liatrio-api:1.0.0