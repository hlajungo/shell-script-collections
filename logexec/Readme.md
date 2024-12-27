A shell script function to log.  
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
third param is "ERROR TEXT", when the command above logexec is failed(not eq 0), it will be output.  

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
The command that is logging will be output, and the SUCCESS TEXT will output too, because `cat t.txt` is success.


