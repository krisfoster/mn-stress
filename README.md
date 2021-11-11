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
