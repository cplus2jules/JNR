# Makefile for jnr programming language

CC = gcc
CFLAGS = -Wall
BISON = bison
FLEX = flex

# Directories
SRC_DIR = src
TEST_DIR = tests
DOCS_DIR = docs
SCRIPTS_DIR = scripts

# Target executable
TARGET = jnr

# Generated files
BISON_SRC = jnr.tab.c
BISON_HDR = jnr.tab.h
FLEX_SRC = lex.yy.c

# Source files
PARSER = $(SRC_DIR)/jnr.y
LEXER = $(SRC_DIR)/jnr.l

all: $(TARGET)

$(TARGET): $(BISON_SRC) $(FLEX_SRC)
	$(CC) $(CFLAGS) $(BISON_SRC) $(FLEX_SRC) -o $(TARGET)

$(BISON_SRC) $(BISON_HDR): $(PARSER)
	$(BISON) -d $(PARSER)

$(FLEX_SRC): $(LEXER)
	$(FLEX) $(LEXER)

clean:
	rm -f $(TARGET) $(BISON_SRC) $(BISON_HDR) $(FLEX_SRC)

test: $(TARGET)
	./$(TARGET) < $(TEST_DIR)/test.jnr

test-types: $(TARGET)
	./$(TARGET) < $(TEST_DIR)/test_types.jnr

test-int: $(TARGET)
	./$(TARGET) < $(TEST_DIR)/test_int.jnr

test-char: $(TARGET)
	./$(TARGET) < $(TEST_DIR)/test_char.jnr

test-float: $(TARGET)
	./$(TARGET) < $(TEST_DIR)/test_float.jnr

test-all: test test-types test-int test-char test-float

.PHONY: all clean test test-types test-int test-char test-float test-all
