const std = @import("std");
const lib = @import("lib.zig");

pub const ArgsError = error{
    TooManyArgs,
    UnknownType,
};

pub const ArgumentsOrder = enum(usize) {
    // ExecutableName = 0,
    UserType = 1,
};

pub const CommandLineArguments = struct {
    user_type: lib.UserType,
};

pub const DEFAULT_TYPE: lib.UserType = lib.UserType.U16;
pub const MAX_ARGS_COUNT: usize = 2;

pub fn main() void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const rawArgs = readArgs(allocator) catch |err| switch (err) {
        std.mem.Allocator.Error.OutOfMemory => {
            std.debug.print("{}\n", .{err});
            std.debug.print("Not enough emory to store args", .{});
            std.process.exit(1);
        },
    };
    const args = parseArgs(rawArgs) catch |err| switch (err) {
        ArgsError.TooManyArgs => {
            std.debug.print("{}\n", .{err});
            std.debug.print("This executable accepts only {d} arguments but more than {d} argument is provided!\n", .{ MAX_ARGS_COUNT - 1, MAX_ARGS_COUNT - 1 });
            std.process.exit(1);
        },
        ArgsError.UnknownType => {
            std.debug.print("{}", .{err});
            std.debug.print("Unknown Argument, Valid Arguments are\nu8\ti8\tu16\ti16\tu32\ti32\tu64\ti64\tf16\tf32\tf64", .{});
            std.process.exit(1);
        },
    };
    const numbers = lib.generate_random_number(args.user_type);
    switch (args.user_type) {
        .U8 => {
            std.debug.print("{d}\n", .{numbers.U8});
        },
        .I8 => {
            std.debug.print("{d}\n", .{numbers.I8});
        },
        .U16 => {
            std.debug.print("{d}\n", .{numbers.U16});
        },
        .I16 => {
            std.debug.print("{d}\n", .{numbers.I16});
        },
        .U32 => {
            std.debug.print("{d}\n", .{numbers.U32});
        },
        .I32 => {
            std.debug.print("{d}\n", .{numbers.I32});
        },
        .U64 => {
            std.debug.print("{d}\n", .{numbers.U64});
        },
        .I64 => {
            std.debug.print("{d}\n", .{numbers.I64});
        },
        .F32 => {
            std.debug.print("{d}\n", .{numbers.F32});
        },
        .F64 => {
            std.debug.print("{d}\n", .{numbers.F64});
        },
    }
}

fn readArgs(allocator: std.mem.Allocator) ![][]const u8 {
    var args = try std.process.argsWithAllocator(allocator);
    defer args.deinit();
    var argsArray = std.ArrayList([]u8).init(allocator);
    while (args.next()) |arg| {
        const buf = try allocator.alloc(u8, arg.len);
        @memcpy(buf, arg);
        try argsArray.append(buf);
    }
    const slice = try argsArray.toOwnedSlice();
    return slice;
}

pub fn parseArgs(args: [][]const u8) ArgsError!CommandLineArguments {
    if (args.len > MAX_ARGS_COUNT) {
        return ArgsError.TooManyArgs;
    }
    const arg: ?[]const u8 = if (args.len > 1) args[@intFromEnum(ArgumentsOrder.UserType)] else null;
    const user_type = if (arg == null)
        DEFAULT_TYPE
    else if (std.mem.eql(u8, "u8", arg.?))
        lib.UserType.U8
    else if (std.mem.eql(u8, "i8", arg.?))
        lib.UserType.I8
    else if (std.mem.eql(u8, "u16", arg.?))
        lib.UserType.U16
    else if (std.mem.eql(u8, "i16", arg.?))
        lib.UserType.I16
    else if (std.mem.eql(u8, "u32", arg.?))
        lib.UserType.U32
    else if (std.mem.eql(u8, "i32", arg.?))
        lib.UserType.I32
    else if (std.mem.eql(u8, "u64", arg.?))
        lib.UserType.U64
    else if (std.mem.eql(u8, "i64", arg.?))
        lib.UserType.I64
    else if (std.mem.eql(u8, "f32", arg.?))
        lib.UserType.F32
    else if (std.mem.eql(u8, "f64", arg.?))
        lib.UserType.F64
    else
        return ArgsError.UnknownType;

    return CommandLineArguments{
        .user_type = user_type,
    };
}
