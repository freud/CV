#!/bin/dash

cd "$(dirname "$0")"

cp "$PWD/../resume.md" "$PWD/../build-website/resume.md"

docker network create pdf-net
docker run --network pdf-net --rm -d --name=jekyll-for-pdf -v="$PWD/../build-website:/srv/jekyll" -p 4001:4001 jekyll/jekyll:4.2.0 /bin/bash -c "chmod -R 777 /srv/jekyll && jekyll serve --port 4001"
serverIp=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' jekyll-for-pdf`
sleep 2s
docker run --network pdf-net --name=puppeteer -v="$PWD:/app" buildkite/puppeteer /bin/bash -c "cd app && wget http://$serverIp:4001/resume.html && npm install && npm start -- --url=http://$serverIp:4001/resume.html"
docker stop jekyll-for-pdf

rm "$PWD/../build-website/resume.md"