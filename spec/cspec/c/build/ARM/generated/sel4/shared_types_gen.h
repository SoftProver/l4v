/* generated from seL4/libsel4/mode_include/32/sel4/shared_types.bf */

#pragma once

#include <config.h>
#include <assert.h>
#include <stdint.h>
#include <util.h>
struct seL4_CNode_CapData {
    uint32_t words[1];
};
typedef struct seL4_CNode_CapData seL4_CNode_CapData_t;

static inline uint32_t CONST
seL4_CNode_CapData_get_guard(seL4_CNode_CapData_t seL4_CNode_CapData) {
    uint32_t ret;
    ret = (seL4_CNode_CapData.words[0] & 0x3ffff00u) >> 8;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
seL4_CNode_CapData_get_guardSize(seL4_CNode_CapData_t seL4_CNode_CapData) {
    uint32_t ret;
    ret = (seL4_CNode_CapData.words[0] & 0xf8u) >> 3;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

struct seL4_CapRights {
    uint32_t words[1];
};
typedef struct seL4_CapRights seL4_CapRights_t;

static inline uint32_t CONST
seL4_CapRights_get_capAllowGrantReply(seL4_CapRights_t seL4_CapRights) {
    uint32_t ret;
    ret = (seL4_CapRights.words[0] & 0x8u) >> 3;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
seL4_CapRights_get_capAllowGrant(seL4_CapRights_t seL4_CapRights) {
    uint32_t ret;
    ret = (seL4_CapRights.words[0] & 0x4u) >> 2;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
seL4_CapRights_get_capAllowRead(seL4_CapRights_t seL4_CapRights) {
    uint32_t ret;
    ret = (seL4_CapRights.words[0] & 0x2u) >> 1;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
seL4_CapRights_get_capAllowWrite(seL4_CapRights_t seL4_CapRights) {
    uint32_t ret;
    ret = (seL4_CapRights.words[0] & 0x1u) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

struct seL4_MessageInfo {
    uint32_t words[1];
};
typedef struct seL4_MessageInfo seL4_MessageInfo_t;

static inline seL4_MessageInfo_t CONST
seL4_MessageInfo_new(uint32_t label, uint32_t capsUnwrapped, uint32_t extraCaps, uint32_t length) {
    seL4_MessageInfo_t seL4_MessageInfo;

    /* fail if user has passed bits that we will override */  
    assert((label & ~0xfffffu) == ((0 && (label & (1u << 31))) ? 0x0 : 0));  
    assert((capsUnwrapped & ~0x7u) == ((0 && (capsUnwrapped & (1u << 31))) ? 0x0 : 0));  
    assert((extraCaps & ~0x3u) == ((0 && (extraCaps & (1u << 31))) ? 0x0 : 0));  
    assert((length & ~0x7fu) == ((0 && (length & (1u << 31))) ? 0x0 : 0));

    seL4_MessageInfo.words[0] = 0
        | (label & 0xfffffu) << 12
        | (capsUnwrapped & 0x7u) << 9
        | (extraCaps & 0x3u) << 7
        | (length & 0x7fu) << 0;

    return seL4_MessageInfo;
}

static inline uint32_t CONST
seL4_MessageInfo_get_label(seL4_MessageInfo_t seL4_MessageInfo) {
    uint32_t ret;
    ret = (seL4_MessageInfo.words[0] & 0xfffff000u) >> 12;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
seL4_MessageInfo_get_capsUnwrapped(seL4_MessageInfo_t seL4_MessageInfo) {
    uint32_t ret;
    ret = (seL4_MessageInfo.words[0] & 0xe00u) >> 9;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline seL4_MessageInfo_t CONST
seL4_MessageInfo_set_capsUnwrapped(seL4_MessageInfo_t seL4_MessageInfo, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0xe00u >> 9 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    seL4_MessageInfo.words[0] &= ~0xe00u;
    seL4_MessageInfo.words[0] |= (v32 << 9) & 0xe00u;
    return seL4_MessageInfo;
}

static inline uint32_t CONST
seL4_MessageInfo_get_extraCaps(seL4_MessageInfo_t seL4_MessageInfo) {
    uint32_t ret;
    ret = (seL4_MessageInfo.words[0] & 0x180u) >> 7;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline seL4_MessageInfo_t CONST
seL4_MessageInfo_set_extraCaps(seL4_MessageInfo_t seL4_MessageInfo, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0x180u >> 7 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    seL4_MessageInfo.words[0] &= ~0x180u;
    seL4_MessageInfo.words[0] |= (v32 << 7) & 0x180u;
    return seL4_MessageInfo;
}

static inline uint32_t CONST
seL4_MessageInfo_get_length(seL4_MessageInfo_t seL4_MessageInfo) {
    uint32_t ret;
    ret = (seL4_MessageInfo.words[0] & 0x7fu) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline seL4_MessageInfo_t CONST
seL4_MessageInfo_set_length(seL4_MessageInfo_t seL4_MessageInfo, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0x7fu >> 0 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    seL4_MessageInfo.words[0] &= ~0x7fu;
    seL4_MessageInfo.words[0] |= (v32 << 0) & 0x7fu;
    return seL4_MessageInfo;
}

