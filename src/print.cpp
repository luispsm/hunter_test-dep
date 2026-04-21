#include <print/print.h>
#include <print/version.h>

#include <iostream>

namespace lps::print {
	void print_test(std::string_view str) {
		std::cout << str << std::endl;
	}

	void print_version() {
		std::cout << "Version: " << VERSION << std::endl;
	}

	void print_commit_id() {
		std::cout << GIT_COMMIT_HASH << std::endl;
	}
}
