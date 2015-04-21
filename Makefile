PROJECT = demo

DEPS = cowboy
dep_cowboy = git git://github.com/extend/cowboy.git 1.0.0

include erlang.mk

run: app
	$(gen_verbose) erl $(SHELL_PATH) $(SHELL_OPTS) -eval 'application:ensure_all_started(demo).'
