## Getting started

1. Install kas

    ```
    pip3 install kas
    ```

2. Install just (follow the instructions on the [justfile website](https://just.systems/man/en/chapter_5.html))

3. Checkout this repository

    ```sh
    git clone https://github.com/reubenmiller/meta-tedge-project.git
    ```

4. Build the default image

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