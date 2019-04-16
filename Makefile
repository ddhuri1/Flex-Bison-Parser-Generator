
default:
        flex -l calc.l
        bison -dv calc.y
        gcc -o calc1 calc.tab.c lex.yy.c -lfl