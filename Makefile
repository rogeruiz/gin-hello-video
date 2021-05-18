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

.PHONY: run-dev
run-dev: ## Runs the development server
	@go run server.go

.PHONY: get-videos
get-videos: is-server-running ## Run a curl GET request to /videos and pipe the reponse through jq
	@curl -s localhost:8800/videos | jq

.PHONY: get-videos-auth
get-videos-auth: is-server-running ## Runs a curl GET request with Auth to /videos and pipe the response through jq
	@curl -s -u 'rogeruiz:test' localhost:8800/videos | jq

.PHONY: post-video
post-video: is-server-running ## Run a curl POST request to /videos with TITLE, DESCRIPTION, and URL passed into the JSON payload
	$(call check_defined, TITLE)
	$(call check_defined, DESCRIPTION)
	$(call check_defined, URL)
	@curl -s -X POST -H "Content-Type: application/json" -d '{"title": "${TITLE}", "description": "${DESCRIPTION}", "url": "${URL}"}' localhost:8800/videos

.PHONY: post-video-auth
post-video-auth: is-server-running ## Run a curl POST request with Auth to /videos with TITLE, DESCRIPTION, and URL passed into the JSON payload
	$(call check_defined, TITLE)
	$(call check_defined, DESCRIPTION)
	$(call check_defined, URL)
	@curl -s -X POST -u 'rogeruiz:test' -H "Content-Type: application/json" -d '{"title": "${TITLE}", "description": "${DESCRIPTION}", "url": "${URL}"}' localhost:8800/videos

.PHONY: post-authored-video
post-authored-video: is-server-running ## Run a curl POST request to /videos with TITLE, DESCRIPTION, URL, FIRSTNAME, LASTNAME, AGE, EMAIL passed into the JSON payload
	$(call check_defined, TITLE)
	$(call check_defined, DESCRIPTION)
	$(call check_defined, URL)
	$(call check_defined, FIRSTNAME)
	$(call check_defined, LASTNAME)
	$(call check_defined, AGE)
	$(call check_defined, EMAIL)
	@curl -s -X POST -H "Content-Type: application/json" -d '{"title": "${TITLE}", "description": "${DESCRIPTION}", "url": "${URL}", "author": {"first_name": "${FIRSTNAME}", "last_name": "${LASTNAME}", "age": ${AGE}, "email": "${EMAIL}"}}' localhost:8800/videos

.PHONY: post-authored-video-auth
post-authored-video-auth: is-server-running ## Run a curl POST request with Auth to /videos with TITLE, DESCRIPTION, URL, FIRSTNAME, LASTNAME, AGE, EMAIL passed into the JSON payload
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
