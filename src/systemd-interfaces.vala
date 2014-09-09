
namespace Systemd
{

public struct UnitInfo
{
    public string name;
    public string description;
    public string load_state;
    public string active_state;
    public string sub_state;
    public string following;
    public ObjectPath unit_path;
    public uint32 job_id;
    public string job_type;
    public ObjectPath job_path;
}

public struct JobInfo
{
    uint32 id;
    string name;
    string type;
    string state;
    ObjectPath job_path;
    ObjectPath unit_path;
}

public struct UnitFile
{
    string name;
    string status;
}

[DBus (use_string_marshalling = true)]
public enum UnitChangeMode
{
    [DBus (value = "symlink")]
    SYMLINK,
    [DBus (value = "unlink")]
    UNLINK
}

public struct UnitChangeSet
{
    UnitChangeMode mode;
    string filename;
    string destination;
}

[DBus (use_string_marshalling = true)]
public enum UnitStartMode
{
    [DBus (value = "replace")]
    REPLACE,
    [DBus (value = "fail")]
    FAIL,
    [DBus (value = "isolate")]
    ISOLATE,
    [DBus (value = "ignore-dependencies")]
    IGNORE_DEPENDENCIES,
    [DBus (Value = "ignore-requirements")]
    IGNORE_REQUIREMENTS
}

public struct UnitProperty
{
    string name;
    Variant value;
}

public struct UnitJob
{
    uint32 id;
    ObjectPath path;
}

[DBus (type_signature = "i")]
public enum UnitConditionStatus
{
    FAILED = -1,
    UNCHECKED = 0,
    PASSED = 1
}

public struct UnitCondition
{
    string type;
    bool is_trigger;
    bool is_reversed;
    string rhs;
    UnitConditionStatus status;
}

public struct UnitLoadError
{
    string id;
    string message;
}

public struct UnitExecInfo
{
    string path;
    string[] args;
    bool fail_if_unclean_exit;
    uint64 start_timestamp;
    uint64 finish_timestamp;
    uint32 pid;
    int32 exit_code;
    int32 status;
}

public struct UnitEnvFile
{
    string path;
    bool active; // Maybe? Don't know
}

public struct UnitBlockIOInfo
{
    // FIXME: This seems to be undocumented? I can't find what the fields are
    // supposed to be, anyway
    string arg0;
    int64 arg1;
}

// FIXME: Same again, this property type doesn't seem to be documented and I
// have no idea what the fields mean, or even what this struct should be
// called...
public struct UnitDeviceAllowInfo
{
    string arg0;
    string arg1;
}


[DBus (name="org.freedesktop.systemd1.Manager")]
public interface Manager : DBusProxy
{
    /* Methods */
    public abstract async ObjectPath get_unit(string name,
                                              Cancellable? cancellable = null) throws IOError;
    [DBus (name="GetUnit")]
    public abstract ObjectPath get_unit_sync(string name,
                                             Cancellable? cancellable = null) throws IOError;

    [DBus (name="GetUnitByPID")]
    public abstract async ObjectPath get_unit_by_pid(uint32 pid,
                                                     Cancellable? cancellable = null) throws IOError;
    [DBus (name="GetUnitByPID")]
    public abstract ObjectPath get_unit_by_pid_sync(uint32 pid,
                                                    Cancellable? cancellable = null) throws IOError;

    public abstract async ObjectPath load_unit(string name,
                                               Cancellable? cancellable = null) throws IOError;
    [DBus (name="LostUnit")]
    public abstract ObjectPath load_unit_sync(string name,
                                              Cancellable? cancellable = null) throws IOError;

    public abstract async ObjectPath start_unit(string name,
                                                UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                                Cancellable? cancellable = null) throws IOError;
    [DBus (name="StartUnit")]
    public abstract ObjectPath start_unit_sync(string name,
                                               UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                               Cancellable? cancellable = null) throws IOError;

    public abstract async ObjectPath stop_unit(string name,
                                               UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                               Cancellable? cancellable = null) throws IOError;
    [DBus (name = "StopUnit")]
    public abstract ObjectPath stop_unit_sync(string name,
                                              UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                              Cancellable? cancellable = null) throws IOError;

    public abstract async ObjectPath reload_unit(string name,
                                                 UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                                 Cancellable? cancellable = null) throws IOError;
    [DBus (name = "ReloadUnit")]
    public abstract ObjectPath reload_unit_sync(string name,
                                                UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                                Cancellable? cancellable = null) throws IOError;

    public abstract async ObjectPath try_restart_unit(string name,
                                                      UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                                      Cancellable? cancellable = null) throws IOError;
    [DBus (name = "TryRestartUnit")]
    public abstract ObjectPath try_restart_unit_sync(string name,
                                                     UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                                     Cancellable? cancellable = null) throws IOError;

    public abstract async ObjectPath reload_or_restart_unit(string name,
                                                            UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                                            Cancellable? cancellable = null) throws IOError;
    [DBus (name = "ReloadOrRestartUnit")]
    public abstract ObjectPath reload_or_restart_unit_sync(string name,
                                                           UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                                           Cancellable? cancellable = null) throws IOError;

    public abstract async ObjectPath reload_or_try_restart_unit(string name,
                                                                UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                                                Cancellable? cancellable = null) throws IOError;
    [DBus (name = "ReloadOrTryRestartUnit")]
    public abstract ObjectPath reload_or_try_restart_unit_sync(string name,
                                                               UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                                               Cancellable? cancellable = null ) throws IOError;

    public abstract async void kill_unit(string name,
                                         string who,
                                         int32 signal,
                                         Cancellable? cancellable = null) throws IOError;
    [DBus (name = "KillUnit")]
    public abstract void kill_unit_sync(string name,
                                        string who,
                                        int32 signal,
                                        Cancellable? cancellable = null) throws IOError;

    public abstract async void reset_failed_unit(string name, Cancellable? cancellable = null) throws IOError;
    [DBus (name = "ResetFailedUnit")]
    public abstract void reset_failed_unit_sync(string name, Cancellable? cancellable = null) throws IOError;

    public abstract async ObjectPath get_job(uint32 id, Cancellable? cancellable = null) throws IOError;
    [DBus (name = "GetJob")]
    public abstract ObjectPath get_job_sync(uint32 id, Cancellable? cancellable = null) throws IOError;

    public abstract async void cancel_job(uint32 id, Cancellable? cancellable = null) throws IOError;
    [DBus (name = "CancelJob")]
    public abstract void cancel_job_sync(int32 id, Cancellable? cancellable = null) throws IOError;

    public abstract async void clear_jobs(Cancellable? cancellable = null) throws IOError;
    [DBus (name = "ClearJobs")]
    public abstract void clear_jobs_sync(Cancellable? cancellable = null) throws IOError;

    public abstract async void reset_failed(Cancellable? cancellable = null) throws IOError;
    [DBus (name = "ResetFailed")]
    public abstract void reset_failed_sync(Cancellable? cancellable = null) throws IOError;

    public abstract async UnitInfo[] list_units(Cancellable? cancellable = null) throws IOError;
    [DBus (name = "ListUnits")]
    public abstract UnitInfo[] list_units_sync(Cancellable? cancellable = null) throws IOError;

    public abstract async JobInfo[] list_jobs(Cancellable? cancellable = null) throws IOError;
    [DBus (name = "ListJobs")]
    public abstract JobInfo[] list_jobs_sync(Cancellable? cancellable = null) throws IOError;

    public abstract async void subscribe(Cancellable? cancellable = null) throws IOError;
    [DBus (name = "Subscribe")]
    public abstract void subscribe_sync(Cancellable? cancellable = null) throws IOError;

    public abstract async void unsubscribe(Cancellable? cancellable = null) throws IOError;
    [DBus (name = "Unsubscribe")]
    public abstract void unsubscribe_sync(Cancellable? cancellable = null) throws IOError;

    public abstract async ObjectPath create_snapshot(string name,
                                                     bool cleanup,
                                                     Cancellable? cancellable = null) throws IOError;
    [DBus (name = "CreateSnapshot")]
    public abstract ObjectPath create_snapshot_sync(string name,
                                                    bool cleanup,
                                                    Cancellable? cancellable = null) throws IOError;

    public abstract async void remove_snapshot(string name,
                                               Cancellable? cancellable = null) throws IOError;
    [DBus (name = "RemoveSnapshot")]
    public abstract void remove_snapshot_sync(string name,
                                              Cancellable? cancellable = null) throws IOError;

