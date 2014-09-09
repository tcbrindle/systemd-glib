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

public struct Systemd.TimerMonotonicInfo
{
    string timer_base;
    uint64 offset;
    uint64 next;
}

public struct Systemd.TimerCalendarInfo
{
    string timer_base;
    string specification;
    uint64 next;
}

[DBus (name = "org.freedesktop.systemd1.Timer")]
public interface Systemd.Timer : DBusProxy, Unit
{
    public abstract string unit { owned get; }
    public abstract TimerMonotonicInfo[] timers_monotonic { owned get; }
    public abstract TimerCalendarInfo[] timers_calendar { owned get; }
    [DBus (name = "NextElapseUSecRealtime")]
    public abstract uint64 next_elapse_usec_realtime { get; }
    [DBus (name = "NextElapseUSecMonotonic")]
    public abstract uint64 next_elapse_usec_monotonic { get; }
}
