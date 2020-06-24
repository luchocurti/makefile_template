CC = gcc                   # define CC as gcc
CFLAGS = -Wall             # define CLAGS as flags to gcc
OBJS = file1.o ... fileN.o # define Object code files
INCLUDE = -Ipath           # define path as an INCLUDE directory
DEPS = fileX.h             # list ALL needed *.h headers files here
OUT_FILE = output_file     # place here the name of the output file

all: $(OUT_FILE) install   # build all listed targets: output_file, install

$(OUT_FILE): $(OBJS)       # target: dependency list of *.o files
	$(CC) $(CFLAGS) $^ $(INCLUDE) -o $@

%.o: %.c $(DEPS)           # for all *.o files: if its *.c or *.h file changed
	$(CC) -c $*.c -o $@    # compile corresponding .c file again, and give its the current target name

install: $(OUT_FILE)                      # make will build output_file first
	echo Install $(OUT_FILE) in /usr/local/bin
	sudo mv $(OUT_FILE) /usr/local/bin/	

run: install                              # depend on install
	echo Run executable image $(OUT_FILE)
	$(OUT_FILE) || /bin/true              # No make error 10 if main() return non-zero

clean:
	rm -f *.o 2> /dev/null				  # Remove all *.o files
	sudo rm -f /usr/local/bin/$(OUT_FILE) # Remove the output_file
