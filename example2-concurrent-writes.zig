const std = @import("std");
const print = @import("std").debug.print;

const WORK_ITERS: usize = 2_000_000;
var x: i32 = 0;

pub fn main() !void {
  const NUM_ITERS: usize = 5;
  var i: usize = 0;
  while (i < NUM_ITERS) : (i += 1) {
    x = 0;
    try runBoth();
    print("now, x = {0}\n", .{x});
  }
}

fn runBoth() !void {
  const thread1 = try std.Thread.spawn(.{}, procA, .{});
  const thread2 = try std.Thread.spawn(.{}, procB, .{});
  thread1.join();
  thread2.join();
}

fn procA() void {
  doWork();
  x = 5;
  print("x = {0}\n", .{x});
}

fn procB() void {
  doWork();
  x = 7;
}

fn doWork() void {
  var i: usize = 0;
  var sum: u64 = 0;
  while (i < WORK_ITERS) : (i += 1) {
    sum += i;
  }
}