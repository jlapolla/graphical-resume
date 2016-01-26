# Check for LiveBlocks module
ifeq ($(wildcard $(d)live-blocks/Makefile),) # LiveBlocks is not installed
  # Download LiveBlocks
  include exec.mk
  $(call exec,git clone https://github.com/jlapolla/live-blocks.git live-blocks,Failed to clone https://github.com/jlapolla/live-blocks.git)
endif

# Require build modules
include require.mk
$(call ,$(call require,$(addsuffix /Makefile,$(d)live-blocks)))

# Main template
define $(d)template

.DEFAULT_GOAL := help

endef

$(eval $($(d)template))
$(eval $(d)template :=)
