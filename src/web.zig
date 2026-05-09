const root = @import("root.zig");
const builtin = @import("builtin");

pub const SUPPORTED: bool = switch (builtin.os.tag) {
    .emscripten => true,
    else => builtin.cpu.arch == .wasm32 or builtin.cpu.arch == .wasm64,
};

pub const WasmBindgenDisplay = struct {
    pub fn new() WasmBindgenDisplay {
        return .{};
    }

    pub fn intoRaw(self: WasmBindgenDisplay) root.RawDisplayHandle {
        return .{ .wasm_bindgen = self };
    }
};

pub const WasmBindgenCanvasWindowHandle = struct {
    obj: *anyopaque,

    pub fn new(obj: *anyopaque) WasmBindgenCanvasWindowHandle {
        return .{ .obj = obj };
    }

    pub fn intoRaw(self: WasmBindgenCanvasWindowHandle) root.RawWindowHandle {
        return .{ .wasm_bindgen_canvas = self };
    }
};

pub const WasmBindgenOffscreenCanvasWindowHandle = struct {
    obj: *anyopaque,

    pub fn new(obj: *anyopaque) WasmBindgenOffscreenCanvasWindowHandle {
        return .{ .obj = obj };
    }

    pub fn intoRaw(self: WasmBindgenOffscreenCanvasWindowHandle) root.RawWindowHandle {
        return .{ .wasm_bindgen_offscreen_canvas = self };
    }
};
