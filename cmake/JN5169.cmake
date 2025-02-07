SET(CMAKE_SYSTEM_NAME Generic)

IF(NOT TOOLCHAIN_PREFIX)
     MESSAGE(STATUS "No TOOLCHAIN_PREFIX specified")
ENDIF()

IF (WIN32)
    SET(TOOL_EXECUTABLE_SUFFIX ".exe")
ELSE()
    SET(TOOL_EXECUTABLE_SUFFIX "")
ENDIF()

SET(TARGET_PREFIX "ba-elf")

SET(TOOLCHAIN_BIN_DIR ${TOOLCHAIN_PREFIX}/bin)
SET(TOOLCHAIN_INC_DIR ${TOOLCHAIN_PREFIX}/include)
SET(TOOLCHAIN_LIB_DIR ${TOOLCHAIN_PREFIX}/lib)

#SET(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
IF(NOT CMAKE_C_COMPILER)
	SET(CMAKE_C_COMPILER ${TOOLCHAIN_BIN_DIR}/${TARGET_PREFIX}-gcc${TOOL_EXECUTABLE_SUFFIX})
ENDIF()

IF(NOT CMAKE_CXX_COMPILER)
	SET(CMAKE_CXX_COMPILER ${TOOLCHAIN_BIN_DIR}/${TARGET_PREFIX}-g++${TOOL_EXECUTABLE_SUFFIX})
ENDIF()

MESSAGE(STATUS "======================")
MESSAGE(STATUS "Toolchain paths")

MESSAGE(STATUS "TOOLCHAIN_BIN_DIR = ${TOOLCHAIN_BIN_DIR}")
MESSAGE(STATUS "TOOLCHAIN_INC_DIR = ${TOOLCHAIN_INC_DIR}")
MESSAGE(STATUS "TOOLCHAIN_LIB_DIR = ${TOOLCHAIN_LIB_DIR}")
MESSAGE(STATUS "CMAKE_C_COMPILER = ${CMAKE_C_COMPILER}")
MESSAGE(STATUS "CMAKE_CXX_COMPILER = ${CMAKE_CXX_COMPILER}")

SET(CMAKE_OBJCOPY ${TOOLCHAIN_BIN_DIR}/${TARGET_PREFIX}-objcopy${TOOL_EXECUTABLE_SUFFIX} CACHE INTERNAL "objcopy tool")
SET(CMAKE_OBJDUMP ${TOOLCHAIN_BIN_DIR}/${TARGET_PREFIX}-objdump${TOOL_EXECUTABLE_SUFFIX} CACHE INTERNAL "objdump tool")
SET(CMAKE_SIZE ${TOOLCHAIN_BIN_DIR}/${TARGET_PREFIX}-size${TOOL_EXECUTABLE_SUFFIX} CACHE INTERNAL "size tool")
SET(CMAKE_DEBUGER ${TOOLCHAIN_BIN_DIR}/${TARGET_PREFIX}-gdb${TOOL_EXECUTABLE_SUFFIX} CACHE INTERNAL "debuger")
SET(CMAKE_CPPFILT ${TOOLCHAIN_BIN_DIR}/${TARGET_PREFIX}-c++filt${TOOL_EXECUTABLE_SUFFIX} CACHE INTERNAL "C++filt")

MESSAGE(STATUS "CMAKE_OBJCOPY = ${CMAKE_OBJCOPY}")
MESSAGE(STATUS "CMAKE_OBJDUMP = ${CMAKE_OBJDUMP}")
MESSAGE(STATUS "CMAKE_SIZE = ${CMAKE_SIZE}")
MESSAGE(STATUS "CMAKE_DEBUGER = ${CMAKE_DEBUGER}")
MESSAGE(STATUS "CMAKE_CPPFILT = ${CMAKE_CPPFILT}")

SET(CMAKE_C_FLAGS_DEBUG "-Og -g" CACHE INTERNAL "c compiler flags debug")
SET(CMAKE_CXX_FLAGS_DEBUG "-Og -g" CACHE INTERNAL "cxx compiler flags debug")
SET(CMAKE_ASM_FLAGS_DEBUG "-g" CACHE INTERNAL "asm compiler flags debug")
SET(CMAKE_EXE_LINKER_FLAGS_DEBUG "" CACHE INTERNAL "linker flags debug")
SET(CMAKE_C_FLAGS_RELEASE "-Os -g" CACHE INTERNAL "c compiler flags release")
SET(CMAKE_CXX_FLAGS_RELEASE "-Os -g" CACHE INTERNAL "cxx compiler flags release")
SET(CMAKE_ASM_FLAGS_RELEASE "-g" CACHE INTERNAL "asm compiler flags release")
SET(CMAKE_EXE_LINKER_FLAGS_RELEASE "" CACHE INTERNAL "linker flags release")

