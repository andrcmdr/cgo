/*
https://isocpp.org/wiki/faq/mixing-c-and-cpp#include-c-hdrs-personal
http://gcc.gnu.org/onlinedocs/cpp/Standard-Predefined-Macros.html
*/

#ifdef __cplusplus
extern "C" {
#endif

    int test();   
    char* testText();

#ifdef __cplusplus
}
#endif
