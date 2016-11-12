all: stream_original stream_link stream_include

GPERF="/home/lottarini/local/gperftools"

stream_original:
	gcc -O2 -g  ./stream.c -o $@

stream_link:
	gcc -O2 -g -L"/home/lottarini/local/gperftools/lib/" ./stream.c -o $@ -Wl,--no-as-needed -lprofiler

stream_include:
	gcc -O2 -g  -I"/home/lottarini/local/gperftools/include/" -L"/home/lottarini/local/gperftools/lib/" ./stream_and_profiler.c -o $@ -lprofiler

test_original: stream_original
	LD_PRELOAD="$(GPERF)/lib/libtcmalloc.so:$(GPERF)/lib/libprofiler.so" CPUPROFILE=./original.prof CPUPROFILE_FREQUENCY=10 ./stream_original
