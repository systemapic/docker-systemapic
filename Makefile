.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'



restart: ## (Re)Start services
	@echo "Run ./compose/restart.sh"

check-wu:
	docker exec -it localhost_wu_1 grunt test

.PHONY: systemapic-domain

systemapic-domain:
	@test -n "${SYSTEMAPIC_DOMAIN}" || \
    { echo "Please set SYSTEMAPIC_DOMAIN env" >&2 && false; }
	@test -d config/${SYSTEMAPIC_DOMAIN} || \
    { echo "No config/${SYSTEMAPIC_DOMAIN} dir found"; \
      echo "Please tweak SYSTEMAPIC_DOMAIN env variable" && false; } >&2

check-pile: systemapic-domain
	PILE_CONFIG_PATH=${PWD}/config/${SYSTEMAPIC_DOMAIN}/pile-config.js \
	WU_CONFIG_PATH=${PWD}/config/${SYSTEMAPIC_DOMAIN}/wu-config.js \
	$(MAKE) -C modules/pile check

check: check-pile ## Run all tests
