## Description
This is a sciprt for Competitive Programming, it will compile the single cpp file, setting single input, compare with answer, timing, and copy the code to clipboard.  

## Dependence
### xclip
For ubuntu/debian user, you can install it with  
```
sudo apt update
sudo apt install xclip
```
## Usage  
Assume you are at `path/to/code/code.cpp` , use `genCodeRun.sh` to gen `test` dir, the `genCodeRun.sh` can place at any place, put it into env variable is recommanded.  
After that, use `vim test/input.txt` and `vim test/answer.txt` to setting input and answer. Use `./test/run.sh code.cpp` to run.  
If things work well, one kind of output will be
```
Accept, code is copied to clipbroad.
Output.
----------
12345
Time: 6 ms
```
And inside clipboard is 
```
// A simple C++ code (test_code.cpp) which takes  
// one string as input and prints the same string 
// to output 
#include <iostream> 
using namespace std; 

int main()
{
  string S;
  cin >> S;
  cout << S << '\n';

  return 0;
}
```
If the output.txt is different with answer.txt, the output will look like
```
Output.
----------
12345
Answer.
----------
12345678
```
