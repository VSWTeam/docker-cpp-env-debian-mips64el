# docker-cpp-env-debian-mips64el

C++ mips64el 開發環境，保含下面軟體：

- CMake
- Conan
- SSH server
- GDB server

## 使用方法

### Conan based projects

```
docker run --rm -it -v $(pwd):/project vswteam/cpp-env-debian-mips64el:latest "mkdir -p build && cd build && conan install .. && conan build .."
```
