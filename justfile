set dotenv-load

# Use an auto generated image version suffix (based on date) if one is not provided
export IMAGE_VERSION_SUFFIX := env_var_or_default("IMAGE_VERSION_SUFFIX", "_" + `date +%Y%m%d%H%M`)

# Generate a build version
generate-version:
    @echo "{{IMAGE_VERSION_SUFFIX}}"

# Clean temp build folder
clean:
    @echo "Cleaning tmp folder"
    rm -rf build/tmp

# Build project from a given file
build-project file *args="":
    python3 -m kas build --update {{file}} {{args}}

# Build demo
build-demo *args="":
    python3 -m kas build --update ./projects/demo.yaml {{args}}

# Publish image to Cumulocity IoT (requires go-c8y-cli to be installed)
publish *args="":
    {{justfile_directory()}}/scripts/publish-c8y.sh {{args}}

runqemu config="./projects/demo.yaml":
    kas shell {{config}} -c 'runqemu'
