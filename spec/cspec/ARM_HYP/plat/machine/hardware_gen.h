/* generated from /L4V/seL4/include/plat/tk1/plat/machine/hardware.bf */

#pragma once

#include <config.h>
#include <assert.h>
#include <stdint.h>
#include <util.h>
struct iopte {
    uint32_t words[1];
};
typedef struct iopte iopte_t;

struct iopde {
    uint32_t words[1];
};
typedef struct iopde iopde_t;

enum iopde_tag {
    iopde_iopde_4m = 0,
    iopde_iopde_pt = 1
};
typedef enum iopde_tag iopde_tag_t;

