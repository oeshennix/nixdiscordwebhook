#include <stddef.h>

struct discordoutgoingrequest{
  char* data;
  size_t len;
};
size_t ReadData(char* buffer, size_t size, size_t count, struct discordoutgoingrequest* str);
