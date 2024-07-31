VPATH		= $(shell find $(SRC_DIR)/ -type d)

# Finds all sources in the SRC_DIR
SRCS_FIND	= $(notdir $(shell find $(SRC_DIR) -type f -name "*$(CODE_EXT)"))

# Compiles all SRCS into .o files in the OBJ_DIR
OBJ			= $(addprefix $(OBJ_DIR)/, $(SRCS:$(CODE_EXT)=$(OBJ_EXT)))

# Finds all folders in the LIB_DIR
ALL_LIB		= $(shell find $(LIB_DIR)/ -maxdepth 1 -mindepth 1 -type d)

# Finds all the compiled libraries in ALL_LIB
LIB			= $(shell find $(LIB_DIR)/ -type f -name "*.a")

# All directories
DIR			= $(SRC_DIR) $(OBJ_DIR) $(LIB_DIR)

# Path to here
THISPATH	= $(shell pwd)

# **************************************************************************** #

# SRCS =	

SRCS		= $(SRCS_FIND)

# **************************************************************************** #

COLOR_NORMAL= \033[32;0m
COLOR_RED	= \033[31;1m
COLOR_BLUE	= \033[36;1m
COLOR_GREEN	= \033[32;1m

# **************************************************************************** #

SRC_DIR		= src
OBJ_DIR 	= obj
LIB_DIR		= lib

# **************************************************************************** #

CC1			= nasm
OBJ_EXT		= .o
CODE_EXT	= .s
FLAGS		= -felf64

# nasm -f elf64 -o main.o main.s
# ld -o main mainnasm -f elf64 -o main.o main.s
# ld -o main main.o && ./main.o && ./main

# **************************************************************************** #

NAME		= libasm.a

# **************************************************************************** #

all: $(DIR) $(ALL_LIB) $(NAME)

# Creates every repositories if it does not exist
$(DIR):
	@mkdir $@

# Compiles every lib in the lib repository
$(ALL_LIB): 
	@make -sC $@

# Takes any C/CPP files and transforms into an object into the OBJ_DIR
$(OBJ_DIR)/%$(OBJ_EXT): %$(CODE_EXT)
	@${CC1} $(FLAGS) -o $@ $<
	@printf "$(COLOR_RED).$(COLOR_NORMAL)"

# Takes an name of executable and compiles everything into it
$(NAME): print $(OBJ)
	@ar -rcs $(NAME) $(OBJ)
	@chmod +x $(NAME)
	@printf "\n"

print:
	@printf "$(COLOR_GREEN)$(NAME) : $(COLOR_NORMAL)"

# **************************************************************************** #

clean:
	@rm -rf $(OBJ)
	@for path in $(ALL_LIB); do \
		make -sC $$path clean;\
	done

# **************************************************************************** #

fclean:
	@rm -rf $(OBJ) $(NAME)
	@for path in $(ALL_LIB); do \
		make -sC $$path fclean;\
	done

# **************************************************************************** #

print_src:
	@for elem in $(SRCS_FIND); do \
		echo $$elem;\
	done

# **************************************************************************** #

re: fclean all

# **************************************************************************** #

exe: all
	./${NAME}

# **************************************************************************** #

.PHONY: all, fclean, clean, re, exe, print_src, $(ALL_LIB)