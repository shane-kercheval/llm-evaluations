.PHONY: tests app proto

include .env
export

####
# Environment
####
build-env:
	uv sync

linting:
	uv run ruff check src/llm_evaluations
	uv run ruff check tests

unittests: proto
	uv run pytest --durations=0 --durations-min=0.1 tests

tests: linting unittests

package-build:
	rm -rf dist/*
	uv build --no-sources

package-publish:
	uv publish --token ${UV_PUBLISH_TOKEN}

package: package-build package-publish
