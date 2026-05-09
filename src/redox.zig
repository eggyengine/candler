const root = @import("root.zig");

/// Redox is not supported as a zig target, so always set to false
pub const SUPPORTED: bool = false;

pub const OrbitalDisplayHandle = struct {
    pub fn new() OrbitalDisplayHandle {
        return .{};
    }

    pub fn intoRaw(self: OrbitalDisplayHandle) root.RawDisplayHandle {
        return .{ .orbital = self };
    }
};

pub const OrbitalWindowHandle = struct {
    window: *anyopaque,

    pub fn new(window: *anyopaque) OrbitalWindowHandle {
        return .{ .window = window };
    }

    pub fn intoRaw(self: OrbitalWindowHandle) root.RawWindowHandle {
        return .{ .orbital = self };
    }
};
