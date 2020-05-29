<div class="reveal">

<div class="slides">

<div class="section">

# Python: A Primer

A HMS Research Computing Training Session

<span class="small"></span>

Alex Truong

alex\_truong@hms.harvard.edu

<https://rc.hms.harvard.edu/>

</div>

<div class="section">

<div class="section">

## Introduction

Why Python?

</div>

<div class="section">

### Python is...

<span class="small"></span>

simple - resembles plain English

easy - no need to declare (in most cases), memory management

clean - whitespace-formatted for visibility

interpreted - good for developing, bad for performance (more on this
later)

</div>

<div class="section">

| Interpreted              | Compiled                              |
| ------------------------ | ------------------------------------- |
| Rapid prototyping        | Faster Performance                    |
| Requires interpreter     | Requires compiler (GCC, etc.)         |
| Dynamic typing (sort of) | Static typing                         |
| Code-level optimization  | Code- and Compiler-level optimization |

</div>

</div>

<div class="section">

<div class="section">

# Accessing Python on O2

</div>

<div class="section">

### Logging into O2

Open a terminal and ssh into o2.hms.harvard.edu

    $ ssh rc_training01@o2.hms.harvard.edu
    rc_training01@o2.hms.harvard.edu's password: 
    
    (snip)
    
    rc_training01@login01:~$

</div>

<div class="section">

### Accessing Python on O2

    $ module avail python
    No modules found!
    Use "module spider" to find all possible modules.
    Use "module keyword key1 key2 ..." to search for all possible modules matching
    any of the "keys".
    
    $ module spider python
    (snip)
       Versions:
          python/2.7.12
          python/3.6.0
    (snip)

</div>

<div class="section">

### Accessing Python on O2 cont'd.

    $ module spider python/2.7.12
    (snip)
    You will need to load all module(s) on any one of the lines below before the "python/2.7.12" module is available to load.
    
          gcc/6.2.0
    (snip)
    
    $ module load gcc/6.2.0 python/2.7.12
    
    $ which python
    /n/app/python/2.7.12/bin/python
    
    $ python
    Python 2.7.12 (default, Sep 27 2017, 13:48:19)
    [GCC 6.2.0] on linux2
    Type "help", "copyright", "credits" or "license" for more information.
    >>>

Today's course will use 2.7.12.

</div>

<div class="section">

### Alternately, virtual environment:

    $ module load gcc/6.2.0 python/2.7.12
    $ which virtualenv
    /n/app/python/2.7.12/bin/virtualenv
    $ virtualenv nameofenv --system-site-packages
    New python executable in nameofenv/bin/python
    Installing setuptools, pip, wheel...done.
    $ source nameofenv/bin/activate
    (nameofenv)$ which python
    ~/nameofenv/bin/python

To deactivate:

    (nameofenv)$ deactivate
    $

</div>

<div class="section">

### Why virtual environment?

Python has modules. if you want to install your own, you need a virtual
environment.

The version on O2 has a certain number of builtin modules; the
`--system-site-packages` flag allows your virtual environment to inherit
those packages so you don't have to reinstall them yourself.

For more information, you can visit our [Personal Python Packages wiki
page](https://wiki.rc.hms.harvard.edu/display/O2/Personal+Python+Packages).

</div>

<div class="section">

### Installing Python modules

To install modules, generally use `pip` or `easy-install` (we recommend
`pip`):

    (nameofenv)$ pip install packagename

If that doesn't work (e.g. you've downloaded the archive manually),
follow the instructions in the provided README file, but it'll go
something like

    (nameofenv)$ python setup.py install

(some will have you use `build` before `install`). Make sure you read
the (hopefully provided) instructions when installing modules manually.

</div>

<div class="section">

### Viewing modules

to see which external modules have been installed/compatible with the
package installer (`pip`):

    $ pip freeze
    bx-python==0.7.3
    cycler==0.10.0
    funcsigs==1.0.2
    matplotlib==1.5.3
    .
    .
    .

</div>

<div class="section">

### Viewing modules cont.

To see ALL modules available on your Python build, type either of:

    $ python -c "help('modules')"

and

    $ python
    Python 2.7.12 (default, Sep 27 2017, 13:48:19)
    [GCC 6.2.0] on linux2
    Type "help", "copyright", "credits" or "license" for more information.
    >>> help('modules')

</div>

<div class="section">

### Viewing modules cont.

