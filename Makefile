check_defined = \
    $(strip $(foreach 1,$1, \
        $(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
    $(if $(value $1),, \
      $(error Undefined $1$(if $2, ($2))))

.PHONY: run-dev
run-dev: ## Runs the development server
	@go run server.go

.PHONY: get-videos
get-videos: ## Run a curl GET request to /videos and pipe the reponse through jq (requires: make run-dev to be running in another terminal window)
	@curl -s localhost:8800/videos | jq

.PHONY: get-videos-auth
get-videos-auth: ## Runs a curl GET request with Auth to /videos and pipe the respoinse through jq (requires: make run-dev to be running in another terminal window)
	@curl -s -u 'rogeruiz:test' localhost:8800/videos | jq

.PHONY: post-video
post-video: ## Run a curl POST request to /videos with TITLE, DESCRIPTION, and URL passed into the JSON payload
	$(call check_defined, TITLE)
	$(call check_defined, DESCRIPTION)
	$(call check_defined, URL)
	@curl -s -X POST -H "Content-Type: application/json" -d '{"title": "${TITLE}", "description": "${DESCRIPTION}", "url": "${URL}"}' localhost:8800/videos

.PHONY: post-video-auth
post-video-auth: ## Run a curl POST request with Auth to /videos with TITLE, DESCRIPTION, and URL passed into the JSON payload
	$(call check_defined, TITLE)
	$(call check_defined, DESCRIPTION)
	$(call check_defined, URL)
	@curl -s -X POST -u 'rogeruiz:test' -H "Content-Type: application/json" -d '{"title": "${TITLE}", "description": "${DESCRIPTION}", "url": "${URL}"}' localhost:8800/videos

.PHONY: post-authored-video-auth
post-authored-video-auth: ## Run a curl POST request with Auth to /videos with TITLE, DESCRIPTION, URL, FIRSTNAME, LASTNAME, AGE, EMAIL passed into the JSON payload
	$(call check_defined, TITLE)
	$(call check_defined, DESCRIPTION)
	$(call check_defined, URL)
	$(call check_defined, FIRSTNAME)
	$(call check_defined, LASTNAME)
	$(call check_defined, AGE)
	$(call check_defined, EMAIL)
	@curl -s -X POST -u 'rogeruiz:test' -H "Content-Type: application/json" -d '{"title": "${TITLE}", "description": "${DESCRIPTION}", "url": "${URL}", "author": {"first_name": "${FIRSTNAME}", "last_name": "${LASTNAME}", "age": ${AGE}, "email": "${EMAIL}"}}' localhost:8800/videos

.PHONY: help
help: ## Outputs this help message.
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
