const std = @import("std");
const print = @import("std").debug.print;

const PROC_NUM_ITERS: usize = 100;

var count: i32 = 0;

pub fn main() !void {
  const NUM_ITERS: usize = 20;
  var i: usize = 0;
  while (i < NUM_ITERS) : (i += 1) {
    count = 0;
    try runAll();
    print("now, count = {0}\n", .{count});
  }
}

fn runAll() !void {
  const thread1 = try std.Thread.spawn(.{}, proc, .{});
  const thread2 = try std.Thread.spawn(.{}, proc, .{});
  const thread3 = try std.Thread.spawn(.{}, proc, .{});
  // const thread4 = try std.Thread.spawn(.{}, proc, .{});
  // const thread5 = try std.Thread.spawn(.{}, proc, .{});
  thread1.join();
  thread2.join();
  thread3.join();
  // thread4.join();
  // thread5.join();
}

fn proc() void {
  var i: usize = 0;
  var temp: i32 = 0;
  while (i < PROC_NUM_ITERS) : (i += 1) {
    temp = count;
    doWork();
    count = temp + 1;
  }
  // print("x = {0}\n", .{x});
}

fn doWork() void {
  var i: usize = 0;
  var sum: u64 = 0;
  while (i < 100) : (i += 1) {
    sum += i;
  }
}