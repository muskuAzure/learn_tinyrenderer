SYSCONF_LINK = g++
CPPFLAGS     = -Iinclude
LDFLAGS      =
LIBS         = -lm

TARGETDIR = out
TARGET    = $(TARGETDIR)/main

SRC      = src/main.cpp src/tgaimage.cpp
OBJECTS  = src/main.o src/tgaimage.o

all: run_and_convert

$(TARGETDIR):
	mkdir -p $(TARGETDIR)

$(TARGET): $(TARGETDIR) $(OBJECTS)
	$(SYSCONF_LINK) -Wall $(LDFLAGS) -o $(TARGET) $(OBJECTS) $(LIBS)

src/%.o: src/%.cpp
	$(SYSCONF_LINK) -Wall $(CPPFLAGS) -c $< -o $@

run_and_convert: $(TARGET)
	./$(TARGET)
	magick convert output.tga output.png
	@echo "Done! output.png is ready."

clean:
	rm -f $(OBJECTS) $(TARGET) output.tga output.png
