Python 学习的流水帐
===================

date: 2015-11-11

-  https://docs.python.org/3/tutorial/index.html

Chapter 2 Using the Python Interpreterg
---------------------------------------

Usage
~~~~~

-  ``python -c command [arg]``: execute statement(s) in command.
-  ``python -m moudle [arg]``: run a moudle.
-  ``python -i``: enter interactive mode.

Specifice encoding
~~~~~~~~~~~~~~~~~~

add ``# -*- coding: encoding -*-`` at the next line of
shebang(\ ``#!``), UTF-8 by default.

Chapter 3 A Informal Introduction to Pythong
--------------------------------------------

Operator
~~~~~~~~

-  ``**``: power, ``2**3`` produce 8.
-  ``//``: divison, but get an integrer result(discarding any fractional
   result).

other operators are similar to C's.

``_`` is a build-in variable **in interactive mode**, was assigned by
the last printed expression.

example:

.. code:: python

    >>> 3/2
    1.5
    >>> 3//2
    1
    >>> 2**3
    8
    >>> _
    8

String
~~~~~~

-  use single quotes ``'...'`` or double quotes ``"..."`` to enclose a
   string.
-  use ``\`` as a escape char.
-  raw string: add ``r`` as prefix.

.. code:: python

    >>> print('C:\some\name')  # here \n means newline!
    C:\some
    ame
    >>> print(r'C:\some\name')  # note the r before the quote
    C:\some\name

-  span multiple lines: use triple-quotes: ``'''...'''`` or
   ``"""..."""``, add a '' at the end of line to prevent a new line.

.. code:: python

    >>> print("""\
    ... Usage: thingy [OPTIONS]
    ...     -h                        Display this usage message
    ...     -H hostname               Hostname to connect to
    ... """)
    ...
    Usage: thingy [OPTIONS]
         -h                        Display this usage message
         -H hostname               Hostname to connect to

-  concat:

.. code:: python

    >>> 3 * 'un' + 'ium'
    'unununium'
    >>> 'Py' 'thon'
    'Python'
    >>> text = ('123'
    ...         '456')
    >>> text
    '123456'

-  subscript

+------+------+------+------+------+------+
| P    | y    | t    | h    | o    | n    |
+======+======+======+======+======+======+
| 0    | 1    | 2    | 3    | 4    | 5    |
+------+------+------+------+------+------+
| -6   | -5   | -4   | -3   | -2   | -1   |
+------+------+------+------+------+------+

example:

.. code:: python

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

    **Note:** \* -0 is the same as 0, negative index start from -1. \*
    Start is always included, and the end always excluded. \* Python
    strings cannot be changed (immutable) \* out of range slice indexes
    are handled gracefully when used for slicing

Chapter 4 More Control Flow Toolsg
----------------------------------

Statement
~~~~~~~~~

-  ``pass`` statments: do nothing
-  ``if`` statments

.. code:: python

    if x = y:
        pass
    elif x = z:
        pass
    else:
        pass

-  ``for`` statement

.. code:: python

    for i in range(1, 10):
        # do sth
    else:
        # 循环正常结束时被执行
        # do sth

-  ``while`` statement

.. code:: python

    while i < n:
        # do sth
    else:
        # 循环正常结束时被执行
        # do sth

Defining function
~~~~~~~~~~~~~~~~~

Keyword argument
^^^^^^^^^^^^^^^^

Using the form ``kwarg = value`` as argument of functions, ``value`` is
default value of this argument and assignment is optional when called.

.. code:: python

    >>> def parrot(voltage, state='a stiff', action='voom', type='Norwegian Blue'):
    ...    print("-- This parrot wouldn't", action, end=' ')
    ...    print("if you put", voltage, "volts through it.")
    ...    print("-- Lovely plumage, the", type)
    ...    print("-- It's", state, "!")
    ...

    parrot(1000)                                          # 1 positional argument
    parrot(voltage=1000)                                  # 1 keyword argument
    parrot(voltage=1000000, action='VOOOOOM')             # 2 keyword arguments
    parrot(action='VOOOOOM', voltage=1000000)             # 2 keyword arguments
    parrot('a million', 'bereft of life', 'jump')         # 3 positional arguments
    parrot('a thousand', state='pushing up the daisies')  # 1 positional, 1 keyword

    **Note:** In a function call: \* keyword arguments must follow
    positional arguments. \* All the keyword arguments passed must match
    one of the arguments accepted by the function. \* Order of keyword
    arguments is not important. \* Assignment of keyword arguments is
    optional, but keyword arguments also includes non-optional arguments
    \* No argument may receive a value more than once.

Arbitrary Argument Lists
^^^^^^^^^^^^^^^^^^^^^^^^

use ``*argname`` as the last argument when defineing a funciton, then
this function can be called with arbitrary number of arguments. These
argument will be warpped up in a tuple. (zero argument is allowed)

.. code:: python

    >>> def arglist(*args):
    ...     list(map(print, args))
    ...
    >>> arglist(1, 2, 3)
    1
    2
    3

if you use ``**argname`` as the last argument, it recieve a dictionary
cotaining all **keyword arguments** except for those corresponding to a
formal parameter.

.. code:: python

    >>> def arglist2(*args, **args2):
    ...     list(map(print, args))
    ...     for k, v in args2.items():
    ...             print(k, v)
    ...
    >>> arglist2(1, 2, 3, a = 'a', b = 'b')
    1
    2
    3
    a a
    b b

Unpacking Argument Lists
^^^^^^^^^^^^^^^^^^^^^^^^

-  write the function call with the ``*``-operator to unpack the
   arguments out of a list or tuple.
-  write the function call with the ``**``-operator to unpack the
   keyword arguments out of a dictionary.

.. code:: python

    >>> def arglist2(*args, **args2):
    ...     list(map(print, args))
    ...     for k,v in args2.items():
    ...             print(k, v)
    ...
    >>> args = [1, 2, 3]
    >>> args2 = {'a': 'a', 'b': 'b'}
    >>> arglist2(*args, **args2)

Lambda Expressions
^^^^^^^^^^^^^^^^^^

.. code:: python

    list(map(lambda x: x + 1, range(1, 10)))

Coding Style
~~~~~~~~~~~~

`PEP 8 <https://www.python.org/dev/peps/pep-0008/>`__: TL;DR

Chapter 8 Exceptiong
--------------------
