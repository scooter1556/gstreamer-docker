# Build Images

 - Enable Cross-compilation

    `docker run --rm --privileged multiarch/qemu-user-static --reset -p yes`

 - Test Build

    `docker buildx build --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag scootsoftware/gstreamer:latest .`
    
 - Build & Load Images

    `docker buildx build --load --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag scootsoftware/gstreamer:latest .`

 - Build & Push Images

    `docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag scootsoftware/gstreamer:latest .`
