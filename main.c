#include <string.h>

extern int printfff(const char *str, size_t len);

int main()
{
	const char *test = "Test 1123123123123\n";
	printfff(test, strlen(test));
	return 0;
}