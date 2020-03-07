.PHONY: build update-nixpkgs clean watch
build:
	nix-shell --pure --run 'make pages'

pages:
	mkdir -p build/cv

	pandoc \
		--output ./build/cv/curriculum-vitae.pdf \
		--include-in-header ./src/cv/tex/base.tex \
		./src/cv/curriculum-vitae.md
	pandoc \
		--standalone \
		--write html5 \
		--output ./build/cv/curriculum-vitae.html \
		--include-in-header ./src/cv/css/cv.css \
		./src/cv/curriculum-vitae.md
	pandoc \
		--standalone \
		--write docx \
		--output ./build/cv/curriculum-vitae.docx \
		./src/cv/curriculum-vitae.md

	cp -f ./build/cv/curriculum-vitae.html build/index.html

	cp -r .well-known build
	cp CNAME build

clean:
	rm -rf build

watch:
	nix-shell --pure --run 'watchexec -e md make pages'
