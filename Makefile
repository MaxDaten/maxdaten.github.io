.PHONY: build update-nixpkgs clean watch

BUILD_DIR=build
SRC_DIR=src

build: pages index domain-metas

$(BUILD_DIR)/cv:
	mkdir -p $@

pages: pdf docx html


index: $(BUILD_DIR)/index.html
$(BUILD_DIR)/index.html: $(BUILD_DIR)/cv/curriculum-vitae.html
	cp -f $< $@


domain-metas:
	cp -r .well-known build
	cp CNAME build


css: $(SRC_DIR)/templates/template.css
$(SRC_DIR)/templates/template.css: $(SRC_DIR)/sass/template.sass
	sass $< $@


docx: $(BUILD_DIR)/cv $(BUILD_DIR)/cv/curriculum-vitae.docx
$(BUILD_DIR)/cv/curriculum-vitae.docx: $(SRC_DIR)/cv/curriculum-vitae.md
	pandoc \
		--standalone \
		--write docx \
		--output $@ \
		$(SRC_DIR)/cv/curriculum-vitae.md


pdf: $(BUILD_DIR)/cv $(BUILD_DIR)/cv/curriculum-vitae.pdf
$(BUILD_DIR)/cv/curriculum-vitae.pdf: $(SRC_DIR)/cv/curriculum-vitae.md $(SRC_DIR)/templates/base.tex
	pandoc \
		--include-in-header $(SRC_DIR)/templates/base.tex \
		$(SRC_DIR)/cv/curriculum-vitae.md \
		--output $@ \


html: $(BUILD_DIR)/cv $(BUILD_DIR)/cv/curriculum-vitae.html
$(BUILD_DIR)/cv/curriculum-vitae.html: build/cv $(SRC_DIR)/cv/curriculum-vitae.md $(SRC_DIR)/templates/template.css $(SRC_DIR)/templates/template.html
	pandoc \
		--self-contained \
		--write html5 \
		--output $(BUILD_DIR)/cv/curriculum-vitae.html \
		--css $(SRC_DIR)/templates/template.css \
		--template $(SRC_DIR)/templates/template.html \
		--verbose \
		$(SRC_DIR)/cv/curriculum-vitae.md


.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)


install:
	echo "done"


watch:
	nix-shell --pure --run 'watchexec --ignore build make pages'
