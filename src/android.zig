const root = @import("root.zig");

const builtin = @import("builtin");
pub const SUPPORTED: bool = builtin.abi == .android or builtin.abi == .androideabi;

pub const AndroidDisplayHandle = struct {
    pub fn new() AndroidDisplayHandle {
        return .{};
    }

    pub fn intoRaw(self: AndroidDisplayHandle) root.RawDisplayHandle {
        return .{ .android = self };
    }
};

pub const AndroidNdkWindowHandle = struct {
    a_native_window: *anyopaque,

    pub fn new(a_native_window: *anyopaque) AndroidNdkWindowHandle {
        return .{ .a_native_window = a_native_window };
    }

    pub fn intoRaw(self: AndroidNdkWindowHandle) root.RawWindowHandle {
        return .{ .android_ndk = self };
    }
};
