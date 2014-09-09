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

[DBus (name = "org.freedesktop.systemd1.Scope")]
public interface Systemd.Scope : DBusProxy, Unit
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