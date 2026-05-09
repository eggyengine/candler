const root = @import("root.zig");
const builtin = @import("builtin");

pub const SUPPORTED: bool = builtin.abi == .ohos or builtin.abi == .ohoseabi;

pub const OhosDisplayHandle = struct {
    pub fn new() OhosDisplayHandle {
        return .{};
    }

    pub fn intoRaw(self: OhosDisplayHandle) root.RawDisplayHandle {
        return .{ .ohos = self };
    }
};

pub const OhosNdkWindowHandle = struct {
    native_window: *anyopaque,

    pub fn new(native_window: *anyopaque) OhosNdkWindowHandle {
        return .{ .native_window = native_window };
    }

    pub fn intoRaw(self: OhosNdkWindowHandle) root.RawWindowHandle {
        return .{ .ohos_ndk = self };
    }
};
