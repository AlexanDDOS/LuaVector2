# LuaVector2
It's a 2D-vector library for Lua, created to be used by video games and simulations.  
## Features
* Vector math
* Distances & vector normalizing
* Computing an angle between the OX axis and the vector
* Creating a vector from an angle at OX
* Dot production
* Comparing vectors & the vector's values
* Vector rounding
* Getting sign factors of the vector and the absolute vector
* Inversing vectors
* Multiplying and dividing vectors both by numbers and other vectors
* Concatenating vectors into arrays
* Copying vectors and overriding their values
* Unpacking vector
  
## Creating vectors  
There're 2 methods to create a new vector: with X and Y `LuaVector2.new(x or 0, y or 0)` and with an angle and a vector length `LuaVector2.fromAngle(radian_angle, length or 1)`
  
## Vector math
You can do all basic Lua math operations with two vectors. You also can multiply, divide and modulo a vector by a number and raise its components to the same numeric power.  
You can also: 
* Invert vectors (with a `-` sign)
* Get:
    * Absolute values (`LuaVector2:abs()`)
    * Sign factors (`LuaVector2:sign()`)
    * Dot products (`LuaVector2:dotProduct(a, b)`)
    * Squared or real distance to an other point (`LuaVector2:sqDist(to or VECTOR.ZERO)`, `LuaVector2:dist(to or VECTOR.ZERO)`)
    * Angle between the angle and the OX axis (`LuaVector2:toAngle()`)
* Round them (`LuaVector2:floor()`,  `LuaVector2:ceil()`)
* Normalize them (`LuaVector2:normalize(unit or 1)`).

## Copying vector, excracting and overriding values
Each vector has 2 compoments: **X component** (`['x']` or `[1]`) and **Y component** (`['y']` or `[2]`).
You can unpack the vector (`LuaVector2:unpack()`), override both its components (`LuaVector2:override(x, y)`) and copy it (`LuaVector2:copy()`).

## Constant Vectors
Direction vectors (*Note: direction where took with the inversed OY axis for almost game engines*):
* `LuaVector2.RIGHT` = {1, 0}
* `LuaVector2.DOWN` = {0, 1}
* `LuaVector2.LEFT` = {-1, 0}
* `LuaVector2.UP` = {0, -1}  
Unit vectors:
* `LuaVector2.ZERO` = {0, 0}
* `LuaVector2.ONE` = {1, 1}
* `LuaVector2.INF` = {1/0, 1/0}
* `LuaVector2.NEG_ONE` = {-1, -1}
* `LuaVector2.NEG_INF` = {-1/0, -1/0}

## License
The library are destributed under the MIT License (see the library file).
