const root = @import("root.zig");

const builtin = @import("builtin");
pub const SUPPORTED: bool = switch (builtin.os.tag) {
    .macos, .maccatalyst => true,
    else => false,
};

pub const AppKitDisplayHandle = struct {
    pub fn new() AppKitDisplayHandle {
        return .{};
    }

    pub fn intoRaw(self: AppKitDisplayHandle) root.RawDisplayHandle {
        return .{ .app_kit = self };
    }
};

pub const AppKitWindowHandle = struct {
    ns_view: *anyopaque,

    pub fn new(ns_view: *anyopaque) AppKitWindowHandle {
        return .{ .ns_view = ns_view };
    }

    pub fn intoRaw(self: AppKitWindowHandle) root.RawWindowHandle {
        return .{ .app_kit = self };
    }
};
