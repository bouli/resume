mkdir resume-photo
cp photo.jpeg resume-photo/photo.jpeg
echo "![Cesar Cardoso](photo.jpeg)" | cat - resume.md > resume-photo/resume.md
cat resume.css | cat - resume-image.css > resume-photo/resume.css
resume-markdown build resume-photo/resume.md --no-pdf
cp resume-photo/resume.html ./resume-with-photo.html
