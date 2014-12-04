TARGET=regex_test

OBJS=main.o

CC?=gcc



all:$(OBJS)
	$(CC) -o $(TARGET) $(OBJS) -lutil

clean:
	rm -f $(TARGET) $(OBJS)
