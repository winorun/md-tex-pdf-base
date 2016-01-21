file=notebook.md
input=include.tex

build:./.build/main.pdf
	@cp ./.build/include.pdf ./notebook.pdf
./.build/main.pdf:$(input)
	xelatex -output-directory=.build .build/include.tex 
	@xelatex -output-directory=.build .build/include.tex > /dev/null

$(input):$(file) mkbuild
	@pandoc $(file) --template=.template.tex -o ./.build/$(input) --listing --no-tex-ligatures --chapter 


mkbuild:
	@rm -f -d -r  ./.build
	@mkdir ./.build
