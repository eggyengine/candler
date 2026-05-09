const root = @import("root.zig");
const builtin = @import("builtin");

pub const SUPPORTED: bool = builtin.os.tag == .linux;

pub const DrmDisplayHandle = struct {
    fd: i32,

    pub fn new(fd: i32) DrmDisplayHandle {
        return .{ .fd = fd };
    }

    pub fn intoRaw(self: DrmDisplayHandle) root.RawDisplayHandle {
        return .{ .drm = self };
    }
};

pub const DrmWindowHandle = struct {
    plane: u32,

    pub fn new(plane: u32) DrmWindowHandle {
        return .{ .plane = plane };
    }

    pub fn intoRaw(self: DrmWindowHandle) root.RawWindowHandle {
        return .{ .drm = self };
    }
};
