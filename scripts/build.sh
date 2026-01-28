source .env

TMP_DIR=.temp
OUTPUT_DIR=output

rm -r $TMP_DIR
rm -r $OUTPUT_DIR

mkdir $TMP_DIR

# SET TEMPLATE DEFAULT VALUES
EMAIL_TEMPLATE="<!-- - ✉️ <email@some-email-server.com> -->"
TELEPHONE_TEMPLATE="<!-- - 📞 +00-0000-0000 -->"
ADDRESS_TEMPLATE="<!-- - 🏠 My Address Street, 0 - 00000 - City, CC -->"

# BUILD THE BASE RESUME
mkdir $TMP_DIR/en
cp README.md $TMP_DIR/en/resume.md
cp resume.css $TMP_DIR/en/resume.css

# UPDATE VARS
sed -i -e "s/$TELEPHONE_TEMPLATE/- ✉️ <hello@cesarcardoso.cc>/g" $TMP_DIR/en/resume.md

# CREATE RESUME FOR WEB WITH NO SENSITIVE DATA
uvx resume-markdown build $TMP_DIR/en/resume.md --no-pdf
cp $TMP_DIR/en/resume.html $TMP_DIR/en/resume-for-web.html

# UPDATE VARS
cp README.md $TMP_DIR/en/resume.md
sed -i -e "s/$TELEPHONE_TEMPLATE/$TELEPHONE/g" $TMP_DIR/en/resume.md
sed -i -e "s/$ADDRESS_TEMPLATE/$ADDRESS/g" $TMP_DIR/en/resume.md
sed -i -e "s/$EMAIL_TEMPLATE/$EMAIL/g" $TMP_DIR/en/resume.md

uvx resume-markdown build $TMP_DIR/en/resume.md --no-pdf

# BUILD RESUME WITH PHOTO
mkdir $TMP_DIR/en/with-photo/
echo "![Cesar Cardoso](photo.jpeg)" | cat - $TMP_DIR/en/resume.md > $TMP_DIR/en/with-photo/resume.md
cat resume.css | cat - resume-image.css  > $TMP_DIR/en/with-photo/resume.css
uvx resume-markdown build $TMP_DIR/en/with-photo/resume.md --no-pdf

# BUILD RESUME IN GERMAN
mkdir $TMP_DIR/de
cp resume-de.md $TMP_DIR/de/resume.md
cp resume.css $TMP_DIR/de/resume.css

# UPDATE VARS
sed -i -e "s/$TELEPHONE_TEMPLATE/- ✉️ <hello@cesarcardoso.cc>/g" $TMP_DIR/de/resume.md

# CREATE RESUME FOR WEB WITH NO SENSITIVE DATA
uvx resume-markdown build $TMP_DIR/de/resume.md --no-pdf
cp $TMP_DIR/de/resume.html $TMP_DIR/de/resume-for-web.html

cp resume-de.md $TMP_DIR/de/resume.md

# UPDATE VARS
sed -i -e "s/$TELEPHONE_TEMPLATE/$TELEPHONE/g" $TMP_DIR/de/resume.md
sed -i -e "s/$ADDRESS_TEMPLATE/$ADDRESS/g" $TMP_DIR/de/resume.md
sed -i -e "s/$EMAIL_TEMPLATE/$EMAIL/g" $TMP_DIR/de/resume.md

uvx resume-markdown build $TMP_DIR/de/resume.md --no-pdf

# BUILD RESUME WITH PHOTO
mkdir $TMP_DIR/de/with-photo/
echo "![Cesar Cardoso](photo.jpeg)" | cat - $TMP_DIR/de/resume.md > $TMP_DIR/de/with-photo/resume.md
cat resume.css | cat - resume-image.css > $TMP_DIR/de/with-photo/resume.css
uvx resume-markdown build $TMP_DIR/de/with-photo/resume.md --no-pdf

# BUILD THE COVER LETTERS
python3 cover-letter.py
# UPDATE VARS
echo "![Cesar Cardoso](photo.jpeg)" | cat - ./cover-letter.md > $TMP_DIR/en/cover-letter.md
sed -i -e "s/$TELEPHONE_TEMPLATE/$TELEPHONE/g" $TMP_DIR/en/cover-letter.md
sed -i -e "s/$ADDRESS_TEMPLATE/$ADDRESS/g" $TMP_DIR/en/cover-letter.md
sed -i -e "s/$EMAIL_TEMPLATE/$EMAIL/g" $TMP_DIR/en/cover-letter.md

TMP_COVER_LETTERS=$TMP_DIR/cover-letters
for cover_letter in "$TMP_COVER_LETTERS"/*.md
do
    sed -i -e "s/$TELEPHONE_TEMPLATE/$TELEPHONE/g" $cover_letter
    sed -i -e "s/$ADDRESS_TEMPLATE/$ADDRESS/g" $cover_letter
    sed -i -e "s/$EMAIL_TEMPLATE/$EMAIL/g" $cover_letter
    uvx resume-markdown build $cover_letter --no-pdf
done

#cp cover-letter.css $TMP_DIR/en/cover-letter.css
#uvx resume-markdown build $TMP_DIR/en/cover-letter.md --no-pdf


mkdir $OUTPUT_DIR
cp $TMP_DIR/en/resume.html $OUTPUT_DIR/resume-en.html
cp $TMP_DIR/de/resume.html $OUTPUT_DIR/resume-de.html
cp $TMP_DIR/en/resume-for-web.html $OUTPUT_DIR/resume-for-web-en.html
cp $TMP_DIR/de/resume-for-web.html $OUTPUT_DIR/resume-for-web-de.html
cp $TMP_DIR/en/with-photo/resume.html $OUTPUT_DIR/resume-en-with-photo.html
cp $TMP_DIR/de/with-photo/resume.html $OUTPUT_DIR/resume-de-with-photo.html
cp photo.jpeg $OUTPUT_DIR/photo.jpeg

for cover_letter in "$TMP_COVER_LETTERS"/*.html
do
    cp $cover_letter $OUTPUT_DIR/$(basename $cover_letter)
done
#cp $TMP_DIR/en/cover-letter.html $OUTPUT_DIR/cover-letter.html
