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
$(eval $(d)submodules := $(addsuffix /,app live-blocks provisions))

# Require build modules
include require.mk
$(eval $(d)subexports := $(call require,$(addprefix $(d),$(addsuffix Makefile,$(call $(d)submodules)))))

# Include watch.mk utility
include watch.mk

# app/ submodule export handling
$(eval $(d)appexports :=)
define $(d)template
$(eval $(d)appexports += $(d)dist/$(1))
$(d)dist/$(1): $(d)app/out/$(1)
	mkdir -p $(dir $(d)dist/$(1)) && cp $(d)app/out/$(1) $(d)dist/$(1)
endef
$(foreach var,$(patsubst $(d)app/out/%,%,$(filter $(d)app/out/%,$(call $(d)subexports))),$(eval $(call $(d)template,$(var))))
$(eval $(d)template :=)

# Dist file copy rules
$(eval $(d)distfiles := $(call $(d)appexports))
define $(d)template
$(eval $(d)distfiles += $(d)$(2))
$(d)$(2): $(d)$(1)
	mkdir -p $(dir $(d)$(2)) && cp $(d)$(1) $(d)$(2)
endef
$(eval $(call $(d)template,live-blocks/live-blocks.js,dist/js/live-blocks.js))
$(eval $(call $(d)template,provisions/angular/angular-1.4.9.min.js,dist/js/angular.js))
$(eval $(call $(d)template,provisions/ui-router/angular-ui-router-0.2.17.min.js,dist/js/angular-ui-router.js))
$(eval $($(d)template) :=)

# Main template
define $(d)template

.PHONY: $(d)dist
$(call helpdoc,$(d)dist)
$(d)dist: $(call $(d)distfiles)

.PHONY: $(d)clean
$(call helpdoc,$(d)clean)
$(d)clean: $(addprefix $(d),$(addsuffix clean,$(filter-out live-blocks/ provisions/,$(call $(d)submodules))))
	rm -rf $(d)dist/

$(eval .DEFAULT_GOAL := help)
endef
$(eval $(call $(d)template))
$(eval $(d)template :=)

# Clear local variables
$(eval $(d)submodules :=)
$(eval $(d)subexports :=)
$(eval $(d)appexports :=)
$(eval $(d)distfiles :=)

