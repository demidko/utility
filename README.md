# Utility

A cross-platform `C++20` command line tool template.

## Usage

Make sure you are signed in to your GitHub account, then just
click [`here`](https://github.com/demidko/utility/generate) to use template.

## Build

We need [GCC](https://gcc.gnu.org) or [LLVM](https://llvm.org) toolset, and [xmake](https://xmake.io) build system:

```shell
xmake # build
xmake run test # run unit tests (optional)
xmake install -o release app # the app wil be located at './release'
```

After that, we can run the app:

```shell
./release/bin/app
```

## Containerization

To build the image, we need [Docker](https://www.docker.com/) installed:

```shell
docker build . -t app
```

After that, we can run the app in the container (if needed):

```shell
docker run -v `pwd`:`pwd` -w `pwd` -it --rm -p 80:80 app
```

To clean up docker use `docker system prune -fa`

## Development with IDE

Some IDEs require a project configuration in a specific format.

* CLion - run `xmake project -k cmake`
* Visual Studio - run `xmake project -k vs`
* Xcode - run `xmake project -k xcode`

For everyone else see `xmake project -h`

## Code style & conventions

* In all cases, use constant references (const T &)
  or [TriviallyCopyable](https://en.cppreference.com/w/cpp/named_req/TriviallyCopyable) for parameters by default.
* To initialize resources, we're using [modern parameter passing by value](https://habr.com/ru/post/460955/), rather
  than a constant link.
* Only the result of the compilation of `* .cpp` files in the` src` folder is included in the release assembly.
* The `src` folder contains the` *.cpp` and `*.h` project files together.
* The `test` folder contains the` *.cpp` and `*.h` project test files together.
* Each `*.h` file must define only one entity in the global namespace, whose name must match the file name.
* The contents of `*.cpp` files not declared in` *.h` file must be protected from `external linkage` from others
  compilation units by adding them to the anonymous namespace or adding the keyword `static`.