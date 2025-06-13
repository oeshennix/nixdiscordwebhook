#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <curl/curl.h>
#include "discord.h"

int main(void){
  curl_global_init(CURL_GLOBAL_ALL);
  CURL *curl;
  CURLcode res;
  curl = curl_easy_init();

  struct curl_slist *list;
  list = curl_slist_append(NULL, "Content-Type: application/json");
  const char *discordwebhookurl=getenv("WEBHOOKURL");
  const char *jsondata=getenv("WEBHOOKDATA");
  puts(discordwebhookurl);
  puts("SDFKJJKLJDSFLKSDLK");

  if(curl) {
    curl_easy_setopt(curl, CURLOPT_SSL_VERIFYSTATUS,1);
    curl_easy_setopt(curl, CURLOPT_CAINFO,"./cacert.pem");
    curl_easy_setopt(curl, CURLOPT_CAPATH,"./cacert.pem");

    curl_easy_setopt(curl, CURLOPT_POST,1);
    curl_easy_setopt(curl, CURLOPT_HTTPHEADER,list);

    curl_easy_setopt(curl, CURLOPT_URL, discordwebhookurl);
    char* data=jsondata;
    struct discordoutgoingrequest r;
    r.data=jsondata;
    r.len=strlen(jsondata);
    curl_easy_setopt(curl, CURLOPT_READFUNCTION, ReadData);
    curl_easy_setopt(curl, CURLOPT_READDATA, &r);

    /* Perform the request, res gets the return code */
    res = curl_easy_perform(curl);
    /* Check for errors */
    if(res != CURLE_OK)
      fprintf(stderr, "curl_easy_perform() failed: %s\n",
              curl_easy_strerror(res));
 
    /* always cleanup */
    curl_easy_cleanup(curl);
  }
  curl_global_cleanup();
  return 0;
}
