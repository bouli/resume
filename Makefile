include .env
deploy:
	rm -r ${PUSH_DIR} | True
	mkdir ${PUSH_DIR} | True
	cp ./output/resume-for-web-de.html ${PUSH_DIR} | True
	cp ./output/resume-for-web-en.html ${PUSH_DIR} | True

build:
	bash ./scripts/build.sh

serve:
	python3 -m http.server -d ./output
