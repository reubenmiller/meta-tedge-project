set dotenv-load

# Use custom work_dir for kas, so the folder can be added to the gitignore list
# but keep the build dir under <project>/build
export KAS_WORK_DIR := env_var_or_default("KAS_WORK_DIR", justfile_directory() + "/_kas")
export KAS_BUILD_DIR := env_var_or_default("KAS_BUILD_DIR", justfile_directory() + "/build")

# Use an auto generated image version suffix (based on date) if one is not provided
export IMAGE_VERSION := env_var_or_default("IMAGE_VERSION", "" + `date +%Y%m%d.%H%M`)
export IMAGE_VERSION_SUFFIX := "_" + IMAGE_VERSION

# Init build folders
init:
    mkdir -p "{{KAS_WORK_DIR}}"
    mkdir -p "{{KAS_BUILD_DIR}}"

# Generate a build version
generate-version:
    @echo "{{IMAGE_VERSION_SUFFIX}}"

# Clean temp build folder
clean:
    @echo "Cleaning tmp folder"
    rm -rf build/tmp

# Clean all build and yocto folders
clean-all:
    @echo "Cleaning all local yocto folders"
    rm -rf build
    rm -rf _kas

# Update project lock file to lock to specific commit per layer
# You need to run this if you are working on a branch and would like up-to-date
# changes
update-lock file *args="": init
    python3 -m kas dump --update --lock {{args}} {{file}} --inplace

# Build project from a given file
build-project file *args="": init
    python3 -m kas build {{file}} {{args}}

# Run custom bitbake command with a given project
bitbake file *args="": init
    python3 -m kas shell {{file}} -c 'bitbake {{args}}'

# Publish image to Cumulocity IoT (requires go-c8y-cli to be installed)
publish *args="":
    {{justfile_directory()}}/scripts/publish-c8y.sh {{args}}

runqemu config="./projects/kirkstone/tedge-rauc.yaml":
    kas shell {{config}} -c 'runqemu'

# Update the lock files of all projects
update-all-locks:
    find ./projects/kirkstone ./projects/scarthgap -maxdepth 1 \( -name "*.yaml" -a ! -name "*.lock.*" \) -exec just update-lock {} \;
