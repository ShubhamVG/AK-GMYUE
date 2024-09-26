pub const BUFFER_SIZE: usize = 20_000;

pub const Heap = struct {
    buffer: []u8,
    current_idx: usize,

    pub fn checkOutOfMem(self: *Heap) bool {
        return self.current_idx > self.buffer.len;
    }

    fn forward(self: *Heap) void {
        self.current_idx += 1;
    }

    pub fn set(self: *Heap, byte: u8) MemError!void {
        if (self.checkOutOfMem()) {
            return MemError.OutOfMemory;
        }

        self.buffer[self.current_idx] = byte;
        self.forward();
    }

    /// start and end are inclusive and start < end.
    pub fn swap(self: *Heap, start: usize, end: usize) MemError!void {
        if (self.checkOutOfMem()) {
            return MemError.OutOfMemory;
        }

        if ((end > self.buffer.len) or (start > end)) {
            return MemError.InvalidBounds;
        }

        const len = end - start + 1;
        const stop = len / 2;
        var x = start;
        var y = end;

        for (0..stop) |_| {
            const temp = self.buffer[x];
            self.buffer[x] = self.buffer[y];
            self.buffer[y] = temp;

            x += 1;
            y -= 1;
        }
    }
};

pub const MemError = error{ OutOfMemory, InvalidBounds };
