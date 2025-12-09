# Getting Started with jnr - Complete Beginner's Guide

Welcome! This guide will help you install and use the **jnr programming language** on your computer, even if you've never programmed before.

## What is jnr?

jnr is a simple programming language where you can:
- Store whole numbers (integers)
- Store letters and symbols (characters)
- Do math (addition, subtraction, multiplication, division, modulo)
- Compare values (less than, greater than, equal to, etc.)
- Display results on your screen
- Ask users for input
- Write comments to document your code

**What makes jnr unique?**
- Uses `!` instead of `;` to end statements (energetic!)
- Uses `show()` to display output
- Uses `ask()` to get input
- Supports `#` comments like Python
- Supports comma-separated variable declarations

---

## Step 1: Check Your Operating System

First, identify which computer you're using:

- **macOS** - If you have a MacBook or Mac
- **Windows** - If you have a PC running Windows
- **Linux** - If you're using Ubuntu, Fedora, etc.

---

## Step 2: Install Required Software

### For macOS Users

#### 2.1 Install Xcode Command Line Tools

This gives you the tools needed to compile programs.

1. **Open Terminal:**
   - Click the magnifying glass (🔍) in the top-right corner of your screen
   - Type "Terminal" and press Enter
   - A window with text will appear - this is the Terminal

2. **Install the tools:**
   - Copy this command: `xcode-select --install`
   - Paste it into Terminal (right-click → Paste, or press Cmd+V)
   - Press Enter
   - A popup window will appear - click "Install"
   - Wait 5-10 minutes for the installation to finish

3. **Verify installation:**
   - Type: `gcc --version`
   - Press Enter
   - You should see something like "Apple clang version..." 

---

### For Windows Users

#### 2.1 Install WSL (Windows Subsystem for Linux)

Windows needs a Linux environment to run the compiler.

1. **Open PowerShell as Administrator:**
   - Click the Windows Start button (⊞)
   - Type "PowerShell"
   - Right-click "Windows PowerShell"
   - Select "Run as administrator"
   - Click "Yes" when asked for permission

2. **Install WSL:**
   - Copy this command: `wsl --install`
   - Paste it into PowerShell
   - Press Enter
   - Restart your computer when prompted

3. **After restart:**
   - Open "Ubuntu" from the Start menu
   - Create a username and password when asked
   - Remember these credentials!

#### 2.2 Install Build Tools in Ubuntu

1. In the Ubuntu window, type:
   ```bash
   sudo apt update
   sudo apt install build-essential flex bison
   ```

2. Enter your password when asked
3. Type `y` and press Enter when asked to continue

---

### For Linux Users (Ubuntu/Debian)

#### 2.1 Install Build Tools

1. **Open Terminal:**
   - Press `Ctrl + Alt + T`

2. **Install the tools:**
   ```bash
   sudo apt update
   sudo apt install build-essential flex bison
   ```

3. Enter your password when asked
4. Type `y` and press Enter when asked to continue

---

## Step 3: Download jnr

Now we'll get the jnr programming language files.

### Option A: Using Git (Recommended)

1. **Check if Git is installed:**
   - Type: `git --version`
   - If you see a version number, skip to step 3

