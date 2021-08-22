const std = @import("std");
const print = @import("std").debug.print;

pub fn main() !void {
  var i: usize = 0;
  while (i < 10) : (i += 1) {
    try runThreads();
    print("-----\n", .{});
  }
}

fn runThreads() !void {
  const thread1 = try std.Thread.spawn(.{}, printA, .{});
  const thread2 = try std.Thread.spawn(.{}, printB, .{});
  thread1.join();
  thread2.join();
}

fn printA() void {
  print("A\n", .{});
}

fn printB() void {
  print("B\n", .{});
}