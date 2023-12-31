SHELL       := bash
MKFILE_PATH := $(abspath $(firstword $(MAKEFILE_LIST)))
TOP_DIR     := $(shell dirname $(MKFILE_PATH))
BUILD_DIR   := $(TOP_DIR)/build

KEY_NAME    := MOK

KEY_DER     := $(BUILD_DIR)/$(KEY_NAME).der
KEY_PRIV    := $(BUILD_DIR)/$(KEY_NAME).priv
KEY_IMP     := $(BUILD_DIR)/$(KEY_NAME).imp
KEY_DONE    := $(BUILD_DIR)/$(KEY_NAME).done

EXIST_OBJS  := $(wildcard $(KEY_DER) $(KEY_PRIV) $(KEY_IMP) $(KEY_DONE))

.PRECIOUS: %.der %.priv %.imp %.done

all: $(KEY_DONE)
	@echo "All done!"

clean:
	@if [ -n "$(EXIST_OBJS)" ]; then \
		rm -vf $(EXIST_OBJS); \
	else \
		echo "Nothing to clean!"; \
	fi

%.done: %.priv %.der %.imp
	@sudo ./sign.sh $*.der $*.priv $@

%.der %.priv:
	@mkdir -p build
	@openssl req -new -x509 -newkey rsa:2048 -keyout $*.priv -outform DER -out $*.der -nodes -days 36500 -subj "/CN=MSI/"
	@chmod 600 $*.priv

%.imp: %.der
	@sudo mokutil --import $<
	@echo "IMPORTED!" > $@
