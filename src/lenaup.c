
#include <llibs.h>

lm up(lu32 argc, lc8* argv[]) {
    llibs_init();
    lcout(X("Hello World!"));
    return L_EXIT_SUCCESS;
}