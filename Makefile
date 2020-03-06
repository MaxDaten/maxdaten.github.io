.PHONY: build update-nixpkgs clean watch
build:
	nix-shell --pure --run 'make pages'

pages:
	mkdir -p cv
	pandoc -H ./src/cv/tex/base.tex -o ./cv/curriculum-vitae.pdf ./src/cv/curriculum-vitae.md
	pandoc -s -t html5 -H ./src/cv/css/cv.css -o ./cv/curriculum-vitae.html ./src/cv/curriculum-vitae.md
	pandoc -s -t docx -o ./cv/curriculum-vitae.docx ./src/cv/curriculum-vitae.md
	ln -sf ./cv/curriculum-vitae.html index.html

clean:
	rm -rf cv
	rm index.html

watch:
	nix-shell --pure --run 'watchexec -e md make pages'
