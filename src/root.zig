pub const android = @import("android.zig");
pub const appkit = @import("appkit.zig");
pub const drm = @import("drm.zig");
pub const gbm = @import("gbm.zig");
pub const haiku = @import("haiku.zig");
pub const ohos = @import("ohos.zig");
pub const redox = @import("redox.zig");
pub const uikit = @import("uikit.zig");
pub const wayland = @import("wayland.zig");
pub const web = @import("web.zig");
pub const windows = @import("windows.zig");
pub const x11 = @import("x11.zig");

pub const AndroidDisplayHandle = android.AndroidDisplayHandle;
pub const AndroidNdkWindowHandle = android.AndroidNdkWindowHandle;
pub const AppKitDisplayHandle = appkit.AppKitDisplayHandle;
pub const AppKitWindowHandle = appkit.AppKitWindowHandle;
pub const DrmDisplayHandle = drm.DrmDisplayHandle;
pub const DrmWindowHandle = drm.DrmWindowHandle;
pub const GbmDisplayHandle = gbm.GbmDisplayHandle;
pub const GbmWindowHandle = gbm.GbmWindowHandle;
pub const HaikuDisplayHandle = haiku.HaikuDisplayHandle;
pub const HaikuWindowHandle = haiku.HaikuWindowHandle;
pub const OhosDisplayHandle = ohos.OhosDisplayHandle;
pub const OhosNdkWindowHandle = ohos.OhosNdkWindowHandle;
pub const OrbitalDisplayHandle = redox.OrbitalDisplayHandle;
pub const OrbitalWindowHandle = redox.OrbitalWindowHandle;
pub const UiKitDisplayHandle = uikit.UiKitDisplayHandle;
pub const UiKitWindowHandle = uikit.UiKitWindowHandle;
pub const WaylandDisplayHandle = wayland.WaylandDisplayHandle;
pub const WaylandWindowHandle = wayland.WaylandWindowHandle;
pub const WasmBindgenCanvasWindowHandle = web.WasmBindgenCanvasWindowHandle;
pub const WasmBindgenDisplay = web.WasmBindgenDisplay;
pub const WasmBindgenOffscreenCanvasWindowHandle = web.WasmBindgenOffscreenCanvasWindowHandle;
pub const Win32WindowHandle = windows.Win32WindowHandle;
pub const WinRtWindowHandle = windows.WinRtWindowHandle;
pub const WindowsDisplayHandle = windows.WindowsDisplayHandle;
pub const XcbDisplayHandle = x11.XcbDisplayHandle;
pub const XcbWindowHandle = x11.XcbWindowHandle;
pub const XlibDisplayHandle = x11.XlibDisplayHandle;
pub const XlibWindowHandle = x11.XlibWindowHandle;

pub const HandleError = error{
    NotSupported,
    Unavailable,
};

pub const RawWindowHandle = union(enum) {
    ui_kit: uikit.UiKitWindowHandle,
    app_kit: appkit.AppKitWindowHandle,
    orbital: redox.OrbitalWindowHandle,
    ohos_ndk: ohos.OhosNdkWindowHandle,
    xlib: x11.XlibWindowHandle,
    xcb: x11.XcbWindowHandle,
    wayland: wayland.WaylandWindowHandle,
    drm: drm.DrmWindowHandle,
    gbm: gbm.GbmWindowHandle,
    win32: windows.Win32WindowHandle,
    win_rt: windows.WinRtWindowHandle,
    wasm_bindgen_canvas: web.WasmBindgenCanvasWindowHandle,
    wasm_bindgen_offscreen_canvas: web.WasmBindgenOffscreenCanvasWindowHandle,
    android_ndk: android.AndroidNdkWindowHandle,
    haiku: haiku.HaikuWindowHandle,
};

pub const RawDisplayHandle = union(enum) {
    ui_kit: uikit.UiKitDisplayHandle,
    app_kit: appkit.AppKitDisplayHandle,
    orbital: redox.OrbitalDisplayHandle,
    ohos: ohos.OhosDisplayHandle,
    xlib: x11.XlibDisplayHandle,
    xcb: x11.XcbDisplayHandle,
    wayland: wayland.WaylandDisplayHandle,
    drm: drm.DrmDisplayHandle,
    gbm: gbm.GbmDisplayHandle,
    windows: windows.WindowsDisplayHandle,
    wasm_bindgen: web.WasmBindgenDisplay,
    android: android.AndroidDisplayHandle,
    haiku: haiku.HaikuDisplayHandle,
};

