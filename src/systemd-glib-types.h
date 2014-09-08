#ifndef __SYSTEMD_GLIB_TYPES_H__
#define __SYSTEMD_GLIB_TYPES_H__

#include <glib.h>
#include <glib-object.h>

G_BEGIN_DECLS

typedef struct _SystemdUnitInfo SystemdUnitInfo;

struct _SystemdUnitInfo
{
    char *name;
    char *description;
    char *load_state;
    char *active_state;
    char *sub_state;
    char *following;
    char *unit_path;
    guint32 job_id;
    char *job_type;
    char *job_path;
};

GType systemd_unit_info_get_type(void);

SystemdUnitInfo* systemd_unit_info_dup(SystemdUnitInfo *info);

void systemd_unit_info_free(SystemdUnitInfo *info);

GPtrArray *systemd_unit_info_list_from_variant(GVariant* variant);



G_END_DECLS

#endif
