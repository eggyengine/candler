const root = @import("root.zig");
const builtin = @import("builtin");

pub const SUPPORTED: bool = switch (builtin.os.tag) {
    .ios, .tvos, .watchos, .visionos, .maccatalyst => true,
    else => false,
};

pub const UiKitDisplayHandle = struct {
    pub fn new() UiKitDisplayHandle {
        return .{};
    }

    pub fn intoRaw(self: UiKitDisplayHandle) root.RawDisplayHandle {
        return .{ .ui_kit = self };
    }
};

pub const UiKitWindowHandle = struct {
    ui_view: *anyopaque,
    ui_view_controller: ?*anyopaque = null,

    pub fn new(ui_view: *anyopaque) UiKitWindowHandle {
        return .{ .ui_view = ui_view };
    }

    pub fn intoRaw(self: UiKitWindowHandle) root.RawWindowHandle {
        return .{ .ui_kit = self };
    }
};
