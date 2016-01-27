# Define exports
$(eval $(d)exports :=)

# File copy rules
define $(d)template
$(eval $(d)exports += $(d)out/$(2))
$(d)out/$(2): $(d)$(1)
	mkdir -p $(dir $(d)out/$(2)) && cp $(d)$(1) $(d)out/$(2)
endef
$(eval $(call $(d)template,index.html,index.html))
$(eval $(call $(d)template,index.html,demo/index.html))
$(eval $(call $(d)template,partials/demo.html,partials/demo.html))
$(eval $(d)template :=)

# Javascript concatenation order
$(eval $(d)js_order := $(d)angular-config.js)
$(eval $(d)js_order += $(d)route-config.js)

# Concatenate file rules
define $(d)template
$(eval $(d)exports += $(d)out/$(2))
$(d)out/$(2): $(1)
	mkdir -p $(dir $(d)out/$(2)) && cat $(1) > $(d)out/$(2)
endef
$(eval $(call $(d)template,$(call $(d)js_order),js/app.js))
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
$(eval $(d)js_order :=)

