source .env

EMAIL_TEMPLATE="email@some-email-server.com"
TELEPHONE_TEMPLATE="+00-0000-0000"
ADDRESS_TEMPLATE="My Address Street, 0 - 00000 - City, CC"

cp README.md resume.md
sed -i -e "s/$TELEPHONE_TEMPLATE/$TELEPHONE/g" resume.md
sed -i -e "s/$ADDRESS_TEMPLATE/$ADDRESS/g" resume.md
sed -i -e "s/$EMAIL_TEMPLATE/$EMAIL/g" resume.md

resume-markdown build --no-pdf
source deploy-image.sh

sed -i -e "s/$TELEPHONE/$TELEPHONE_TEMPLATE/g" resume.md
sed -i -e "s/$ADDRESS/$ADDRESS_TEMPLATE/g" resume.md
sed -i -e "s/$EMAIL/$EMAIL_TEMPLATE/g" resume.md
