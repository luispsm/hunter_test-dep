#include <print/print.h>

#include <iostream>

namespace lps::print {
	void print_test(std::string_view str) {
		std::cout << str << std::endl;
	}
}
