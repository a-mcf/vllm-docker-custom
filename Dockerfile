ARG BASE_TAG=v0.18.1
FROM vllm/vllm-openai:${BASE_TAG}

# Qwen3.5 requires bleeding-edge transformers (model_type "qwen3_5" / "qwen3_5_text"
# is not recognized by the transformers version bundled in the stock vLLM image).
RUN pip install --no-cache-dir \
    "transformers @ git+https://github.com/huggingface/transformers.git@f2ba019"
