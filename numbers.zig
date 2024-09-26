const memory = @import("memory.zig");
const sys = @import("sys.zig");

var buffer: [memory.BUFFER_SIZE]u8 = .{0} ** memory.BUFFER_SIZE;
var heap = memory.Heap{
    .buffer = &buffer,
    .current_idx = 0,
};

pub fn binStrToDec(bin_str: []const u8) NumError!u64 {
    var dec: u64 = 0;

    for (bin_str) |b| {
        dec *= 2;
        dec += switch (b) {
            '0' => 0,
            '1' => 1,
            else => return NumError.NotBinary,
        };
    }

    return dec;
}

pub fn decToBinStr(n: u64) memory.MemError![]const u8 {
    if (n == 0) {
        return &.{'0'};
    }

    var num = n;
    const heap_start = heap.current_idx;

    while (num > 0) {
        const bit_char: u8 = '0' + @as(u8, @truncate(num & 1));
        try heap.set(bit_char);
        num /= 2;
    }

    // swapping the bits
    try heap.swap(heap_start, heap.current_idx - 1);

    return heap.buffer[heap_start..heap.current_idx];
}

pub fn decAsString(n: u64) memory.MemError![]const u8 {
    if (n == 0) {
        return &.{'0'};
    }

    var num = n;
    const heap_start: usize = heap.current_idx;

    while (num > 0) {
        const digit: u8 = @intCast(num % 10);
        num = num / 10;
        try heap.set('0' + digit);
    }

    // swapping the digits
    try heap.swap(heap_start, heap.current_idx - 1);

    return heap.buffer[heap_start..heap.current_idx];
}

pub const NumError = error{NotBinary};