SET(CMAKE_C_FLAGS "-march=ba2 -mcpu=jn51xx -mredzone-size=4 -mbranch-cost=3 -fomit-frame-pointer -fshort-enums -Wall -Wpacked -Wcast-align -fdata-sections -ffunction-sections" CACHE INTERNAL "c compiler flags")
SET(CMAKE_CXX_FLAGS "-march=ba2 -mcpu=jn51xx -mredzone-size=4 -mbranch-cost=3 -fomit-frame-pointer -fshort-enums -Wall -Wpacked -Wcast-align -fdata-sections -ffunction-sections -fno-rtti -fno-exceptions -fno-use-cxa-atexit -fno-threadsafe-statics" CACHE INTERNAL "cxx compiler flags")
SET(CMAKE_ASM_FLAGS "-march=ba2 -mcpu=jn51xx -mredzone-size=4 -mbranch-cost=3 -fomit-frame-pointer -fshort-enums -Wall -Wpacked -Wcast-align -fdata-sections -ffunction-sections -fno-use-cxa-atexit -fno-threadsafe-statics" CACHE INTERNAL "asm compiler flags")
SET(CMAKE_EXE_LINKER_FLAGS "-Wl,--gc-sections -Wl,-u_AppColdStart -Wl,-u_AppWarmStart -march=ba2 -mcpu=jn51xx -mredzone-size=4 -mbranch-cost=3 -fomit-frame-pointer -Os -fshort-enums -nostartfiles -fno-rtti -fno-exceptions -fno-use-cxa-atexit -fno-threadsafe-statics -Wl,--gc-sections -Wl,--defsym=__stack_size=5000 -Wl,--defsym,__minimum_heap_size=2000 " CACHE INTERNAL "executable linker flags")
SET(CMAKE_MODULE_LINKER_FLAGS "" CACHE INTERNAL "module linker flags")
SET(CMAKE_SHARED_LINKER_FLAGS "" CACHE INTERNAL "shared linker flags")

MESSAGE(STATUS "======================")
MESSAGE(STATUS "Compiler flags")

MESSAGE(STATUS "CMAKE_C_FLAGS = ${CMAKE_C_FLAGS}")
MESSAGE(STATUS "CMAKE_CXX_FLAGS = ${CMAKE_CXX_FLAGS}")
MESSAGE(STATUS "CMAKE_ASM_FLAGS = ${CMAKE_ASM_FLAGS}")
MESSAGE(STATUS "CMAKE_EXE_LINKER_FLAGS = ${CMAKE_EXE_LINKER_FLAGS}")
MESSAGE(STATUS "CMAKE_MODULE_LINKER_FLAGS = ${CMAKE_MODULE_LINKER_FLAGS}")
MESSAGE(STATUS "CMAKE_SHARED_LINKER_FLAGS = ${CMAKE_SHARED_LINKER_FLAGS}")

MESSAGE(STATUS "CMAKE_C_FLAGS_DEBUG = ${CMAKE_C_FLAGS_DEBUG}")
MESSAGE(STATUS "CMAKE_CXX_FLAGS_DEBUG = ${CMAKE_CXX_FLAGS_DEBUG}")
MESSAGE(STATUS "CMAKE_ASM_FLAGS_DEBUG = ${CMAKE_ASM_FLAGS_DEBUG}")
MESSAGE(STATUS "CMAKE_EXE_LINKER_FLAGS_DEBUG = ${CMAKE_EXE_LINKER_FLAGS_DEBUG}")
MESSAGE(STATUS "CMAKE_C_FLAGS_RELEASE = ${CMAKE_C_FLAGS_RELEASE}")
MESSAGE(STATUS "CMAKE_CXX_FLAGS_RELEASE = ${CMAKE_CXX_FLAGS_RELEASE}")
MESSAGE(STATUS "CMAKE_ASM_FLAGS_RELEASE = ${CMAKE_ASM_FLAGS_RELEASE}")
MESSAGE(STATUS "CMAKE_EXE_LINKER_FLAGS_RELEASE = ${CMAKE_EXE_LINKER_FLAGS_RELEASE}")

SET(CMAKE_FIND_ROOT_PATH ${TOOLCHAIN_PREFIX} ${EXTRA_FIND_PATH})
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

