A shell script function to log a command state.  
### Dep
bash

### Usage Example
AnyShellScript.sh
```
cat t.txt

logexec $? \
  "SUC" \
  "ERR"
```
first param is fixed.  
second param is "SUCCESS TEXT", when the command above logexec is success, it will be output.  
third param is "ERROR TEXT", when the command above logexec is failed ( $? not eq 0), it will be output.  

t.txt
```
123
```
After `./AnyShellScript.sh`, on terminal
```
123
cat t.txt
SUC
```
The command that is logging will be output, and the SUCCESS TEXT will output too, because `cat t.txt` is successed.

### Usage Example 2
Same as `Usage Example`, but
```
cat \
  \
  \
  \
\
t.txt

logexec $? \
  "SUC" \
  "ERR"
```
Output on terminal will be
```
123
cat \
  \
  \
  \
\
t.txt
SUC
```
The "\\" will be detected and find until the command don't have "\\".

