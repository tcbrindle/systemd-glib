
systemd-glib
============

systemd-glib is a library wrapping the systemd D-Bus API, using GDBus.
It can be used from C, Vala, and other languages using GObject introspection
(though see known issues below).

Examples
--------

A simple example in C, using sync calls with error checking omitted:

```C
int main()
{
    SystemdManager *manager;
    SystemdUnitInfo *units;
    int i, num_units;
    char *version;

    manager = systemd_get_system_manager_proxy_sync(NULL, NULL);

    g_print("Using %s\n", systemd_manager_get_version(manager));

    units = systemd_manager_get_units_sync(manager, NULL, &num_units, NULL);

    g_print("Units:\n");
    for (i = 0; i < num_units; i++) {
        g_print("\t%s\n", units[i].name);
    }

    /* ...clean up... */
}
```

Or the same in Vala, this time using async calls:

```Vala
async void run()
{
    var manager = yield Systemd.get_system_manager_proxy();

    print("Using %s\n", manager.version);

    var units = yield manager.get_units();

    print("Units:\n");
    foreach (var u in units) {
        print("\t%s\n", u.name);
    }
}

void main()
{
    var loop = new MainLoop();

    run.begin( (obj, res) => {
        try {
            run.end(res);
        catch (Error e) {
            error(e.message);
        }
        loop.quit();
    });

    loop.run();
}
```

or Python...

```python
from gi.repository import Systemd

manager = Systemd.get_system_manager_proxy_sync()
units = manager.get_units_sync()

for u in units:
    print(u.name);
```

Requirements
------------

You'll need to have the headers/development packages for GLib, GObject and GIO
installed, but you probably already knew that. The bindings are generated using
Vala, so you'll need to have a recent version of the Vala compiler.

And of course, you'll need to be running systemd or the library won't do you
much good :-)

Licence
-------

    This library is free software; you can redistribute it and/or modify it
    under the terms of the GNU Lesser General Public License as published
    by the Free Software Foundation, either version 2.1 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser
    General Public License for more details.


Bugs? Patches?
--------------

Please use the github issue tracker.


Known issues
------------

Unfortunately, Vala doesn't currently add real GObject properties to the
GInterfaces it generates for D-Bus, but only get/set functions. This
is compounded by the fact that the getters and setters aren't listed in the
generated GIR (though the imaginary GObject properties are!). Since there are
a *lot* of properties involved in the systemd D-Bus interface, this is a bit
of a problem when it comes to trying to use systemd-glib via introspection
right now. I've filed the bug for Vala, so hopefully it will be fixed.

In the mean time, a workaround is to use the `get_cached_property()` method of
the generated proxy class, along with the *D-Bus* name of the property (not
the GObject name). For example:

```Python
from gi.repository import Systemd

manager = Systemd.get_manager_sync()

version = manager.get_cached_property("Version")

print(version)

```

This sucks, but hopefully it will get sorted.

Secondly, Vala automatically marshalls complex argument types into boxed structs.
This is awesome because doing it manually with GVariant is a bit of a pain
(especially in C), and is largely the reason the bindings use Vala rather than
gdbus-codegen. Sadly however, GJS doesn't seem to deal with boxed structs
very well at all, and will complain loudly if you try to use any method which
returns them.

On the plus side, GJS has its own excellent D-Bus functionality built-in, making
systemd-glib somewhat redundant there.


Why Vala and not gdbus-codegen?
-------------------------------

Mostly because I plan on using the library from C, and (IMO) Vala generates a
much nicer C API than gdbus-codegen given the same D-Bus interface.

In particular, Vala has automatic marshalling between GVariants and complex C
types, which gdbus-codegen can only do for very few cases -- for the most part,
using gdbus-codegen means you have to construct and deconstruct GVariants
yourself, which is kind of rubbish. Sure, you could write your own (de)marshalling
functions, but why bother when Vala generates them for you?


