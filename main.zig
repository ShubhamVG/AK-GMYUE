const sys = @import("sys.zig");
const numbers = @import("numbers.zig");

pub fn main() !void {
    sys.print("Hello world\n");

    // 10111 is 23
    const n: u64 = numbers.binStrToDec("10111") catch {
        sys.print("Invalid binary");
        return;
    };

    const n_str: []const u8 = try numbers.decAsString(n); // should be 23
    sys.print(n_str);
    sys.print("\n");

    const b_str: []const u8 = try numbers.decToBinStr(0);
    sys.print(b_str);
    sys.print("\n");
}
