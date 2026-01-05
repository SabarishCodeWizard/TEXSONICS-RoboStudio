# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appsampleUI_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appsampleUI_autogen.dir/ParseCache.txt"
  "appsampleUI_autogen"
  )
endif()
