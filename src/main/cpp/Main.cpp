#include <iostream>
#include <fstream>
#include <string>
#include <filesystem>
#include <spdlog/spdlog.h>

int main(int argc, char **argv) {
  using namespace std;
  using namespace std::filesystem;
  auto resourcesDirectory = current_path() / path(argv[0]).parent_path().filename();
  spdlog::info("Resource directory detected: {}", string(resourcesDirectory));
  auto resourceFile = std::ifstream(resourcesDirectory / "Example.txt");
  for (std::string line; getline(resourceFile, line);) {
    spdlog::info("{}", line);
  }
}