and it will output something like:

    Please wait a moment while I gather a list of all available modules...
    
    (there might be some warnings here...)
    
    276-pkg_graph       bisect              keyword             sha
    BaseHTTPServer      blah                lib2to3             shelve
    Bastion             brainteaser         linecache           shlex
    CDROM               bsddb               linuxaudiodev       shutil
    .
    .
    .

</div>

</div>

<div class="section">

<div class="section">

# Let's Learn Python\!

</div>

<div class="section">

### Syntax

Statements are terminated by newlines (e.g. enter key)

Examples:

    >>> a = 1
    >>> print "hello world"
    hello world

</div>

<div class="section">

### Nuances: Quotations

In general, double and single quotes are interchangeable, both for
printing and argument passing:

    >>> print "hello world"
    hello world
    >>> print 'hello world'
    hello world
    
    >>> str = 'abcdefg'
    >>> str1 = "abcdefg"
    >>> str == str1
    True

</div>

<div class="section">

### Nuances: Escaped characters

Sometimes, you'll need to escape (backslash) certain special characters
to get them to display correctly when printing. For example, if you want
to preserve double quotations in your string:

    >>> print ""hello world""
      File "", line 1
        print ""hello world""
                    ^
    SyntaxError: invalid syntax
    >>> print "\"hello world\""
    "hello world"

