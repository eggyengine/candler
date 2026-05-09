const root = @import("root.zig");
const builtin = @import("builtin");

pub const SUPPORTED: bool = switch (builtin.os.tag) {
    .linux, .freebsd, .netbsd, .openbsd, .dragonfly => true,
    else => false,
};

pub const WaylandDisplayHandle = struct {
    display: *anyopaque,

    pub fn new(display: *anyopaque) WaylandDisplayHandle {
        return .{ .display = display };
    }

    pub fn intoRaw(self: WaylandDisplayHandle) root.RawDisplayHandle {
        return .{ .wayland = self };
    }
};

pub const WaylandWindowHandle = struct {
    surface: *anyopaque,

    pub fn new(surface: *anyopaque) WaylandWindowHandle {
        return .{ .surface = surface };
    }

    pub fn intoRaw(self: WaylandWindowHandle) root.RawWindowHandle {
        return .{ .wayland = self };
    }
};
