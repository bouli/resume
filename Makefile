include .env
deploy:
	rm -r ${PUSH_DIR}
	mkdir ${PUSH_DIR}
	cp ./output/* ${PUSH_DIR}

build:
	bash ./scripts/build.sh

serve:
	python3 -m http.server -d ./output