A list of escape characters can be found at the [Python
documentation](https://docs.python.org/2/reference/lexical_analysis.html#string-literals)
and elsewhere on the internet.

</div>

<div class="section">

### Comments

Comments are used to make code more legible. In python, they are denoted
with the octothorpe:

    #!/usr/bin/env python
    ...
    # do stuff here
    ...

Multi-line comments can either be manually be broken down, or held in a
docstring with triple quotes:

    """
    this is a
    multi-line comment
    """

We'll revisit the `#!` line in a little bit.

</div>

</div>

<div class="section">

<div class="section">

## Basic Features

Data structures, looping, etc.

</div>

<div class="section">

### Data types

Python is dynamically typed; there is no need to declare (e.g. `int n =
num`). You can also reassign:

    >>> number = 1
    >>> number
    1
    >>> number = 2
    >>> number
    2
    >>> str = 'abc'
    >>> str
    'abc'
    >>> str = 'def'
    >>> str
    'def'
    >>> str = 1
    >>> str
    1

</div>

<div class="section">

### Data types, an aside

However, strings (and some other stuff like tuples) are not *mutable*;
you cannot modify its content. When you reassign the variable as seen
previously, you're actually generating a new object. You can't modify
the original object:

    >>> s = "abc"
    >>> s[0] 
    'a'
    >>> s[0] = "o"
    Traceback (most recent call last):
      File "", line 1, in 
    TypeError: 'str' object does not support item assignment

The above example was shamelessly lifted off [Stack
Overflow](http://stackoverflow.com/questions/8056130/immutable-vs-mutable-types-python).

</div>

<div class="section">

### Back to data types

Like most languages, Python has higher level data structures. Of note
are lists (arrays) and dictionaries. Relatedly, there are also tuples
and sets. Each structure fills different niches.

</div>

<div class="section">

### Lists

Lists are the most versatile; they are the effective equivalent of
arrays in other languages. They are ordered, and you can fetch specific
indices. You can mix and match types, have duplicates, nest lists, etc.
To generate a list:

    >>> lst = [] #initialize a list of indeterminate size
    >>> lst.append('a')
    >>> lst
    ['a']
    >>>lst.extend(['b', 'c'])
    >>>lst
    ['a', 'b', 'c']
    
    >>> lst2 = [None]*5 #initialize a list of predetermined size (an array)
    >>> lst2
    [None, None, None, None, None]
    >>> lst2[1] = 'foo'
    >>>lst2[1]
    'foo'
    >>> lst2
    [None, 'foo', None, None, None]

</div>

<div class="section">

### Sets

Sets are lists that do not allow duplicates. Sets are useful if you need
to take unions, intersections, etc. To generate sets:

    >>> st = set(lst)
    >>> st
    set(['a', 'c', 'b'])
    
    >>> lst3 = [1, 1, 2, 3, 4, 4]
    >>> st2 = set(lst3)
    >>> st2
    set([1, 2, 3, 4])
    
    >>> st3 = {1, 2, 3}
    >>> st3
    set([1, 2, 3])

</div>

<div class="section">

### Sample set operations

Here are some elementary operations you can perform with sets:

    >>> set1 = {1, 2, 3}
    >>> set2 = {3, 4, 5}
    >>> set1 | set2        # union
    set([1, 2, 3, 4, 5])
    >>> set1 & set2        # intersection
    set([3])
    >>> set1 - set2        # set difference
    set([1, 2])
    >>> set2 - set1
    set([4, 5])
    >>> set1 ^ set2        # symmetric difference
    set([1, 2, 4, 5])
    >>> set2 ^ set1
    set([1, 2, 4, 5])

More information can be found in the
[documentation](https://docs.python.org/2/library/sets.html).

</div>

<div class="section">

### Tuples

Tuples are lists, but immutable. Once created, they cannot be modified.
If you know the size of your data structure, tuples are preferred over
lists because Python will know exactly how much memory to allocate. To
create tuples:

    >>> empty_tuple = ()
    >>> empty_tuple
    ()
    >>> one_element = 1,
    >>> one_element
    (1,)
    >>> mixed_tuple = (1, 'a', [1, 'a'])
    >>> mixed_tuple
    (1, 'a', [1, 'a'])
    >>> lst = [1, 2, 3]
    >>> tuple_from_list = tuple(lst)
    >>> tuple_from_list
    (1, 2, 3)

</div>

<div class="section">

### Dictionaries

Dictionaries are associative collections (maps). They are composed of
key:value pairs (most of the time). To create a dictionary:

    >>> empty_dict = {}    # careful not to confuse this with empty sets; to initialize an empty set, use set()
    >>> empty_dict
    {}
    >>> dict1 = {1: 'a', 2: 'b', 3: 'c'}
    >>> dict1
    {1: 'a', 2: 'b', 3: 'c'}
    >>> dict2 = dict([(1, 'a'), (2, 'b'), (3, 'c')])
    >>> dict2
    {1: 'a', 2: 'b', 3: 'c'}
    >>> dict3 = dict(a=1, b=2, c=3)     # only works if keys are strings
    >>> dict3
    {'a': 1, 'c': 3, 'b': 2}
    >>> dict4 = dict(1=a, 2=b, 3=c)
      File "", line 1
    SyntaxError: keyword can't be an expression

</div>

</div>

<div class="section">

<div class="section">

### Basic data structure manipulations

lists are zero-indexed (count from 0), and you can reference positions
like so:

    >>> lst = [1, 2, 3, 4, 5]
    >>> lst[1]
    2
    >>> lst[1:]     # sublist from second entry to end
    [2, 3, 4, 5]
    >>> lst[1:3]    # note that the fourth element is omitted; when end indices are specified, Python stops BEFORE they are reached
    [2, 3]
    >>> lst[:3]     # sublist from beginning to fourth entry
    [1, 2, 3]
    >>> lst[1::2]  # sublist from second to end, every other element
    [2, 4]
    >>> lst[-1]     # last entry (reverse indexing)
    5
    >>> lst2 = [1, 2, 3, [4, 5]]    # nested list
    >>> lst2[3][1]  # specify all relevant indices from outside in
    5

</div>

<div class="section">

### Basic data structure manipulations cont.

Dictionaries don't have indices to reference, but they do have keys and
values. To interact with dictionaries:

    >>> dict1 = {1: 'a', 2: 'b', 3: 'c'}
    >>> dict1[1]
    'a'
    >>> dict1.keys()
    [1, 2, 3]
    >>> dict1.values()
    ['a', 'b', 'c']

</div>

<div class="section">

There's a lot more you can do with these data structures. If you find
yourself wondering if *x* data structure can do *y* thing, feel free to
search for an answer. More often than not, there will be a solution\!

</div>

</div>

<div class="section">

<div class="section">

### Flow Control

for, while, if/else

</div>

<div class="section">

### For loops

For loops are very straightforward to implement, if a little obfuscated.
To iterate over a list:

    >>> things = ['apple', 'banana', 'cherry']
    >>> for thing in things:
    ...     print thing
    ...
    apple
    banana
    cherry
    >>>

</div>

<div class="section">

This will go through every item in your list (or tuple or whatever) in
order. If you also wanted to fetch indices, you'd use:

    >>> for idx, thing in enumerate(things):
    ...     print idx, thing
    ...
    0 apple
    1 banana
    2 cherry
    >>>

The `enumerate()` function is actually an *iterator* that spits out a
tuple consisting of (index, value) and assigns each to idx, name. This
is called a **named tuple**.

</div>

<div class="section">

The ` for a in b  ` structure can be replaced with any generic construct
(within reason). For a generic loop, you can do something like:

    >>>for i in range(5):
    ...     print i
    ...
    0
    1
    2
    3
    4

</div>

<div class="section">

### While loops

Similar in function to `for` loops, while loops are used to iterate, and
are useful if you don't know how long to iterate for (e.g. searching for
convergence, etc.). A generic while loop looks like this:

    >>>toggle = True
    >>> while toggle == True:
    ...     toggle = False
    ...     print toggle
    ...
    False

A very simplistic example, but the above while loop runs one iteration,
then exits because `toggle` is no longer `True`.

</div>

<div class="section">

### If/elif/else

`if/else` statements are useful when you need to handle different cases
in your workflow. A generic if/elif/else statement structure:

    # take some input (let's say, a number)
    if input == 0:       #if input is zero
        print 'zero'
    elif input % 2 == 0: #if input is otherwise even
        print 'even'
    else:                #if input is odd
        print 'odd'

You may use as many `elif`s as you require to solve your problem.

</div>

<div class="section">

### An aside: try/except

Python has the interesting distinction of relatively lightweight
exception handling. Exceptions are only computationally expensive if
they trigger. For more information, [this page has a good analysis of
if/else versus
try/except](https://www.jeffknupp.com/blog/2013/02/06/write-cleaner-python-use-exceptions/).

</div>

</div>

<div class="section">

<div class="section">

## A few pertinent modules

</div>

<div class="section">

### SciPy

SciPy has a bunch of interesting functions that automate various aspects
of scientific computing, like statistics and higher-level mathematics.
Most of these are callable in one line. Briefly, this is how to use the
SciPy module. You will need to consult the
[documentation](http://docs.scipy.org/doc/) for complex usage.

    >>> from scipy import constants        # `from scipy import *` will not behave as expected
    >>> constants.c                        # speed of light
    299792458.0
    >>> from scipy.stats import norm
    >>> norm.cdf(5, 0, 3)                  # P(x<5) if X~N(0,3)
    0.9522096477271853

</div>

<div class="section">

### NumPy

Numpy is the go-to module if you need to perform complex arithmetic or
do matrix operations (manipulate data frames. It is much more efficient
(and easy to use) than using system Python utilities. An example:

    >>> import numpy as np       # the general way; using `as` allows you to set an alias (if the name is too long to type)
    >>> cvalues = [25.3, 24.8, 26.9, 23.9]    # a typical python list of Celcius values
    >>> C = np.array(cvalues)       # create a numpy array
    >>> print C
    [ 25.3  24.8  26.9  23.9]       # note that they look identical
    >>> print(C * 9 / 5 + 32)       # convert to Fahrenheit using scalar multiplication
    [ 77.54  76.64  80.42  75.02]
    >>> fvalues = [x*9/5 + 32 for x in cvalues]    # with a typical list, you need to loop over it and compute element-wise instead
    >>> print fvalues
    [77.54, 76.64, 80.42, 75.02]       # same result, less efficient/readable

</div>

<div class="section">

### More NumPy

A brief look at arrays: NumPy data structures

    >>> nested_list = [[3.4, 8.7, 9.9], [1.1, -7.8, -0.7], [4.1, 12.3, 4.8]]      # a python nested list
    >>> nested_list
    [[3.4, 8.7, 9.9], [1.1, -7.8, -0.7], [4.1, 12.3, 4.8]]
    >>> A = np.array ([ [3.4, 8.7, 9.9], [1.1, -7.8, -0.7], [4.1, 12.3, 4.8]])    # a numpy array (matrix)
    >>> A
    array([[  3.4   8.7   9.9]
     [  1.1  -7.8  -0.7]
     [  4.1  12.3   4.8]])

Note the formatting of the print. This is indicative of the logic and
illustrates why numpy is the preferred implementation of Python matrix
operations. The SciPy documentation linked previously also includes
NumPy documentation.

</div>

<div class="section">

### Matplotlib

Matplotlib is a basic plotting software. You can generate plots in real
time (X11) or create them and write to files to view later. There is
also a degree of customization afforded in plots. The below example
covers the easiest example:

    >>> import matplotlib.pyplot as plt
    >>> plt.plot([1,2,3,4])
    [(some memory address)]
    >>> plt.ylabel('some numbers')
    (another memory address)
    >>> plt.show()

You can save the image using something like `plt.savefig('image.png')`.

See the [matplotlib documentation](http://matplotlib.org/contents.html)
for more information.

</div>

</div>

<div class="section">

## Object Oriented Python

PSA: Python can also implement classes.

Using classes over functions in Python is generally to the user's
discretion, but standard common sense and logic applies as usual. If
your program expands to the point where you think an object is more
effective than functions, then feel free to implement it.

No instruction on classes will be given here, as it is beyond the scope
of the course. For more information, you can consult an [in-depth
article like
this](https://www.jeffknupp.com/blog/2014/06/18/improve-your-python-python-classes-and-object-oriented-programming/)
or look straight at the [Python
documentation](https://docs.python.org/2/tutorial/classes.html).

</div>

<div class="section">

<div class="section">

# A brief Introduction to Scripting

</div>

<div class="section">

### Up until now, we've mostly been playing inside the interpreter. Here, we'll briefly go over what is required to write a proper Python program.

</div>

<div class="section">

### To start:

Strictly speaking, all you need for a Python program is a text file with
the shebang line on top. Recall:

    #!/usr/bin/env python

This line indicates to the computer that this is a python program, and
it should look in this location to execute. Similar shebangs may look
like:

    #!/usr/bin/python
    #!/bin/bash
    #!/usr/bin/perl
    etc.

The shebang is telling the computer to look in the specified directory
for the proper method of execution.

</div>

<div class="section">

### Why use `env`?

`env` is used for portability. On \*nix machines, there is a path
`/usr/bin` where most system programs/binaries are installed. If you
need to install multiple versions, this can be an issue. Which version
of Python do you want to use?

This is what `env` is for. It tells the computer to look at the current
environment, and choose the Python that is currently in use. This is
especially helpful on Orchestra, where we have multiple versions
installed at the same time.

</div>

<div class="section">

### A basic program

Once you've included the shebang, you can get right to it. Start typing
lines just as you would in the interpreter, and once you execute your
program, each line will resolve itself in order.

    #!/usr/bin/env python
    
    print "hello world"

Type this into a text file, and save it as whatever, and include `.py`
at the end for your own convenience.

To execute this program, just type at the terminal:

    $ python file.py

You've just written your first python program\!

</div>

<div class="section">

### Basic Structure

The previous program is not likely going to be your typical use case.
More complex programs may use modules, functions, classes, etc.

A typical program will have the following structure:

    #!/usr/bin/env python
    
    # IMPORT EVERYTHING HERE
    
    # CREATE FUNCTIONS AND/OR CLASSES HERE
    
    def main():
        # CODE THAT DOES NOT BELONG IN FUNCTIONS GOES HERE
    
    if __name__ == '__main__':
        main()

</div>

<div class="section">

To extend the previous trivial example:

    #!/usr/bin/env python
    
    # no modules were required, so none were imported
    
    # no functions were needed, so none were created
    
    def main():
        print "hello world"
    
    if __name__ == '__main__':
        main()

</div>

<div class="section">

### What are Functions?

Functions are typically used when you have repetitive code. Instead of
pasting the code over and over, just put it in a function, and use
("call") it when needed. For example:

    def do_thing():
        print "hello world"
        return

Then to reference it, just type elsewhere in your program:

    do_thing()

and the program will execute the code within the `do_thing` function.

</div>

<div class="section">

You can also make functions take arguments:

    def do_thing(phrase):
        print phrase
        return
    
    ...
    
    phrase = "hello world"
    do_thing(phrase)

</div>

<div class="section">

You can also assign values to variables with functions. To do this, make
use of the `return` keyword. Note that previously, it has been naked,
which means nothing is returned. Python is smart enough to know what you
mean if you omit `return`, but it's always nice to include it for
consistency.

To extend the previous example:

    def do_thing(phrase):
        print phrase
    
        new_phrase = "goodbye world"
    
        return new_phrase
    
    ...
    
    phrase = "hello world"
    
    phrase2 = do_thing(phrase)
    print phrase2

</div>

<div class="section">

Putting it all together:

    #!/usr/bin/env python
    
    def do_thing(phrase):
        """Transform the input phrase into a new phrase."""
        print phrase
        new_phrase = "goodbye world"
    
        return new_phrase
    
    def main():
        phrase = "hello world"
        phrase2 = do_thing(phrase)
    
        print phrase2
    
    if __name__ == '__main__':
        main()

</div>

</div>

<div class="section">

## Final Thoughts: Compatibility

Today's course was taught on 2.7.12.

We have many versions of Python available, and not all are created
equal. Most distinct is the difference between 2.x and 3.x; there are
several syntax changes that will be required to use version 3.x.

For more information, look at this trusty [2.x to 3.x compatibility
cheat sheet](http://python-future.org/compatible_idioms.html).

</div>

<div class="section">

That's it\! Thanks for coming\!

If you have any questions, feel free to email me directly at
alex\_truong@hms.harvard.edu or visit [our
website](https://rc.hms.harvard.edu/#support) to submit a ticket. We
also do consulting\!

</div>

</div>

</div>
