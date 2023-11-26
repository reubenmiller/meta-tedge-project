## Getting started

1. Install kas

    ```
    pip install kas
    ```

2. Checkout this repository

    ```sh
    git clone https://github.com/reubenmiller/meta-tedge-project.git
    ```

3. Build the default image

    **Raspberry Pi**

    ```sh
    python3 -m kas build ./projects/demo.yaml
    ```

    Or if you want to configure a common sstate cache and download folder to share amongst different projects then you can use the following environment variables:

    ```sh
    export SSTATE_DIR=/data/yocto/sstate-cache
    export DL_DIR=/data/yocto/downloads

    python3 -m kas build ./projects/demo.yaml
    ```
