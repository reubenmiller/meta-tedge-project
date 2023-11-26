set dotenv-load

export IMAGE_VERSION_SUFFIX := env_var_or_default("IMAGE_VERSION_SUFFIX", "_" + `date +%Y%m%d%H%M`)

# Generate a build version
generate-version:
    @echo "{{IMAGE_VERSION_SUFFIX}}"

# Build project from a given file
build-project file:
    python3 -m kas build {{file}}

# Build demo
build-demo:
    python3 -m kas build ./projects/demo.yaml

# Publish image to Cumulocity IoT
publish:
    {{justfile_directory()}}/scripts/publish-c8y.sh
