#include <iostream>
#include <fstream>
#include <string>
#include <filesystem>
#include <spdlog/spdlog.h>

int main(int argc, char **argv) {
  using namespace std;
  using namespace std::filesystem;
  spdlog::info("{}", current_path().string());
  spdlog::info("{}", path(argv[0]).parent_path().string());
  auto resourcesDirectory = current_path() / path(argv[0]).parent_path();
  spdlog::info("{}", resourcesDirectory.string());
  auto resourceFile = std::ifstream(resourcesDirectory / "Example.txt");
  for (std::string line; getline(resourceFile, line);) {
    spdlog::info("{}", line);
  }
}
