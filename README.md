# LuaVector2
Simple 2D-vector library for Lua, created for generic purposes  
## Features
* Basic vector math
* Distance between vectors (linear & square) & vector normalizing
* Computing the angle between the vector amd the X axis or another vector and vice versa
* Dot production
* Cross production (as 3 component table) and its Z component
* Comparing vectors & one vector's values
* Vector rounding
* Unpacking & concatenating vectors like tables
* Copying vectors and overriding their values
* Constant vectors
* Adaptation for math or games/graphics (inversed Y axis)
  
### Creating vectors  
There are 3 methods to define a new vector:
* With its X and Y coordinates (`LuaVector2.new(x, y)`)
* With an angle (in radians) and a vector length (`LuaVector2.fromAngle(angle, length)`). *Optionally, it takes the basic vector, showing the direction of 0 radians, as the third argument.*
* Copying a constant or already existing vector (`LuaVector2.copy(src)` or `src:copy()`)

### Copying vector, excracting and overriding values
Each vector has 2 compoments: **X component** (`['x']` or `[1]`) and **Y component** (`['y']` or `[2]`).
You can unpack the vector (`LuaVector2:unpack()`), override its components (`LuaVector2:override(x, y)`) or copy it (`LuaVector2:copy()`).

### Constant Vectors
Directional vectors:
* `LuaVector2.RIGHT = {1, 0}`
* `LuaVector2.DOWN = {0, -1}`
* `LuaVector2.LEFT = {1, 0}`
* `LuaVector2.UP = {0, 1}`  
Unit vectors:
* `LuaVector2.ZERO = {0, 0}`
* `LuaVector2.ONE = {1, 1}`
* `LuaVector2.INF = {1/0, 1/0}`
* `LuaVector2.NEG_ONE = {-1, -1}`
* `LuaVector2.NEG_INF = {-1/0, -1/0}`  
*Note: the vertical directions where took with the direct Y axis. Most game engines (like [http://love2d.org](LÖVE)) and other graphic libraries/programs use the inverted Y axis, which can be enabled with changing `Vector2.yScale = 1` to `Vector2.yScale = -1` **inside the library code**. Changing this option after initialization will change the function behaviour, but not the constant vectors, so be careful while using them!*  

## License
The library are destributed under the MIT License (see the library file).
