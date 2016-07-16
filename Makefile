.PHONY: all clean build
VPATH = ./.build

input=include
# Получаем имена файлов markdown без README.md
files := $(filter-out README.md,$(wildcard *.md))
# Получаем имя первого файла без суфикса
output:=$(word 1,$(basename $(files)))
#~ --metadata=size:a4paper - для pandoc
#Определяем тип документа например scrartcl
type := $(word 2,$(shell cat config.yaml | grep -i type))

#Если тип scrreprt или scrbook добавляем при компиляции --chapter
#Можно добавить и другие типы которые начинают нумерацию с \chapter
flag := $(if $(filter-out scrreprt scrbook,$(type)),,--chapter)

all: $(input).tex 
	@cp .build/$(input).pdf ./$(output).pdf

$(input).tex: $(files) .build config.yaml
	@echo "Собираем" $@
	pandoc $(files) config.yaml --template=.template.tex -o ./.build/$@ --listing --no-tex-ligatures $(flag)
	xelatex -output-directory=.build $(input).tex
	@xelatex -output-directory=.build $(input).tex > /dev/null 

.build:
	@rm -f -d -r  ./.build
	@mkdir ./.build


