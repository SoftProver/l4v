/* generated from /L4V/seL4/include/arch/arm/arch/object/structures.bf */

#pragma once

#include <config.h>
#include <assert.h>
#include <stdint.h>
#include <util.h>
struct endpoint {
    uint32_t words[4];
};
typedef struct endpoint endpoint_t;

static inline uint32_t PURE
endpoint_ptr_get_epQueue_head(endpoint_t *endpoint_ptr) {
    uint32_t ret;
    ret = (endpoint_ptr->words[1] & 0xfffffff0u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline void
endpoint_ptr_set_epQueue_head(endpoint_t *endpoint_ptr, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0xfffffff0u << 0) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    endpoint_ptr->words[1] &= ~0xfffffff0u;
    endpoint_ptr->words[1] |= (v32 >> 0) & 0xfffffff0;
}

static inline uint32_t PURE
endpoint_ptr_get_epQueue_tail(endpoint_t *endpoint_ptr) {
    uint32_t ret;
    ret = (endpoint_ptr->words[0] & 0xfffffff0u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline void
endpoint_ptr_set_epQueue_tail(endpoint_t *endpoint_ptr, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0xfffffff0u << 0) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    endpoint_ptr->words[0] &= ~0xfffffff0u;
    endpoint_ptr->words[0] |= (v32 >> 0) & 0xfffffff0;
}

static inline uint32_t PURE
endpoint_ptr_get_state(endpoint_t *endpoint_ptr) {
    uint32_t ret;
    ret = (endpoint_ptr->words[0] & 0x3u) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline void
endpoint_ptr_set_state(endpoint_t *endpoint_ptr, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0x3u >> 0) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    endpoint_ptr->words[0] &= ~0x3u;
    endpoint_ptr->words[0] |= (v32 << 0) & 0x3;
}

struct mdb_node {
    uint32_t words[2];
};
typedef struct mdb_node mdb_node_t;

static inline mdb_node_t CONST
mdb_node_new(uint32_t mdbNext, uint32_t mdbRevocable, uint32_t mdbFirstBadged, uint32_t mdbPrev) {
    mdb_node_t mdb_node;

    /* fail if user has passed bits that we will override */  
    assert((mdbNext & ~0xfffffff8u) == ((0 && (mdbNext & (1u << 31))) ? 0x0 : 0));  
    assert((mdbRevocable & ~0x1u) == ((0 && (mdbRevocable & (1u << 31))) ? 0x0 : 0));  
    assert((mdbFirstBadged & ~0x1u) == ((0 && (mdbFirstBadged & (1u << 31))) ? 0x0 : 0));  
    assert((mdbPrev & ~0xfffffff8u) == ((0 && (mdbPrev & (1u << 31))) ? 0x0 : 0));

    mdb_node.words[0] = 0
        | (mdbPrev & 0xfffffff8u) >> 0;
    mdb_node.words[1] = 0
        | (mdbNext & 0xfffffff8u) >> 0
        | (mdbRevocable & 0x1u) << 1
        | (mdbFirstBadged & 0x1u) << 0;

    return mdb_node;
}

static inline uint32_t CONST
mdb_node_get_mdbNext(mdb_node_t mdb_node) {
    uint32_t ret;
    ret = (mdb_node.words[1] & 0xfffffff8u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline void
mdb_node_ptr_set_mdbNext(mdb_node_t *mdb_node_ptr, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0xfffffff8u << 0) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    mdb_node_ptr->words[1] &= ~0xfffffff8u;
    mdb_node_ptr->words[1] |= (v32 >> 0) & 0xfffffff8;
}

static inline uint32_t CONST
mdb_node_get_mdbRevocable(mdb_node_t mdb_node) {
    uint32_t ret;
    ret = (mdb_node.words[1] & 0x2u) >> 1;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline mdb_node_t CONST
mdb_node_set_mdbRevocable(mdb_node_t mdb_node, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0x2u >> 1 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    mdb_node.words[1] &= ~0x2u;
    mdb_node.words[1] |= (v32 << 1) & 0x2u;
    return mdb_node;
}

static inline void
mdb_node_ptr_set_mdbRevocable(mdb_node_t *mdb_node_ptr, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0x2u >> 1) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    mdb_node_ptr->words[1] &= ~0x2u;
    mdb_node_ptr->words[1] |= (v32 << 1) & 0x2;
}

static inline uint32_t CONST
mdb_node_get_mdbFirstBadged(mdb_node_t mdb_node) {
    uint32_t ret;
    ret = (mdb_node.words[1] & 0x1u) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline mdb_node_t CONST
mdb_node_set_mdbFirstBadged(mdb_node_t mdb_node, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0x1u >> 0 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    mdb_node.words[1] &= ~0x1u;
    mdb_node.words[1] |= (v32 << 0) & 0x1u;
    return mdb_node;
}

static inline void
mdb_node_ptr_set_mdbFirstBadged(mdb_node_t *mdb_node_ptr, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0x1u >> 0) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    mdb_node_ptr->words[1] &= ~0x1u;
    mdb_node_ptr->words[1] |= (v32 << 0) & 0x1;
}

static inline uint32_t CONST
mdb_node_get_mdbPrev(mdb_node_t mdb_node) {
    uint32_t ret;
    ret = (mdb_node.words[0] & 0xfffffff8u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline mdb_node_t CONST
mdb_node_set_mdbPrev(mdb_node_t mdb_node, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0xfffffff8u << 0 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    mdb_node.words[0] &= ~0xfffffff8u;
    mdb_node.words[0] |= (v32 >> 0) & 0xfffffff8u;
    return mdb_node;
}

static inline void
mdb_node_ptr_set_mdbPrev(mdb_node_t *mdb_node_ptr, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0xfffffff8u << 0) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    mdb_node_ptr->words[0] &= ~0xfffffff8u;
    mdb_node_ptr->words[0] |= (v32 >> 0) & 0xfffffff8;
}

struct notification {
    uint32_t words[4];
};
typedef struct notification notification_t;

static inline uint32_t PURE
notification_ptr_get_ntfnBoundTCB(notification_t *notification_ptr) {
    uint32_t ret;
    ret = (notification_ptr->words[3] & 0xfffffff0u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline void
notification_ptr_set_ntfnBoundTCB(notification_t *notification_ptr, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0xfffffff0u << 0) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    notification_ptr->words[3] &= ~0xfffffff0u;
    notification_ptr->words[3] |= (v32 >> 0) & 0xfffffff0;
}

static inline uint32_t PURE
notification_ptr_get_ntfnMsgIdentifier(notification_t *notification_ptr) {
    uint32_t ret;
    ret = (notification_ptr->words[2] & 0xffffffffu) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline void
notification_ptr_set_ntfnMsgIdentifier(notification_t *notification_ptr, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0xffffffffu >> 0) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    notification_ptr->words[2] &= ~0xffffffffu;
    notification_ptr->words[2] |= (v32 << 0) & 0xffffffff;
}

static inline uint32_t PURE
notification_ptr_get_ntfnQueue_head(notification_t *notification_ptr) {
    uint32_t ret;
    ret = (notification_ptr->words[1] & 0xfffffff0u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline void
notification_ptr_set_ntfnQueue_head(notification_t *notification_ptr, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0xfffffff0u << 0) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    notification_ptr->words[1] &= ~0xfffffff0u;
    notification_ptr->words[1] |= (v32 >> 0) & 0xfffffff0;
}

static inline uint32_t PURE
notification_ptr_get_ntfnQueue_tail(notification_t *notification_ptr) {
    uint32_t ret;
    ret = (notification_ptr->words[0] & 0xfffffff0u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline void
notification_ptr_set_ntfnQueue_tail(notification_t *notification_ptr, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0xfffffff0u << 0) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    notification_ptr->words[0] &= ~0xfffffff0u;
    notification_ptr->words[0] |= (v32 >> 0) & 0xfffffff0;
}

static inline uint32_t PURE
notification_ptr_get_state(notification_t *notification_ptr) {
    uint32_t ret;
    ret = (notification_ptr->words[0] & 0x3u) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline void
notification_ptr_set_state(notification_t *notification_ptr, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0x3u >> 0) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    notification_ptr->words[0] &= ~0x3u;
    notification_ptr->words[0] |= (v32 << 0) & 0x3;
}

struct stored_hw_asid {
    uint32_t words[1];
};
typedef struct stored_hw_asid stored_hw_asid_t;

struct thread_state {
    uint32_t words[3];
};
typedef struct thread_state thread_state_t;

static inline uint32_t PURE
thread_state_ptr_get_blockingIPCBadge(thread_state_t *thread_state_ptr) {
    uint32_t ret;
    ret = (thread_state_ptr->words[2] & 0xfffffff0u) >> 4;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline void
thread_state_ptr_set_blockingIPCBadge(thread_state_t *thread_state_ptr, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0xfffffff0u >> 4) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    thread_state_ptr->words[2] &= ~0xfffffff0u;
    thread_state_ptr->words[2] |= (v32 << 4) & 0xfffffff0;
}

static inline uint32_t PURE
thread_state_ptr_get_blockingIPCCanGrant(thread_state_t *thread_state_ptr) {
    uint32_t ret;
    ret = (thread_state_ptr->words[2] & 0x8u) >> 3;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline void
thread_state_ptr_set_blockingIPCCanGrant(thread_state_t *thread_state_ptr, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0x8u >> 3) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    thread_state_ptr->words[2] &= ~0x8u;
    thread_state_ptr->words[2] |= (v32 << 3) & 0x8;
}

static inline uint32_t PURE
thread_state_ptr_get_blockingIPCCanGrantReply(thread_state_t *thread_state_ptr) {
    uint32_t ret;
    ret = (thread_state_ptr->words[2] & 0x4u) >> 2;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline void
thread_state_ptr_set_blockingIPCCanGrantReply(thread_state_t *thread_state_ptr, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0x4u >> 2) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    thread_state_ptr->words[2] &= ~0x4u;
    thread_state_ptr->words[2] |= (v32 << 2) & 0x4;
}

static inline uint32_t PURE
thread_state_ptr_get_blockingIPCIsCall(thread_state_t *thread_state_ptr) {
    uint32_t ret;
    ret = (thread_state_ptr->words[2] & 0x2u) >> 1;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline void
thread_state_ptr_set_blockingIPCIsCall(thread_state_t *thread_state_ptr, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0x2u >> 1) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    thread_state_ptr->words[2] &= ~0x2u;
    thread_state_ptr->words[2] |= (v32 << 1) & 0x2;
}

static inline uint32_t CONST
thread_state_get_tcbQueued(thread_state_t thread_state) {
    uint32_t ret;
    ret = (thread_state.words[1] & 0x1u) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline void
thread_state_ptr_set_tcbQueued(thread_state_t *thread_state_ptr, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0x1u >> 0) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    thread_state_ptr->words[1] &= ~0x1u;
    thread_state_ptr->words[1] |= (v32 << 0) & 0x1;
}

static inline uint32_t PURE
thread_state_ptr_get_blockingObject(thread_state_t *thread_state_ptr) {
    uint32_t ret;
    ret = (thread_state_ptr->words[0] & 0xfffffff0u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline void
thread_state_ptr_set_blockingObject(thread_state_t *thread_state_ptr, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0xfffffff0u << 0) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    thread_state_ptr->words[0] &= ~0xfffffff0u;
    thread_state_ptr->words[0] |= (v32 >> 0) & 0xfffffff0;
}

static inline uint32_t CONST
thread_state_get_tsType(thread_state_t thread_state) {
    uint32_t ret;
    ret = (thread_state.words[0] & 0xfu) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t PURE
thread_state_ptr_get_tsType(thread_state_t *thread_state_ptr) {
    uint32_t ret;
    ret = (thread_state_ptr->words[0] & 0xfu) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline void
thread_state_ptr_set_tsType(thread_state_t *thread_state_ptr, uint32_t v32) {
    /* fail if user has passed bits that we will override */
    assert((((~0xfu >> 0) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));
    thread_state_ptr->words[0] &= ~0xfu;
    thread_state_ptr->words[0] |= (v32 << 0) & 0xf;
}

struct vm_attributes {
    uint32_t words[1];
};
typedef struct vm_attributes vm_attributes_t;

static inline vm_attributes_t CONST
vm_attributes_new(uint32_t armExecuteNever, uint32_t armParityEnabled, uint32_t armPageCacheable) {
    vm_attributes_t vm_attributes;

    /* fail if user has passed bits that we will override */  
    assert((armExecuteNever & ~0x1u) == ((0 && (armExecuteNever & (1u << 31))) ? 0x0 : 0));  
    assert((armParityEnabled & ~0x1u) == ((0 && (armParityEnabled & (1u << 31))) ? 0x0 : 0));  
    assert((armPageCacheable & ~0x1u) == ((0 && (armPageCacheable & (1u << 31))) ? 0x0 : 0));

    vm_attributes.words[0] = 0
        | (armExecuteNever & 0x1u) << 2
        | (armParityEnabled & 0x1u) << 1
        | (armPageCacheable & 0x1u) << 0;

    return vm_attributes;
}

static inline uint32_t CONST
vm_attributes_get_armExecuteNever(vm_attributes_t vm_attributes) {
    uint32_t ret;
    ret = (vm_attributes.words[0] & 0x4u) >> 2;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
vm_attributes_get_armParityEnabled(vm_attributes_t vm_attributes) {
    uint32_t ret;
    ret = (vm_attributes.words[0] & 0x2u) >> 1;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
vm_attributes_get_armPageCacheable(vm_attributes_t vm_attributes) {
    uint32_t ret;
    ret = (vm_attributes.words[0] & 0x1u) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

struct cap {
    uint32_t words[2];
};
typedef struct cap cap_t;

enum cap_tag {
    cap_null_cap = 0,
    cap_untyped_cap = 2,
    cap_endpoint_cap = 4,
    cap_notification_cap = 6,
    cap_reply_cap = 8,
    cap_cnode_cap = 10,
    cap_thread_cap = 12,
    cap_small_frame_cap = 1,
    cap_frame_cap = 3,
    cap_asid_pool_cap = 5,
    cap_page_table_cap = 7,
    cap_page_directory_cap = 9,
    cap_asid_control_cap = 11,
    cap_irq_control_cap = 14,
    cap_irq_handler_cap = 30,
    cap_zombie_cap = 46,
    cap_domain_cap = 62,
    cap_vcpu_cap = 15
};
typedef enum cap_tag cap_tag_t;

static inline uint32_t CONST
cap_get_capType(cap_t cap) {
    if ((cap.words[0] & 0xe) != 0xe)
        return (cap.words[0] >> 0) & 0xfu;
    return (cap.words[0] >> 0) & 0xffu;
}

static inline int CONST
cap_capType_equals(cap_t cap, uint32_t cap_type_tag) {
    if ((cap_type_tag & 0xe) != 0xe)
        return ((cap.words[0] >> 0) & 0xfu) == cap_type_tag;
    return ((cap.words[0] >> 0) & 0xffu) == cap_type_tag;
}

static inline cap_t CONST
cap_null_cap_new(void) {
    cap_t cap;

    /* fail if user has passed bits that we will override */  
    assert(((uint32_t)cap_null_cap & ~0xfu) == ((0 && ((uint32_t)cap_null_cap & (1u << 31))) ? 0x0 : 0));

    cap.words[0] = 0
        | ((uint32_t)cap_null_cap & 0xfu) << 0;
    cap.words[1] = 0;

    return cap;
}

static inline cap_t CONST
cap_untyped_cap_new(uint32_t capFreeIndex, uint32_t capIsDevice, uint32_t capBlockSize, uint32_t capPtr) {
    cap_t cap;

    /* fail if user has passed bits that we will override */  
    assert((capFreeIndex & ~0x3ffffffu) == ((0 && (capFreeIndex & (1u << 31))) ? 0x0 : 0));  
    assert((capIsDevice & ~0x1u) == ((0 && (capIsDevice & (1u << 31))) ? 0x0 : 0));  
    assert((capBlockSize & ~0x1fu) == ((0 && (capBlockSize & (1u << 31))) ? 0x0 : 0));  
    assert((capPtr & ~0xfffffff0u) == ((0 && (capPtr & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)cap_untyped_cap & ~0xfu) == ((0 && ((uint32_t)cap_untyped_cap & (1u << 31))) ? 0x0 : 0));

    cap.words[0] = 0
        | (capPtr & 0xfffffff0u) >> 0
        | ((uint32_t)cap_untyped_cap & 0xfu) << 0;
    cap.words[1] = 0
        | (capFreeIndex & 0x3ffffffu) << 6
        | (capIsDevice & 0x1u) << 5
        | (capBlockSize & 0x1fu) << 0;

    return cap;
}

static inline uint32_t CONST
cap_untyped_cap_get_capFreeIndex(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_untyped_cap);

    ret = (cap.words[1] & 0xffffffc0u) >> 6;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_untyped_cap_set_capFreeIndex(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_untyped_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0xffffffc0u >> 6 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0xffffffc0u;
    cap.words[1] |= (v32 << 6) & 0xffffffc0u;
    return cap;
}

static inline void
cap_untyped_cap_ptr_set_capFreeIndex(cap_t *cap_ptr,
                                      uint32_t v32) {
    assert(((cap_ptr->words[0] >> 0) & 0xf) ==
           cap_untyped_cap);

    /* fail if user has passed bits that we will override */
    assert((((~0xffffffc0u >> 6) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap_ptr->words[1] &= ~0xffffffc0u;
    cap_ptr->words[1] |= (v32 << 6) & 0xffffffc0u;
}

static inline uint32_t CONST
cap_untyped_cap_get_capIsDevice(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_untyped_cap);

    ret = (cap.words[1] & 0x20u) >> 5;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
cap_untyped_cap_get_capBlockSize(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_untyped_cap);

    ret = (cap.words[1] & 0x1fu) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
cap_untyped_cap_get_capPtr(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_untyped_cap);

    ret = (cap.words[0] & 0xfffffff0u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_endpoint_cap_new(uint32_t capEPBadge, uint32_t capCanGrantReply, uint32_t capCanGrant, uint32_t capCanSend, uint32_t capCanReceive, uint32_t capEPPtr) {
    cap_t cap;

    /* fail if user has passed bits that we will override */  
    assert((capEPBadge & ~0xfffffffu) == ((0 && (capEPBadge & (1u << 31))) ? 0x0 : 0));  
    assert((capCanGrantReply & ~0x1u) == ((0 && (capCanGrantReply & (1u << 31))) ? 0x0 : 0));  
    assert((capCanGrant & ~0x1u) == ((0 && (capCanGrant & (1u << 31))) ? 0x0 : 0));  
    assert((capCanSend & ~0x1u) == ((0 && (capCanSend & (1u << 31))) ? 0x0 : 0));  
    assert((capCanReceive & ~0x1u) == ((0 && (capCanReceive & (1u << 31))) ? 0x0 : 0));  
    assert((capEPPtr & ~0xfffffff0u) == ((0 && (capEPPtr & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)cap_endpoint_cap & ~0xfu) == ((0 && ((uint32_t)cap_endpoint_cap & (1u << 31))) ? 0x0 : 0));

    cap.words[0] = 0
        | (capEPBadge & 0xfffffffu) << 4
        | ((uint32_t)cap_endpoint_cap & 0xfu) << 0;
    cap.words[1] = 0
        | (capCanGrantReply & 0x1u) << 3
        | (capCanGrant & 0x1u) << 2
        | (capCanSend & 0x1u) << 0
        | (capCanReceive & 0x1u) << 1
        | (capEPPtr & 0xfffffff0u) >> 0;

    return cap;
}

static inline uint32_t CONST
cap_endpoint_cap_get_capEPPtr(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_endpoint_cap);

    ret = (cap.words[1] & 0xfffffff0u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
cap_endpoint_cap_get_capCanGrantReply(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_endpoint_cap);

    ret = (cap.words[1] & 0x8u) >> 3;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_endpoint_cap_set_capCanGrantReply(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_endpoint_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0x8u >> 3 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0x8u;
    cap.words[1] |= (v32 << 3) & 0x8u;
    return cap;
}

static inline uint32_t CONST
cap_endpoint_cap_get_capCanGrant(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_endpoint_cap);

    ret = (cap.words[1] & 0x4u) >> 2;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_endpoint_cap_set_capCanGrant(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_endpoint_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0x4u >> 2 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0x4u;
    cap.words[1] |= (v32 << 2) & 0x4u;
    return cap;
}

static inline uint32_t CONST
cap_endpoint_cap_get_capCanReceive(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_endpoint_cap);

    ret = (cap.words[1] & 0x2u) >> 1;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_endpoint_cap_set_capCanReceive(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_endpoint_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0x2u >> 1 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0x2u;
    cap.words[1] |= (v32 << 1) & 0x2u;
    return cap;
}

static inline uint32_t CONST
cap_endpoint_cap_get_capCanSend(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_endpoint_cap);

    ret = (cap.words[1] & 0x1u) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_endpoint_cap_set_capCanSend(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_endpoint_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0x1u >> 0 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0x1u;
    cap.words[1] |= (v32 << 0) & 0x1u;
    return cap;
}

static inline uint32_t CONST
cap_endpoint_cap_get_capEPBadge(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_endpoint_cap);

    ret = (cap.words[0] & 0xfffffff0u) >> 4;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_endpoint_cap_set_capEPBadge(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_endpoint_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0xfffffff0u >> 4 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[0] &= ~0xfffffff0u;
    cap.words[0] |= (v32 << 4) & 0xfffffff0u;
    return cap;
}

static inline cap_t CONST
cap_notification_cap_new(uint32_t capNtfnBadge, uint32_t capNtfnCanReceive, uint32_t capNtfnCanSend, uint32_t capNtfnPtr) {
    cap_t cap;

    /* fail if user has passed bits that we will override */  
    assert((capNtfnBadge & ~0xfffffffu) == ((0 && (capNtfnBadge & (1u << 31))) ? 0x0 : 0));  
    assert((capNtfnCanReceive & ~0x1u) == ((0 && (capNtfnCanReceive & (1u << 31))) ? 0x0 : 0));  
    assert((capNtfnCanSend & ~0x1u) == ((0 && (capNtfnCanSend & (1u << 31))) ? 0x0 : 0));  
    assert((capNtfnPtr & ~0xfffffff0u) == ((0 && (capNtfnPtr & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)cap_notification_cap & ~0xfu) == ((0 && ((uint32_t)cap_notification_cap & (1u << 31))) ? 0x0 : 0));

    cap.words[0] = 0
        | (capNtfnPtr & 0xfffffff0u) >> 0
        | ((uint32_t)cap_notification_cap & 0xfu) << 0;
    cap.words[1] = 0
        | (capNtfnBadge & 0xfffffffu) << 4
        | (capNtfnCanReceive & 0x1u) << 1
        | (capNtfnCanSend & 0x1u) << 0;

    return cap;
}

static inline uint32_t CONST
cap_notification_cap_get_capNtfnBadge(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_notification_cap);

    ret = (cap.words[1] & 0xfffffff0u) >> 4;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_notification_cap_set_capNtfnBadge(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_notification_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0xfffffff0u >> 4 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0xfffffff0u;
    cap.words[1] |= (v32 << 4) & 0xfffffff0u;
    return cap;
}

static inline uint32_t CONST
cap_notification_cap_get_capNtfnCanReceive(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_notification_cap);

    ret = (cap.words[1] & 0x2u) >> 1;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_notification_cap_set_capNtfnCanReceive(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_notification_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0x2u >> 1 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0x2u;
    cap.words[1] |= (v32 << 1) & 0x2u;
    return cap;
}

static inline uint32_t CONST
cap_notification_cap_get_capNtfnCanSend(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_notification_cap);

    ret = (cap.words[1] & 0x1u) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_notification_cap_set_capNtfnCanSend(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_notification_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0x1u >> 0 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0x1u;
    cap.words[1] |= (v32 << 0) & 0x1u;
    return cap;
}

static inline uint32_t CONST
cap_notification_cap_get_capNtfnPtr(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_notification_cap);

    ret = (cap.words[0] & 0xfffffff0u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_reply_cap_new(uint32_t capReplyCanGrant, uint32_t capReplyMaster, uint32_t capTCBPtr) {
    cap_t cap;

    /* fail if user has passed bits that we will override */  
    assert((capReplyCanGrant & ~0x1u) == ((0 && (capReplyCanGrant & (1u << 31))) ? 0x0 : 0));  
    assert((capReplyMaster & ~0x1u) == ((0 && (capReplyMaster & (1u << 31))) ? 0x0 : 0));  
    assert((capTCBPtr & ~0xffffffc0u) == ((0 && (capTCBPtr & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)cap_reply_cap & ~0xfu) == ((0 && ((uint32_t)cap_reply_cap & (1u << 31))) ? 0x0 : 0));

    cap.words[0] = 0
        | (capReplyCanGrant & 0x1u) << 5
        | (capReplyMaster & 0x1u) << 4
        | (capTCBPtr & 0xffffffc0u) >> 0
        | ((uint32_t)cap_reply_cap & 0xfu) << 0;
    cap.words[1] = 0;

    return cap;
}

static inline uint32_t CONST
cap_reply_cap_get_capTCBPtr(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_reply_cap);

    ret = (cap.words[0] & 0xffffffc0u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
cap_reply_cap_get_capReplyCanGrant(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_reply_cap);

    ret = (cap.words[0] & 0x20u) >> 5;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_reply_cap_set_capReplyCanGrant(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_reply_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0x20u >> 5 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[0] &= ~0x20u;
    cap.words[0] |= (v32 << 5) & 0x20u;
    return cap;
}

static inline uint32_t CONST
cap_reply_cap_get_capReplyMaster(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_reply_cap);

    ret = (cap.words[0] & 0x10u) >> 4;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_cnode_cap_new(uint32_t capCNodeRadix, uint32_t capCNodeGuardSize, uint32_t capCNodeGuard, uint32_t capCNodePtr) {
    cap_t cap;

    /* fail if user has passed bits that we will override */  
    assert((capCNodeRadix & ~0x1fu) == ((0 && (capCNodeRadix & (1u << 31))) ? 0x0 : 0));  
    assert((capCNodeGuardSize & ~0x1fu) == ((0 && (capCNodeGuardSize & (1u << 31))) ? 0x0 : 0));  
    assert((capCNodeGuard & ~0x3ffffu) == ((0 && (capCNodeGuard & (1u << 31))) ? 0x0 : 0));  
    assert((capCNodePtr & ~0xffffffe0u) == ((0 && (capCNodePtr & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)cap_cnode_cap & ~0xfu) == ((0 && ((uint32_t)cap_cnode_cap & (1u << 31))) ? 0x0 : 0));

    cap.words[0] = 0
        | (capCNodePtr & 0xffffffe0u) >> 0
        | ((uint32_t)cap_cnode_cap & 0xfu) << 0;
    cap.words[1] = 0
        | (capCNodeRadix & 0x1fu) << 18
        | (capCNodeGuardSize & 0x1fu) << 23
        | (capCNodeGuard & 0x3ffffu) << 0;

    return cap;
}

static inline uint32_t CONST
cap_cnode_cap_get_capCNodeGuardSize(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_cnode_cap);

    ret = (cap.words[1] & 0xf800000u) >> 23;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_cnode_cap_set_capCNodeGuardSize(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_cnode_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0xf800000u >> 23 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0xf800000u;
    cap.words[1] |= (v32 << 23) & 0xf800000u;
    return cap;
}

static inline uint32_t CONST
cap_cnode_cap_get_capCNodeRadix(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_cnode_cap);

    ret = (cap.words[1] & 0x7c0000u) >> 18;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
cap_cnode_cap_get_capCNodeGuard(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_cnode_cap);

    ret = (cap.words[1] & 0x3ffffu) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_cnode_cap_set_capCNodeGuard(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_cnode_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0x3ffffu >> 0 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0x3ffffu;
    cap.words[1] |= (v32 << 0) & 0x3ffffu;
    return cap;
}

static inline uint32_t CONST
cap_cnode_cap_get_capCNodePtr(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_cnode_cap);

    ret = (cap.words[0] & 0xffffffe0u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_thread_cap_new(uint32_t capTCBPtr) {
    cap_t cap;

    /* fail if user has passed bits that we will override */  
    assert((capTCBPtr & ~0xfffffff0u) == ((0 && (capTCBPtr & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)cap_thread_cap & ~0xfu) == ((0 && ((uint32_t)cap_thread_cap & (1u << 31))) ? 0x0 : 0));

    cap.words[0] = 0
        | (capTCBPtr & 0xfffffff0u) >> 0
        | ((uint32_t)cap_thread_cap & 0xfu) << 0;
    cap.words[1] = 0;

    return cap;
}

static inline uint32_t CONST
cap_thread_cap_get_capTCBPtr(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_thread_cap);

    ret = (cap.words[0] & 0xfffffff0u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_small_frame_cap_new(uint32_t capFMappedASIDLow, uint32_t capFVMRights, uint32_t capFMappedAddress, uint32_t capFIsDevice, uint32_t capFMappedASIDHigh, uint32_t capFBasePtr) {
    cap_t cap;

    /* fail if user has passed bits that we will override */  
    assert((capFMappedASIDLow & ~0x3ffu) == ((0 && (capFMappedASIDLow & (1u << 31))) ? 0x0 : 0));  
    assert((capFVMRights & ~0x3u) == ((0 && (capFVMRights & (1u << 31))) ? 0x0 : 0));  
    assert((capFMappedAddress & ~0xfffff000u) == ((0 && (capFMappedAddress & (1u << 31))) ? 0x0 : 0));  
    assert((capFIsDevice & ~0x1u) == ((0 && (capFIsDevice & (1u << 31))) ? 0x0 : 0));  
    assert((capFMappedASIDHigh & ~0x7fu) == ((0 && (capFMappedASIDHigh & (1u << 31))) ? 0x0 : 0));  
    assert((capFBasePtr & ~0xfffff000u) == ((0 && (capFBasePtr & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)cap_small_frame_cap & ~0xfu) == ((0 && ((uint32_t)cap_small_frame_cap & (1u << 31))) ? 0x0 : 0));

    cap.words[0] = 0
        | (capFIsDevice & 0x1u) << 31
        | (capFMappedASIDHigh & 0x7fu) << 24
        | (capFBasePtr & 0xfffff000u) >> 8
        | ((uint32_t)cap_small_frame_cap & 0xfu) << 0;
    cap.words[1] = 0
        | (capFMappedASIDLow & 0x3ffu) << 22
        | (capFVMRights & 0x3u) << 20
        | (capFMappedAddress & 0xfffff000u) >> 12;

    return cap;
}

static inline uint32_t CONST
cap_small_frame_cap_get_capFMappedASIDLow(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_small_frame_cap);

    ret = (cap.words[1] & 0xffc00000u) >> 22;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_small_frame_cap_set_capFMappedASIDLow(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_small_frame_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0xffc00000u >> 22 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0xffc00000u;
    cap.words[1] |= (v32 << 22) & 0xffc00000u;
    return cap;
}

static inline uint32_t CONST
cap_small_frame_cap_get_capFVMRights(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_small_frame_cap);

    ret = (cap.words[1] & 0x300000u) >> 20;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_small_frame_cap_set_capFVMRights(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_small_frame_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0x300000u >> 20 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0x300000u;
    cap.words[1] |= (v32 << 20) & 0x300000u;
    return cap;
}

static inline uint32_t CONST
cap_small_frame_cap_get_capFMappedAddress(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_small_frame_cap);

    ret = (cap.words[1] & 0xfffffu) << 12;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_small_frame_cap_set_capFMappedAddress(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_small_frame_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0xfffffu << 12 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0xfffffu;
    cap.words[1] |= (v32 >> 12) & 0xfffffu;
    return cap;
}

static inline uint32_t CONST
cap_small_frame_cap_get_capFIsDevice(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_small_frame_cap);

    ret = (cap.words[0] & 0x80000000u) >> 31;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
cap_small_frame_cap_get_capFMappedASIDHigh(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_small_frame_cap);

    ret = (cap.words[0] & 0x7f000000u) >> 24;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_small_frame_cap_set_capFMappedASIDHigh(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_small_frame_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0x7f000000u >> 24 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[0] &= ~0x7f000000u;
    cap.words[0] |= (v32 << 24) & 0x7f000000u;
    return cap;
}

static inline uint32_t CONST
cap_small_frame_cap_get_capFBasePtr(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_small_frame_cap);

    ret = (cap.words[0] & 0xfffff0u) << 8;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_frame_cap_new(uint32_t capFSize, uint32_t capFMappedASIDLow, uint32_t capFVMRights, uint32_t capFMappedAddress, uint32_t capFIsDevice, uint32_t capFMappedASIDHigh, uint32_t capFBasePtr) {
    cap_t cap;

    /* fail if user has passed bits that we will override */  
    assert((capFSize & ~0x3u) == ((0 && (capFSize & (1u << 31))) ? 0x0 : 0));  
    assert((capFMappedASIDLow & ~0x3ffu) == ((0 && (capFMappedASIDLow & (1u << 31))) ? 0x0 : 0));  
    assert((capFVMRights & ~0x3u) == ((0 && (capFVMRights & (1u << 31))) ? 0x0 : 0));  
    assert((capFMappedAddress & ~0xffffc000u) == ((0 && (capFMappedAddress & (1u << 31))) ? 0x0 : 0));  
    assert((capFIsDevice & ~0x1u) == ((0 && (capFIsDevice & (1u << 31))) ? 0x0 : 0));  
    assert((capFMappedASIDHigh & ~0x7fu) == ((0 && (capFMappedASIDHigh & (1u << 31))) ? 0x0 : 0));  
    assert((capFBasePtr & ~0xffffc000u) == ((0 && (capFBasePtr & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)cap_frame_cap & ~0xfu) == ((0 && ((uint32_t)cap_frame_cap & (1u << 31))) ? 0x0 : 0));

    cap.words[0] = 0
        | (capFIsDevice & 0x1u) << 29
        | (capFMappedASIDHigh & 0x7fu) << 22
        | (capFBasePtr & 0xffffc000u) >> 10
        | ((uint32_t)cap_frame_cap & 0xfu) << 0;
    cap.words[1] = 0
        | (capFSize & 0x3u) << 30
        | (capFMappedASIDLow & 0x3ffu) << 20
        | (capFVMRights & 0x3u) << 18
        | (capFMappedAddress & 0xffffc000u) >> 14;

    return cap;
}

static inline uint32_t CONST
cap_frame_cap_get_capFSize(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_frame_cap);

    ret = (cap.words[1] & 0xc0000000u) >> 30;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
cap_frame_cap_get_capFMappedASIDLow(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_frame_cap);

    ret = (cap.words[1] & 0x3ff00000u) >> 20;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_frame_cap_set_capFMappedASIDLow(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_frame_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0x3ff00000u >> 20 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0x3ff00000u;
    cap.words[1] |= (v32 << 20) & 0x3ff00000u;
    return cap;
}

static inline uint32_t CONST
cap_frame_cap_get_capFVMRights(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_frame_cap);

    ret = (cap.words[1] & 0xc0000u) >> 18;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_frame_cap_set_capFVMRights(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_frame_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0xc0000u >> 18 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0xc0000u;
    cap.words[1] |= (v32 << 18) & 0xc0000u;
    return cap;
}

static inline uint32_t CONST
cap_frame_cap_get_capFMappedAddress(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_frame_cap);

    ret = (cap.words[1] & 0x3ffffu) << 14;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_frame_cap_set_capFMappedAddress(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_frame_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0x3ffffu << 14 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0x3ffffu;
    cap.words[1] |= (v32 >> 14) & 0x3ffffu;
    return cap;
}

static inline uint32_t CONST
cap_frame_cap_get_capFIsDevice(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_frame_cap);

    ret = (cap.words[0] & 0x20000000u) >> 29;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
cap_frame_cap_get_capFMappedASIDHigh(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_frame_cap);

    ret = (cap.words[0] & 0x1fc00000u) >> 22;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_frame_cap_set_capFMappedASIDHigh(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_frame_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0x1fc00000u >> 22 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[0] &= ~0x1fc00000u;
    cap.words[0] |= (v32 << 22) & 0x1fc00000u;
    return cap;
}

static inline uint32_t CONST
cap_frame_cap_get_capFBasePtr(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_frame_cap);

    ret = (cap.words[0] & 0x3ffff0u) << 10;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_asid_pool_cap_new(uint32_t capASIDBase, uint32_t capASIDPool) {
    cap_t cap;

    /* fail if user has passed bits that we will override */  
    assert((capASIDBase & ~0x1ffffu) == ((0 && (capASIDBase & (1u << 31))) ? 0x0 : 0));  
    assert((capASIDPool & ~0xfffffff0u) == ((0 && (capASIDPool & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)cap_asid_pool_cap & ~0xfu) == ((0 && ((uint32_t)cap_asid_pool_cap & (1u << 31))) ? 0x0 : 0));

    cap.words[0] = 0
        | (capASIDPool & 0xfffffff0u) >> 0
        | ((uint32_t)cap_asid_pool_cap & 0xfu) << 0;
    cap.words[1] = 0
        | (capASIDBase & 0x1ffffu) << 0;

    return cap;
}

static inline uint32_t CONST
cap_asid_pool_cap_get_capASIDBase(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_asid_pool_cap);

    ret = (cap.words[1] & 0x1ffffu) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
cap_asid_pool_cap_get_capASIDPool(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_asid_pool_cap);

    ret = (cap.words[0] & 0xfffffff0u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_page_table_cap_new(uint32_t capPTIsMapped, uint32_t capPTMappedASID, uint32_t capPTMappedAddress, uint32_t capPTBasePtr) {
    cap_t cap;

    /* fail if user has passed bits that we will override */  
    assert((capPTIsMapped & ~0x1u) == ((0 && (capPTIsMapped & (1u << 31))) ? 0x0 : 0));  
    assert((capPTMappedASID & ~0x1ffffu) == ((0 && (capPTMappedASID & (1u << 31))) ? 0x0 : 0));  
    assert((capPTMappedAddress & ~0xffe00000u) == ((0 && (capPTMappedAddress & (1u << 31))) ? 0x0 : 0));  
    assert((capPTBasePtr & ~0xfffffc00u) == ((0 && (capPTBasePtr & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)cap_page_table_cap & ~0xfu) == ((0 && ((uint32_t)cap_page_table_cap & (1u << 31))) ? 0x0 : 0));

    cap.words[0] = 0
        | (capPTBasePtr & 0xfffffc00u) >> 0
        | ((uint32_t)cap_page_table_cap & 0xfu) << 0;
    cap.words[1] = 0
        | (capPTIsMapped & 0x1u) << 29
        | (capPTMappedASID & 0x1ffffu) << 12
        | (capPTMappedAddress & 0xffe00000u) >> 21;

    return cap;
}

static inline uint32_t CONST
cap_page_table_cap_get_capPTIsMapped(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_page_table_cap);

    ret = (cap.words[1] & 0x20000000u) >> 29;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_page_table_cap_set_capPTIsMapped(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_page_table_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0x20000000u >> 29 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0x20000000u;
    cap.words[1] |= (v32 << 29) & 0x20000000u;
    return cap;
}

static inline void
cap_page_table_cap_ptr_set_capPTIsMapped(cap_t *cap_ptr,
                                      uint32_t v32) {
    assert(((cap_ptr->words[0] >> 0) & 0xf) ==
           cap_page_table_cap);

    /* fail if user has passed bits that we will override */
    assert((((~0x20000000u >> 29) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap_ptr->words[1] &= ~0x20000000u;
    cap_ptr->words[1] |= (v32 << 29) & 0x20000000u;
}

static inline uint32_t CONST
cap_page_table_cap_get_capPTMappedASID(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_page_table_cap);

    ret = (cap.words[1] & 0x1ffff000u) >> 12;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_page_table_cap_set_capPTMappedASID(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_page_table_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0x1ffff000u >> 12 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0x1ffff000u;
    cap.words[1] |= (v32 << 12) & 0x1ffff000u;
    return cap;
}

static inline uint32_t CONST
cap_page_table_cap_get_capPTMappedAddress(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_page_table_cap);

    ret = (cap.words[1] & 0x7ffu) << 21;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_page_table_cap_set_capPTMappedAddress(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_page_table_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0x7ffu << 21 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0x7ffu;
    cap.words[1] |= (v32 >> 21) & 0x7ffu;
    return cap;
}

static inline uint32_t CONST
cap_page_table_cap_get_capPTBasePtr(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_page_table_cap);

    ret = (cap.words[0] & 0xfffffc00u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_page_directory_cap_new(uint32_t capPDMappedASID, uint32_t capPDIsMapped, uint32_t capPDBasePtr) {
    cap_t cap;

    /* fail if user has passed bits that we will override */  
    assert((capPDMappedASID & ~0x1ffffu) == ((0 && (capPDMappedASID & (1u << 31))) ? 0x0 : 0));  
    assert((capPDIsMapped & ~0x1u) == ((0 && (capPDIsMapped & (1u << 31))) ? 0x0 : 0));  
    assert((capPDBasePtr & ~0xffffc000u) == ((0 && (capPDBasePtr & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)cap_page_directory_cap & ~0xfu) == ((0 && ((uint32_t)cap_page_directory_cap & (1u << 31))) ? 0x0 : 0));

    cap.words[0] = 0
        | (capPDIsMapped & 0x1u) << 4
        | (capPDBasePtr & 0xffffc000u) >> 0
        | ((uint32_t)cap_page_directory_cap & 0xfu) << 0;
    cap.words[1] = 0
        | (capPDMappedASID & 0x1ffffu) << 0;

    return cap;
}

static inline uint32_t CONST
cap_page_directory_cap_get_capPDMappedASID(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_page_directory_cap);

    ret = (cap.words[1] & 0x1ffffu) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline void
cap_page_directory_cap_ptr_set_capPDMappedASID(cap_t *cap_ptr,
                                      uint32_t v32) {
    assert(((cap_ptr->words[0] >> 0) & 0xf) ==
           cap_page_directory_cap);

    /* fail if user has passed bits that we will override */
    assert((((~0x1ffffu >> 0) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap_ptr->words[1] &= ~0x1ffffu;
    cap_ptr->words[1] |= (v32 << 0) & 0x1ffffu;
}

static inline uint32_t CONST
cap_page_directory_cap_get_capPDBasePtr(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_page_directory_cap);

    ret = (cap.words[0] & 0xffffc000u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
cap_page_directory_cap_get_capPDIsMapped(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xf) ==
           cap_page_directory_cap);

    ret = (cap.words[0] & 0x10u) >> 4;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline void
cap_page_directory_cap_ptr_set_capPDIsMapped(cap_t *cap_ptr,
                                      uint32_t v32) {
    assert(((cap_ptr->words[0] >> 0) & 0xf) ==
           cap_page_directory_cap);

    /* fail if user has passed bits that we will override */
    assert((((~0x10u >> 4) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap_ptr->words[0] &= ~0x10u;
    cap_ptr->words[0] |= (v32 << 4) & 0x10u;
}

static inline cap_t CONST
cap_asid_control_cap_new(void) {
    cap_t cap;

    /* fail if user has passed bits that we will override */  
    assert(((uint32_t)cap_asid_control_cap & ~0xfu) == ((0 && ((uint32_t)cap_asid_control_cap & (1u << 31))) ? 0x0 : 0));

    cap.words[0] = 0
        | ((uint32_t)cap_asid_control_cap & 0xfu) << 0;
    cap.words[1] = 0;

    return cap;
}

static inline cap_t CONST
cap_irq_control_cap_new(void) {
    cap_t cap;

    /* fail if user has passed bits that we will override */  
    assert(((uint32_t)cap_irq_control_cap & ~0xffu) == ((0 && ((uint32_t)cap_irq_control_cap & (1u << 31))) ? 0x0 : 0));

    cap.words[0] = 0
        | ((uint32_t)cap_irq_control_cap & 0xffu) << 0;
    cap.words[1] = 0;

    return cap;
}

static inline cap_t CONST
cap_irq_handler_cap_new(uint32_t capIRQ) {
    cap_t cap;

    /* fail if user has passed bits that we will override */  
    assert((capIRQ & ~0xffu) == ((0 && (capIRQ & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)cap_irq_handler_cap & ~0xffu) == ((0 && ((uint32_t)cap_irq_handler_cap & (1u << 31))) ? 0x0 : 0));

    cap.words[0] = 0
        | ((uint32_t)cap_irq_handler_cap & 0xffu) << 0;
    cap.words[1] = 0
        | (capIRQ & 0xffu) << 0;

    return cap;
}

static inline uint32_t CONST
cap_irq_handler_cap_get_capIRQ(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xff) ==
           cap_irq_handler_cap);

    ret = (cap.words[1] & 0xffu) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_zombie_cap_new(uint32_t capZombieID, uint32_t capZombieType) {
    cap_t cap;

    /* fail if user has passed bits that we will override */  
    assert((capZombieType & ~0x3fu) == ((0 && (capZombieType & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)cap_zombie_cap & ~0xffu) == ((0 && ((uint32_t)cap_zombie_cap & (1u << 31))) ? 0x0 : 0));

    cap.words[0] = 0
        | (capZombieType & 0x3fu) << 8
        | ((uint32_t)cap_zombie_cap & 0xffu) << 0;
    cap.words[1] = 0
        | capZombieID << 0;

    return cap;
}

static inline uint32_t CONST
cap_zombie_cap_get_capZombieID(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xff) ==
           cap_zombie_cap);

    ret = (cap.words[1] & 0xffffffffu) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_zombie_cap_set_capZombieID(cap_t cap, uint32_t v32) {
    assert(((cap.words[0] >> 0) & 0xff) ==
           cap_zombie_cap);
    /* fail if user has passed bits that we will override */
    assert((((~0xffffffffu >> 0 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    cap.words[1] &= ~0xffffffffu;
    cap.words[1] |= (v32 << 0) & 0xffffffffu;
    return cap;
}

static inline uint32_t CONST
cap_zombie_cap_get_capZombieType(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xff) ==
           cap_zombie_cap);

    ret = (cap.words[0] & 0x3f00u) >> 8;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline cap_t CONST
cap_domain_cap_new(void) {
    cap_t cap;

    /* fail if user has passed bits that we will override */  
    assert(((uint32_t)cap_domain_cap & ~0xffu) == ((0 && ((uint32_t)cap_domain_cap & (1u << 31))) ? 0x0 : 0));

    cap.words[0] = 0
        | ((uint32_t)cap_domain_cap & 0xffu) << 0;
    cap.words[1] = 0;

    return cap;
}

static inline cap_t CONST
cap_vcpu_cap_new(uint32_t capVCPUPtr) {
    cap_t cap;

    /* fail if user has passed bits that we will override */  
    assert((capVCPUPtr & ~0xffffff00u) == ((0 && (capVCPUPtr & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)cap_vcpu_cap & ~0xffu) == ((0 && ((uint32_t)cap_vcpu_cap & (1u << 31))) ? 0x0 : 0));

    cap.words[0] = 0
        | (capVCPUPtr & 0xffffff00u) >> 0
        | ((uint32_t)cap_vcpu_cap & 0xffu) << 0;
    cap.words[1] = 0;

    return cap;
}

static inline uint32_t CONST
cap_vcpu_cap_get_capVCPUPtr(cap_t cap) {
    uint32_t ret;
    assert(((cap.words[0] >> 0) & 0xff) ==
           cap_vcpu_cap);

    ret = (cap.words[0] & 0xffffff00u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

struct lookup_fault {
    uint32_t words[2];
};
typedef struct lookup_fault lookup_fault_t;

enum lookup_fault_tag {
    lookup_fault_invalid_root = 0,
    lookup_fault_missing_capability = 1,
    lookup_fault_depth_mismatch = 2,
    lookup_fault_guard_mismatch = 3
};
typedef enum lookup_fault_tag lookup_fault_tag_t;

static inline uint32_t CONST
lookup_fault_get_lufType(lookup_fault_t lookup_fault) {
    return (lookup_fault.words[0] >> 0) & 0x3u;
}

static inline lookup_fault_t CONST
lookup_fault_invalid_root_new(void) {
    lookup_fault_t lookup_fault;

    /* fail if user has passed bits that we will override */  
    assert(((uint32_t)lookup_fault_invalid_root & ~0x3u) == ((0 && ((uint32_t)lookup_fault_invalid_root & (1u << 31))) ? 0x0 : 0));

    lookup_fault.words[0] = 0
        | ((uint32_t)lookup_fault_invalid_root & 0x3u) << 0;
    lookup_fault.words[1] = 0;

    return lookup_fault;
}

static inline lookup_fault_t CONST
lookup_fault_missing_capability_new(uint32_t bitsLeft) {
    lookup_fault_t lookup_fault;

    /* fail if user has passed bits that we will override */  
    assert((bitsLeft & ~0x3fu) == ((0 && (bitsLeft & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)lookup_fault_missing_capability & ~0x3u) == ((0 && ((uint32_t)lookup_fault_missing_capability & (1u << 31))) ? 0x0 : 0));

    lookup_fault.words[0] = 0
        | (bitsLeft & 0x3fu) << 2
        | ((uint32_t)lookup_fault_missing_capability & 0x3u) << 0;
    lookup_fault.words[1] = 0;

    return lookup_fault;
}

static inline uint32_t CONST
lookup_fault_missing_capability_get_bitsLeft(lookup_fault_t lookup_fault) {
    uint32_t ret;
    assert(((lookup_fault.words[0] >> 0) & 0x3) ==
           lookup_fault_missing_capability);

    ret = (lookup_fault.words[0] & 0xfcu) >> 2;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline lookup_fault_t CONST
lookup_fault_depth_mismatch_new(uint32_t bitsFound, uint32_t bitsLeft) {
    lookup_fault_t lookup_fault;

    /* fail if user has passed bits that we will override */  
    assert((bitsFound & ~0x3fu) == ((0 && (bitsFound & (1u << 31))) ? 0x0 : 0));  
    assert((bitsLeft & ~0x3fu) == ((0 && (bitsLeft & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)lookup_fault_depth_mismatch & ~0x3u) == ((0 && ((uint32_t)lookup_fault_depth_mismatch & (1u << 31))) ? 0x0 : 0));

    lookup_fault.words[0] = 0
        | (bitsFound & 0x3fu) << 8
        | (bitsLeft & 0x3fu) << 2
        | ((uint32_t)lookup_fault_depth_mismatch & 0x3u) << 0;
    lookup_fault.words[1] = 0;

    return lookup_fault;
}

static inline uint32_t CONST
lookup_fault_depth_mismatch_get_bitsFound(lookup_fault_t lookup_fault) {
    uint32_t ret;
    assert(((lookup_fault.words[0] >> 0) & 0x3) ==
           lookup_fault_depth_mismatch);

    ret = (lookup_fault.words[0] & 0x3f00u) >> 8;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
lookup_fault_depth_mismatch_get_bitsLeft(lookup_fault_t lookup_fault) {
    uint32_t ret;
    assert(((lookup_fault.words[0] >> 0) & 0x3) ==
           lookup_fault_depth_mismatch);

    ret = (lookup_fault.words[0] & 0xfcu) >> 2;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline lookup_fault_t CONST
lookup_fault_guard_mismatch_new(uint32_t guardFound, uint32_t bitsLeft, uint32_t bitsFound) {
    lookup_fault_t lookup_fault;

    /* fail if user has passed bits that we will override */  
    assert((bitsLeft & ~0x3fu) == ((0 && (bitsLeft & (1u << 31))) ? 0x0 : 0));  
    assert((bitsFound & ~0x3fu) == ((0 && (bitsFound & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)lookup_fault_guard_mismatch & ~0x3u) == ((0 && ((uint32_t)lookup_fault_guard_mismatch & (1u << 31))) ? 0x0 : 0));

    lookup_fault.words[0] = 0
        | (bitsLeft & 0x3fu) << 8
        | (bitsFound & 0x3fu) << 2
        | ((uint32_t)lookup_fault_guard_mismatch & 0x3u) << 0;
    lookup_fault.words[1] = 0
        | guardFound << 0;

    return lookup_fault;
}

static inline uint32_t CONST
lookup_fault_guard_mismatch_get_guardFound(lookup_fault_t lookup_fault) {
    uint32_t ret;
    assert(((lookup_fault.words[0] >> 0) & 0x3) ==
           lookup_fault_guard_mismatch);

    ret = (lookup_fault.words[1] & 0xffffffffu) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
lookup_fault_guard_mismatch_get_bitsLeft(lookup_fault_t lookup_fault) {
    uint32_t ret;
    assert(((lookup_fault.words[0] >> 0) & 0x3) ==
           lookup_fault_guard_mismatch);

    ret = (lookup_fault.words[0] & 0x3f00u) >> 8;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
lookup_fault_guard_mismatch_get_bitsFound(lookup_fault_t lookup_fault) {
    uint32_t ret;
    assert(((lookup_fault.words[0] >> 0) & 0x3) ==
           lookup_fault_guard_mismatch);

    ret = (lookup_fault.words[0] & 0xfcu) >> 2;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

struct pde {
    uint32_t words[2];
};
typedef struct pde pde_t;

enum pde_tag {
    pde_pde_invalid = 0,
    pde_pde_section = 1,
    pde_pde_coarse = 3
};
typedef enum pde_tag pde_tag_t;

static inline uint32_t CONST
pde_get_pdeType(pde_t pde) {
    return (pde.words[0] >> 0) & 0x3u;
}

static inline uint32_t PURE
pde_ptr_get_pdeType(pde_t *pde_ptr) {
    return (pde_ptr->words[0] >> 0) & 0x3u;
}

static inline pde_t CONST
pde_pde_invalid_new(uint32_t stored_hw_asid, uint32_t stored_asid_valid) {
    pde_t pde;

    /* fail if user has passed bits that we will override */  
    assert((stored_hw_asid & ~0xffu) == ((0 && (stored_hw_asid & (1u << 31))) ? 0x0 : 0));  
    assert((stored_asid_valid & ~0x1u) == ((0 && (stored_asid_valid & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)pde_pde_invalid & ~0x3u) == ((0 && ((uint32_t)pde_pde_invalid & (1u << 31))) ? 0x0 : 0));

    pde.words[0] = 0
        | (stored_hw_asid & 0xffu) << 24
        | (stored_asid_valid & 0x1u) << 23
        | ((uint32_t)pde_pde_invalid & 0x3u) << 0;
    pde.words[1] = 0;

    return pde;
}

static inline uint32_t CONST
pde_pde_invalid_get_stored_hw_asid(pde_t pde) {
    uint32_t ret;
    assert(((pde.words[0] >> 0) & 0x3) ==
           pde_pde_invalid);

    ret = (pde.words[0] & 0xff000000u) >> 24;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
pde_pde_invalid_get_stored_asid_valid(pde_t pde) {
    uint32_t ret;
    assert(((pde.words[0] >> 0) & 0x3) ==
           pde_pde_invalid);

    ret = (pde.words[0] & 0x800000u) >> 23;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline pde_t CONST
pde_pde_section_new(uint32_t XN, uint32_t contiguous_hint, uint32_t address, uint32_t AF, uint32_t SH, uint32_t HAP, uint32_t MemAttr) {
    pde_t pde;

    /* fail if user has passed bits that we will override */  
    assert((XN & ~0x1u) == ((0 && (XN & (1u << 31))) ? 0x0 : 0));  
    assert((contiguous_hint & ~0x1u) == ((0 && (contiguous_hint & (1u << 31))) ? 0x0 : 0));  
    assert((address & ~0xfffff000u) == ((0 && (address & (1u << 31))) ? 0x0 : 0));  
    assert((AF & ~0x1u) == ((0 && (AF & (1u << 31))) ? 0x0 : 0));  
    assert((SH & ~0x3u) == ((0 && (SH & (1u << 31))) ? 0x0 : 0));  
    assert((HAP & ~0x3u) == ((0 && (HAP & (1u << 31))) ? 0x0 : 0));  
    assert((MemAttr & ~0xfu) == ((0 && (MemAttr & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)pde_pde_section & ~0x3u) == ((0 && ((uint32_t)pde_pde_section & (1u << 31))) ? 0x0 : 0));

    pde.words[0] = 0
        | (address & 0xfffff000u) >> 0
        | (AF & 0x1u) << 10
        | (SH & 0x3u) << 8
        | (HAP & 0x3u) << 6
        | (MemAttr & 0xfu) << 2
        | ((uint32_t)pde_pde_section & 0x3u) << 0;
    pde.words[1] = 0
        | (XN & 0x1u) << 22
        | (contiguous_hint & 0x1u) << 20;

    return pde;
}

static inline uint32_t CONST
pde_pde_section_get_contiguous_hint(pde_t pde) {
    uint32_t ret;
    assert(((pde.words[0] >> 0) & 0x3) ==
           pde_pde_section);

    ret = (pde.words[1] & 0x100000u) >> 20;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t PURE
pde_pde_section_ptr_get_contiguous_hint(pde_t *pde_ptr) {
    uint32_t ret;
    assert(((pde_ptr->words[0] >> 0) & 0x3) ==
           pde_pde_section);

    ret = (pde_ptr->words[1] & 0x100000u) >> 20;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
pde_pde_section_get_address(pde_t pde) {
    uint32_t ret;
    assert(((pde.words[0] >> 0) & 0x3) ==
           pde_pde_section);

    ret = (pde.words[0] & 0xfffff000u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline pde_t CONST
pde_pde_section_set_address(pde_t pde, uint32_t v32) {
    assert(((pde.words[0] >> 0) & 0x3) ==
           pde_pde_section);
    /* fail if user has passed bits that we will override */
    assert((((~0xfffff000u << 0 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    pde.words[0] &= ~0xfffff000u;
    pde.words[0] |= (v32 >> 0) & 0xfffff000u;
    return pde;
}

static inline uint32_t PURE
pde_pde_section_ptr_get_address(pde_t *pde_ptr) {
    uint32_t ret;
    assert(((pde_ptr->words[0] >> 0) & 0x3) ==
           pde_pde_section);

    ret = (pde_ptr->words[0] & 0xfffff000u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline pde_t CONST
pde_pde_coarse_new(uint32_t address) {
    pde_t pde;

    /* fail if user has passed bits that we will override */  
    assert((address & ~0xfffff000u) == ((0 && (address & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)pde_pde_coarse & ~0x3u) == ((0 && ((uint32_t)pde_pde_coarse & (1u << 31))) ? 0x0 : 0));

    pde.words[0] = 0
        | (address & 0xfffff000u) >> 0
        | ((uint32_t)pde_pde_coarse & 0x3u) << 0;
    pde.words[1] = 0;

    return pde;
}

static inline uint32_t CONST
pde_pde_coarse_get_address(pde_t pde) {
    uint32_t ret;
    assert(((pde.words[0] >> 0) & 0x3) ==
           pde_pde_coarse);

    ret = (pde.words[0] & 0xfffff000u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t PURE
pde_pde_coarse_ptr_get_address(pde_t *pde_ptr) {
    uint32_t ret;
    assert(((pde_ptr->words[0] >> 0) & 0x3) ==
           pde_pde_coarse);

    ret = (pde_ptr->words[0] & 0xfffff000u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

struct pdeS1 {
    uint32_t words[2];
};
typedef struct pdeS1 pdeS1_t;

enum pdeS1_tag {
    pdeS1_pdeS1_invalid = 0,
    pdeS1_pdeS1_section = 1,
    pdeS1_pdeS1_coarse = 3
};
typedef enum pdeS1_tag pdeS1_tag_t;

static inline pdeS1_t CONST
pdeS1_pdeS1_invalid_new(void) {
    pdeS1_t pdeS1;

    /* fail if user has passed bits that we will override */  
    assert(((uint32_t)pdeS1_pdeS1_invalid & ~0x3u) == ((0 && ((uint32_t)pdeS1_pdeS1_invalid & (1u << 31))) ? 0x0 : 0));

    pdeS1.words[0] = 0
        | ((uint32_t)pdeS1_pdeS1_invalid & 0x3u) << 0;
    pdeS1.words[1] = 0;

    return pdeS1;
}

static inline pdeS1_t CONST
pdeS1_pdeS1_section_new(uint32_t XN, uint32_t PXN, uint32_t contiguous_hint, uint32_t address, uint32_t nG, uint32_t AF, uint32_t SH, uint32_t AP, uint32_t NS, uint32_t AttrIndx) {
    pdeS1_t pdeS1;

    /* fail if user has passed bits that we will override */  
    assert((XN & ~0x1u) == ((0 && (XN & (1u << 31))) ? 0x0 : 0));  
    assert((PXN & ~0x1u) == ((0 && (PXN & (1u << 31))) ? 0x0 : 0));  
    assert((contiguous_hint & ~0x1u) == ((0 && (contiguous_hint & (1u << 31))) ? 0x0 : 0));  
    assert((address & ~0xfffff000u) == ((0 && (address & (1u << 31))) ? 0x0 : 0));  
    assert((nG & ~0x1u) == ((0 && (nG & (1u << 31))) ? 0x0 : 0));  
    assert((AF & ~0x1u) == ((0 && (AF & (1u << 31))) ? 0x0 : 0));  
    assert((SH & ~0x3u) == ((0 && (SH & (1u << 31))) ? 0x0 : 0));  
    assert((AP & ~0x3u) == ((0 && (AP & (1u << 31))) ? 0x0 : 0));  
    assert((NS & ~0x1u) == ((0 && (NS & (1u << 31))) ? 0x0 : 0));  
    assert((AttrIndx & ~0x7u) == ((0 && (AttrIndx & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)pdeS1_pdeS1_section & ~0x3u) == ((0 && ((uint32_t)pdeS1_pdeS1_section & (1u << 31))) ? 0x0 : 0));

    pdeS1.words[0] = 0
        | (address & 0xfffff000u) >> 0
        | (nG & 0x1u) << 11
        | (AF & 0x1u) << 10
        | (SH & 0x3u) << 8
        | (AP & 0x3u) << 6
        | (NS & 0x1u) << 5
        | (AttrIndx & 0x7u) << 2
        | ((uint32_t)pdeS1_pdeS1_section & 0x3u) << 0;
    pdeS1.words[1] = 0
        | (XN & 0x1u) << 22
        | (PXN & 0x1u) << 21
        | (contiguous_hint & 0x1u) << 20;

    return pdeS1;
}

static inline pdeS1_t CONST
pdeS1_pdeS1_coarse_new(uint32_t NSTable, uint32_t APTable, uint32_t XNTable, uint32_t PXNTable, uint32_t address) {
    pdeS1_t pdeS1;

    /* fail if user has passed bits that we will override */  
    assert((NSTable & ~0x1u) == ((0 && (NSTable & (1u << 31))) ? 0x0 : 0));  
    assert((APTable & ~0x3u) == ((0 && (APTable & (1u << 31))) ? 0x0 : 0));  
    assert((XNTable & ~0x1u) == ((0 && (XNTable & (1u << 31))) ? 0x0 : 0));  
    assert((PXNTable & ~0x1u) == ((0 && (PXNTable & (1u << 31))) ? 0x0 : 0));  
    assert((address & ~0xfffff000u) == ((0 && (address & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)pdeS1_pdeS1_coarse & ~0x3u) == ((0 && ((uint32_t)pdeS1_pdeS1_coarse & (1u << 31))) ? 0x0 : 0));

    pdeS1.words[0] = 0
        | (address & 0xfffff000u) >> 0
        | ((uint32_t)pdeS1_pdeS1_coarse & 0x3u) << 0;
    pdeS1.words[1] = 0
        | (NSTable & 0x1u) << 31
        | (APTable & 0x3u) << 29
        | (XNTable & 0x1u) << 28
        | (PXNTable & 0x1u) << 27;

    return pdeS1;
}

struct pte {
    uint32_t words[2];
};
typedef struct pte pte_t;

enum pte_tag {
    pte_pte_invalid = 0,
    pte_pte_small = 3
};
typedef enum pte_tag pte_tag_t;

static inline uint32_t CONST
pte_get_pteType(pte_t pte) {
    return (pte.words[0] >> 0) & 0x3u;
}

static inline uint32_t PURE
pte_ptr_get_pteType(pte_t *pte_ptr) {
    return (pte_ptr->words[0] >> 0) & 0x3u;
}

static inline pte_t CONST
pte_pte_invalid_new(void) {
    pte_t pte;

    /* fail if user has passed bits that we will override */  
    assert(((uint32_t)pte_pte_invalid & ~0x3u) == ((0 && ((uint32_t)pte_pte_invalid & (1u << 31))) ? 0x0 : 0));

    pte.words[0] = 0
        | ((uint32_t)pte_pte_invalid & 0x3u) << 0;
    pte.words[1] = 0;

    return pte;
}

static inline pte_t CONST
pte_pte_small_new(uint32_t XN, uint32_t contiguous_hint, uint32_t address, uint32_t AF, uint32_t SH, uint32_t HAP, uint32_t MemAttr) {
    pte_t pte;

    /* fail if user has passed bits that we will override */  
    assert((XN & ~0x1u) == ((0 && (XN & (1u << 31))) ? 0x0 : 0));  
    assert((contiguous_hint & ~0x1u) == ((0 && (contiguous_hint & (1u << 31))) ? 0x0 : 0));  
    assert((address & ~0xfffff000u) == ((0 && (address & (1u << 31))) ? 0x0 : 0));  
    assert((AF & ~0x1u) == ((0 && (AF & (1u << 31))) ? 0x0 : 0));  
    assert((SH & ~0x3u) == ((0 && (SH & (1u << 31))) ? 0x0 : 0));  
    assert((HAP & ~0x3u) == ((0 && (HAP & (1u << 31))) ? 0x0 : 0));  
    assert((MemAttr & ~0xfu) == ((0 && (MemAttr & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)pte_pte_small & ~0x3u) == ((0 && ((uint32_t)pte_pte_small & (1u << 31))) ? 0x0 : 0));

    pte.words[0] = 0
        | (address & 0xfffff000u) >> 0
        | (AF & 0x1u) << 10
        | (SH & 0x3u) << 8
        | (HAP & 0x3u) << 6
        | (MemAttr & 0xfu) << 2
        | ((uint32_t)pte_pte_small & 0x3u) << 0;
    pte.words[1] = 0
        | (XN & 0x1u) << 22
        | (contiguous_hint & 0x1u) << 20;

    return pte;
}

static inline uint32_t CONST
pte_pte_small_get_contiguous_hint(pte_t pte) {
    uint32_t ret;
    assert(((pte.words[0] >> 0) & 0x3) ==
           pte_pte_small);

    ret = (pte.words[1] & 0x100000u) >> 20;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t PURE
pte_pte_small_ptr_get_contiguous_hint(pte_t *pte_ptr) {
    uint32_t ret;
    assert(((pte_ptr->words[0] >> 0) & 0x3) ==
           pte_pte_small);

    ret = (pte_ptr->words[1] & 0x100000u) >> 20;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
pte_pte_small_get_address(pte_t pte) {
    uint32_t ret;
    assert(((pte.words[0] >> 0) & 0x3) ==
           pte_pte_small);

    ret = (pte.words[0] & 0xfffff000u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline pte_t CONST
pte_pte_small_set_address(pte_t pte, uint32_t v32) {
    assert(((pte.words[0] >> 0) & 0x3) ==
           pte_pte_small);
    /* fail if user has passed bits that we will override */
    assert((((~0xfffff000u << 0 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    pte.words[0] &= ~0xfffff000u;
    pte.words[0] |= (v32 >> 0) & 0xfffff000u;
    return pte;
}

static inline uint32_t PURE
pte_pte_small_ptr_get_address(pte_t *pte_ptr) {
    uint32_t ret;
    assert(((pte_ptr->words[0] >> 0) & 0x3) ==
           pte_pte_small);

    ret = (pte_ptr->words[0] & 0xfffff000u) << 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

struct pteS1 {
    uint32_t words[2];
};
typedef struct pteS1 pteS1_t;

enum pteS1_tag {
    pteS1_pteS1_invalid = 0,
    pteS1_pteS1_small = 3
};
typedef enum pteS1_tag pteS1_tag_t;

static inline pteS1_t CONST
pteS1_pteS1_small_new(uint32_t XN, uint32_t PXN, uint32_t contiguous_hint, uint32_t address, uint32_t nG, uint32_t AF, uint32_t SH, uint32_t AP, uint32_t NS, uint32_t AttrIndx) {
    pteS1_t pteS1;

    /* fail if user has passed bits that we will override */  
    assert((XN & ~0x1u) == ((0 && (XN & (1u << 31))) ? 0x0 : 0));  
    assert((PXN & ~0x1u) == ((0 && (PXN & (1u << 31))) ? 0x0 : 0));  
    assert((contiguous_hint & ~0x1u) == ((0 && (contiguous_hint & (1u << 31))) ? 0x0 : 0));  
    assert((address & ~0xfffff000u) == ((0 && (address & (1u << 31))) ? 0x0 : 0));  
    assert((nG & ~0x1u) == ((0 && (nG & (1u << 31))) ? 0x0 : 0));  
    assert((AF & ~0x1u) == ((0 && (AF & (1u << 31))) ? 0x0 : 0));  
    assert((SH & ~0x3u) == ((0 && (SH & (1u << 31))) ? 0x0 : 0));  
    assert((AP & ~0x3u) == ((0 && (AP & (1u << 31))) ? 0x0 : 0));  
    assert((NS & ~0x1u) == ((0 && (NS & (1u << 31))) ? 0x0 : 0));  
    assert((AttrIndx & ~0x7u) == ((0 && (AttrIndx & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)pteS1_pteS1_small & ~0x3u) == ((0 && ((uint32_t)pteS1_pteS1_small & (1u << 31))) ? 0x0 : 0));

    pteS1.words[0] = 0
        | (address & 0xfffff000u) >> 0
        | (nG & 0x1u) << 11
        | (AF & 0x1u) << 10
        | (SH & 0x3u) << 8
        | (AP & 0x3u) << 6
        | (NS & 0x1u) << 5
        | (AttrIndx & 0x7u) << 2
        | ((uint32_t)pteS1_pteS1_small & 0x3u) << 0;
    pteS1.words[1] = 0
        | (XN & 0x1u) << 22
        | (PXN & 0x1u) << 21
        | (contiguous_hint & 0x1u) << 20;

    return pteS1;
}

struct seL4_Fault {
    uint32_t words[2];
};
typedef struct seL4_Fault seL4_Fault_t;

enum seL4_Fault_tag {
    seL4_Fault_NullFault = 0,
    seL4_Fault_CapFault = 1,
    seL4_Fault_UnknownSyscall = 2,
    seL4_Fault_UserException = 3,
    seL4_Fault_VMFault = 5,
    seL4_Fault_VGICMaintenance = 6,
    seL4_Fault_VCPUFault = 7,
    seL4_Fault_VPPIEvent = 8
};
typedef enum seL4_Fault_tag seL4_Fault_tag_t;

static inline uint32_t CONST
seL4_Fault_get_seL4_FaultType(seL4_Fault_t seL4_Fault) {
    return (seL4_Fault.words[0] >> 0) & 0xfu;
}

static inline seL4_Fault_t CONST
seL4_Fault_NullFault_new(void) {
    seL4_Fault_t seL4_Fault;

    /* fail if user has passed bits that we will override */  
    assert(((uint32_t)seL4_Fault_NullFault & ~0xfu) == ((0 && ((uint32_t)seL4_Fault_NullFault & (1u << 31))) ? 0x0 : 0));

    seL4_Fault.words[0] = 0
        | ((uint32_t)seL4_Fault_NullFault & 0xfu) << 0;
    seL4_Fault.words[1] = 0;

    return seL4_Fault;
}

static inline seL4_Fault_t CONST
seL4_Fault_CapFault_new(uint32_t address, uint32_t inReceivePhase) {
    seL4_Fault_t seL4_Fault;

    /* fail if user has passed bits that we will override */  
    assert((inReceivePhase & ~0x1u) == ((0 && (inReceivePhase & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)seL4_Fault_CapFault & ~0xfu) == ((0 && ((uint32_t)seL4_Fault_CapFault & (1u << 31))) ? 0x0 : 0));

    seL4_Fault.words[0] = 0
        | (inReceivePhase & 0x1u) << 31
        | ((uint32_t)seL4_Fault_CapFault & 0xfu) << 0;
    seL4_Fault.words[1] = 0
        | address << 0;

    return seL4_Fault;
}

static inline uint32_t CONST
seL4_Fault_CapFault_get_address(seL4_Fault_t seL4_Fault) {
    uint32_t ret;
    assert(((seL4_Fault.words[0] >> 0) & 0xf) ==
           seL4_Fault_CapFault);

    ret = (seL4_Fault.words[1] & 0xffffffffu) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
seL4_Fault_CapFault_get_inReceivePhase(seL4_Fault_t seL4_Fault) {
    uint32_t ret;
    assert(((seL4_Fault.words[0] >> 0) & 0xf) ==
           seL4_Fault_CapFault);

    ret = (seL4_Fault.words[0] & 0x80000000u) >> 31;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline seL4_Fault_t CONST
seL4_Fault_UnknownSyscall_new(uint32_t syscallNumber) {
    seL4_Fault_t seL4_Fault;

    /* fail if user has passed bits that we will override */  
    assert(((uint32_t)seL4_Fault_UnknownSyscall & ~0xfu) == ((0 && ((uint32_t)seL4_Fault_UnknownSyscall & (1u << 31))) ? 0x0 : 0));

    seL4_Fault.words[0] = 0
        | ((uint32_t)seL4_Fault_UnknownSyscall & 0xfu) << 0;
    seL4_Fault.words[1] = 0
        | syscallNumber << 0;

    return seL4_Fault;
}

static inline uint32_t CONST
seL4_Fault_UnknownSyscall_get_syscallNumber(seL4_Fault_t seL4_Fault) {
    uint32_t ret;
    assert(((seL4_Fault.words[0] >> 0) & 0xf) ==
           seL4_Fault_UnknownSyscall);

    ret = (seL4_Fault.words[1] & 0xffffffffu) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline seL4_Fault_t CONST
seL4_Fault_UserException_new(uint32_t number, uint32_t code) {
    seL4_Fault_t seL4_Fault;

    /* fail if user has passed bits that we will override */  
    assert((code & ~0xfffffffu) == ((0 && (code & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)seL4_Fault_UserException & ~0xfu) == ((0 && ((uint32_t)seL4_Fault_UserException & (1u << 31))) ? 0x0 : 0));

    seL4_Fault.words[0] = 0
        | (code & 0xfffffffu) << 4
        | ((uint32_t)seL4_Fault_UserException & 0xfu) << 0;
    seL4_Fault.words[1] = 0
        | number << 0;

    return seL4_Fault;
}

static inline uint32_t CONST
seL4_Fault_UserException_get_number(seL4_Fault_t seL4_Fault) {
    uint32_t ret;
    assert(((seL4_Fault.words[0] >> 0) & 0xf) ==
           seL4_Fault_UserException);

    ret = (seL4_Fault.words[1] & 0xffffffffu) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
seL4_Fault_UserException_get_code(seL4_Fault_t seL4_Fault) {
    uint32_t ret;
    assert(((seL4_Fault.words[0] >> 0) & 0xf) ==
           seL4_Fault_UserException);

    ret = (seL4_Fault.words[0] & 0xfffffff0u) >> 4;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline seL4_Fault_t CONST
seL4_Fault_VMFault_new(uint32_t address, uint32_t FSR, uint32_t instructionFault) {
    seL4_Fault_t seL4_Fault;

    /* fail if user has passed bits that we will override */  
    assert((FSR & ~0x3ffffffu) == ((0 && (FSR & (1u << 31))) ? 0x0 : 0));  
    assert((instructionFault & ~0x1u) == ((0 && (instructionFault & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)seL4_Fault_VMFault & ~0xfu) == ((0 && ((uint32_t)seL4_Fault_VMFault & (1u << 31))) ? 0x0 : 0));

    seL4_Fault.words[0] = 0
        | (FSR & 0x3ffffffu) << 6
        | (instructionFault & 0x1u) << 4
        | ((uint32_t)seL4_Fault_VMFault & 0xfu) << 0;
    seL4_Fault.words[1] = 0
        | address << 0;

    return seL4_Fault;
}

static inline uint32_t CONST
seL4_Fault_VMFault_get_address(seL4_Fault_t seL4_Fault) {
    uint32_t ret;
    assert(((seL4_Fault.words[0] >> 0) & 0xf) ==
           seL4_Fault_VMFault);

    ret = (seL4_Fault.words[1] & 0xffffffffu) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
seL4_Fault_VMFault_get_FSR(seL4_Fault_t seL4_Fault) {
    uint32_t ret;
    assert(((seL4_Fault.words[0] >> 0) & 0xf) ==
           seL4_Fault_VMFault);

    ret = (seL4_Fault.words[0] & 0xffffffc0u) >> 6;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
seL4_Fault_VMFault_get_instructionFault(seL4_Fault_t seL4_Fault) {
    uint32_t ret;
    assert(((seL4_Fault.words[0] >> 0) & 0xf) ==
           seL4_Fault_VMFault);

    ret = (seL4_Fault.words[0] & 0x10u) >> 4;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline seL4_Fault_t CONST
seL4_Fault_VGICMaintenance_new(uint32_t idx, uint32_t idxValid) {
    seL4_Fault_t seL4_Fault;

    /* fail if user has passed bits that we will override */  
    assert((idx & ~0x3fu) == ((0 && (idx & (1u << 31))) ? 0x0 : 0));  
    assert((idxValid & ~0x1u) == ((0 && (idxValid & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)seL4_Fault_VGICMaintenance & ~0xfu) == ((0 && ((uint32_t)seL4_Fault_VGICMaintenance & (1u << 31))) ? 0x0 : 0));

    seL4_Fault.words[0] = 0
        | ((uint32_t)seL4_Fault_VGICMaintenance & 0xfu) << 0;
    seL4_Fault.words[1] = 0
        | (idx & 0x3fu) << 26
        | (idxValid & 0x1u) << 25;

    return seL4_Fault;
}

static inline uint32_t CONST
seL4_Fault_VGICMaintenance_get_idx(seL4_Fault_t seL4_Fault) {
    uint32_t ret;
    assert(((seL4_Fault.words[0] >> 0) & 0xf) ==
           seL4_Fault_VGICMaintenance);

    ret = (seL4_Fault.words[1] & 0xfc000000u) >> 26;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline uint32_t CONST
seL4_Fault_VGICMaintenance_get_idxValid(seL4_Fault_t seL4_Fault) {
    uint32_t ret;
    assert(((seL4_Fault.words[0] >> 0) & 0xf) ==
           seL4_Fault_VGICMaintenance);

    ret = (seL4_Fault.words[1] & 0x2000000u) >> 25;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline seL4_Fault_t CONST
seL4_Fault_VCPUFault_new(uint32_t hsr) {
    seL4_Fault_t seL4_Fault;

    /* fail if user has passed bits that we will override */  
    assert(((uint32_t)seL4_Fault_VCPUFault & ~0xfu) == ((0 && ((uint32_t)seL4_Fault_VCPUFault & (1u << 31))) ? 0x0 : 0));

    seL4_Fault.words[0] = 0
        | ((uint32_t)seL4_Fault_VCPUFault & 0xfu) << 0;
    seL4_Fault.words[1] = 0
        | hsr << 0;

    return seL4_Fault;
}

static inline uint32_t CONST
seL4_Fault_VCPUFault_get_hsr(seL4_Fault_t seL4_Fault) {
    uint32_t ret;
    assert(((seL4_Fault.words[0] >> 0) & 0xf) ==
           seL4_Fault_VCPUFault);

    ret = (seL4_Fault.words[1] & 0xffffffffu) >> 0;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

static inline seL4_Fault_t CONST
seL4_Fault_VPPIEvent_new(uint32_t irq_w) {
    seL4_Fault_t seL4_Fault;

    /* fail if user has passed bits that we will override */  
    assert((irq_w & ~0x3ffu) == ((0 && (irq_w & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)seL4_Fault_VPPIEvent & ~0xfu) == ((0 && ((uint32_t)seL4_Fault_VPPIEvent & (1u << 31))) ? 0x0 : 0));

    seL4_Fault.words[0] = 0
        | ((uint32_t)seL4_Fault_VPPIEvent & 0xfu) << 0;
    seL4_Fault.words[1] = 0
        | (irq_w & 0x3ffu) << 22;

    return seL4_Fault;
}

static inline uint32_t CONST
seL4_Fault_VPPIEvent_get_irq_w(seL4_Fault_t seL4_Fault) {
    uint32_t ret;
    assert(((seL4_Fault.words[0] >> 0) & 0xf) ==
           seL4_Fault_VPPIEvent);

    ret = (seL4_Fault.words[1] & 0xffc00000u) >> 22;
    /* Possibly sign extend */
    if (__builtin_expect(!!(0 && (ret & (1u << (31)))), 0)) {
        ret |= 0x0;
    }
    return ret;
}

struct virq {
    uint32_t words[1];
};
typedef struct virq virq_t;

enum virq_tag {
    virq_virq_invalid = 0,
    virq_virq_pending = 1,
    virq_virq_active = 2
};
typedef enum virq_tag virq_tag_t;

static inline uint32_t CONST
virq_get_virqType(virq_t virq) {
    return (virq.words[0] >> 28) & 0x3u;
}

static inline virq_t CONST
virq_virq_invalid_set_virqEOIIRQEN(virq_t virq, uint32_t v32) {
    assert(((virq.words[0] >> 28) & 0x3) ==
           virq_virq_invalid);
    /* fail if user has passed bits that we will override */
    assert((((~0x80000u >> 19 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    virq.words[0] &= ~0x80000u;
    virq.words[0] |= (v32 << 19) & 0x80000u;
    return virq;
}

static inline virq_t CONST
virq_virq_pending_new(uint32_t virqGroup, uint32_t virqPriority, uint32_t virqEOIIRQEN, uint32_t virqIRQ) {
    virq_t virq;

    /* fail if user has passed bits that we will override */  
    assert((virqGroup & ~0x1u) == ((0 && (virqGroup & (1u << 31))) ? 0x0 : 0));  
    assert(((uint32_t)virq_virq_pending & ~0x3u) == ((0 && ((uint32_t)virq_virq_pending & (1u << 31))) ? 0x0 : 0));  
    assert((virqPriority & ~0x1fu) == ((0 && (virqPriority & (1u << 31))) ? 0x0 : 0));  
    assert((virqEOIIRQEN & ~0x1u) == ((0 && (virqEOIIRQEN & (1u << 31))) ? 0x0 : 0));  
    assert((virqIRQ & ~0x3ffu) == ((0 && (virqIRQ & (1u << 31))) ? 0x0 : 0));

    virq.words[0] = 0
        | (virqGroup & 0x1u) << 30
        | ((uint32_t)virq_virq_pending & 0x3u) << 28
        | (virqPriority & 0x1fu) << 23
        | (virqEOIIRQEN & 0x1u) << 19
        | (virqIRQ & 0x3ffu) << 0;

    return virq;
}

static inline virq_t CONST
virq_virq_pending_set_virqEOIIRQEN(virq_t virq, uint32_t v32) {
    assert(((virq.words[0] >> 28) & 0x3) ==
           virq_virq_pending);
    /* fail if user has passed bits that we will override */
    assert((((~0x80000u >> 19 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    virq.words[0] &= ~0x80000u;
    virq.words[0] |= (v32 << 19) & 0x80000u;
    return virq;
}

static inline virq_t CONST
virq_virq_active_set_virqEOIIRQEN(virq_t virq, uint32_t v32) {
    assert(((virq.words[0] >> 28) & 0x3) ==
           virq_virq_active);
    /* fail if user has passed bits that we will override */
    assert((((~0x80000u >> 19 ) | 0x0) & v32) == ((0 && (v32 & (1u << (31)))) ? 0x0 : 0));

    virq.words[0] &= ~0x80000u;
    virq.words[0] |= (v32 << 19) & 0x80000u;
    return virq;
}

