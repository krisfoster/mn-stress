# mn-stress

# Environment I am running this on:

```sh

$ grep MemTotal /proc/meminfo
MemTotal:       65302852 kB

$ gcc --version
gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2)
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$ java -version
java version "17.0.1" 2021-10-19 LTS
Java(TM) SE Runtime Environment GraalVM EE 21.3.0 (build 17.0.1+12-LTS-jvmci-21.3-b05)
Java HotSpot(TM) 64-Bit Server VM GraalVM EE 21.3.0 (build 17.0.1+12-LTS-jvmci-21.3-b05, mixed mode, sharing)

$ uname -a
Linux instance-20211109-1740 5.4.17-2102.206.1.el7uek.x86_64 #2 SMP Wed Oct 6 16:40:40 PDT 2021 x86_64 x86_64 x86_64 GNU/Linux

$ native-image --version
GraalVM 21.3.0 Java 17 EE (Java Version 17.0.1+12-LTS-jvmci-21.3-b05)

$ echo $JAVA_HOME
/usr/lib64/graalvm/graalvm21-ee-java17
```

# To build & Run / Test

```sh
$ cd netty
$ mvn clean package -Pnative
$ ./test.sh

$ cd jetty
$ mvn clean package -Pnative
$ ./test.sh
```

# Error

The error that I am seeing:

```sh
08:21:02.250 [default-nioEventLoopGroup-1-55] ERROR i.m.h.s.netty.RoutingInBoundHandler - Micronaut Server Error - No request state present. Cause: Cannot reserve 16777216 bytes of direct buffer memory (allocated: 285216775, limit: 299892736)
java.lang.OutOfMemoryError: Cannot reserve 16777216 bytes of direct buffer memory (allocated: 285216775, limit: 299892736)
	at java.nio.Bits.reserveMemory(Bits.java:178)
	at java.nio.DirectByteBuffer.<init>(DirectByteBuffer.java:121)
	at java.nio.ByteBuffer.allocateDirect(ByteBuffer.java:332)
	at io.netty.buffer.PoolArena$DirectArena.allocateDirect(PoolArena.java:648)
	at io.netty.buffer.PoolArena$DirectArena.newChunk(PoolArena.java:623)
	at io.netty.buffer.PoolArena.allocateNormal(PoolArena.java:202)
	at io.netty.buffer.PoolArena.tcacheAllocateSmall(PoolArena.java:172)
	at io.netty.buffer.PoolArena.allocate(PoolArena.java:134)
	at io.netty.buffer.PoolArena.allocate(PoolArena.java:126)
	at io.netty.buffer.PooledByteBufAllocator.newDirectBuffer(PooledByteBufAllocator.java:395)
	at io.netty.buffer.AbstractByteBufAllocator.directBuffer(AbstractByteBufAllocator.java:188)
	at io.netty.buffer.AbstractByteBufAllocator.directBuffer(AbstractByteBufAllocator.java:179)
	at io.netty.buffer.AbstractByteBufAllocator.ioBuffer(AbstractByteBufAllocator.java:140)
	at io.netty.channel.DefaultMaxMessagesRecvByteBufAllocator$MaxMessageHandle.allocate(DefaultMaxMessagesRecvByteBufAllocator.java:120)
	at io.netty.channel.nio.AbstractNioByteChannel$NioByteUnsafe.read(AbstractNioByteChannel.java:150)
	at io.netty.channel.nio.NioEventLoop.processSelectedKey(NioEventLoop.java:719)
	at io.netty.channel.nio.NioEventLoop.processSelectedKeysOptimized(NioEventLoop.java:655)
	at io.netty.channel.nio.NioEventLoop.processSelectedKeys(NioEventLoop.java:581)
	at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:493)
	at io.netty.util.concurrent.SingleThreadEventExecutor$4.run(SingleThreadEventExecutor.java:986)
	at io.netty.util.internal.ThreadExecutorMap$2.run(ThreadExecutorMap.java:74)
	at io.netty.util.concurrent.FastThreadLocalRunnable.run(FastThreadLocalRunnable.java:30)
	at java.lang.Thread.run(Thread.java:833)
	at com.oracle.svm.core.thread.JavaThreads.threadStartRoutine(JavaThreads.java:596)
	at com.oracle.svm.core.posix.thread.PosixJavaThreads.pthreadStartRoutine(PosixJavaThreads.java:192)
```

## Update on using memory params with `netty`


Graeme Rocher suggested adding the following params to the native image command line, in order to resolve the issues. FOlloing is the command line that resolves the out of memory errors. We still get error responses. The `test.sh` script doesn't have the params, as I wanted to preserve the errors. Note to myself - are these params documented somewhere?

```sh
./target/barry -Xmx256m -XX:MaxRAMPercentage=90.0 -Dio.netty.allocator.numDirectArenas=0 -Dio.netty.noPreferDirect=true &
```


