cmake_minimum_required(VERSION 3.0)

string(SHA256 FILE_NAME_HASH ${FILE_NAME})

find_program(XDG_MIME xdg-mime)
if (XDG_MIME)
execute_process(COMMAND ${XDG_MIME} query filetype ${FILE_PATH} OUTPUT_VARIABLE FILE_MIME)
else()
set(FILE_MIME "unsupported")
endif()

get_filename_component(EMBED_FILE_EXT ${EMBED_FILE_PATH} LAST_EXT)

# Substitute encoded HEX content into template source file
if ("${EMBED_FILE_EXT}" STREQUAL ".cpp")
configure_file("${CMAKE_CURRENT_INCLUDE_DIR}/incbin.cpp.in" ${EMBED_FILE_PATH})
elseif ("${EMBED_FILE_EXT}" STREQUAL ".asm")
configure_file("${CMAKE_CURRENT_INCLUDE_DIR}/incbin.asm.in" ${EMBED_FILE_PATH})
else()
message(FATAL_ERROR "Unknown embedded file template extension: ${EMBED_FILE_EXT}")
endif()

