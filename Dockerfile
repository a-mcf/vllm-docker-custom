ARG BASE_TAG=v0.18.1
FROM vllm/vllm-openai:${BASE_TAG}

# Qwen3.5 requires bleeding-edge transformers (model_type "qwen3_5" / "qwen3_5_text"
# is not recognized by the transformers version bundled in the stock vLLM image).
RUN apt-get update && apt-get install -y --no-install-recommends git && \
    pip install --no-cache-dir \
    "transformers @ git+https://github.com/huggingface/transformers.git@f2ba019" && \
    apt-get purge -y git && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Fix RoPE bug: list | set is not supported, need set() wrapper
RUN TF_FILE="$(python3 -c 'import transformers, pathlib; print(pathlib.Path(transformers.__file__).parent / "modeling_rope_utils.py")')" && \
    sed -i 's/ignore_keys_at_rope_validation = ignore_keys_at_rope_validation | {"partial_rotary_factor"}/ignore_keys_at_rope_validation = set(ignore_keys_at_rope_validation) | {"partial_rotary_factor"}/' "$TF_FILE"
