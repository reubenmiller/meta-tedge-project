## Getting started

1. Checkout the project

    ```sh
    git clone https://github.com/reubenmiller/meta-tedge-project.git
    ```

2. Install just (follow the instructions on the [justfile website](https://just.systems/man/en/chapter_5.html))

3. Install [kas](https://kas.readthedocs.io/en/latest/) (as tool used to managed yocto bitbake projects)

    ```sh
    pip3 install kas
    ```

4. Build the demo image

    **Raspberry Pi**

    ```sh
    just build-demo
    ```

    Or if you want to configure a common sstate cache and download folder to share amongst different projects then can define the following environment files in a local `.env` file:

    *file: .env**

    ```
    SSTATE_DIR=/data/yocto/sstate-cache
    DL_DIR=/data/yocto/downloads
    ```

5. Publish/upload the built image to Cumulocity IoT (requires [go-c8y-cli](https://goc8ycli.netlify.app/) to be installed and a session to be active)

    ```sh
    set-session "your_session"
    just publish
    ```

## Using build tasks

### Build demo (using default machine type)

```sh
just build-demo
```

### Building for a specific machine

```sh
KAS_MACHINE=raspberrypi3-64 just build-demo
```

Or you can save the KAS_MACHINE value in your .env file

```
KAS_MACHINE=raspberrypi3-64
```