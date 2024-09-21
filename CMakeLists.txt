cmake_minimum_required(VERSION 3.25.1)

project(reproduce_ASAN_crash VERSION 1.0)

option(WITH_ASAN"Build with address sanitizer" NO)
if(WITH_ASAN)
  add_compile_options(-fsanitize=address)
  add_link_options(-fsanitize=address)
endif()

include(FetchContent)
FetchContent_Declare(
  or-tools
  GIT_REPOSITORY https://github.com/google/or-tools.git
  GIT_TAG v9.11
  GIT_SHALLOW TRUE
  FIND_PACKAGE_ARGS "9.11...<9.12" REQUIRED CONFIG NAMES ortools)
FetchContent_MakeAvailable(or-tools)

add_executable(reproduce_ASAN_crash reproduce_ASAN_crash.cpp)
target_link_libraries(reproduce_ASAN_crash ortools::ortools)