    public abstract async void reload(Cancellable? cancellable = null) throws IOError;
    [DBus (name = "Reload")]
    public abstract void reload_sync(Cancellable? cancellable = null) throws IOError;

    public abstract async void reexecute(Cancellable? cancellable = null) throws IOError;
    [DBus (name = "Reexecute")]
    public abstract void reexecute_sync(Cancellable? cancellable = null) throws IOError;

    public abstract async void exit(Cancellable? cancellable = null) throws IOError;
    [DBus (name = "Exit")]
    public abstract void exit_sync(Cancellable? cancellable = null) throws IOError;

    public abstract async void reboot(Cancellable? cancellable = null) throws IOError;
    [DBus (name = "Reboot")]
    public abstract void reboot_sync(Cancellable? cancellable = null) throws IOError;

    public abstract async void power_off(Cancellable? cancellable = null) throws IOError;
    [DBus (name = "PowerOff")]
    public abstract void power_off_sync(Cancellable? cancellable = null) throws IOError;

    public abstract async void halt(Cancellable? cancellable = null) throws IOError;
    [DBus (name = "Halt")]
    public abstract void halt_sync(Cancellable? cancellable = null) throws IOError;

    [DBus (name = "KExec")]
    public abstract async void kexec(Cancellable? cancellable = null) throws IOError;
    [DBus (name = "KExec")]
    public abstract void kexec_sync(Cancellable? cancellable = null) throws IOError;

    public abstract async void switch_root(string new_root,
                                           string init,
                                           Cancellable? cancellable = null) throws IOError;
    [DBus (name = "SwitchRoot")]
    public abstract void switch_root_sync(string new_root,
                                          string inti,
                                          Cancellable? cancellable = null) throws IOError;

    public abstract async void set_environment(string[] names,
                                               Cancellable? cancellable = null) throws IOError;
    [DBus (name = "SetEnvironment")]
    public abstract void set_environment_sync(string[] names,
                                              Cancellable? cancellable = null) throws IOError;

    public abstract async void unset_environment(string[] names,
                                               Cancellable? cancellable = null) throws IOError;
    [DBus (name = "UnsetEnvironment")]
    public abstract void unset_environment_sync(string[] names,
                                              Cancellable? cancellable = null) throws IOError;

    public abstract async void unset_and_set_environment(string[] unset,
                                                         string[] set,
                                                         Cancellable? cancellable = null) throws IOError;
    [DBus (name = "UnsetAndSetEnvironment")]
    public abstract void unset_andset_environment_sync(string[] unset,
                                                       string[] set,
                                                       Cancellable? cancellable = null) throws IOError;

    public abstract async UnitFile[] list_unit_files(Cancellable? cancellable = null) throws IOError;
    [DBus (name = "ListUnitFiles")]
    public abstract UnitFile[] list_unit_files_sync(Cancellable? cancellable = null) throws IOError;

    public abstract async string get_unit_file_state(string file,
                                                     Cancellable? cancellable = null) throws IOError;
    [DBus (name = "GetUnitFileState")]
    public abstract string get_unit_file_state_sync(string file,
                                                    Cancellable? cancellable = null) throws IOError;

    public abstract async void enable_unit_files(string[] files,
                                                 bool runtime,
                                                 bool force,
                                                 out bool carries_install_info,
                                                 out UnitChangeSet[] changes,
                                                 Cancellable? cancellable = null) throws IOError;
    [DBus (name = "EnableUnitFiles")]
    public abstract void enable_unit_files_sync(string[] files,
                                                bool runtime,
                                                bool force,
                                                out bool carries_install_info,
                                                out UnitChangeSet[] changes,
                                                Cancellable? cancellable = null) throws IOError;

    public abstract async UnitChangeSet[] disable_unit_files(string[] files,
                                                             bool runtime,
                                                             Cancellable? cancellable = null) throws IOError;
    [DBus (name = "DisableUnitFiles")]
    public abstract UnitChangeSet[] disable_unit_files_sync(string[] files,
                                                            bool runtime,
                                                            bool force,
                                                            Cancellable? cancellable = null) throws IOError;

    public abstract async void reenable_unit_files(string[] files,
                                                   bool runtime,
                                                   bool force,
                                                   out bool carries_install_info,
                                                   out UnitChangeSet[] changes,
                                                   Cancellable? cancellable = null) throws IOError;
    [DBus (name = "ReenableUnitFiles")]
    public abstract void reenable_unit_files_sync(string[] files,
                                                  bool runtime,
                                                  bool force,
                                                  out bool carries_install_info,
                                                  out UnitChangeSet[] changes,
                                                  Cancellable? cancellable = null) throws IOError;

    public abstract async UnitChangeSet[] link_unit_files(string[] files,
                                                          bool runtime,
                                                          bool force,
                                                          Cancellable? cancellable = null) throws IOError;
    [DBus (name = "LinkUnitFiles")]
    public abstract UnitChangeSet[] link_unit_files_sync(string[] files,
                                                         bool runtime,
                                                         bool force,
                                                         Cancellable? cancellable = null) throws IOError;

    public abstract async void preset_unit_files(string[] files,
                                                 bool runtime,
                                                 bool force,
                                                 out bool carries_install_info,
                                                 out UnitChangeSet[] changes,
                                                 Cancellable? cancellable = null) throws IOError;
    [DBus (name = "PresetUnitFiles")]
    public abstract void preset_unit_files_sync(string[] files,
                                                bool runtime,
                                                bool force,
                                                out bool carries_install_info,
                                                out UnitChangeSet[] changes,
                                                Cancellable? cancellable = null) throws IOError;

    public abstract async UnitChangeSet[] mask_unit_files(string[] files,
                                                          bool runtime,
                                                          bool force,
                                                          Cancellable? cancellable = null) throws IOError;
    [DBus (name = "MaskUnitFiles")]
    public abstract UnitChangeSet[] mask_unit_files_sync(string[] files,
                                                         bool runtime,
                                                         bool force,
                                                         Cancellable? cancellable = null) throws IOError;

    public abstract async UnitChangeSet[] unmask_unit_files(string[] files,
                                                            bool runtime,
                                                            Cancellable? cancellable = null) throws IOError;
    [DBus (name = "UnmaskUnitFiles")]
    public abstract UnitChangeSet[] unmask_unit_files_sync(string[] files,
                                                           bool runtime,
                                                           Cancellable? cancellable = null) throws IOError;

    public abstract async UnitChangeSet[] set_default_target(string[] files,
                                                             Cancellable? cancellable = null) throws IOError;
    [DBus (name = "SetDefaultTarget")]
    public abstract UnitChangeSet[] set_default_target_sync(string[] files,
                                                            Cancellable? cancellable = null) throws IOError;

    public abstract async string get_default_target(Cancellable? cancellable = null) throws IOError;
    [DBus (name = "GetDefaultTarget")]
    public abstract string get_default_target_sync(Cancellable? cancellable = null) throws IOError;

    public abstract async void set_unit_properties(string name,
                                                   bool runtime,
                                                   UnitProperty[] properties,
                                                   Cancellable? cancellable = null) throws IOError;
    [DBus (name = "SetUnitProperties")]
    public abstract void set_unit_properties_sync(string name,
                                                  bool runtime,
                                                  UnitProperty[] properties,
                                                  Cancellable? cancellable = null) throws IOError;

    // Hmmm, so in the async call {} gets converted to the right variant type, but in the sync
    // call it doesn't and gives us a compile error. One or the other must be a bug, but I'm
    // not sure which it is...
    public abstract async ObjectPath start_transient_unit(string name,
                                                          string mode,
                                                          UnitProperty[] properties,
                                                          [DBus (signature = "a(sa(sv))")]
                                                          Variant aux = {},
                                                          Cancellable? cancellable = null) throws IOError;
    [DBus (name = "StartTransientUnit")]
    public abstract ObjectPath start_transient_unit_sync(string name,
                                                         string mode,
                                                         UnitProperty[] properties,
                                                         [DBus (signature = "a(sa(sv))")]
                                                         Variant aux = new Variant("a(sa(sv))"),
                                                         Cancellable? cancellable = null) throws IOError;

    /* Signals */
    
    public signal void unit_new(string id, ObjectPath unit);

    public signal void unit_removed(string id, ObjectPath unit);

