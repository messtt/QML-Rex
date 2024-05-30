cmake_minimum_required(VERSION 3.16)

project(QML-Rex VERSION 1.0 LANGUAGES CXX)

find_package(Qt6 6.2 COMPONENTS Quick Gui REQUIRED)

qt_standard_project_setup(REQUIRES 6.5)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

file(GLOB_RECURSE SRC_FILES src/*.cpp)
file(GLOB_RECURSE HEADER_FILES src/*.hpp)

# Change the name of the executable to avoid conflict
qt_add_executable(QML_RexApp ${SRC_FILES} ${HEADER_FILES}
        src/BackEnd.hpp
        src/BackEnd.cpp)

qt_add_qml_module(QML_RexApp
        URI QML-Rex VERSION 1.0
        QML_FILES
        qml/main.qml
        RESOURCES
        qml.qrc
)

target_link_libraries(QML_RexApp PRIVATE Qt6::Gui Qt6::Quick)
