Python 学习的流水帐
====
date: 2015-11-11

教程是：https://docs.python.org/3/tutorial/index.html  
虽然奎宁一开始就安利了 aiohttp 和 lxml，虽说 python 易学，可是感觉这些东西还是在我的理解范围之外……先放着好了

# Chapter 2 Using the Python Interpreter¶
## Usage
* `python -c command [arg]`: execute statement(s) in command.
* `python -m moudle [arg]`: run a moudle.
* `python -i`: enter interactive mode.

## Specifice encoding
add `# -*- coding: encoding -*-` at the next line of shebang(`#!`), UTF-8 by default.

# Chapter 3 A Informal Introduction to Python¶
## Operator
* `**`: power, `2**3` produce 8.
* `//`: divison, but get an integrer result(discarding any fractional result).

other operators are similar to C's.

`_` is a build-in variable **in interactive mode**, was assigned by the last printed expression.

example:

```python
>>> 3/2
1.5
>>> 3//2
1
>>> 2**3
8
>>> _
8
```

## String
* use single quotes `'...'` or double quotes `"..."` to enclose a string.
* use `\` as a escape char.
* raw string: add `r` as prefix.

```
>>> print('C:\some\name')  # here \n means newline!
C:\some
ame
>>> print(r'C:\some\name')  # note the r before the quote
C:\some\name
```

* span multiple lines: use triple-quotes: `'''...'''` or `"""..."""`, add a '\' at the end of line to prevent a new line.

```python
>>> print("""\
... Usage: thingy [OPTIONS]
...     -h                        Display this usage message
...     -H hostname               Hostname to connect to
... """)
...
Usage: thingy [OPTIONS]
     -h                        Display this usage message
     -H hostname               Hostname to connect to
```

* concat:

```
>>> 3 * 'un' + 'ium'
'unununium'
>>> 'Py' 'thon'
'Python'
>>> text = ('123'
...         '456')
>>> text
'123456'
```

* subscript

```
 P | y | t | h | o | n
---|---|---|---|---|---
 0 | 1 | 2 | 3 | 4 | 5
-6 |-5 |-4 |-3 |-2 |-1
```

example:

```python
>>> word = 'Python'
>>> word[0]
'P'
>>> word[-1]
'n'
>>> word[0:2]   # characters from position 0 (included) to 2 (excluded)
'Py'
>>> word[-2:]   # characters from the second-last (included) to the end
'on'
>>> word[:2]    # character from the beginning to position 2 (excluded)
'Py'
>>> word[4:42]  # out of range slice indexes are handled gracefully when used for slicing
'on'
```

> **Note:**
> * -0 is the same as 0, negative index start from -1.
> * Start is always included, and the end always excluded.
> * Python strings cannot be changed (immutable)
> * out of range slice indexes are handled gracefully when used for slicing