    public signal void job_new(uint32 id, ObjectPath job, string unit);

    public signal void job_removed(uint32 id, ObjectPath job, string unit, string result);

    public signal void startup_finished(uint64 firmware,
                                        uint64 loader,
                                        uint64 kernel,
                                        uint64 initrd,
                                        uint64 userspace,
                                        uint64 total);

    public signal void unit_files_changed();

    public signal void reloading(bool active);

    /* Properties */

    public abstract string version { owned get; }

    public abstract string features { owned get; }

    public abstract string tainted { owned get; }

    public abstract uint64 firmware_timestamp { get; }

    public abstract uint64 firmware_timestamp_monotonic { get; }

    public abstract uint64 loader_timestamp { get; }

    public abstract uint64 loader_timestamp_monotonic { get; }

    public abstract uint64 kernel_timestamp { get; }

    public abstract uint64 kernel_timestamp_monotonic { get; }

    [DBus (name = "InitRDTimestamp")]
    public abstract uint64 initrd_timestamp { get; }

    [DBus (name = "InitRDTimestampMonotonic")]
    public abstract uint64 initrd_timestamp_monotonic { get; }

    public abstract uint64 userspace_timestamp { get; }

    public abstract uint64 userspace_timestamp_monotonic { get; }

    public abstract uint64 finish_timestamp { get; }

    public abstract uint64 finish_timestamp_monotonic { get; }

    public abstract uint64 generators_start_timestamp { get; }

    public abstract uint64 generators_start_timestamp_monotonic { get; }

    public abstract uint64 generators_finish_timestamp { get; }

    public abstract uint64 generators_finish_timestamp_monotonic { get; }

    public abstract uint64 units_load_start_timestamp { get; }

    public abstract uint64 units_load_start_timestamp_monotonic { get; }

    public abstract uint64 units_load_finish_timestamp { get; }

    public abstract uint64 units_load_finish_timestamp_monotonic { get; }

    public abstract uint64 security_start_timestamp { get; }

    public abstract uint64 security_start_timestamp_monotonic { get; }

    public abstract uint64 security_finish_timestamp { get; }

    public abstract uint64 security_finish_timestamp_monotonic { get; }

    public abstract string log_level { owned get; set; }

    public abstract string log_target { owned get; set; }

    public abstract uint32 n_names { get; }

    public abstract uint32 n_jobs { get; }

    public abstract uint32 n_installed_jobs { get; }

    public abstract uint32 n_failed_jobs { get; }

    public abstract double progress { get; }

    public abstract string[] environment { owned get; }

    public abstract bool confirm_spawn { get; }

    public abstract bool show_status { get; }

    public abstract string[] unit_path { owned get; }

    public abstract string default_standard_output { owned get; }

    public abstract string default_standard_error { owned get; }

    [DBus (name = "RuntimeWatchdogUSec")]
    public abstract uint64 runtime_watchdog_usec { get; set; }

    [DBus (name = "ShutdownWatchdogUSec")]
    public abstract uint64 shutdown_watchdog_usec { get; set; }

    public abstract string virtualization { owned get; }

    public abstract string architecture { owned get; }

    /* Helper methods (non-virtual) to construct proxies of different types */
    /* These inherit the connection/path etc from the Manager proxy */
    
    [DBus (visible = false)]
    public async Unit get_unit_proxy(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return yield g_connection.get_proxy("org.freedesktop.systemd1.Unit",
                                            path,
                                            g_flags,
                                            cancellable);
    }

    [DBus (visible = false)]
    public Unit get_unit_proxy_sync(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return g_connection.get_proxy_sync("org.freedesktop.systemd1.Unit",
                                           path,
                                           g_flags,
                                           cancellable);
    }

    [DBus (visible = false)]
    public async Service get_service_proxy(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return yield g_connection.get_proxy("org.freedesktop.systemd1.Service",
                                            path,
                                            g_flags,
                                            cancellable);
    }

    [DBus (visible = false)]
    public Service get_service_proxy_sync(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return g_connection.get_proxy_sync("org.freedesktop.systemd1.Service",
                                           path,
                                           g_flags,
                                           cancellable);
    }

    [DBus (visible = false)]
    public async Socket get_socket_proxy(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return yield g_connection.get_proxy("org.freedesktop.systemd1.Socket",
                                            path,
                                            g_flags,
                                            cancellable);
    }

    [DBus (visible = false)]
    public Socket get_socket_proxy_sync(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return g_connection.get_proxy_sync("org.freedesktop.systemd1.Socket",
                                           path,
                                           g_flags,
                                           cancellable);
    }

    [DBus (visible = false)]
    public async Target get_target_proxy(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return yield g_connection.get_proxy("org.freedesktop.systemd1.Target",
                                            path,
                                            g_flags,
                                            cancellable);
    }

    [DBus (visible = false)]
    public Target get_target_proxy_sync(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return g_connection.get_proxy_sync("org.freedesktop.systemd1.Target",
                                           path,
                                           g_flags,
                                           cancellable);
    }

    [DBus (visible = false)]
    public async Device get_device_proxy(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return yield g_connection.get_proxy("org.freedesktop.systemd1.Device",
                                            path,
                                            g_flags,
                                            cancellable);
    }

    [DBus (visible = false)]
    public Device get_device_proxy_sync(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return g_connection.get_proxy_sync("org.freedesktop.systemd1.Device",
                                           path,
                                           g_flags,
                                           cancellable);
    }

    [DBus (visible = false)]
    public async Mount get_mount_proxy(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return yield g_connection.get_proxy("org.freedesktop.systemd1.Mount",
                                            path,
                                            g_flags,
                                            cancellable);
    }

    [DBus (visible = false)]
    public Mount get_mount_proxy_sync(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return g_connection.get_proxy_sync("org.freedesktop.systemd1.Mount",
                                           path,
                                           g_flags,
                                           cancellable);
    }
    
    [DBus (visible = false)]
    public async Automount get_automount_proxy(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return yield g_connection.get_proxy("org.freedesktop.systemd1.Automount",
                                            path,
                                            g_flags,
                                            cancellable);
    }

    [DBus (visible = false)]
    public Automount get_automount_proxy_sync(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return g_connection.get_proxy_sync("org.freedesktop.systemd1.Automount",
                                           path,
                                           g_flags,
                                           cancellable);
    }

    [DBus (visible = false)]
    public async Snapshot get_snapshot_proxy(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return yield g_connection.get_proxy("org.freedesktop.systemd1.Snapshot",
                                            path,
                                            g_flags,
                                            cancellable);
    }

    [DBus (visible = false)]
    public Snapshot get_snapshot_proxy_sync(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return g_connection.get_proxy_sync("org.freedesktop.systemd1.Snapshot",
                                           path,
                                           g_flags,
                                           cancellable);
    }

    [DBus (visible = false)]
    public async Timer get_timer_proxy(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return yield g_connection.get_proxy("org.freedesktop.systemd1.Timer",
                                            path,
                                            g_flags,
                                            cancellable);
    }

    [DBus (visible = false)]
    public Timer get_timer_proxy_sync(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return g_connection.get_proxy_sync("org.freedesktop.systemd1.Timer",
                                           path,
                                           g_flags,
                                           cancellable);
    }

    [DBus (visible = false)]
    public async Swap get_swap_proxy(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return yield g_connection.get_proxy("org.freedesktop.systemd1.Swap",
                                            path,
                                            g_flags,
                                            cancellable);
    }

    [DBus (visible = false)]
    public Swap get_swap_proxy_sync(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return g_connection.get_proxy_sync("org.freedesktop.systemd1.Swap",
                                           path,
                                           g_flags,
                                           cancellable);
    }

    [DBus (visible = false)]
    public async Path get_path_proxy(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return yield g_connection.get_proxy("org.freedesktop.systemd1.Path",
                                            path,
                                            g_flags,
                                            cancellable);
    }

    [DBus (visible = false)]
    public Path get_path_proxy_sync(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return g_connection.get_proxy_sync("org.freedesktop.systemd1.Path",
                                           path,
                                           g_flags,
                                           cancellable);
    }

    [DBus (visible = false)]
    public async Slice get_slice_proxy(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return yield g_connection.get_proxy("org.freedesktop.systemd1.Slice",
                                            path,
                                            g_flags,
                                            cancellable);
    }

