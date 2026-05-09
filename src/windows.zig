const root = @import("root.zig");
const builtin = @import("builtin");

pub const SUPPORTED: bool = builtin.os.tag == .windows;

pub const WindowsDisplayHandle = struct {
    pub fn new() WindowsDisplayHandle {
        return .{};
    }

    pub fn intoRaw(self: WindowsDisplayHandle) root.RawDisplayHandle {
        return .{ .windows = self };
    }
};

pub const Win32WindowHandle = struct {
    hwnd: isize,
    hinstance: ?isize = null,

    pub fn new(hwnd: isize) Win32WindowHandle {
        return .{ .hwnd = hwnd };
    }

    pub fn intoRaw(self: Win32WindowHandle) root.RawWindowHandle {
        return .{ .win32 = self };
    }
};

pub const WinRtWindowHandle = struct {
    core_window: *anyopaque,

    pub fn new(core_window: *anyopaque) WinRtWindowHandle {
        return .{ .core_window = core_window };
    }

    pub fn intoRaw(self: WinRtWindowHandle) root.RawWindowHandle {
        return .{ .win_rt = self };
    }
};
