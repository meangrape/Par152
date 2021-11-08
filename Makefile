# *********************
# * this file was     *
# * derived from:     *
# *                   *
# * protoMakefile     *
# * for Par 1.52      *
# * Copyright 2001 by *
# * Adam M. Costello  *
# *********************


prefix = /Users/jayed

CHMOD = chmod
CP = cp
LS = ls

# Define CC so that the command
#
# $(CC) foo.c
#
# compiles the ANSI C source file "foo.c" into the object file "foo.o".
# You may assume that foo.c uses no floating point math.
#
# If your operating system or your compiler's exit() function
# automatically frees all memory allocated by malloc() when a process
# terminates, then you can choose to trade away space efficiency for
# time efficiency by defining DONTFREE.
#
# Example (for Solaris 2.x with SPARCompiler C):
# CC = cc -c -O -s -Xc -DDONTFREE

CC = gcc

CFLAGS = -g -O2

LDFLAGS = -L/opt/homebrew/opt/expat/lib

LIBS = 

# Define LINK1 and LINK2 so that the command
#
# $(LINK1) foo1.o foo2.o foo3.o $(LINK2) foo
#
# links the object files "foo1.o", "foo2.o", "foo3.o" into the
# executable file "foo".  You may assume that none of the .o files use
# floating point math.
#
# Example (for Solaris 2.x with SPARCompiler C):
# LINK1 = cc -s
# LINK2 = -o

LINK1 = $(CC)
LINK2 = -o
LINKFLAGS = $(CFLAGS)

# Define RM so that the command
#
# $(RM) foo1 foo2 foo3
#
# removes the files "foo1", "foo2", and "foo3", and preferably doesn't
# complain if they don't exist.

RM = rm -f

# Define JUNK to be a list of additional files, other than par and
# $(OBJS), that you want to be removed by "make clean".

JUNK = ./*~ ./\#~ a.out core

# Define O to be the usual suffix for object files.

O = .o

# Define E to be the usual suffix for executable files.

E =

OBJS = buffer$O charset$O errmsg$O par$O reformat$O

.c$O:
	$(CC) $(CFLAGS) -c $<

all:	par$E

par$E: $(OBJS)
	$(LINK1) $(LINKFLAGS) $(OBJS) $(LINK2) par$E $(LDFLAGS) $(LIBS)

buffer$O: buffer.c buffer.h errmsg.h

charset$O: charset.c charset.h errmsg.h buffer.h

errmsg$O: errmsg.c errmsg.h

par$O: par.c charset.h errmsg.h buffer.h reformat.h

reformat$O: reformat.c reformat.h errmsg.h buffer.h

clean:
	(cd test; $(MAKE) $@)
	-$(RM) $(OBJS) $(JUNK)

mostlyclean:	clean
	(cd test; $(MAKE) $@)
	-$(RM) par

distclean: mostlyclean
	(cd test; $(MAKE) $@)
	-$(RM) -r ./autom4te.cache/
	-$(RM) config.cache config.log config.status
	-$(RM) Makefile 

check:	all
	(cd test; $(MAKE) $@)

install:	install-exe install-man install-show

install-exe:	uninstall-exe
	$(CP) par $(prefix)/bin/
	$(CHMOD) 775 $(prefix)/bin/par

install-man:	uninstall-man
	$(CP) par.1 $(prefix)/man/man1/
	$(CHMOD) 664 $(prefix)/man/man1/par.1

install-show:
	@echo
	@echo Installed files...
	@echo
	@$(LS) -l $(prefix)/bin/par $(prefix)/man/man1/par.1
	@echo

uninstall:	uninstall-exe uninstall-man

uninstall-exe:
	-$(RM) $(prefix)/bin/par

uninstall-man:
	-$(RM) $(prefix)/man/man1/par.1
