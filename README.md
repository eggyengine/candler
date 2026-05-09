# candler

candler is used for windowing libraries to implement their own ways to get window information through a common interface. 

## add to project
requires zig `0.16.0`

to use this with the zig build system, import as so:
```bash
zig fetch --save git+https://github.com/eggyengine/candler
```

and then in `build.zig`:
```zig
const candler = b.dependency("candler", .{
    .target = target,
    .optimize = optimize,
});

// since this library is targeted towards windowing libraries, it uses a lib import (exe would work fine)
lib.root_module.addImport("candler", candler.module("candler"));
```

and lastly in your library/executable:
```zig
const candler = @import("candler");
```
