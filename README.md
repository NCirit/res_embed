# Embed resources into binary with NASM and CMake

Embed resources into binary with NASM and CMake in a cross-platform way (Linux, Windows and Mac support).

Unlike [xxd_embed](https://github.com/dmikushin/xxd_embed.git), the files are included into an assembly file as a data directly, which is fast even for very large files. In order to compile the assembly file, NASM is deployed on Windows/MacOS, and GNU AS on all other platforms.

## Example

1. Add this `res_embed` project to your CMake project as a submodule:

```
cd some/path
git submodule add https://github.com/dmikushin/res_embed.git
```

2. Integrate `res_embed` project into your `CMakeLists.txt`:

```cmake 
add_subdirectory(some/path/res_embed)
```

3. Embed the following example resource file into an executable using `res_embed` macro:

```
$ cat resource 
Hello, world!
```

```cmake
add_executable(res_example "example.cpp")
res_embed(res_example "resource" ${CMAKE_CURRENT_SOURCE_DIR}/resource)
```

4. Use the embedded resource in your program:

```c++
#include "res_embed.h"

#include <cstdio>

int main(int argc, char* argv[])
{
	printf("%s", res_embed::get("resource"));
	return 0;
}
```

