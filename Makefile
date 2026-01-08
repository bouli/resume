include .env
deploy:
	rm -r ${PUSH_DIR}
	mkdir ${PUSH_DIR}
	cp ./output/resume-for-web-de.html ${PUSH_DIR}
	cp ./output/resume-for-web-en.html ${PUSH_DIR}

build:
	bash ./scripts/build.sh

serve:
	python3 -m http.server -d ./output
