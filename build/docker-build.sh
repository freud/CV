cp ../resume.md .
sudo docker run --rm --volume="$PWD:/srv/jekyll" -it jekyll/jekyll jekyll build
cp _site/resume.html ..
rm resume.md