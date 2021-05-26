check_defined = \
    $(strip $(foreach 1,$1, \
        $(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
    $(if $(value $1),, \
      $(error Undefined $1$(if $2, ($2))))

.PHONY: is-server-running
is-server-running:
	@nc -zv 127.0.0.1 8800 &> /dev/null || \
		if [ $$? -eq 1 ]; then echo "The development server is not running.\nRun \`make run-dev\` in another terminal."; false; fi

.PHONY: is-jq-installed
is-jq-installed:
	@which jq &> /dev/null || \
		if [ $$? -eq 1 ]; then echo "The \`jq\` CLI is not installed.\nPlease install \`jq\` from https://stedolan.github.io/jq/download/."; false; fi

.PHONY: is-httpie-installed
is-httpie-installed:
	@which http &> /dev/null || \
		if [ $$? -eq 1 ]; then echo "The \`httpie\` CLI is not installed.\nPlease install \`httpie\` from https://httpie.io/."; false; fi

.PHONY: clean-data-files
clean-data-files: ## Cleans up any migrations/tmp-data.json files that are ignored by Git.
	@echo "Removing data files:"
	@rm -rvf migrations/tmp-data.json

.PHONY: clean-vendor-files
clean-vendor-files: ## Cleans up any templates/vendor files that are ignored by Git.
	@echo "Removing vendor files:"
	@rm -rvf templates/vendor/bootstrap-5.0.1-dist/

.PHONY: expand-vendor-files
expand-vendor-files: ## Expands the compressed vendor files in templates/vendor as a sibling directory. Use this to copy vendored library files manually as needed.
	@echo "Explanding archives found in templates/vendor:"
	@unzip -d templates/vendor/ $(shell find templates/vendor/ -iname 'bootstrap*.zip')

.PHONY: run-dev
run-dev: ## Runs the development server.
	@go run server.go

.PHONY: get-videos
get-videos: is-server-running is-httpie-installed ## Run a curl GET request to /videos and pipe the reponse through `jq`.
	@http :8800/api/videos

.PHONY: get-videos-auth
get-videos-auth: is-server-running is-httpie-installed ## Runs a curl GET request with Basic Auth to /videos and pipe the response through `jq`.
	@http -a 'rogeruiz:test' :8800/api/videos

.PHONY: post-video
post-video: generate-json is-server-running is-httpie-installed ## Run a curl POST request to /videos with TITLE, DESCRIPTION, and URL passed into the JSON payload.
	$(call check_defined, TITLE)
	$(call check_defined, DESCRIPTION)
	$(call check_defined, URL)
	@http POST :8800/api/videos < ./migrations/tmp-data.json

.PHONY: post-video-auth
post-video-auth: generate-json is-server-running is-httpie-installed ## Run a curl POST request with Basic Auth to /videos with TITLE, DESCRIPTION, and URL passed into the JSON payload.
	$(call check_defined, TITLE)
	$(call check_defined, DESCRIPTION)
	$(call check_defined, URL)
	@http -a 'rogeruiz:test' POST :8800/api/videos < ./migrations/tmp-data.json

.PHONY: post-authored-video
post-authored-video: generate-json-with-author is-server-running is-httpie-installed ## Run a curl POST request to /videos with TITLE, DESCRIPTION, URL, FIRSTNAME, LASTNAME, AGE, EMAIL passed into the JSON payload.
	$(call check_defined, TITLE)
	$(call check_defined, DESCRIPTION)
	$(call check_defined, URL)
	$(call check_defined, FIRSTNAME)
	$(call check_defined, LASTNAME)
	$(call check_defined, AGE)
	$(call check_defined, EMAIL)
	@http POST :8800/api/videos < ./migrations/tmp-data.json

.PHONY: post-authored-video-auth
post-authored-video-auth: generate-json-with-author is-server-running is-httpie-installed ## Run a curl POST request with Basic Auth to /videos with TITLE, DESCRIPTION, URL, FIRSTNAME, LASTNAME, AGE, EMAIL passed into the JSON payload.
	$(call check_defined, TITLE)
	$(call check_defined, DESCRIPTION)
	$(call check_defined, URL)
	$(call check_defined, FIRSTNAME)
	$(call check_defined, LASTNAME)
	$(call check_defined, AGE)
	$(call check_defined, EMAIL)
	@http -a 'rogeruiz:test' POST :8800/api/videos < ./migrations/tmp-data.json

.PHONY: quick-seed-db
quick-seed-db: is-server-running ## Run a very quick and simple seeding of the memory-cache for testing
	@./migrations/seed-db.sh

.PHONY: generate-json
generate-json: is-jq-installed clean-data-files ## Generates JSON for un-authored video posts with `jq` and saves them to ./migrations/tmp-data.json
	$(call check_defined, TITLE)
	$(call check_defined, DESCRIPTION)
	$(call check_defined, URL)
	jq -n \
  --arg TITLE "${TITLE}" \
  --arg DESCRIPTION "${DESCRIPTION}" \
  --arg URL "${URL}" \
  --raw-output \
  -f ./migrations/data-template.json \
> ./migrations/tmp-data.json

.PHONY: generate-json-with-author
generate-json-with-author: is-jq-installed clean-data-files ## Generates JSON for authored video posts with `jq` and saves them to ./migrations/tmp-data.json
	$(call check_defined, TITLE)
	$(call check_defined, DESCRIPTION)
	$(call check_defined, URL)
	$(call check_defined, FIRSTNAME)
	$(call check_defined, LASTNAME)
	$(call check_defined, AGE)
	$(call check_defined, EMAIL)
	jq -n \
  --arg TITLE "${TITLE}" \
  --arg DESCRIPTION "${DESCRIPTION}" \
  --arg URL "${URL}" \
  --arg FIRSTNAME "${FIRSTNAME}" \
  --arg LASTNAME "${LASTNAME}" \
  --argjson AGE "${AGE}" \
  --arg EMAIL "${EMAIL}" \
  --raw-output \
  -f ./migrations/data-template-with-author.json \
> ./migrations/tmp-data.json

.PHONY: help
help: ## Outputs this help message.
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
