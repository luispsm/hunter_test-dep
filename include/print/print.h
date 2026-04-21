#pragma once

#include <string_view>

namespace lps::print {
	void print_test(std::string_view str);
	void print_version();
	void print_commit_id();
}
