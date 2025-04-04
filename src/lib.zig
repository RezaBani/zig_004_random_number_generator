const std = @import("std");

pub const UserType = enum {
    U8,
    I8,
    U16,
    I16,
    U32,
    I32,
    U64,
    I64,
    F32,
    F64,
};

pub const Numbers = struct {
    U8: u8 = 0,
    I8: i8 = 0,
    U16: u16 = 0,
    I16: i16 = 0,
    U32: u32 = 0,
    I32: i32 = 0,
    U64: u64 = 0,
    I64: i64 = 0,
    F32: f32 = 0,
    F64: f64 = 0,
};

pub fn generate_random_number(userType: UserType) Numbers {
    const time = std.time.timestamp();
    var seed = std.Random.DefaultPrng.init(@intCast(time));
    const random = std.Random.DefaultPrng.random(&seed);
    var numbers = Numbers{};
    switch (userType) {
        .U8 => numbers.U8 = random.int(u8),
        .I8 => numbers.I8 = random.int(i8),
        .U16 => numbers.U16 = random.int(u16),
        .I16 => numbers.I16 = random.int(i16),
        .U32 => numbers.U32 = random.int(u32),
        .I32 => numbers.I32 = random.int(i32),
        .U64 => numbers.U64 = random.int(u64),
        .I64 => numbers.I64 = random.int(i64),
        .F32 => numbers.F32 = random.float(f32),
        .F64 => numbers.F64 = random.float(f64),
    }
    return numbers;
}

pub fn generate_random_number_typed(comptime T: type) T {
    const time = std.time.timestamp();
    var seed = std.Random.DefaultPrng.init(@intCast(time));
    const random = std.Random.DefaultPrng.random(&seed);
    const number = switch (@typeInfo(T)) {
        .Int => random.int(T),
        .Float => random.float(T),
    };
    return number;
}
