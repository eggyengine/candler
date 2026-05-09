const root = @import("root.zig");
const RawDisplayHandle = root.RawDisplayHandle;
const RawWindowHandle = root.RawWindowHandle;
const builtin = @import("builtin");

pub const SUPPORTED: bool = builtin.os.tag == .linux;

pub const GbmDisplayHandle = struct {
    gbm_device: *anyopaque,

    pub fn new(gbm_device: *anyopaque) GbmDisplayHandle {
        return .{ .gbm_device = gbm_device };
    }

    pub fn intoRaw(self: GbmDisplayHandle) RawDisplayHandle {
        return .{ .gbm = self };
    }
};

pub const GbmWindowHandle = struct {
    gbm_surface: *anyopaque,

    pub fn new(gbm_surface: *anyopaque) GbmWindowHandle {
        return .{ .gbm_surface = gbm_surface };
    }

    pub fn intoRaw(self: GbmWindowHandle) RawWindowHandle {
        return .{ .gbm = self };
    }
};
