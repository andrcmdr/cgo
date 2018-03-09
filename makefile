# GNU Make build great again!

BINNAME := cgotest
BUILDDIR := build
GOFLAGS :=

.PHONY: help
default help:
	@echo "Usage: make <command>\n"
	@echo "The commands are:"
	@echo "   help        This help info about commands."
	@echo "   all         Binary build and make vendor packge/archive."
	@echo "   build       Build binary."
	@echo "   $(BINNAME)     Just another binary build, again."
	@echo "   vendor      Make vendor package/archive."
	@echo "   raced       Binary build with run-time race-detector."
	@echo "   run         Binary build and run."
	@echo "   run-raced   Binary build and run with run-time race-detector."
	@echo "   vet         Statical verifications of sources."
	@echo "   test        Run tests."

.PHONY: all
all: $(BINNAME) vendor

.PHONY: build
build: $(BINNAME)

.PHONY: $(BINNAME)
$(BINNAME):
	go build -o ./${BINNAME}-${BUILDDIR}/bin/${BINNAME}${RACED} -i ${GOFLAGS}

.PHONY: vendor
vendor:
	mkdir -vp ./${BINNAME}-${BUILDDIR}/src
	cp --preserve=all --parents --copy-contents -rf *.cpp *.h *.go makefile ./${BINNAME}-${BUILDDIR}/src
#	time sleep 0.5
#	tar -vc --lzma -f ./../${BINNAME}-${BUILDDIR}.tar.xz -C ./../ ./${shell basename "`pwd`"}
#	tar -vc --lzma -f ./../${BINNAME}-${BUILDDIR}.tar.xz -C ./../ ./${shell bash -c "echo '`pwd`' | grep -iPo '([/])\K([^/]+)(?=/?$$|$$)'"}
#	tar -vc --lzma -f ./../${BINNAME}-${BUILDDIR}.tar.xz -C ./../ ./${shell bash -c "echo '`pwd`' | pcregrep -io '([/])\K([^/]+)(?=/?$$|$$)'"}
#	tar -vc --lzma -f ./../${BINNAME}-${BUILDDIR}.tar.xz -C ./../ ./${shell echo "`pwd`" | grep -iPo "([/])\K([^/]+)(?=/?$$|$$)"}
#	tar -vc --lzma -f ./../${BINNAME}-${BUILDDIR}.tar.xz -C ./../ ./${shell echo "`pwd`" | pcregrep -io "([/])\K([^/]+)(?=/?$$|$$)"}
	tar -vc --lzma -f ./${BINNAME}-${BUILDDIR}.tar.xz -C ./ ./${BINNAME}-${BUILDDIR}
	@echo "Packaged ${BINNAME}-${BUILDDIR} to ${BINNAME}-${BUILDDIR}.tar.xz"

.PHONY: raced
raced: GOFLAGS := -race ${GOFLAGS}
raced: RACED := -raced
raced: $(BINNAME)

.PHONY: run
run: $(BINNAME)
	time ./${BINNAME}-${BUILDDIR}/bin/${BINNAME}${RACED}

.PHONY: run-raced
run-raced: GOFLAGS := -race ${GOFLAGS}
run-raced: RACED := -raced
run-raced: run

.PHONY: vet
vet:
	go vet -v -n -x -all -cgocall ./*.go

.PHONY: test
test:
	go test ./tests
