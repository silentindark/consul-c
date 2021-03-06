#
# Makefile for libconsul-c
#
# * Copyright (C) 2020, The Wazo Authors (see the AUTHORS file)
#
# This program is free software, distributed under the terms of
# the GNU General Public License Version 3. See the COPYING file
# at the top of the source tree.
#

INSTALL = install
DESTLIB = /usr/lib
DESTHEADER = /usr/include/consul

TARGET = libconsul-c.so
TARGETHEADER = consul.h
OBJECTS = client.o request.o server.o watcher.o base64.o service.o
CFLAGS += -I.
CFLAGS += -DHAVE_STDINT_H=1
CFLAGS += -Wall -Wextra -Wno-unused-parameter -Wstrict-prototypes -Wmissing-declarations -Winit-self -Wmissing-format-attribute \
          -Wformat=2 -g -fPIC -D_GNU_SOURCE
LIBS += -lcurl
LDFLAGS = -Wall -ljansson -shared

.PHONY: install clean

$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@ $(LIBS)

%.o: %.c $(HEADERS)
	$(CC) -c $(CFLAGS) -o $@ $<

install: $(TARGET)
	mkdir -p $(DESTDIR)$(DESTLIB)
	mkdir -p $(DESTDIR)$(DESTHEADER)
	install -m 755 $(TARGET) $(DESTDIR)$(DESTLIB)
	install -m 755 $(TARGETHEADER) $(DESTDIR)$(DESTHEADER)
clean:
	rm -f $(OBJECTS)
	rm -f $(TARGET)
