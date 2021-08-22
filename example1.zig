const std = @import("std");
const print = @import("std").debug.print;

const WORK_ITERS: usize = 5_000_000;

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
  doWork();
  print("A\n", .{});
}

fn printB() void {
  doWork();
  print("B\n", .{});
}

fn doWork() void {
  var i: usize = 0;
  var sum: u64 = 0;
  while (i < WORK_ITERS) : (i += 1) {
    sum += i;
  }
}