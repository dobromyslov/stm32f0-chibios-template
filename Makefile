##############################################################################
# Project, sources and paths
#

# Project name
PROJECT=stm32-chibios

# Imported source files and paths
CHIBIOS = ./chibios-2.6.5
include $(CHIBIOS)/boards/ST_STM32F0_DISCOVERY/board.mk
include $(CHIBIOS)/os/hal/platforms/STM32F0xx/platform.mk
include $(CHIBIOS)/os/hal/hal.mk
include $(CHIBIOS)/os/ports/GCC/ARMCMx/STM32F0xx/port.mk
include $(CHIBIOS)/os/kernel/kernel.mk

# C sources
CSRC = $(PORTSRC) \
       $(KERNSRC) \
       $(HALSRC) \
       $(PLATFORMSRC) \
       $(BOARDSRC) \
       src/main.c

# C++ sources
CPPSRC =

# C sources to be compiled in ARM mode regardless of the global setting.
# NOTE: Mixing ARM and THUMB mode enables the -mthumb-interwork compiler
#       option that results in lower performance and larger code size.
ACSRC =

# C++ sources to be compiled in ARM mode regardless of the global setting.
# NOTE: Mixing ARM and THUMB mode enables the -mthumb-interwork compiler
#       option that results in lower performance and larger code size.
ACPPSRC =

# C sources to be compiled in THUMB mode regardless of the global setting.
# NOTE: Mixing ARM and THUMB mode enables the -mthumb-interwork compiler
#       option that results in lower performance and larger code size.
TCSRC =

# C sources to be compiled in THUMB mode regardless of the global setting.
# NOTE: Mixing ARM and THUMB mode enables the -mthumb-interwork compiler
#       option that results in lower performance and larger code size.
TCPPSRC =

# List ASM source files here
ASMSRC = $(PORTASM)

INCDIR = $(PORTINC) $(KERNINC)  \
         $(HALINC) $(PLATFORMINC) $(BOARDINC) \
         $(CHIBIOS)/os/various \
         src/conf

##############################################################################
# Compiler settings
#

MCU  = cortex-m0

# Compiler options
USE_OPT = -O2 -ggdb -fomit-frame-pointer -falign-functions=16

# C specific options (added to USE_OPT).
USE_COPT = 

# C++ specific options (added to USE_OPT).
USE_CPPOPT = -fno-rtti

# Compile the application in THUMB mode.
USE_THUMB = yes

# ARM-specific options
AOPT =

# THUMB-specific options
TOPT = -mthumb -DTHUMB

TRGT = arm-none-eabi-
CC   = $(TRGT)gcc
CPPC = $(TRGT)g++
LD   = $(TRGT)gcc
# Enable loading with g++ only if you need C++ runtime support.
# NOTE: You can use C++ even without C++ support if you are careful. C++
#       runtime support makes code size explode.
#LD   = $(TRGT)g++
CP   = $(TRGT)objcopy
AS   = $(TRGT)gcc -x assembler-with-cpp
OD   = $(TRGT)objdump
SZ   = $(TRGT)size
HEX  = $(CP) -O ihex
BIN  = $(CP) -O binary

# Define C warning options here
CWARN = -Wall -Wextra -Wstrict-prototypes

# Define C++ warning options here
CPPWARN = -Wall -Wextra

# Verbose log while compiling
USE_VERBOSE_COMPILE = no

##############################################################################
# Linker settings
#

# Linker garbage collection: ask linker to remove unused code and data
USE_LINK_GC = yes

# Linker extra options
USE_LDOPT = 

# Link time optimizations (LTO)
USE_LTO = no

# Linker script
LDSCRIPT= $(PORTLD)/STM32F051x8.ld

##############################################################################
# Start of default section
#

# List all default C defines here, like -D_DEBUG=1
DDEFS =

# List all default ASM defines here, like -D_DEBUG=1
DADEFS =

# List all default directories to look for include files here
DINCDIR =

# List the default directory to look for the libraries here
DLIBDIR =

# List all default libraries here
DLIBS =


##############################################################################
# Start of user section
#

# List all user C define here, like -D_DEBUG=1
UDEFS =

# Define ASM defines here
UADEFS =

# List all user directories here
UINCDIR =

# List the user directory to look for the libraries here
ULIBDIR =

# List all user libraries here
ULIBS =

##############################################################################
# OpenOCD section
#

# Location of OpenOCD Board .cfg files
OPENOCD_BOARD_DIR = /usr/share/openocd/scripts/board

# OpenOCD board config file
OPENOCD_BOARD_CFG = stm32f0discovery.cfg

RULESPATH = $(CHIBIOS)/os/ports/GCC/ARMCMx
include $(RULESPATH)/rules.mk

# Flashes your board using OpenOCD
flash: all
	openocd -f $(OPENOCD_BOARD_DIR)/$(OPENOCD_BOARD_CFG) -f openocd/stm32f0-flash.cfg \
            -c "stm_flash `pwd`/$(BUILDDIR)/$(PROJECT).bin" -c shutdown

