/*
This file contains operations used in combinatorics.
*/

#include <iostream>
#include <cassert>

/*
Define a factorial function 'fact' that calculates the factorial of a number.
Arguments:
'n' - an unsigned integer
Return:
unsigned long long.
Requirements:
- The function should use recusion.
Implementation details:
- If n == 0 or n == 1, return 1
- return n * fact(n - 1)
*/

unsigned long long fact(unsigned int n) {
    if (n == 0 || n == 1) {
        return 1;
    }
    return n * fact(n - 1);
}






