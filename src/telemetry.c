#include <stdio.h>
#include <string.h>
#include <assert.h>
#include "telemetry.h"

/* Records a telemetry tag into a fixed 16-byte field. */
void telemetry_record(const char *tag) {
    char field[16];
    if (strlen(tag) >= sizeof(field)) { printf("tag too long\n"); return; }
    snprintf(field, sizeof(field), "%s", tag);
    printf("recorded: %s\n", field);
}
