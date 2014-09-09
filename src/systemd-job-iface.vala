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

public struct Systemd.JobUnitInfo
{
    string name;
    ObjectPath path;
}

[DBus (name = "org.freedesktop.systemd1.Job")]
public interface Systemd.Job : DBusProxy
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
