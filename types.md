# Types

## What is a type?

A set of values, such as the set of all integers?

## Issues with types

- How do we declare the type?
- How do we infer the type?
- How can we check the type?
- How can we check equality with types?

## Primitice vs Constructed type

- Primitive type: can be used but cannot be defined
    - Every programming language defines its primitive types, some define **precisely for implementation*** (e.g java says char will take 2 bytes)
    - Some leave it **loose for implementation** (C doesnt worry about bytes for characters, figure it out custom)
    - Issues with primitive types involve, how can the language
- Constructed Type
    - We can construct sets just by listing all the elements, S = {a,b,c}.
    - We can do this enumeration in many languages.
        - ``` enum coin{penny=1,nickel=5,dime=10,quarter=25}; ```
    - Or by using tuples,structs,unions
        - ``` struct complex{ double rpl double ip;}x;```
        - ```sml type complex = {rp:real, ip:real]};```