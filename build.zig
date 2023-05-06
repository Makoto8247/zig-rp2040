const std = @import("std");
const rp2040 = @import("deps/raspberrypi-rp2040/build.zig");
const uf2 = @import("deps/uf2/src/main.zig");
const file_source = std.build.FileSource;

pub fn build(b: *std.Build) void {
    const mode = b.standardOptimizeOption(.{});
    const rp2040_opt = rp2040.PicoExecutableOptions{
        .name = "main",
        .source_file = file_source.relative("./src/main.zig"),
        .optimize = mode,
    };

    const exe = rp2040.addPiPicoExecutable(b, rp2040_opt);
    exe.installArtifact(b);

    const uf2_step = uf2.Uf2Step.create(exe.inner, .{ .family_id = .RP2040 });
    uf2_step.install();
}