    [DBus (visible = false)]
    public Slice get_slice_proxy_sync(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return g_connection.get_proxy_sync("org.freedesktop.systemd1.Slice",
                                           path,
                                           g_flags,
                                           cancellable);
    }

    [DBus (visible = false)]
    public async Scope get_scope_proxy(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return yield g_connection.get_proxy("org.freedesktop.systemd1.Scope",
                                            path,
                                            g_flags,
                                            cancellable);
    }

    [DBus (visible = false)]
    public Scope get_scope_proxy_sync(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return g_connection.get_proxy_sync("org.freedesktop.systemd1.Scope",
                                           path,
                                           g_flags,
                                           cancellable);
    }

    [DBus (visible = false)]
    public async Job get_job_proxy(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return yield g_connection.get_proxy("org.freedesktop.systemd1.Job",
                                            path,
                                            g_flags,
                                            cancellable);
    }

    [DBus (visible = false)]
    public Job get_job_proxy_sync(ObjectPath path, Cancellable? cancellable = null) throws IOError
    {
        return g_connection.get_proxy_sync("org.freedesktop.systemd1.Job",
                                           path,
                                           g_flags,
                                           cancellable);
    }
}

[DBus (name = "org.freedesktop.systemd1.Unit")]
public interface Unit : DBusProxy
{
    /* Methods */
    public abstract async ObjectPath start(UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                           Cancellable? cancellable = null) throws IOError;
    [DBus (name = "Start")]
    public abstract ObjectPath start_sync(UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                          Cancellable? cancellable = null) throws IOError;

    public abstract async ObjectPath stop(UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                          Cancellable? cancellable = null) throws IOError;
    [DBus (name = "Stop")]
    public abstract ObjectPath stop_sync(UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                         Cancellable? cancellable = null) throws IOError;

    public abstract async ObjectPath restart(UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                             Cancellable? cancellable = null) throws IOError;
    [DBus (name = "Restart")]
    public abstract ObjectPath restart_sync(UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                            Cancellable? cancellable = null) throws IOError;

    public abstract async ObjectPath try_restart(UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                                 Cancellable? cancellable = null) throws IOError;
    [DBus (name = "TryRestart")]
    public abstract ObjectPath try_restart_sync(UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                                Cancellable? cancellable = null) throws IOError;

    public abstract async ObjectPath reload_or_restart(UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                                      Cancellable? cancellable = null) throws IOError;
    [DBus (name = "ReloadOrRestart")]
    public abstract ObjectPath reload_or_restart_sync(UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                                      Cancellable? cancellable = null) throws IOError;

    public abstract async ObjectPath reload_or_try_restart(UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                                           Cancellable? cancellable = null) throws IOError;
    [DBus (name = "ReloadOrTryRestart")]
    public abstract ObjectPath reload_or_try_restart_sync(UnitStartMode mode = Systemd.UnitStartMode.REPLACE,
                                                          Cancellable? cancellable = null) throws IOError;

