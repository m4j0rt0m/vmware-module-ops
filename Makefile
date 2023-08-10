SHELL       := bash
MKFILE_PATH := $(abspath $(firstword $(MAKEFILE_LIST)))
TOP_DIR     := $(shell dirname $(MKFILE_PATH))
BUILD_DIR   := $(TOP_DIR)/build

KEY_NAME    := MOK

KEY_DER     := $(BUILD_DIR)/$(KEY_NAME).der
KEY_PRIV    := $(BUILD_DIR)/$(KEY_NAME).priv
KEY_IMP     := $(BUILD_DIR)/$(KEY_NAME).imp
KEY_DONE    := $(BUILD_DIR)/$(KEY_NAME).done

all: $(KEY_DONE)

clean:
	rm -v $(BUILD_DIR)/*

%.done: %.priv %.der %.imp
	sudo ./sign.sh $*.der $*.priv $@

%.der %.priv:
	mkdir -p build
	openssl req -new -x509 -newkey rsa:2048 -keyout $*.priv -outform DER -out $*.der -nodes -days 36500 -subj "/CN=MSI/"
	chmod 600 $*.priv

%.imp: %.der
	sudo mokutil --import $<
	echo "IMPORTED!" > $@
