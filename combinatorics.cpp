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
Examples:
fact(0) => 1
fact(1) => 1
fact(5) => 120
fact(6) => 720
*/

unsigned long long fact(unsigned int n) {
    if (n == 0 || n == 1) {
        return 1;
    }
    return n * fact(n - 1);
}



/*
Create a test function 'test_fact' to test the 'fact' function.
Requirements:
The function should test the following scenarios:
- fact(0) => 1
- fact(1) => 1
- fact(5) => 120
- fact(6) => 720
- fact(10) => 3628800
The function should use the 'assert' function to check the results.
The function should print "All test cases pass" if all the tests pass.
*/

void test_fact() {
    assert(fact(0) == 1);
    assert(fact(1) == 1);
    assert(fact(5) == 120);
    assert(fact(6) == 720);
    assert(fact(10) == 3628800);
    std::cout << "All test cases pass" << std::endl;
}




