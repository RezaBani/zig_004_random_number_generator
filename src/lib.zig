const std = @import("std");

pub fn generate_random_number(comptime T: type) T {
    const time = std.time.timestamp();
    var seed = std.Random.DefaultPrng.init(@intCast(time));
    const random = std.Random.DefaultPrng.random(&seed);
    const number = switch (@typeInfo(T)) {
        .float => random.float(T),
        .int => random.int(T),
        else => @compileError("illigal Type!"),
    };
    return number;
}
