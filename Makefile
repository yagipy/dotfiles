.PHONY: apply

apply:
	github_token="$$(gh auth token)" && \
		sudo darwin-rebuild switch --flake "$(CURDIR)#$$USER" --option access-tokens "github.com=$$github_token"
	/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
