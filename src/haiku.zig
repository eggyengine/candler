const root = @import("root.zig");
const builtin = @import("builtin");

pub const SUPPORTED: bool = builtin.os.tag == .haiku;

pub const HaikuDisplayHandle = struct {
    pub fn new() HaikuDisplayHandle {
        return .{};
    }

    pub fn intoRaw(self: HaikuDisplayHandle) root.RawDisplayHandle {
        return .{ .haiku = self };
    }
};

pub const HaikuWindowHandle = struct {
    b_window: *anyopaque,
    b_direct_window: ?*anyopaque = null,

    pub fn new(b_window: *anyopaque) HaikuWindowHandle {
        return .{ .b_window = b_window };
    }

    pub fn intoRaw(self: HaikuWindowHandle) root.RawWindowHandle {
        return .{ .haiku = self };
    }
};
