const std = @import("std");
const lib = @import("lib.zig");
const main = @import("main.zig");

test "lib test" {
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

test "main test" {
    const allocator = std.testing.allocator;

    const argumentSetOkEmpty: [][]const u8 = @constCast(&[_][]const u8{"executableName"});
    const argumentSetOkOne: [][]const u8 = @constCast(&[_][]const u8{ "executableName", "u32" });
    const argumentSetBad: [][]const u8 = @constCast(&[_][]const u8{ "executableName", "garbage" });
    const argumentSetBadExtra: [][]const u8 = @constCast(&[_][]const u8{ "executableName", "f64", "extra" });

    try std.testing.expectEqual(main.DEFAULT_TYPE, (try main.parseArgs(argumentSetOkEmpty)).user_type);
    try std.testing.expectEqual(lib.UserType.U32, (try main.parseArgs(argumentSetOkOne)).user_type);
    try std.testing.expectError(main.ArgsError.UnknownType, main.parseArgs(argumentSetBad));
    try std.testing.expectError(main.ArgsError.TooManyArgs, main.parseArgs(argumentSetBadExtra));

    var okArgs = std.ArrayList([][]const u8).init(allocator);
    defer okArgs.deinit();
    try okArgs.append(argumentSetOkOne);
    try okArgs.append(argumentSetOkEmpty);
    for (okArgs.items) |rawArgs| {
        const args = try main.parseArgs(rawArgs);
        const numbers = lib.generate_random_number(args.user_type);
        switch (args.user_type) {
            .U8 => {},
            .I8 => {},
            .U16 => {
                try std.testing.expectEqual(numbers.U8, 0);
                try std.testing.expectEqual(numbers.I8, 0);
                try std.testing.expectEqual(numbers.I16, 0);
                try std.testing.expectEqual(numbers.U32, 0);
                try std.testing.expectEqual(numbers.I32, 0);
                try std.testing.expectEqual(numbers.U64, 0);
                try std.testing.expectEqual(numbers.I64, 0);
                try std.testing.expectEqual(numbers.F32, 0);
                try std.testing.expectEqual(numbers.F64, 0);
            },
            .I16 => {},
            .U32 => {
                try std.testing.expectEqual(numbers.U8, 0);
                try std.testing.expectEqual(numbers.I8, 0);
                try std.testing.expectEqual(numbers.U16, 0);
                try std.testing.expectEqual(numbers.I16, 0);
                try std.testing.expectEqual(numbers.I32, 0);
                try std.testing.expectEqual(numbers.U64, 0);
                try std.testing.expectEqual(numbers.I64, 0);
                try std.testing.expectEqual(numbers.F32, 0);
                try std.testing.expectEqual(numbers.F64, 0);
            },
            .I32 => {},
            .U64 => {},
            .I64 => {},
            .F32 => {},
            .F64 => {},
        }
    }
}
