const std = @import("std");
const lib = @import("lib.zig");
const main = @import("main.zig");

test "lib test" {
    const number_u8 = lib.generate_random_number(u8);
    const number_i8 = lib.generate_random_number(i8);
    const number_u16 = lib.generate_random_number(u16);
    const number_i16 = lib.generate_random_number(i16);
    const number_u32 = lib.generate_random_number(u32);
    const number_i32 = lib.generate_random_number(i32);
    const number_u64 = lib.generate_random_number(u64);
    const number_i64 = lib.generate_random_number(i64);
    const number_f32 = lib.generate_random_number(f32);
    const number_f64 = lib.generate_random_number(f64);
    try std.testing.expect(number_u8 > std.math.minInt(u8) and number_u8 < std.math.maxInt(u8));
    try std.testing.expect(number_i8 > std.math.minInt(i8) and number_i8 < std.math.maxInt(i8));
    try std.testing.expect(number_u16 > std.math.minInt(u16) and number_u16 < std.math.maxInt(u16));
    try std.testing.expect(number_i16 > std.math.minInt(i16) and number_i16 < std.math.maxInt(i16));
    try std.testing.expect(number_u32 > std.math.minInt(u32) and number_u32 < std.math.maxInt(u32));
    try std.testing.expect(number_i32 > std.math.minInt(i32) and number_i32 < std.math.maxInt(i32));
    try std.testing.expect(number_u64 > std.math.minInt(u64) and number_u64 < std.math.maxInt(u64));
    try std.testing.expect(number_i64 > std.math.minInt(i64) and number_i64 < std.math.maxInt(i64));
    try std.testing.expect(number_f32 > std.math.floatMin(f32) and number_f32 < std.math.floatMax(f32));
    try std.testing.expect(number_f64 > std.math.floatMin(f64) and number_f64 < std.math.floatMax(f64));
}