    /* Properties */
    public abstract string id { owned get; }
    public abstract string[] names { owned get; }
    public abstract string following { owned get; }
    public abstract string[] requires { owned get; }
    public abstract string[] requires_overridable { owned get; }
    public abstract string[] requisite { owned get; }
    public abstract string[] requisite_overridable { owned get; }
    public abstract string[] wants { owned get; }
    public abstract string[] binds_to { owned get; }
    public abstract string[] part_of { owned get; }
    public abstract string[] required_by { owned get; }
    public abstract string[] required_by_overridable { owned get; }
    public abstract string[] wanted_by { owned get; }
    public abstract string[] bound_by { owned get; }
    public abstract string[] consists_of { owned get; }
    public abstract string[] conflicts { owned get; }
    public abstract string[] conflicted_by { owned get; }
    public abstract string[] before { owned get; }
    public abstract string[] after { owned get; }
    public abstract string[] on_failure { owned get; }
    public abstract string[] triggers { owned get; }
    public abstract string[] triggered_by { owned get; }
    public abstract string[] propagates_reload_to { owned get; }
    public abstract string[] reload_propagated_from { owned get; }
    public abstract string[] requires_mounts_for { owned get; }
    public abstract string description { owned get; }
    public abstract string source_path { owned get; }
    public abstract string[] drop_in_paths { owned get; }
    public abstract string[] documentation { owned get; }
    public abstract string load_state { owned get; }
    public abstract string active_state { owned get; }
    public abstract string sub_state { owned get; }
    public abstract string fragment_path { owned get; }
    public abstract uint64 inactive_exit_timestamp { get; }
    public abstract uint64 inactive_exit_timestamp_monotonic { get; }
    public abstract uint64 active_enter_timestamp { get; }
    public abstract uint64 active_enter_timestamp_monotonic { get; }
    public abstract uint64 active_exit_timestamp { get; }
    public abstract uint64 active_exit_timestamp_monotonic { get; }
    public abstract uint64 inactive_enter_timestamp { get; }
    public abstract uint64 inactive_enter_timestamp_monotonic { get; }
    public abstract bool can_start { get; }
    public abstract bool can_stop { get; }
    public abstract bool can_reload { get; }
    public abstract bool can_isolate { get; }
    public abstract UnitJob job { owned get; }
    public abstract bool stop_when_unneeded { get; }
    public abstract bool refuse_manual_start { get; }
    public abstract bool refuse_manual_stop { get; }
    public abstract bool allow_isolate { get; }
    public abstract bool default_dependencies { get; }
    public abstract bool on_failure_isolate { get; }
    public abstract bool ignore_on_isolate { get; }
    public abstract bool ignore_on_snapshot { get; }
    public abstract bool need_daemon_reload { get; }
    [DBus (name = "JobTimeoutUSec")]
    public abstract uint64 job_timeout_usec { get; }
    public abstract uint64 condition_timestamp { get; }
    public abstract uint64 condition_timestamp_monotonic { get; }
    public abstract bool condition_result { get; }
    public abstract UnitCondition[] conditions { owned get; }
    public abstract UnitLoadError[] load_error { owned get; }
    public abstract bool transient { get; }
}

[DBus (name = "org.freedesktop.systemd1.Service")]
public interface Service : DBusProxy, Unit
{
    /* Properties */
    [DBus (name = "Type")]
    public abstract string service_type { owned get; } // avoid get_type() problems
    public abstract string restart { owned get; }
    [DBus (name = "PIDFile")]
    public abstract string pid_file { owned get; }
    public abstract string notify_access { owned get; }
    [DBus (name = "RestartUSec")]
    public abstract uint64 restart_usec { get; }
    [DBus (name = "TimeoutUSec")]
    public abstract uint64 timeout_usec { get; }
    [DBus (name = "WatchdogUSec")]
    public abstract uint64 watchdog_usec { get; }
    public abstract uint64 watchdog_timestamp { get; }
    public abstract uint64 watchdog_timestamp_monotonic { get; }
    public abstract uint64 start_limit_interval { get; }
    public abstract uint32 start_limit_burst { get; }
    public abstract string start_limit_action { owned get; set; }
    public abstract string slice { owned get; }
    public abstract string control_group { owned get; }
    public abstract UnitExecInfo[] exec_start_pre { owned get; }
    public abstract UnitExecInfo[] exec_start { owned get; }
    public abstract UnitExecInfo[] exec_start_post { owned get; }
    public abstract UnitExecInfo[] exec_reload { owned get; }
    public abstract UnitExecInfo[] exec_stop { owned get; }
    public abstract UnitExecInfo[] exec_stop_post { owned get; }
    public abstract string[] environment { owned get; }
    public abstract UnitEnvFile[] environment_files { owned get; }
    [DBus (name = "UMask")]
    public abstract uint32 umask { get; }
    [DBus (name = "LimitCPU")]
    public abstract uint64 limit_cpu { get; }
    [DBus (name = "LimitFSIZE")]
    public abstract uint64 limit_fsize { get; }
    [DBus (name = "LimitDATA")]
    public abstract uint64 limit_data { get; }
    [DBus (name = "LimitSTACK")]
    public abstract uint64 limit_stack { get; }
    [DBus (name = "LimitCORE")]
    public abstract uint64 limit_core { get; }
    [DBus (name = "LimitRSS")]
    public abstract uint64 limit_rss { get; }
    [DBus (name = "LimitNOFILE")]
    public abstract uint64 limit_nofile { get; }
    [DBus (name = "LimitAS")]
    public abstract uint64 limit_as { get; }
    [DBus (name = "LimitNPROC")]
    public abstract uint64 limit_nproc { get; }
    [DBus (name = "LimitMEMLOCK")]
    public abstract uint64 limit_memlock { get; }
    [DBus (name = "LimitLOCKS")]
    public abstract uint64 limit_locks { get; }
    [DBus (name = "LimitSIGPENDING")]
    public abstract uint64 limit_sigpending { get; }
    [DBus (name = "LimitMSGQUEUE")]
    public abstract uint64 limit_msgqueue { get; }
    [DBus (name = "LimitNICE")]
    public abstract uint64 limit_nice { get; }
    [DBus (name = "LimitRTPRIO")]
    public abstract uint64 limit_rtprio { get; }
    [DBus (name = "LimitRTTIME")]
    public abstract uint64 limit_rttime { get; }
    public abstract string working_directory { owned get; }
    public abstract string root_directory { owned get; }
    [DBus (name = "OOMScoreAdjust")]
    public abstract int32 oom_score_adjust { get; }
    public abstract int32 nice { get; }
    [DBus (name = "IOScheduling")]
    public abstract int32 io_scheduling { get; }
    [DBus (name = "CPUSchedulingPolicy")]
    public abstract int32 cpu_scheduling_policy { get; }
    [DBus (name = "CPUSchedulingPolicyPriority")]
    public abstract int32 cpu_scheduling_priority { get; }
    [DBus (name = "CPUAffinity")]
    public abstract uint8[] cpu_affinity { owned get; }
    [DBus (name = "TimerSlackNSec")]
    public abstract uint64 timer_slack_nsec { get; }
    [DBus (name = "CPUSchedulingResetOnFork")]
    public abstract bool cpu_scheduling_reset_on_fork { get; }
    public abstract bool non_blocking { get; }
    public abstract string standard_input { owned get; }
    public abstract string standard_output { owned get; }
    public abstract string standard_error { owned get; }
    [DBus (name = "TTYPath")]
    public abstract string tty_path { owned get; }
    [DBus (name = "TTYReset")]
    public abstract bool tty_reset { get; }
    [DBus (name = "TTYVHangup")]
    public abstract bool tty_vhangup { get; }
    [DBus (name = "TTYVTDisallocate")]
    public abstract bool tty_vt_disallocate { get; }
    public abstract int32 syslog_priority { get; }
    public abstract string syslog_identifier { owned get; }
    public abstract bool syslog_level_prefix { get; }
    public abstract string capabilities { owned get; }
    public abstract int32 secure_bits { get; }
    public abstract uint64 capability_bounding_set { get; }
    public abstract string user { owned get; }
    public abstract string group { owned get; }
    public abstract string[] supplementary_groups { owned get; }
    [DBus (name = "TCPWrapName")]
    public abstract string tcp_wrap_name { owned get; }
    [DBus (name = "PAMName")]
    public abstract string pam_name { owned get; }
    public abstract string[] read_write_directories { owned get; }
    public abstract string[] read_only_directories { owned get; }
    public abstract string[] inaccessible_directories { owned get; }
    public abstract uint64 mount_flags { get; }
    public abstract bool private_tmp { get; }
    public abstract bool private_network { get; }
    public abstract bool same_process_group { get; }
    public abstract string utmp_identifier { owned get; }
    [DBus (name = "IgnoreSIGPIPE")]
    public abstract bool ignore_sigpipe { get; }
    public abstract bool no_new_privileges { get; }
    public abstract uint32[] system_call_filter { owned get; }
    public abstract string kill_mode { owned get; }
    public abstract int32 kill_signal { get; }
    [DBus (name = "SendSIGKILL")]
    public abstract bool send_sigkill { get; }
    [DBus (name = "SendSIGHUP")]
    public abstract bool send_sighup { get; }
    [DBus (name = "CPUAccounting")]
    public abstract bool cpu_accounting { get; }
    [DBus (name = "CPUShares")]
    public abstract uint64 cpu_shares { get; }
    [DBus (name = "BlockIOAccounting")]
    public abstract bool block_io_accounting { get; }
    [DBus (name = "BlockIOWeight")]
    public abstract int64 block_io_weight { get; }
    [DBus (name = "BlockIODeviceWeight")]
    public abstract UnitBlockIOInfo[] block_ui_device_weight { owned get; }
    [DBus (name = "BlockIOReadBandwidth")]
    public abstract UnitBlockIOInfo[] block_ui_read_bandwidth { owned get; }
    [DBus (name = "BlockIOWriteBandwidth")]
    public abstract UnitBlockIOInfo[] block_ui_write_bandwidth { owned get; }
    public abstract bool memory_accounting { get; }
    public abstract uint64 memory_limit { get; }
    public abstract string device_policy { owned get; }
    public abstract UnitDeviceAllowInfo[] device_allow { owned get; }
    public abstract bool permissions_start_only { get; }
    public abstract bool root_directory_start_only { get; }
    public abstract bool remain_after_exit { get; }
    public abstract uint64 exec_main_start_timestamp { get; }
    public abstract uint64 exec_main_start_timestamp_monotonic { get; }
    public abstract uint64 exec_main_exit_timestamp { get; }
    public abstract uint64 exec_main_exit_timestamp_monotonic { get; }
    [DBus (name = "ExecMainPID")]
    public abstract uint32 exec_main_pid { get; }
    public abstract int32 exec_main_code { get; }
    [DBus (name = "MainPID")]
    public abstract uint32 main_pid { get; }
    [DBus (name = "ControlPID")]
    public abstract uint32 control_pid { get; }
    public abstract string bus_name { owned get; }
    public abstract string status_text { owned get; }
    public abstract string result { owned get; }
}

// FIXME: Undocumented in DBus
public struct SocketListenInfo
{
    string arg0;
    string arg1; 
}

[DBus (name = "org.freedesktop.systemd1.Socket")]
public interface Socket : DBusProxy, Unit
{
    /* Properties */
    [DBus (name = "BindIPv6Only")]
    public abstract bool bind_ipv6_only { get; } // Advertised as a bool, appears to return string. Bug?
    public abstract uint32 backlog { get; }
    [DBus (name = "TimeoutUSec")]
    public abstract uint64 timeout_usec { get; }
    public abstract string slice { owned get; }
    public abstract string control_group { owned get; }
    public abstract UnitExecInfo[] exec_start_pre { owned get; }
    public abstract UnitExecInfo[] exec_start_post { owned get; }
    public abstract UnitExecInfo[] exec_stop_pre { owned get; }
    public abstract UnitExecInfo[] exec_stop_post { owned get; }
    public abstract string[] environment { owned get; }
    public abstract UnitEnvFile[] environment_files { owned get; }
    [DBus (name = "UMask")]
    public abstract uint32 umask { get; }
    [DBus (name = "LimitCPU")]
    public abstract uint64 limit_cpu { get; }
    [DBus (name = "LimitFSIZE")]
    public abstract uint64 limit_fsize { get; }
    [DBus (name = "LimitDATA")]
    public abstract uint64 limit_data { get; }
    [DBus (name = "LimitSTACK")]
    public abstract uint64 limit_stack { get; }
    [DBus (name = "LimitCORE")]
    public abstract uint64 limit_core { get; }
    [DBus (name = "LimitRSS")]
    public abstract uint64 limit_rss { get; }
    [DBus (name = "LimitNOFILE")]
    public abstract uint64 limit_nofile { get; }
    [DBus (name = "LimitAS")]
    public abstract uint64 limit_as { get; }
    [DBus (name = "LimitNPROC")]
    public abstract uint64 limit_nproc { get; }
    [DBus (name = "LimitMEMLOCK")]
    public abstract uint64 limit_memlock { get; }
    [DBus (name = "LimitLOCKS")]
    public abstract uint64 limit_locks { get; }
    [DBus (name = "LimitSIGPENDING")]
    public abstract uint64 limit_sigpending { get; }
    [DBus (name = "LimitMSGQUEUE")]
    public abstract uint64 limit_msgqueue { get; }
    [DBus (name = "LimitNICE")]
    public abstract uint64 limit_nice { get; }
    [DBus (name = "LimitRTPRIO")]
    public abstract uint64 limit_rtprio { get; }
    [DBus (name = "LimitRTTIME")]
    public abstract uint64 limit_rttime { get; }
    public abstract string working_directory { owned get; }
    public abstract string root_directory { owned get; }
    [DBus (name = "OOMScoreAdjust")]
    public abstract int32 oom_score_adjust { get; }
    public abstract int32 nice { get; }
    [DBus (name = "IOScheduling")]
    public abstract int32 io_scheduling { get; }
    [DBus (name = "CPUSchedulingPolicy")]
    public abstract int32 cpu_scheduling_policy { get; }
    [DBus (name = "CPUSchedulingPolicyPriority")]
    public abstract int32 cpu_scheduling_priority { get; }
    [DBus (name = "CPUAffinity")]
    public abstract uint8[] cpu_affinity { owned get; }
    [DBus (name = "TimerSlackNSec")]
    public abstract uint64 timer_slack_nsec { get; }
    [DBus (name = "CPUSchedulingResetOnFork")]
    public abstract bool cpu_scheduling_reset_on_fork { get; }
    public abstract bool non_blocking { get; }
    public abstract string standard_input { owned get; }
    public abstract string standard_output { owned get; }
    public abstract string standard_error { owned get; }
    [DBus (name = "TTYPath")]
    public abstract string tty_path { owned get; }
    [DBus (name = "TTYReset")]
    public abstract bool tty_reset { get; }
    [DBus (name = "TTYVHangup")]
    public abstract bool tty_vhangup { get; }
    [DBus (name = "TTYVTDisallocate")]
    public abstract bool tty_vt_disallocate { get; }
    public abstract int32 syslog_priority { get; }
    public abstract string syslog_identifier { owned get; }
    public abstract bool syslog_level_prefix { get; }
    public abstract string capabilities { owned get; }
    public abstract int32 secure_bits { get; }
    public abstract uint64 capability_bounding_set { get; }
    public abstract string user { owned get; }
    public abstract string group { owned get; }
    public abstract string[] supplementary_groups { owned get; }
    [DBus (name = "TCPWrapName")]
    public abstract string tcp_wrap_name { owned get; }
    [DBus (name = "PAMName")]
    public abstract string pam_name { owned get; }
    public abstract string[] read_write_directories { owned get; }
    public abstract string[] read_only_directories { owned get; }
    public abstract string[] inaccessible_directories { owned get; }
    public abstract uint64 mount_flags { get; }
    public abstract bool private_tmp { get; }
    public abstract bool private_network { get; }
    public abstract bool same_process_group { get; }
    public abstract string utmp_identifier { owned get; }
    [DBus (name = "IgnoreSIGPIPE")]
    public abstract bool ignore_sigpipe { get; }
    public abstract bool no_new_privileges { get; }
    public abstract uint32[] system_call_filter { owned get; }
    public abstract string kill_mode { owned get; }
    public abstract int32 kill_signal { get; }
    [DBus (name = "SendSIGKILL")]
    public abstract bool send_sigkill { get; }
    [DBus (name = "SendSIGHUP")]
    public abstract bool send_sighup { get; }
    [DBus (name = "CPUAccounting")]
    public abstract bool cpu_accounting { get; }
    [DBus (name = "CPUShares")]
    public abstract uint64 cpu_shares { get; }
    [DBus (name = "BlockIOAccounting")]
    public abstract bool block_io_accounting { get; }
    [DBus (name = "BlockIOWeight")]
    public abstract int64 block_io_weight { get; }
    [DBus (name = "BlockIODeviceWeight")]
    public abstract UnitBlockIOInfo[] block_ui_device_weight { owned get; }
    [DBus (name = "BlockIOReadBandwidth")]
    public abstract UnitBlockIOInfo[] block_ui_read_bandwidth { owned get; }
    [DBus (name = "BlockIOWriteBandwidth")]
    public abstract UnitBlockIOInfo[] block_ui_write_bandwidth { owned get; }
    public abstract bool memory_accounting { get; }
    public abstract uint64 memory_limit { get; }
    public abstract string device_policy { owned get; }
    public abstract UnitDeviceAllowInfo[] device_allow { owned get; }
    [DBus (name = "ControlPID")]
    public abstract uint32 control_pid { get; }
    public abstract string bind_to_device { owned get; }
    public abstract uint32 directory_mode { get; }
    public abstract uint32 socket_mode { get; }
    public abstract bool accept { get; }
    public abstract bool keep_alive { get; }
    public abstract int32 priority { get; }
    public abstract uint64 receive_buffer { get; }
    public abstract uint64 send_buffer { get; }
    [DBus (name = "IPTOS")]
    public abstract int32 ip_tos { get; } // Correct spacing I think?
    [DBus (name = "IPTTL")]
    public abstract int32 ip_ttl { get; }
    public abstract uint64 pipe_size { get; }
    public abstract bool free_bind { get; }
    public abstract bool transparent { get; }
    public abstract bool broadcast { get; }
    public abstract bool pass_credentials { get; }
    public abstract bool pass_security { get; }
    public abstract int32 mark { get; }
    public abstract uint32 max_connections { get; }
    public abstract uint32 n_accepted { get; }
    public abstract uint32 n_connections { get; }
    public abstract int64 message_queue_max_messages { get; }
    public abstract int64 message_queue_message_size { get; }
    public abstract SocketListenInfo[] listen { owned get; }
    public abstract string result { owned get; }
    public abstract bool reuse_port { get; }
    public abstract string smack_label { owned get; }
    [DBus (name = "SmackLabelIPIn")]
    public abstract string smack_label_ip_in { owned get; }
    [DBus (name = "SmackLabelIPIn")]
    public abstract string smack_label_ip_out { owned get; }
}

[DBus (name = "org.freedesktop.systemd1.Target")]
public interface Target : DBusProxy, Unit
{
    /* Well, that was easy */
}

[DBus (name = "org.freedesktop.systemd1.Device")]
public interface Device : DBusProxy, Unit
{
    [DBus (name = "SysFSPath")]
    public abstract string sysfs_path { owned get; }
}

[DBus (name = "org.freedesktop.systemd1.Mount")]
public interface Mount : DBusProxy, Unit
{
    /* Properties */
    public abstract string where { owned get; }
    public abstract string what { owned get; }
    public abstract string options { owned get; }
    [DBus (name = "Type")]
    public abstract string mount_type { owned get; }
    [DBus (name = "TimeoutUSec")]
    public abstract uint64 timeout_usec { get; }
    public abstract string slice { owned get; }
    public abstract string control_group { owned get; }
    public abstract UnitExecInfo[] exec_mount { owned get; }
    public abstract UnitExecInfo[] exec_unmount { owned get; }
    public abstract UnitExecInfo[] exec_remount { owned get; }
    public abstract string[] environment { owned get; }
    public abstract UnitEnvFile[] environment_files { owned get; }
    [DBus (name = "UMask")]
    public abstract uint32 umask { get; }
    [DBus (name = "LimitCPU")]
    public abstract uint64 limit_cpu { get; }
    [DBus (name = "LimitFSIZE")]
    public abstract uint64 limit_fsize { get; }
    [DBus (name = "LimitDATA")]
    public abstract uint64 limit_data { get; }
    [DBus (name = "LimitSTACK")]
    public abstract uint64 limit_stack { get; }
    [DBus (name = "LimitCORE")]
    public abstract uint64 limit_core { get; }
    [DBus (name = "LimitRSS")]
    public abstract uint64 limit_rss { get; }
    [DBus (name = "LimitNOFILE")]
    public abstract uint64 limit_nofile { get; }
    [DBus (name = "LimitAS")]
    public abstract uint64 limit_as { get; }
    [DBus (name = "LimitNPROC")]
    public abstract uint64 limit_nproc { get; }
    [DBus (name = "LimitMEMLOCK")]
    public abstract uint64 limit_memlock { get; }
    [DBus (name = "LimitLOCKS")]
    public abstract uint64 limit_locks { get; }
    [DBus (name = "LimitSIGPENDING")]
    public abstract uint64 limit_sigpending { get; }
    [DBus (name = "LimitMSGQUEUE")]
    public abstract uint64 limit_msgqueue { get; }
    [DBus (name = "LimitNICE")]
    public abstract uint64 limit_nice { get; }
    [DBus (name = "LimitRTPRIO")]
    public abstract uint64 limit_rtprio { get; }
    [DBus (name = "LimitRTTIME")]
    public abstract uint64 limit_rttime { get; }
    public abstract string working_directory { owned get; }
    public abstract string root_directory { owned get; }
    [DBus (name = "OOMScoreAdjust")]
    public abstract int32 oom_score_adjust { get; }
    public abstract int32 nice { get; }
    [DBus (name = "IOScheduling")]
    public abstract int32 io_scheduling { get; }
    [DBus (name = "CPUSchedulingPolicy")]
    public abstract int32 cpu_scheduling_policy { get; }
    [DBus (name = "CPUSchedulingPolicyPriority")]
    public abstract int32 cpu_scheduling_priority { get; }
    [DBus (name = "CPUAffinity")]
    public abstract uint8[] cpu_affinity { owned get; }
    [DBus (name = "TimerSlackNSec")]
    public abstract uint64 timer_slack_nsec { get; }
    [DBus (name = "CPUSchedulingResetOnFork")]
    public abstract bool cpu_scheduling_reset_on_fork { get; }
    public abstract bool non_blocking { get; }
    public abstract string standard_input { owned get; }
    public abstract string standard_output { owned get; }
    public abstract string standard_error { owned get; }
    [DBus (name = "TTYPath")]
    public abstract string tty_path { owned get; }
    [DBus (name = "TTYReset")]
    public abstract bool tty_reset { get; }
    [DBus (name = "TTYVHangup")]
    public abstract bool tty_vhangup { get; }
    [DBus (name = "TTYVTDisallocate")]
    public abstract bool tty_vt_disallocate { get; }
    public abstract int32 syslog_priority { get; }
    public abstract string syslog_identifier { owned get; }
    public abstract bool syslog_level_prefix { get; }
    public abstract string capabilities { owned get; }
    public abstract int32 secure_bits { get; }
    public abstract uint64 capability_bounding_set { get; }
    public abstract string user { owned get; }
    public abstract string group { owned get; }
    public abstract string[] supplementary_groups { owned get; }
    [DBus (name = "TCPWrapName")]
    public abstract string tcp_wrap_name { owned get; }
    [DBus (name = "PAMName")]
    public abstract string pam_name { owned get; }
    public abstract string[] read_write_directories { owned get; }
    public abstract string[] read_only_directories { owned get; }
    public abstract string[] inaccessible_directories { owned get; }
    public abstract uint64 mount_flags { get; }
    public abstract bool private_tmp { get; }
    public abstract bool private_network { get; }
    public abstract bool same_process_group { get; }
    public abstract string utmp_identifier { owned get; }
    [DBus (name = "IgnoreSIGPIPE")]
    public abstract bool ignore_sigpipe { get; }
    public abstract bool no_new_privileges { get; }
    public abstract uint32[] system_call_filter { owned get; }
    public abstract string kill_mode { owned get; }
    public abstract int32 kill_signal { get; }
    [DBus (name = "SendSIGKILL")]
    public abstract bool send_sigkill { get; }
    [DBus (name = "SendSIGHUP")]
    public abstract bool send_sighup { get; }
    [DBus (name = "CPUAccounting")]
    public abstract bool cpu_accounting { get; }
    [DBus (name = "CPUShares")]
    public abstract uint64 cpu_shares { get; }
    [DBus (name = "BlockIOAccounting")]
    public abstract bool block_io_accounting { get; }
    [DBus (name = "BlockIOWeight")]
    public abstract int64 block_io_weight { get; }
    [DBus (name = "BlockIODeviceWeight")]
    public abstract UnitBlockIOInfo[] block_ui_device_weight { owned get; }
    [DBus (name = "BlockIOReadBandwidth")]
    public abstract UnitBlockIOInfo[] block_ui_read_bandwidth { owned get; }
    [DBus (name = "BlockIOWriteBandwidth")]
    public abstract UnitBlockIOInfo[] block_ui_write_bandwidth { owned get; }
    public abstract bool memory_accounting { get; }
    public abstract uint64 memory_limit { get; }
    public abstract string device_policy { owned get; }
    public abstract UnitDeviceAllowInfo[] device_allow { owned get; }
    public abstract uint32 control_pid { get; }
    public abstract uint32 directory_mode { get; }
    public abstract string result { owned get; }
}

[DBus (name = "org.freedesktop.systemd1.Automount")]
public interface Automount : DBusProxy, Unit
{
    public abstract string where { owned get; }
    public abstract uint32 directory_mode { get; }
    public abstract string result { owned get; }
}

[DBus (name = "org.freedesktop.systemd1.Snapshot")]
public interface Snapshot : DBusProxy, Unit
{
    /* Methods */
    public abstract async void remove(Cancellable? cancellable = null) throws IOError;
    [DBus (name = "Remove")]
    public abstract void remove_sync(Cancellable? cancellable = null) throws IOError;