#MESSAGE(STATUS " = ${}")


FUNCTION(ADD_HEX_BIN_TARGETS TARGET)
    IF(EXECUTABLE_OUTPUT_PATH)
      SET(FILENAME "${EXECUTABLE_OUTPUT_PATH}/${TARGET}")
    ELSE()
      SET(FILENAME "${TARGET}")
    ENDIF()
    ADD_CUSTOM_TARGET(OUTPUT "${TARGET}.hex"
        DEPENDS ${TARGET}
        COMMAND ${CMAKE_OBJCOPY} -Oihex ${FILENAME} ${FILENAME}.hex
    )
    ADD_CUSTOM_TARGET("${TARGET}.bin"
        DEPENDS ${TARGET}
        COMMAND ${CMAKE_OBJCOPY} -j .version -j .bir -j .flashheader -j .vsr_table -j .vsr_handlers -j .rodata -j .text -j .data -j .bss -j .heap -j .stack -j .ro_mac_address -j .ro_ota_header -j .pad -S -O binary ${FILENAME} ${FILENAME}.tmp.bin
#        COMMAND "${SDK_PREFIX}\\Tools\\OTAUtils\\JET.exe" -m otamerge --embed_hdr -c ${FILENAME}.tmp.bin -v JN516x -n 1 -t 1 -u 0x1037 -j "HelloZigbee2021                 " -o ${FILENAME}.bin
        COMMAND python3 "${SDK_PREFIX}/Tools/OTAUtils/jn_encryption_tool.py" -m otamerge --embed_hdr -c ${FILENAME}.tmp.bin -v JN516x -n 1 -t 1 -u 0x1037 -j "HelloZigbee2021                 " -o ${FILENAME}.bin
    )
ENDFUNCTION()

FUNCTION(ADD_OTA_BIN_TARGETS TARGET)
    IF(EXECUTABLE_OUTPUT_PATH)
      SET(FILENAME "${EXECUTABLE_OUTPUT_PATH}/${TARGET}")
    ELSE()
      SET(FILENAME "${TARGET}")
    ENDIF()
    ADD_CUSTOM_TARGET(${TARGET}.ota
        DEPENDS ${TARGET}.bin
	# HACK/TODO: setting file version to 2 (-n 2), so that OTA image is always newer than current version
        COMMAND python3 "${SDK_PREFIX}/Tools/OTAUtils/jn_encryption_tool.py" -m otamerge --embed_hdr -c ${FILENAME}.tmp.bin -v JN516x -n 2 -t 1 -u 0x1037 -j "HelloZigbee2021                 " -o ${FILENAME}.bin
        COMMAND python3 "${SDK_PREFIX}/Tools/OTAUtils/jn_encryption_tool.py" -m otamerge --ota -v JN516x -n 2 -t 1 -u 0x1037 -p 1 -c ${FILENAME}.bin -o ${FILENAME}.ota
    )
ENDFUNCTION()

FUNCTION(ADD_DUMP_TARGET TARGET)
    IF(EXECUTABLE_OUTPUT_PATH)
      SET(FILENAME "${EXECUTABLE_OUTPUT_PATH}/${TARGET}")
    ELSE()
      SET(FILENAME "${TARGET}")
    ENDIF()
    ADD_CUSTOM_TARGET(${TARGET}.dump DEPENDS ${TARGET} COMMAND ${CMAKE_OBJDUMP} -x -D -S -s ${FILENAME} | ${CMAKE_CPPFILT} > ${FILENAME}.dump)
ENDFUNCTION()

FUNCTION(PRINT_SIZE_OF_TARGETS TARGET)
    IF(EXECUTABLE_OUTPUT_PATH)
      SET(FILENAME "${EXECUTABLE_OUTPUT_PATH}/${TARGET}")
    ELSE()
      SET(FILENAME "${TARGET}")
    ENDIF()
    add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${CMAKE_SIZE} ${FILENAME})
ENDFUNCTION()

FUNCTION(FLASH_FIRMWARE_TARGET TARGET)
    IF(EXECUTABLE_OUTPUT_PATH)
      SET(FILENAME "${EXECUTABLE_OUTPUT_PATH}/${TARGET}")
    ELSE()
      SET(FILENAME "${TARGET}")
    ENDIF()
    add_custom_target(${TARGET}.flash DEPENDS ${TARGET}.bin COMMAND "C:\\NXP\\ProductionFlashProgrammer\\JN51xxProgrammer.exe" -V 0 -s COM3 -f ${FILENAME}.bin)
ENDFUNCTION()
