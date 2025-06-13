#include "discord.h"
#include <string.h>
#include <stdio.h>
size_t ReadData(char* buffer, size_t size, size_t count, struct discordoutgoingrequest* str){
  if(str->len==0)
    return 0;

  size_t to_copy = (str->len < count) ? (str->len) : count;
  puts(str->data);
  fflush(stdout);
  memcpy(buffer, str->data, to_copy);
  str->len -= to_copy;
  str->data += to_copy;
  /*
  if(str->len < count){
    return to_copy;
  }
  */
  return to_copy;
}
