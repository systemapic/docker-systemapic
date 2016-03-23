.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'



restart: ## (Re)Start services
	@echo "Run ./compose/restart.sh"

.PHONY: systemapic-domain

systemapic-domain:
	@test -n "${SYSTEMAPIC_DOMAIN}" || \
    { echo "Please set SYSTEMAPIC_DOMAIN env" >&2 && false; }
	@test -d config/${SYSTEMAPIC_DOMAIN} || \
    { echo "No config/${SYSTEMAPIC_DOMAIN} dir found"; \
      echo "Please tweak SYSTEMAPIC_DOMAIN env variable" && false; } >&2

test-config: systemapic-domain
	$(MAKE) -C config/${SYSTEMAPIC_DOMAIN} test-config

check-pile: systemapic-domain
	PILE_CONFIG_PATH=${PWD}/config/${SYSTEMAPIC_DOMAIN}/pile-config.js \
	WU_CONFIG_PATH=${PWD}/config/${SYSTEMAPIC_DOMAIN}/wu-config.js \
	$(MAKE) -C modules/pile check

check-wu-from-host: systemapic-domain test-config
	PILE_CONFIG_PATH=${PWD}/config/${SYSTEMAPIC_DOMAIN}/pile-config.js \
	WU_CONFIG_PATH=${PWD}/config/${SYSTEMAPIC_DOMAIN}/wu-config-test.js \
	$(MAKE) -C modules/wu check

check-wu-from-docker: systemapic-domain
	docker exec -it ${SYSTEMAPIC_DOMAIN}_wu_1 make check

check: check-pile ## Run all tests
