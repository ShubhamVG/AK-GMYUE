pub fn print(str: []const u8) void {
    asm volatile (
        \\syscall
        :
        : [_] "{rax}" (1),
          [_] "{rdi}" (1),
          [_] "{rsi}" (str.ptr),
          [_] "{rdx}" (str.len),
    );
}
