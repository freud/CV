#!/bin/dash

cd "$(dirname "$0")"

cp "$PWD/../resume.md" "$PWD/../build-website/resume.md"

sudo docker run --rm -d --name=jekyll-for-pdf -v="$PWD/../build-website:/srv/jekyll" -p 4001:4001 jekyll/jekyll /bin/bash -c "chmod -R 777 /srv/jekyll && jekyll serve --port 4001 --host 0.0.0.0"

docker run --network host --rm -v="$PWD:/app" buildkite/puppeteer /bin/bash -c "cd app && npm install && npm start -- --url=http://127.0.0.1:4001/resume.html"

docker stop jekyll-for-pdf

rm "$PWD/../build-website/resume.md"