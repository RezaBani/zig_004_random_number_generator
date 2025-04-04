const std = @import("std");
const lib = @import("lib.zig");

test "simple test" {
    const number_u8 = lib.generate_random_number(lib.UserType.U8);
    const number_i8 = lib.generate_random_number(lib.UserType.I8);
    const number_u16 = lib.generate_random_number(lib.UserType.U16);
    const number_i16 = lib.generate_random_number(lib.UserType.I16);
    const number_u32 = lib.generate_random_number(lib.UserType.U32);
    const number_i32 = lib.generate_random_number(lib.UserType.I32);
    const number_u64 = lib.generate_random_number(lib.UserType.U64);
    const number_i64 = lib.generate_random_number(lib.UserType.I64);
    const number_f32 = lib.generate_random_number(lib.UserType.F32);
    const number_f64 = lib.generate_random_number(lib.UserType.F64);
    try std.testing.expect(number_u8.U8 > std.math.minInt(u8) and number_u8.U8 < std.math.maxInt(u8));
    try std.testing.expect(number_i8.I8 > std.math.minInt(i8) and number_i8.I8 < std.math.maxInt(i8));
    try std.testing.expect(number_u16.U16 > std.math.minInt(u16) and number_u16.U16 < std.math.maxInt(u16));
    try std.testing.expect(number_i16.I16 > std.math.minInt(i16) and number_i16.I16 < std.math.maxInt(i16));
    try std.testing.expect(number_u32.U32 > std.math.minInt(u32) and number_u32.U32 < std.math.maxInt(u32));
    try std.testing.expect(number_i32.I32 > std.math.minInt(i32) and number_i32.I32 < std.math.maxInt(i32));
    try std.testing.expect(number_u64.U64 > std.math.minInt(u64) and number_u64.U64 < std.math.maxInt(u64));
    try std.testing.expect(number_i64.I64 > std.math.minInt(i64) and number_i64.I64 < std.math.maxInt(i64));
    try std.testing.expect(number_f32.F32 > std.math.floatMin(f32) and number_f32.F32 < std.math.floatMax(f32));
    try std.testing.expect(number_f64.F64 > std.math.floatMin(f64) and number_f64.F64 < std.math.floatMax(f64));
}
