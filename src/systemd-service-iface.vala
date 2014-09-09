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

[DBus (name = "org.freedesktop.systemd1.Service")]
public interface Systemd.Service : DBusProxy, Unit
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
