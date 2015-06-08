# The Pancake Language

Pancake was born out of the author&rsquo;s biases and frustrations when teaching introductory computer science. 

The current goal is for Pancake to be a language that is

-   easy to learn, with simple syntax and decent error messages
-   has a rigorously defined semantics presented in both a mechanized and semi-formal, readable, way
-   is suitable to teaching basic lessons in computer science
    -   the idea of algorithms
    -   control flow
    -   choosing the right data types
    -   error handling
    -   testing
    -   modularity
    -   etc.
-   is typed, but has a type inference algorithm

So far, Pancake is looking like a strictified baby version of Haskell 98, or perhaps a tiny ML with type classes and slightly more Haskell-ish syntax. If you cross those two descriptions that&rsquo;s probably fairly close to what&rsquo;s in my head. 

You&rsquo;ll notice this shows a bias towards functional programming, which is entirely true. Given the fact that previously esoteric topics such as lambda abstractions, functions as first-class values, and higher-order functions are now uniquitous in mainstream languages I don&rsquo;t think there&rsquo;s any reason to shy away from them when teaching introductory computer science. In addition, I want to convey basic concepts of choosing data types and principles of abstraction before teaching any kind of object-oriented programming. It&rsquo;s my personal experience that object-oriented techniques taught in a first programming course tend to conflate the actually important ideas of objects and classes/prototypes with basic encapsulation and the existence of abstract data types, which are actually independent concepts that **can** be realized with objects.
