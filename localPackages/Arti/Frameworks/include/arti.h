#ifndef ARTI_H
#define ARTI_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
int32_t arti_start(const char *data_dir, uint16_t socks_port);
int32_t arti_stop(void);
int32_t arti_is_running(void);
int32_t arti_bootstrap_progress(void);
int32_t arti_bootstrap_summary(char *buf, int32_t len);
int32_t arti_go_dormant(void);
int32_t arti_wake(void);
#ifdef __cplusplus
}
#endif
#endif
