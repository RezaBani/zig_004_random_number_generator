**Simple tool to generate random numbers**

use it with command like this:

`zig build run`

or with a specific numeric type like this:

`zig build run -- $NUMERIC_TYPE`

which `$NUMERIC_TYPE` can be one of this types:

`u8 i8 u16 i16 u32 i32 u64 i64 f32 f64`

default (when no `$NUMERIC_TYPE` is provided) is `u16`

this is originally developed to be used in the following repo:

https://github.com/RezaBani/rust_002_guessing_game

why? because rust std doesn't provide random number generators :(