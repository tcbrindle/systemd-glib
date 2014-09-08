
NULL=

lib_LTLIBRARIES = libsystemd-glib.la

libsystemd_glib_la_SOURCES = \
    ${dbus_built_sources} \
    systemd-glib.h \
    systemd-glib-types.c systemd-glib-types.h \
    ${NULL}

libsystemd_glib_la_CFLAGS = \
    ${GIO_CFLAGS} \
    ${NULL}

libsystemd_glib_la_LIBADD = \
    ${GIO_LIBS} \
    ${NULL}

libsystemd_glibincludedir = ${includedir}/systemd

libsystemd_glibinclude_HEADERS = \
	systemd-glib.h \
	systemd-glib-generated.h \
	systemd-glib-types.h
	${NULL}

${dbus_built_sources} : Makefile.am ${dbus_xml_sources}
	${AM_V_GEN} \
	gdbus-codegen \
		--interface-prefix org.freedesktop.systemd1. \
		--c-namespace Systemd \
		--c-generate-object-manager \
		--generate-c-code systemd-glib-generated \
		${dbus_xml_sources} \
		$(NULL)

dbus_built_sources = \
    systemd-glib-generated.c systemd-glib-generated.h \
    ${NULL}

BUILT_SOURCES = \
    ${dbus_built_sources} \
    ${NULL}

dbus_xml_sources = \
    org.freedesktop.systemd1.Automount.xml \
    org.freedesktop.systemd1.Device.xml \
    org.freedesktop.systemd1.Job.xml \
    org.freedesktop.systemd1.Manager.xml \
    org.freedesktop.systemd1.Mount.xml \
    org.freedesktop.systemd1.Path.xml \
    org.freedesktop.systemd1.Scope.xml \
    org.freedesktop.systemd1.Service.xml \
    org.freedesktop.systemd1.Slice.xml \
    org.freedesktop.systemd1.Snapshot.xml \
    org.freedesktop.systemd1.Socket.xml \
    org.freedesktop.systemd1.Swap.xml \
    org.freedesktop.systemd1.Target.xml \
    org.freedesktop.systemd1.Timer.xml \
    org.freedesktop.systemd1.Unit.xml \
    ${NULL}

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = systemd-glib.pc

-include $(INTROSPECTION_MAKEFILE)
INTROSPECTION_GIRS =
INTROSPECTION_SCANNER_ARGS = \
    --add-include-path=$(srcdir) \
    --symbol-prefix=systemd \
    --warn-all -v
INTROSPECTION_COMPILER_ARGS = --includedir=$(srcdir)

if HAVE_INTROSPECTION
introspection_sources = $(libsystemd_glib_la_SOURCES)

Systemd-1.0.gir: Makefile.am libsystemd-glib.la
Systemd_1_0_gir_INCLUDES = Gio-2.0
Systemd_1_0_gir_CFLAGS = $(INCLUDES)
Systemd_1_0_gir_LIBS = libsystemd-glib.la
Systemd_1_0_gir_FILES = $(introspection_sources)
Systemd_1_0_gir_SCANNERFLAGS = --c-include "systemd/systemd-glib.h"
INTROSPECTION_GIRS += Systemd-1.0.gir

girdir = $(datadir)/gir-1.0
gir_DATA = $(INTROSPECTION_GIRS)

typelibdir = $(libdir)/girepository-1.0
typelib_DATA = $(INTROSPECTION_GIRS:.gir=.typelib)

CLEANFILES = $(gir_DATA) $(typelib_DATA)

if ENABLE_VAPIGEN
include $(VAPIGEN_MAKEFILE)

systemd-glib.vapi: Systemd-1.0.gir systemd-glib.deps

VAPIGEN_VAPIS = \
	systemd-glib.vapi

systemd_glib_vapi_DEPS = glib-2.0 gio-2.0
systemd_glib_vapi_METADATADIRS = $(srcdir)
systemd_glib_vapi_FILES = Systemd-1.0.gir

VAPI_DEPS = $(VAPIGEN_VAPIS:.vapi=.deps)

systemd-glib.deps: Makefile.am
	$(AM_V_GEN) echo $(systemd_glib_vapi_DEPS) | tr ' ' '\n' > $@

vapidir = $(datadir)/vala/vapi
vapi_DATA = \
	$(VAPIGEN_VAPIS) \
	$(VAPI_DEPS)

CLEANFILES += \
	$(VAPIGEN_VAPIS) \
	$(VAPI_DEPS)

endif # ENABLE_VAPIGEN
endif # HAVE_INTROSPECTION

EXTRA_DIST = \
    systemd-glib.pc.in \
    ${dbus_xml_sources} \
    ${NULL}
