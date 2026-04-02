# vllm-docker-custom

Custom vLLM image with bleeding-edge transformers for Qwen3.5 support.

## Why

The stock `vllm/vllm-openai` image bundles transformers 4.57.6, which doesn't recognize Qwen3.5's `qwen3_5` / `qwen3_5_text` model types. This causes failures when loading local Qwen3.5 models (tokenizer, image processor, etc. all go through `AutoConfig` which chokes on the unknown type).

This image layers the required transformers version on top of the stock vLLM image.

## Image

```
ghcr.io/a-mcf/vllm-docker-custom:latest
```

## Usage in Helm

```yaml
repository: ghcr.io/a-mcf/vllm-docker-custom
tag: v0.18.1
```

## Building locally

```bash
docker build -t vllm-custom .
docker build --build-arg BASE_TAG=v0.18.1 -t vllm-custom .
```

## CI

Pushes to `main` trigger a GitHub Actions build that pushes to GHCR. Use `workflow_dispatch` to build with a different base tag.