pub const WindowHandle = struct {
    raw: RawWindowHandle,

    pub fn borrowRaw(raw: RawWindowHandle) WindowHandle {
        return .{ .raw = raw };
    }

    pub fn asRaw(self: WindowHandle) RawWindowHandle {
        return self.raw;
    }
};

pub const DisplayHandle = struct {
    raw: RawDisplayHandle,

    pub fn borrowRaw(raw: RawDisplayHandle) DisplayHandle {
        return .{ .raw = raw };
    }

    pub fn asRaw(self: DisplayHandle) RawDisplayHandle {
        return self.raw;
    }
};

pub const HasWindowHandle = struct {
    ptr: *const anyopaque,
    window_handle_fn: *const fn (*const anyopaque) HandleError!WindowHandle,

    pub fn init(ptr: anytype) HasWindowHandle {
        const Ptr = @TypeOf(ptr);
        const ptr_info = @typeInfo(Ptr);

        if (ptr_info != .pointer) {
            @compileError("HasWindowHandle.init expects a pointer");
        }

        const Child = ptr_info.pointer.child;

        const Impl = struct {
            fn windowHandle(erased: *const anyopaque) HandleError!WindowHandle {
                const self: Ptr = @ptrCast(@alignCast(erased));
                return Child.windowHandle(self);
            }
        };

        return .{
            .ptr = ptr,
            .window_handle_fn = Impl.windowHandle,
        };
    }

    pub fn windowHandle(self: HasWindowHandle) HandleError!WindowHandle {
        return self.window_handle_fn(self.ptr);
    }
};

pub const HasDisplayHandle = struct {
    ptr: *const anyopaque,
    display_handle_fn: *const fn (*const anyopaque) HandleError!DisplayHandle,

    pub fn init(ptr: anytype) HasDisplayHandle {
        const Ptr = @TypeOf(ptr);
        const ptr_info = @typeInfo(Ptr);

        if (ptr_info != .pointer) {
            @compileError("HasDisplayHandle.init expects a pointer");
        }

        const Child = ptr_info.pointer.child;

        const Impl = struct {
            fn displayHandle(erased: *const anyopaque) HandleError!DisplayHandle {
                const self: Ptr = @ptrCast(@alignCast(erased));
                return Child.displayHandle(self);
            }
        };

        return .{
            .ptr = ptr,
            .display_handle_fn = Impl.displayHandle,
        };
    }

    pub fn displayHandle(self: HasDisplayHandle) HandleError!DisplayHandle {
        return self.display_handle_fn(self.ptr);
    }
};

pub const WindowHandleVtable = struct {
    window_handle_fn: *const fn (*const anyopaque) HandleError!WindowHandle,
    drop_fn: ?*const fn (*anyopaque) void = null,
};

pub const DisplayHandleVtable = struct {
    display_handle_fn: *const fn (*const anyopaque) HandleError!DisplayHandle,
    drop_fn: ?*const fn (*anyopaque) void = null,
};

pub const OwnedWindowHandle = struct {
    ptr: *anyopaque,
    vtable: *const WindowHandleVtable,

    pub fn init(ptr: *anyopaque, vtable: *const WindowHandleVtable) OwnedWindowHandle {
        return .{ .ptr = ptr, .vtable = vtable };
    }

    pub fn windowHandle(self: OwnedWindowHandle) HandleError!WindowHandle {
        return self.vtable.window_handle_fn(self.ptr);
    }

    pub fn deinit(self: OwnedWindowHandle) void {
        if (self.vtable.drop_fn) |drop| {
            drop(self.ptr);
        }
    }
};

pub const OwnedDisplayHandle = struct {
    ptr: *anyopaque,
    vtable: *const DisplayHandleVtable,

    pub fn init(ptr: *anyopaque, vtable: *const DisplayHandleVtable) OwnedDisplayHandle {
        return .{ .ptr = ptr, .vtable = vtable };
    }

    pub fn displayHandle(self: OwnedDisplayHandle) HandleError!DisplayHandle {
        return self.vtable.display_handle_fn(self.ptr);
    }

    pub fn deinit(self: OwnedDisplayHandle) void {
        if (self.vtable.drop_fn) |drop| {
            drop(self.ptr);
        }
    }
};

pub const SyncWindowHandle = OwnedWindowHandle;
pub const SyncDisplayHandle = OwnedDisplayHandle;
