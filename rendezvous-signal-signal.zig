const std = @import("std");
const print = @import("std").debug.print;

const Semaphore = struct {
  const Self = @This();

  value: i32,

  fn new() Self {
    return Semaphore {
      .value = 0
    };
  }

  fn signal(self: *Self) void {
    self.value += 1;
  }

  fn wait(self: *Self) void {
    self.value -= 1;

    while (self.value < 0) {
    }
  }

};

var aArrived: Semaphore = Semaphore.new();
var bArrived: Semaphore = Semaphore.new();

pub fn main() !void {
  const NUM_ITERS: usize = 20;
  var i: usize = 0;
  while (i < NUM_ITERS) : (i += 1) {
    try runThreads();
    print("-----\n", .{});
  }
}

fn runThreads() !void {
  const thread1 = try std.Thread.spawn(.{}, procA, .{});
  const thread2 = try std.Thread.spawn(.{}, procB, .{});
  thread1.join();
  thread2.join();
}

fn procA() void {
  doWork();
  print("hello from A\n", .{});
  aArrived.signal();
  doSmallWork();
  bArrived.wait();
  print("bye from A\n", .{});
}

fn procB() void {
  doWork();
  print("hello from B\n", .{});
  bArrived.signal();
  doSmallWork();
  aArrived.wait();
  print("bye from B\n", .{});
}

fn doWork() void {
  var i: usize = 0;
  var sum: usize = 0;
  while (i < 1_000_000) : (i += 1) {
    sum += i;
  }
}

fn doSmallWork() void {
  var i: usize = 0;
  var sum: usize = 0;
  while (i < 10) : (i += 1) {
    sum += i;
  }
}