# devtool only

.PHONY: docs examples build debug

docs:
	ldoc --fatalwarnings .

build:
	luarocks make

debug:
	luarocks make CFLAGS="-g"

test:
	busted .

format:
	clang-format src/*.c src/*.h -i
	lua-format **/*.lua **/*.rockspec config.ld -i
	prettier -w *.md

check:
	luacheck src examples spec
	luarocks lint *.rockspec

examples:
	./scripts/run_examples.sh