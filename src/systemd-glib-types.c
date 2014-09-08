
#include "systemd-glib-types.h"

G_DEFINE_BOXED_TYPE(SystemdUnitInfo, systemd_unit_info,
                    systemd_unit_info_dup, systemd_unit_info_free);

SystemdUnitInfo*
systemd_unit_info_dup(SystemdUnitInfo *info)
{
    SystemdUnitInfo *dup = g_slice_new(SystemdUnitInfo);

    dup->name = g_strdup(info->name);
    dup->description = g_strdup(info->description);
    dup->load_state = g_strdup(info->load_state);
    dup->active_state = g_strdup(info->active_state);
    dup->sub_state = g_strdup(info->sub_state);
    dup->following = g_strdup(info->following);
    dup->unit_path = g_strdup(info->unit_path);
    dup->job_id = info->job_id;
    dup->job_type = info->job_type;
    dup->job_path = info->job_path;

    return dup;
}

void
systemd_unit_info_free(SystemdUnitInfo *info)
{
    g_free(info->name);
    g_free(info->description);
    g_free(info->load_state);
    g_free(info->active_state);
    g_free(info->sub_state);
    g_free(info->following);
    g_free(info->unit_path);
    g_free(info->job_type);
    g_free(info->job_path);

    g_slice_free(SystemdUnitInfo, info);
}

/**
 * systemd_unit_info_list_from_variant:
 * @variant: A #GVariant returned by systemd_call_list_units_sync() and friends
 *
 * Returns: (transfer container) (element-type Systemd.UnitInfo): A #GPtrArray
 */
GPtrArray *
systemd_unit_info_list_from_variant(GVariant* variant)
{
    int i = 0;
    GPtrArray *array = g_ptr_array_new_with_free_func(
                           (GDestroyNotify) systemd_unit_info_free);

    for (i = 0; i < g_variant_n_children(variant); i++)
    {
        SystemdUnitInfo info = { NULL, };
        g_variant_get_child(variant, i, "(ssssssouso)",
                            &info.name,
                            &info.description,
                            &info.active_state,
                            &info.sub_state,
                            &info.following,
                            &info.unit_path,
                            &info.job_id,
                            &info.job_type,
                            &info.job_path);
        g_ptr_array_add(array, systemd_unit_info_dup(&info));
    }

    return array;
}
