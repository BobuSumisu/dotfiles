IGNORES	=	--ignore="\."
IGNORES += 	--ignore="\.git*"
IGNORES += 	--ignore="Makefile"
IGNORES += 	--ignore="README.md"

ifeq ($(strip $(TARGET)),)
	TARGET_DIR=$(HOME)
else
	TARGET_DIR=$(TARGET)
endif

info:
	@echo "To install into your \$$HOME, simply run:"
	@echo 
	@echo "  \$$ make install"
	@echo 
	@echo "To install into another directory, set the \$$TARGET envar:"
	@echo 
	@echo "  \$$ TARGET=/tmp/foo make install"	
	@echo
	@echo "To do a dry run (no actuall file changes):"
	@echo
	@echo "  \$$ make dry-install"
	@echo
	@echo "Finally to un-/reinstall:"
	@echo
	@echo "  \$$ make uninstall"
	@echo "  \$$ make reinstall"

install:
	@stow -v -S -t $(TARGET_DIR) $(IGNORES) .

uninstall:
	@stow -v -D -t $(TARGET_DIR) $(IGNORES) .

reinstall:
	@stow -v -R -t $(TARGET_DIR) $(IGNORES) .

dry-install:
	@stow -n -v -S -t $(TARGET_DIR) $(IGNORES) .

.PHONY: info install uninstall dry-install
