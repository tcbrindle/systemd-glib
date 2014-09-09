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

[DBus (use_string_marshalling = true)]
public enum Systemd.PathCondition
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

public struct Systemd.PathInfo
{
    string condition;
    string path;
}

[DBus (name = "org.freedesktop.systemd1.Path")]
public interface Systemd.Path : DBusProxy, Unit
{
    public abstract string unit { owned get; }
    public abstract PathInfo[] paths { owned get; }
    public abstract bool make_directory { get; }
    public abstract uint32 directory_mode { get; }
    public abstract string result { owned get; }
}
