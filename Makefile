
# Default target executed when no arguments are given to make.
all: help

lint:
	hatch fmt --check

format:
	hatch fmt

test:
	hatch test

wheel:
	hatch build

# 'make docs' is a make command, use 'doc' instead of 'docs' to avoid conflict
doc:
	hatch env run -e docs mkdocs build

clean:
	hatch clean

######################
# HELP
######################

help:
	@echo '----'
	@echo 'lint                         - run linters'
	@echo 'format                       - run code formatters'
	@echo 'test                         - run unit tests'
	@echo 'wheel                        - build wheel package'
	@echo 'doc                          - build documentation site'
	@echo 'clean                        - clean up'
