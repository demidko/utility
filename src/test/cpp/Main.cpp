#define CATCH_CONFIG_MAIN

#include <spdlog/spdlog.h>
#include <catch2/catch_test_macros.hpp>

TEST_CASE("Test") {
  REQUIRE(2 + 2 == 4);
}

