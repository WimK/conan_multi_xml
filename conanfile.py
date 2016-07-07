from conans import ConanFile, CMake

class MultiXMLConan(ConanFile):
    name = "multixml"
    version = "0.1"
    settings = "os", "compiler", "build_type", "arch"
    requires = "CMakeMultiGen/0.1@wimk/testing", "libxml2/2.9.3@wimk/testing"
    generators = "cmakemulti"
    #generators = "cmake"