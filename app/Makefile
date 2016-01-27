# Define exports
$(eval $(d)exports :=)

# File copy rules
define $(d)template
$(eval $(d)exports += $(d)$(2))
$(d)$(2): $(d)$(1)
	mkdir -p $(dir $(d)$(2)) && cp $(d)$(1) $(d)$(2)
endef
$(eval $(call $(d)template,index.html,out/index.html))
$(eval $(d)template :=)

# Main template
define $(d)template

$(eval include helpdoc.mk)

.PHONY: $(d)clean
$(call helpdoc,$(d)clean)
$(d)clean:
	rm -rf $(d)out/

$(eval .DEFAULT_GOAL := help)
endef
$(eval $(call $(d)template))
$(eval $(d)template :=)

# Set final exports
$(eval exports := $(call $(d)exports))

# Clear local variables
$(eval $(d)exports :=)