    /* Properties */
    public abstract bool cleanup { get; }
}

public struct TimerMonotonicInfo
{
    string timer_base;
    uint64 offset;
    uint64 next;
}

public struct TimerCalendarInfo
{
    string timer_base;
    string specification;
    uint64 next;
}

[DBus (name = "org.freedesktop.systemd1.Timer")]
public interface Timer : DBusProxy, Unit
{
    public abstract string unit { owned get; }
    public abstract TimerMonotonicInfo[] timers_monotonic { owned get; }
    public abstract TimerCalendarInfo[] timers_calendar { owned get; }
    [DBus (name = "NextElapseUSecRealtime")]
    public abstract uint64 next_elapse_usec_realtime { get; }
    [DBus (name = "NextElapseUSecMonotonic")]
    public abstract uint64 next_elapse_usec_monotonic { get; }
}

[DBus (name = "org.freedesktop.systemd1.Swap")]
public interface Swap : DBusProxy, Unit
{
    /* Properties */
    public abstract string what { owned get; }
    public abstract int32 priority { get; }
    [DBus (name = "TimeoutUSec")]
    public abstract uint64 timeout_usec { get; }
    public abstract UnitExecInfo[] exec_activate { owned get; }
    public abstract UnitExecInfo[] exec_deactivate { owned get; }
    public abstract string[] environment { owned get; }
    public abstract UnitEnvFile[] environment_files { owned get; }
    [DBus (name = "UMask")]
    public abstract uint32 umask { get; }
    [DBus (name = "LimitCPU")]
    public abstract uint64 limit_cpu { get; }
    [DBus (name = "LimitFSIZE")]
    public abstract uint64 limit_fsize { get; }
    [DBus (name = "LimitDATA")]
    public abstract uint64 limit_data { get; }
    [DBus (name = "LimitSTACK")]
    public abstract uint64 limit_stack { get; }
    [DBus (name = "LimitCORE")]
    public abstract uint64 limit_core { get; }
    [DBus (name = "LimitRSS")]
    public abstract uint64 limit_rss { get; }
    [DBus (name = "LimitNOFILE")]
    public abstract uint64 limit_nofile { get; }
    [DBus (name = "LimitAS")]
    public abstract uint64 limit_as { get; }
    [DBus (name = "LimitNPROC")]
    public abstract uint64 limit_nproc { get; }
    [DBus (name = "LimitMEMLOCK")]
    public abstract uint64 limit_memlock { get; }
    [DBus (name = "LimitLOCKS")]
    public abstract uint64 limit_locks { get; }
    [DBus (name = "LimitSIGPENDING")]
    public abstract uint64 limit_sigpending { get; }
    [DBus (name = "LimitMSGQUEUE")]
    public abstract uint64 limit_msgqueue { get; }
    [DBus (name = "LimitNICE")]
    public abstract uint64 limit_nice { get; }
    [DBus (name = "LimitRTPRIO")]
    public abstract uint64 limit_rtprio { get; }
    [DBus (name = "LimitRTTIME")]
    public abstract uint64 limit_rttime { get; }
    public abstract string working_directory { owned get; }
    public abstract string root_directory { owned get; }
    [DBus (name = "OOMScoreAdjust")]
    public abstract int32 oom_score_adjust { get; }
    public abstract int32 nice { get; }
    [DBus (name = "IOScheduling")]
    public abstract int32 io_scheduling { get; }
    [DBus (name = "CPUSchedulingPolicy")]
    public abstract int32 cpu_scheduling_policy { get; }
    [DBus (name = "CPUSchedulingPolicyPriority")]
    public abstract int32 cpu_scheduling_priority { get; }
    [DBus (name = "CPUAffinity")]
    public abstract uint8[] cpu_affinity { owned get; }
    [DBus (name = "TimerSlackNSec")]
    public abstract uint64 timer_slack_nsec { get; }
    [DBus (name = "CPUSchedulingResetOnFork")]
    public abstract bool cpu_scheduling_reset_on_fork { get; }
    public abstract bool non_blocking { get; }
    public abstract string standard_input { owned get; }
    public abstract string standard_output { owned get; }
    public abstract string standard_error { owned get; }
    [DBus (name = "TTYPath")]
    public abstract string tty_path { owned get; }
    [DBus (name = "TTYReset")]
    public abstract bool tty_reset { get; }
    [DBus (name = "TTYVHangup")]
    public abstract bool tty_vhangup { get; }
    [DBus (name = "TTYVTDisallocate")]
    public abstract bool tty_vt_disallocate { get; }
    public abstract int32 syslog_priority { get; }
    public abstract string syslog_identifier { owned get; }
    public abstract bool syslog_level_prefix { get; }
    public abstract string capabilities { owned get; }
    public abstract int32 secure_bits { get; }
    public abstract uint64 capability_bounding_set { get; }
    public abstract string user { owned get; }
    public abstract string group { owned get; }
    public abstract string[] supplementary_groups { owned get; }
    [DBus (name = "TCPWrapName")]
    public abstract string tcp_wrap_name { owned get; }
    [DBus (name = "PAMName")]
    public abstract string pam_name { owned get; }
    public abstract string[] read_write_directories { owned get; }
    public abstract string[] read_only_directories { owned get; }
    public abstract string[] inaccessible_directories { owned get; }
    public abstract uint64 mount_flags { get; }
    public abstract bool private_tmp { get; }
    public abstract bool private_network { get; }
    public abstract bool same_process_group { get; }
    public abstract string kill_mode { owned get; }
    public abstract int32 kill_signal { get; }
    public abstract string utmp_identifier { owned get; }
    [DBus (name = "IgnoreSIGPIPE")]
    public abstract bool ignore_sigpipe { get; }
    public abstract bool no_new_privileges { get; }
    public abstract uint32[] system_call_filter { owned get; }
    [DBus (name = "SendSIGKILL")]
    public abstract bool send_sigkill { get; }
    [DBus (name = "SendSIGHUP")]
    public abstract bool send_sighup { get; }
    [DBus (name = "CPUAccounting")]
    public abstract bool cpu_accounting { get; }
    [DBus (name = "CPUShares")]
    public abstract uint64 cpu_shares { get; }
    [DBus (name = "BlockIOAccounting")]
    public abstract bool block_io_accounting { get; }
    [DBus (name = "BlockIOWeight")]
    public abstract int64 block_io_weight { get; }
    [DBus (name = "BlockIODeviceWeight")]
    public abstract UnitBlockIOInfo[] block_ui_device_weight { owned get; }
    [DBus (name = "BlockIOReadBandwidth")]
    public abstract UnitBlockIOInfo[] block_ui_read_bandwidth { owned get; }
    [DBus (name = "BlockIOWriteBandwidth")]
    public abstract UnitBlockIOInfo[] block_ui_write_bandwidth { owned get; }
    public abstract bool memory_accounting { get; }
    public abstract uint64 memory_limit { get; }
    public abstract string device_policy { owned get; }
    public abstract UnitDeviceAllowInfo[] device_allow { owned get; }
    public abstract uint32 control_pid { get; }
    public abstract string result { owned get; }
}

[DBus (use_string_marshalling = true)]
public enum PathCondition
{
    [DBus (value = "PathExists")]
    PATH_EXISTS,
    [DBus (value = "PathExistsGlob")]
    PATH_EXISTS_GLOB,
    [DBus (value = "PathChanged")]
    PATH_CHANGED,
    [DBus (value = "PathModified")]
    PATH_MODIFIED,
    [DBus (value = "DirectoryNotEmpty")]
    DIRECTORY_NOT_EMPTY;
}

public struct PathInfo
{
    string condition;
    string path;
}

[DBus (name = "org.freedesktop.systemd1.Path")]
public interface Path : DBusProxy, Unit
{
    public abstract string unit { owned get; }
    public abstract PathInfo[] paths { owned get; }
    public abstract bool make_directory { get; }
    public abstract uint32 directory_mode { get; }
    public abstract string result { owned get; }
}

[DBus (name = "org.freedesktop.systemd1.Slice")]
public interface Slice : DBusProxy, Unit
{
    public abstract string slice { owned get; }
    public abstract string control_group { owned get; }
    public abstract bool cpu_accounting { get; }
    [DBus (name = "CPUShares")]
    public abstract uint64 cpu_shares { get; }
    [DBus (name = "BlockIOAccounting")]
    public abstract bool block_io_accounting { get; }
    [DBus (name = "BlockIOWeight")]
    public abstract int64 block_io_weight { get; }
    [DBus (name = "BlockIODeviceWeight")]
    public abstract UnitBlockIOInfo[] block_ui_device_weight { owned get; }
    [DBus (name = "BlockIOReadBandwidth")]
    public abstract UnitBlockIOInfo[] block_ui_read_bandwidth { owned get; }
    [DBus (name = "BlockIOWriteBandwidth")]
    public abstract UnitBlockIOInfo[] block_ui_write_bandwidth { owned get; }
    public abstract bool memory_accounting { get; }
    public abstract uint64 memory_limit { get; }
    public abstract string device_policy { owned get; }
    public abstract UnitDeviceAllowInfo[] device_allow { owned get; }
}

[DBus (name = "org.freedesktop.systemd1.Scope")]
public interface Scope : DBusProxy, Unit
{
    /* Methods */
    public abstract async void abandon(Cancellable? cancellable = null) throws IOError;
    [DBus (name = "abandon")]
    public abstract void abandon_sync(Cancellable? cancellable = null) throws IOError;

