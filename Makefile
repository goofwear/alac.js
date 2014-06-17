browser: src/*.coffee
	mkdir -p build/
	./node_modules/.bin/browserify \
		--extension .coffee \
		--global-transform browserify-shim \
		--debug \
		. \
		| ./node_modules/.bin/exorcist build/alac.js.map > build/alac.js

clean:
	rm -rf build/
