# build file for Docker container
docker build -t liatrio-api .
docker run --name liatrio-api -p 5000:5000 -d liatrio-api