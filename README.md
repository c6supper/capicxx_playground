# capicxx_playground docker builder
       
- Build docker
    ```
    docker build --progress=plain -t c6supper/capicxx_playground -f docker/Dockerfile ./
    ```
    
- Build release docker
    * change the version
    * Build & Push 
    ```
    ./build-env/build.sh c6supper capicxx_playground release
    ```

_This project with inspired by_ [build-common-api-cpp-native](https://github.com/gunnarx/build-common-api-cpp-native).
