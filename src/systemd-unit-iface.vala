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

}
