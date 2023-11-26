set dotenv-load

# Build project from a given file
build-project file:
    python3 -m kas build {{file}}

# Build demo
build-demo:
    python3 -m kas build ./projects/demo.yaml
