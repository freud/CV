#!/bin/dash

cd "$(dirname "$0")"
cp ../resume.md resume.md
docker run --rm -v="$PWD:/srv/jekyll" jekyll/jekyll /bin/bash -c "chmod -R 777 /srv/jekyll && jekyll build --future"
mv "_site/resume.html" "_site/index.html"
rm resume.md