2. **Install Git (if needed):**
   - **macOS:** Type `brew install git` (or install from https://git-scm.com)
   - **Windows/WSL:** Type `sudo apt install git`
   - **Linux:** Type `sudo apt install git`

3. **Download jnr:**
   ```bash
   git clone https://github.com/cplus2jules/JNR.git
   cd JNR
   ```

### Option B: Manual Download

1. Go to: https://github.com/cplus2jules/JNR
2. Click the green "Code" button
3. Click "Download ZIP"
4. Extract the ZIP file to a folder
5. Open Terminal/Command Prompt
6. Navigate to the folder:
   ```bash
   cd path/to/JNR
   ```
   (Replace `path/to/JNR` with the actual location)

---

## Step 4: Compile jnr

This step converts the source code into a program you can run.

1. **Make sure you're in the jnr folder:**
   - Type: `pwd` (shows current location)
   - You should see something ending with `/JNR` or `/jnr`

2. **Compile the program:**
   ```bash
   make
   ```

3. **What you'll see:**
   ```
   bison -d src/jnr.y
   flex src/jnr.l
   gcc -Wall jnr.tab.c lex.yy.c -o jnr
   ```
   ✅ If you see this, compilation was successful!

4. **Check if it worked:**
   ```bash
   ls -l jnr
   ```
   You should see a file named `jnr` - this is your program!

---

## Step 5: Write Your First Program

Let's create a simple program!

### Method 1: Using a Text Editor

1. **Open a text editor:**
   - **macOS:** TextEdit (Applications → TextEdit)
   - **Windows:** Notepad (Start → Notepad)
   - **Linux:** gedit or nano

2. **Type this code:**
   ```
   int x = 10!
   int y = 20!
   show(x + y)!
   ```

3. **Save the file:**
   - Save it as `my_first_program.jnr`
   - Save it in the `JNR` folder (same folder as the `jnr` program)
   - **Important:** Make sure it's saved as plain text, not `.txt`!

### Method 2: Using Terminal (Easier!)

1. **In Terminal, type:**
   ```bash
   nano tests/my_first_program.jnr
   ```

2. **Type your code:**
   ```
   int x = 10!
   int y = 20!
   show(x + y)!
   ```

3. **Save and exit:**
   - Press `Ctrl + O` (save)
   - Press Enter
   - Press `Ctrl + X` (exit)

---

## Step 6: Run Your Program

Now the exciting part - running your code!

1. **Make sure you're in the JNR folder**

2. **Run your program:**
   ```bash
   ./jnr < tests/my_first_program.jnr
   ```

3. **What you'll see:**
   ```
   Welcome to jnr! (Type your code, Press Ctrl+D to run)
   30
   ```

🎉 **Congratulations!** You just ran your first jnr program!

**What happened:**
- `x` was set to 10
- `y` was set to 20
- The program added them together (10 + 20 = 30)
- It displayed the result: 30

---

## Understanding jnr Programs

### The Three Data Types

#### 1. Integers (Whole Numbers)
```
int age = 25!
int score = 100!
show(age)!
```
**Output:** `25`

#### 2. Characters (Single Letters/Symbols)
```
char grade = 'A'!
char symbol = '!'!
show(grade)!
```
**Output:** `A`

**Note:** JNR v4.2 supports only `int` and `char` types. For decimal calculations, use scaled integers (e.g., multiply by 100 to represent cents).

### Doing Math

```
int a = 10!
int b = 5!

int sum = a + b!
int diff = a - b!
int product = a * b!
int quotient = a / b!
int remainder = a % b!

show(sum)!
show(diff)!
show(product)!
show(quotient)!
show(remainder)!
```

**Output:**
```
15
5
50
2
0
```

### Using the Show Function

```
show(10)!              # Prints: 10
show('A')!             # Prints: A
show(5 + 3)!           # Prints: 8
show((10 + 5) * 2)!    # Prints: 30
```

### Adding Comments

```
# This is a comment - it's ignored by the compiler
int x = 10!  # You can also put comments at the end of lines
show(x)!
```

---

## Example Programs

### Example 1: Age Calculator
```
int birth_year = 2000!
int current_year = 2025!
int age = current_year - birth_year!
show(age)!
```

### Example 2: Comparison Operations
```
int a = 10!
int b = 5!
int is_greater = a > b!
show(is_greater)!  # Prints: 1 (true)
```

### Example 3: Comma-Separated Declarations
```
# Declare multiple variables at once
int x = 100, y = 200, z = 300!
int sum = x + y + z!
show(sum)!  # Prints: 600
```

### Example 4: Using Scaled Integers for Prices
```
# Represent prices in cents to avoid decimals
int item1 = 1299!  # $12.99 in cents
int item2 = 850!   # $8.50 in cents
int item3 = 525!   # $5.25 in cents
int total = item1 + item2 + item3!
show(total)!       # Prints: 2674 (cents) = $26.74
```

---

## Testing the Example Programs

The jnr project comes with example programs you can try:

```bash
./jnr < tests/test_int.jnr       # Integer operations
./jnr < tests/test_char.jnr      # Character handling
./jnr < tests/test_types.jnr     # All types together
./jnr < tests/test_comma_declarations.jnr  # Comma-separated declarations
```

Or run all tests at once:
```bash
make test-all
```

---

## Common Problems & Solutions

### Problem: "command not found: make"

**Solution:**
- **macOS:** Install Xcode Command Line Tools (see Step 2.1)
- **Windows/Linux:** Install build-essential (see Step 2.2)

### Problem: "No such file or directory"

**Solution:**
- Make sure you're in the correct folder
- Type `pwd` to see your current location
- Navigate to the jnr folder: `cd JNR`

### Problem: "Permission denied"

**Solution:**
- Make the file executable: `chmod +x jnr`
- Try running with `./jnr` (note the `./` at the beginning)

### Problem: "Syntax Error" when running program

**Solution:**
- Check that every line is formatted correctly
- Make sure declarations have a type: `int x = 5` not just `x = 5`
- Check that parentheses match: `print(x)` not `print(x`

### Problem: My program file has ".txt" extension

**Solution:**
- Rename it to remove the `.txt`
- **macOS:** In Finder, select file → Get Info → remove `.txt`
- **Windows:** Right-click → Rename → change `file.jnr.txt` to `file.jnr`

---

## Tips for Writing Programs

### 1. Start Simple
Begin with basic programs and gradually add complexity.

### 2. Use Descriptive Names
```
Good:  int student_count = 30
Bad:   int x = 30
```

### 3. One Statement Per Line
```
Good:
int x = 10
int y = 20

Bad:
int x = 10 int y = 20
```

### 4. Test Often
After writing a few lines, run your program to check for errors.

### 5. Read Error Messages
They tell you what's wrong:
- "Variable not defined" → You forgot to declare it
- "Division by zero" → You're dividing by 0
- "Syntax Error" → Check spelling and punctuation

---

## Quick Reference

### Variable Declaration
```
int name = value!      # For whole numbers
char name = 'x'!       # For single characters

# Comma-separated declarations
int x = 10, y = 20, z!  # z defaults to 0
char a = 'A', b, c = 'C'!  # b defaults to '\0'
```

### Math Operators
```
+    Addition
-    Subtraction
*    Multiplication
/    Division
%    Modulo (remainder)
()   Parentheses for order
```

### Comparison Operators
```
<    Less than
>    Greater than
<=   Less than or equal
>=   Greater than or equal
==   Equal to
!=   Not equal to
```

### Functions
```
show(value)!           # Display output
show(variable)!        # Display variable value
ask(variable)!         # Get user input
```

### Comments
```
# This is a comment
int x = 10!  # Comments can go at the end too
```

---

## Next Steps

Now that you've mastered the basics:

1. Try modifying the example programs
2. Write a program to solve a real problem
3. Experiment with different combinations of operations
4. Share your programs with friends!

---

## Getting Help

If you get stuck:

1. **Check the error message** - It usually tells you what's wrong
2. **Review the examples** in the `tests/` folder
3. **Read the documentation** in `docs/README.md`
4. **Start fresh** - Create a new simple program to test

---

## Summary Checklist

- [ ] Installed development tools (Terminal, compilers)
- [ ] Downloaded jnr from GitHub
- [ ] Compiled jnr using `make`
- [ ] Created your first program
- [ ] Successfully ran the program
- [ ] Tried the example programs
- [ ] Understand the two data types (int, char)
- [ ] Can do basic math and comparison operations
- [ ] Know how to use `show()` and `ask()`
- [ ] Can write comments with `#`
- [ ] Understand comma-separated declarations

**Congratulations! You're now a jnr programmer!** 🎉

---

## Quick Command Reference

```bash
# Navigate to jnr folder
cd JNR

# Compile jnr
make

# Run a program
./jnr < tests/filename.jnr

# Run all tests
make test-all

# Clean up compiled files
make clean

# Create a new program file
nano tests/myprogram.jnr
```

**Happy coding!** 💻✨
