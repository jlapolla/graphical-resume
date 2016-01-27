# Check for LiveBlocks module
ifeq ($(wildcard $(d)live-blocks/Makefile),) # LiveBlocks is not installed
  # Download LiveBlocks
  include exec.mk
  $(call exec,git clone https://github.com/jlapolla/live-blocks.git live-blocks,Failed to clone https://github.com/jlapolla/live-blocks.git)
endif # End check for LiveBlocks module
# Check for provisions module
ifeq ($(wildcard provisions/Makefile),) # Provisions module is not installed
  # Download provisions module
  include exec.mk
  $(call exec,git clone https://github.com/jlapolla/provisions.git provisions,Failed to clone https://github.com/jlapolla/provisions.git)
endif # End check for provisions module

# List submodules
$(eval $(d)submodules := $(addsuffix /,live-blocks provisions))

# Require build modules
include require.mk
$(eval $(d)subexports := $(call require,$(addprefix $(d),$(addsuffix Makefile,$(call $(d)submodules)))))

# Include watch.mk utility
include watch.mk

# File copy rules
define $(d)template
$(d)$(2): $(d)$(1)
	mkdir -p $(dir $(d)$(2))
	cp $(d)$(1) $(d)$(2)
endef

$(eval $(call $(d)template,live-blocks/live-blocks.js,dist/js/live-blocks.js))
$(eval $(call $(d)template,provisions/angular/angular-1.4.9.min.js,dist/js/angular.js))
$(eval $(call $(d)template,provisions/ui-router/angular-ui-router-0.2.17.min.js,dist/js/angular-ui-router.js))
$(eval $(call $(d)template,index.html,dist/index.html))
$(eval $($(d)template) :=)

# Main template
define $(d)template

.PHONY: $(d)dist
$(call helpdoc,$(d)dist)
$(d)dist: $(addsuffix .js,$(addprefix $(d)dist/js/,live-blocks angular angular-ui-router)) \
  $(addprefix $(d)dist/,index.html)

.PHONY: $(d)clean
$(call helpdoc,$(d)clean)
$(d)clean:
	rm -rf $(d)dist/

$(eval .DEFAULT_GOAL := help)
endef
$(eval $($(d)template))
$(eval $(d)template :=)

# Clear local variables
$(eval $(d)submodules :=)
$(eval $(d)subexports :=)

