/* systemd-glib: GObject bindings for systemd D-Bus interface
 *
 * Copyright (c) 2014 Tristan Brindle <t.c.brindle@gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General
 * Public License along with this library; if not, see <http://www.gnu.org/licenses/>.
 */

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

public async Manager get_system_manager_proxy(Cancellable? cancellable = null) throws IOError
{
    return yield Bus.get_proxy(BusType.SYSTEM,
                               "org.freedesktop.systemd1",
                               "/org/freedesktop/systemd1",
                               DBusProxyFlags.GET_INVALIDATED_PROPERTIES,
                               cancellable);
}

public Manager get_system_manager_proxy_sync(Cancellable? cancellable = null) throws IOError
{
    return Bus.get_proxy_sync(BusType.SYSTEM,
                              "org.freedesktop.systemd1",
                              "/org/freedesktop/systemd1",
                              DBusProxyFlags.GET_INVALIDATED_PROPERTIES,
                              cancellable);
}

}
