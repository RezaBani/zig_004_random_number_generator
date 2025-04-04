const std = @import("std");
const lib = @import("lib.zig");
const options = @import("options");

pub fn main() void {
    const compilerErrorMsg =
        \\invalid type definition, type must be one of the following:
        \\Unsigned integer: u8 or u16 or u32 or u64
        \\Signed integer:i8 or i16 or i32 or i64
        \\Float: f32 or f64
    ;
    const int_signed = comptime if (std.ascii.toLower(options.user_type[0]) == 'u')
        std.builtin.Signedness.unsigned
    else if (std.ascii.toLower(options.user_type[0]) == 'i')
        std.builtin.Signedness.signed
    else if (std.ascii.toLower(options.user_type[0]) == 'f')
        null
    else
        @compileError(compilerErrorMsg);

    const bits_amount = comptime std.fmt.parseUnsigned(u16, options.user_type[1..], 10) catch |err| switch (err) {
        else => {
            std.debug.print("{}\n", .{err});
            std.debug.print("This Should never be seen\n", .{});
            std.process.exit(1);
        },
    };
    comptime {
        if (@TypeOf(int_signed) != @TypeOf(null) and (bits_amount == 8 or bits_amount == 16 or bits_amount == 32 or bits_amount == 64)) {
            _ = 0;
        } else if (@TypeOf(int_signed) == @TypeOf(null) and (bits_amount == 32 or bits_amount == 64)) {
            _ = 0;
        } else {
            @compileError(compilerErrorMsg);
        }
    }

    const user_type = comptime if (@TypeOf(int_signed) == @TypeOf(null))
        std.meta.Float(bits_amount)
    else
        std.meta.Int(int_signed, bits_amount);

    const number = lib.generate_random_number(user_type);
    std.debug.print("{d}\n", .{number});
}
