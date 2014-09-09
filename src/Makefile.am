
NULL=

lib_LTLIBRARIES = libsystemd-glib.la

libsystemd_glib_la_SOURCES = \
    systemd-interfaces.vala \
    ${NULL}

libsystemd_glib_la_VALAFLAGS = \
    --pkg gio-2.0 \
    --vapi systemd-glib.vapi \
    --gir Systemd-1.0.gir \
    -H systemd-glib.h \
    --library systemd-glib \
    ${NULL}

libsystemd_glib_la_CFLAGS = \
    ${GIO_CFLAGS} \
    ${NULL}

libsystemd_glib_la_LIBADD = \
    ${GIO_LIBS} \
    ${NULL}

libsystemd_glibincludedir = ${includedir}

libsystemd_glibinclude_HEADERS = \
    systemd-glib.h \
    ${NULL}

vapidir = ${datadir}/vala/vapi
vapi_DATA = systemd-glib.vapi systemd-glib.deps

girdir = $(datadir)/gir-1.0
gir_DATA = Systemd-1.0.gir

CLEANFILES = ${gir_DATA}

if HAVE_INTROSPECTION

-include $(INTROSPECTION_MAKEFILE)

Systemd-1.0.typelib : Makefile.am Systemd-1.0.gir
	${AM_V_GEN} \
	${INTROSPECTION_COMPILER} \
		--shared-library libsystemd-glib \
		--output Systemd-1.0.typelib \
		${gir_DATA}

typelibdir = $(libdir)/girepository-1.0
typelib_DATA = Systemd-1.0.typelib

CLEANFILES += ${typelib_DATA}

endif # HAVE_INTROSPECTION

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = systemd-glib.pc

EXTRA_DIST = \
    systemd-glib.pc.in \
    systemd-glib.deps \
    ${NULL}

GITIGNOREFILES = \
    systemd-interfaces.c \
    systemd-glib.vapi \
    systemd-glib.h \
    ${NULL}

-include $(top_srcdir)/git.mk
