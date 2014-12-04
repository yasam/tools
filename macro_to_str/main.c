#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <time.h>


#define DEFINED_BUT_NO_VALUE
#define DEFINED_INT 3
#define DEFINED_STR "ABC"

#define VALUE_TO_STRING(x) #x
#define VALUE(x) VALUE_TO_STRING(x)
#define VAR_NAME_VALUE(var) #var"="VALUE(var)

/* Some example here */
#pragma message(VAR_NAME_VALUE(NOT_DEFINED))
#pragma message(VAR_NAME_VALUE(DEFINED_BUT_NO_VALUE))
#pragma message(VAR_NAME_VALUE(DEFINED_INT))
#pragma message(VAR_NAME_VALUE(DEFINED_STR))
int main(int argc,char **argv) {

    
    return 0;

}