    /* Signals */
    public signal void request_stop();

    /* Properties */
    public abstract string slice { owned get; }
    public abstract string control_group { owned get; }
    [DBus (name = "TimeoutStopUSec")]
    public abstract uint64 timeout_stop_usec { get; }
    public abstract string kill_mode { owned get; }
    public abstract int32 kill_signal { get; }
    public abstract bool cpu_accounting { get; }
    [DBus (name = "CPUShares")]
    public abstract uint64 cpu_shares { get; }
    [DBus (name = "BlockIOAccounting")]
    public abstract bool block_io_accounting { get; }
    [DBus (name = "BlockIOWeight")]
    public abstract int64 block_io_weight { get; }
    [DBus (name = "BlockIODeviceWeight")]
    public abstract UnitBlockIOInfo[] block_ui_device_weight { owned get; }
    [DBus (name = "BlockIOReadBandwidth")]
    public abstract UnitBlockIOInfo[] block_ui_read_bandwidth { owned get; }
    [DBus (name = "BlockIOWriteBandwidth")]
    public abstract UnitBlockIOInfo[] block_ui_write_bandwidth { owned get; }
    public abstract bool memory_accounting { get; }
    public abstract uint64 memory_limit { get; }
    public abstract string device_policy { owned get; }
    public abstract UnitDeviceAllowInfo[] device_allow { owned get; }
}

public struct JobUnitInfo
{
    string name;
    ObjectPath path;
}

[DBus (name = "org.freedesktop.systemd1.Job")]
public interface Job : DBusProxy
{
    /* Methods */
    public abstract async void cancel(Cancellable? cancellable = null) throws IOError;
    [DBus (name = "cancel")]
    public abstract void cancel_sync(Cancellable? cancellable = null) throws IOError;

    /* Properties */
    public abstract uint32 id { get; }
    public abstract JobUnitInfo unit { owned get; }
    public abstract string job_type { owned get; }
    public abstract string state { owned get; }
}

public async Manager get_system_manager(Cancellable? cancellable = null) throws IOError
{
    return yield Bus.get_proxy(BusType.SYSTEM,
                               "org.freedesktop.systemd1",
                               "/org/freedesktop/systemd1",
                               DBusProxyFlags.GET_INVALIDATED_PROPERTIES,
                               cancellable);
}

public Manager get_system_manager_sync(Cancellable? cancellable = null) throws IOError
{
    return Bus.get_proxy_sync(BusType.SYSTEM,
                              "org.freedesktop.systemd1",
                              "/org/freedesktop/systemd1",
                              DBusProxyFlags.GET_INVALIDATED_PROPERTIES,
                              cancellable);
}

} // end namespace Systemd
