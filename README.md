# Native Utility

The cross-platform C++20 command line tool template.

## Usage

Make sure you are signed in to your GitHub account, then just
[click here](https://github.com/demidko/native-utility/generate) to use template.

## Download

GitHub CI automatically generates versions of the application for different operating systems. See the Actions Tab.


## Build

We need [GCC](https://gcc.gnu.org) or [LLVM](https://llvm.org) or [Visual Studio](https://visualstudio.microsoft.com/)
toolchain, and [xmake](https://xmake.io) build system.

```shell
xmake
```

After that, we can run the release app:

```shell
./build/main/app
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

To clean up Docker use `docker system prune -fa`

## Interop with Java

See [JNR project](https://github.com/jnr/jnr-ffi).

## Development with IDE

Some IDEs require a project configuration in a specific format. You can configure project with other build system:

* CLion, VS Code:
  ```shell
  xmake project -k cmake
  ```
* Visual Studio
  ```shell
  xmake project -k vc
  ```
* Xcode:
  ```shell
  xmake project -k xcode
  ```

* For someone else see:
  ```shell
  xmake project -h
  ```

## Code style & Conventions

* The entry point must be located in the `./src/main/cpp/Main.cpp` file for correct build script work.
* Use functional style.
  ```c++
  auto x = User("John"); // good, functional
  auto x = User{"John"}; // bad, no need '{..}' with functional initialization.
  User x = User("John"); // bad, old style!

  auto listUsers() -> vector<User> {} // good, clean code
  void listUsers(vector<User> to&) {} // bad, C++03 old style
  ```
* Always use const lvalue (const T &)
  or [TriviallyCopyable](https://en.cppreference.com/w/cpp/named_req/TriviallyCopyable) for readonly parameters.
  ```c++
  auto readFrom(const Book &book) {} // good, no copy
  auto readFrom(Book book) {} // bad, copying!
  
  auto print(string_view text) {} // good, no copy
  auto print(string text) {} // bad, copying!
  ```
* To initialize resources, we're using [modern parameter passing by value](https://habr.com/ru/post/460955/), rather
  than a constant link.
  ```c++
  class Example { 
    private: 
      data field;
    public: 
      Example(data v): field(move(v)) {} // good, no copy
      Example(const data &v): field(v) {} // bad, copying!
  };
  ```
* Use rvalue links (T &&) only in move constructors.
  ```c++
  class Example {
      <...>
    public: 
      Example(Example &&other): data(move(other.data)) {} // good, move resources.
  
      Example(AnotherType &&v): field(v) {} // very bad! Use passing-by-value-then-move instead.
      Example(AntoherType v): field(move(v)) {} // good, no copy
  };
  
  auto readSomeone(Book &&book) {} // bad, use const Book &. No need moving there!
  ```
* Only the result of the compilation of `* .cpp` files in the` src/main` folder is included in the release assembly.
* The `src/main` folder contains the` *.cpp` and `*.h` project files together.
* The `src/test` folder contains the` *.cpp` and `*.h` project test files together.
* Each `*.h` file must define only one entity in the global namespace, whose name must match the file name.
* The contents of `*.cpp` files not declared in` *.h` file must be protected from `external linkage` from others
  compilation units by adding them to the anonymous namespace or adding the keyword `static`.