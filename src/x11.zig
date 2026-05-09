const root = @import("root.zig");
const builtin = @import("builtin");

pub const SUPPORTED: bool = switch (builtin.os.tag) {
    .linux, .freebsd, .netbsd, .openbsd, .dragonfly, .illumos => true,
    else => false,
};

pub const XlibDisplayHandle = struct {
    display: ?*anyopaque,
    screen: c_int,

    pub fn new(display: ?*anyopaque, screen: c_int) XlibDisplayHandle {
        return .{ .display = display, .screen = screen };
    }

    pub fn intoRaw(self: XlibDisplayHandle) root.RawDisplayHandle {
        return .{ .xlib = self };
    }
};

pub const XlibWindowHandle = struct {
    window: c_ulong,
    visual_id: c_ulong = 0,

    pub fn new(window: c_ulong) XlibWindowHandle {
        return .{ .window = window };
    }

    pub fn intoRaw(self: XlibWindowHandle) root.RawWindowHandle {
        return .{ .xlib = self };
    }
};

pub const XcbDisplayHandle = struct {
    connection: ?*anyopaque,
    screen: c_int,

    pub fn new(connection: ?*anyopaque, screen: c_int) XcbDisplayHandle {
        return .{ .connection = connection, .screen = screen };
    }

    pub fn intoRaw(self: XcbDisplayHandle) root.RawDisplayHandle {
        return .{ .xcb = self };
    }
};

pub const XcbWindowHandle = struct {
    window: u32,
    visual_id: ?u32 = null,

    pub fn new(window: u32) XcbWindowHandle {
        return .{ .window = window };
    }

    pub fn intoRaw(self: XcbWindowHandle) root.RawWindowHandle {
        return .{ .xcb = self };
    }
};
