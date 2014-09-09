AC_INIT(systemd-glib, 1.0)
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_HEADERS([config.h])

AM_INIT_AUTOMAKE([1.11])

AM_SILENT_RULES([yes])

AC_PROG_CC
AM_PROG_VALAC

LT_INIT

PKG_CHECK_MODULES(GIO, [gio-unix-2.0 ])

GOBJECT_INTROSPECTION_CHECK([1.2.9])

AC_OUTPUT([
Makefile
src/systemd-glib.pc
src/Makefile
])
