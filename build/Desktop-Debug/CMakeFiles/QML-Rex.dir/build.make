# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.29

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/mest/Documents/Projets/QML-Rex

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/mest/Documents/Projets/QML-Rex/build/Desktop-Debug

# Include any dependencies generated for this target.
include CMakeFiles/QML-Rex.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/QML-Rex.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/QML-Rex.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/QML-Rex.dir/flags.make

CMakeFiles/QML-Rex.dir/src/main.cpp.o: CMakeFiles/QML-Rex.dir/flags.make
CMakeFiles/QML-Rex.dir/src/main.cpp.o: /home/mest/Documents/Projets/QML-Rex/src/main.cpp
CMakeFiles/QML-Rex.dir/src/main.cpp.o: CMakeFiles/QML-Rex.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/mest/Documents/Projets/QML-Rex/build/Desktop-Debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/QML-Rex.dir/src/main.cpp.o"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/QML-Rex.dir/src/main.cpp.o -MF CMakeFiles/QML-Rex.dir/src/main.cpp.o.d -o CMakeFiles/QML-Rex.dir/src/main.cpp.o -c /home/mest/Documents/Projets/QML-Rex/src/main.cpp

CMakeFiles/QML-Rex.dir/src/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/QML-Rex.dir/src/main.cpp.i"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/mest/Documents/Projets/QML-Rex/src/main.cpp > CMakeFiles/QML-Rex.dir/src/main.cpp.i

CMakeFiles/QML-Rex.dir/src/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/QML-Rex.dir/src/main.cpp.s"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/mest/Documents/Projets/QML-Rex/src/main.cpp -o CMakeFiles/QML-Rex.dir/src/main.cpp.s

# Object files for target QML-Rex
QML__Rex_OBJECTS = \
"CMakeFiles/QML-Rex.dir/src/main.cpp.o"

# External object files for target QML-Rex
QML__Rex_EXTERNAL_OBJECTS =

QML-Rex: CMakeFiles/QML-Rex.dir/src/main.cpp.o
QML-Rex: CMakeFiles/QML-Rex.dir/build.make
QML-Rex: CMakeFiles/QML-Rex.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/home/mest/Documents/Projets/QML-Rex/build/Desktop-Debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable QML-Rex"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/QML-Rex.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/QML-Rex.dir/build: QML-Rex
.PHONY : CMakeFiles/QML-Rex.dir/build

CMakeFiles/QML-Rex.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/QML-Rex.dir/cmake_clean.cmake
.PHONY : CMakeFiles/QML-Rex.dir/clean

CMakeFiles/QML-Rex.dir/depend:
	cd /home/mest/Documents/Projets/QML-Rex/build/Desktop-Debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/mest/Documents/Projets/QML-Rex /home/mest/Documents/Projets/QML-Rex /home/mest/Documents/Projets/QML-Rex/build/Desktop-Debug /home/mest/Documents/Projets/QML-Rex/build/Desktop-Debug /home/mest/Documents/Projets/QML-Rex/build/Desktop-Debug/CMakeFiles/QML-Rex.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/QML-Rex.dir/depend

