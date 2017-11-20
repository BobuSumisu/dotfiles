# Copyright (C) 2014 Google Inc.
#
# This file is part of ycmd.
#
# ycmd is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ycmd is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with ycmd.  If not, see <http://www.gnu.org/licenses/>.

import os
import ycm_core

flags = [
    "-std=c99",
    "-D_DEFAULT_SOURCE",
    "-D_BSD_SOURCE",
    "-D_GNU_SOURCE",
    "-xc",
    "-Wall",
    "-Wextra",
    "-Wpedantic",
    "-Werror",
    "-Wfloat-equal",
    "-Wundef",
    "-Wshadow",
    "-Wpointer-arith",
    "-Wcast-align",
    "-Wstrict-prototypes",
    "-Wwrite-strings",
    "-Waggregate-return",
    "-Wcast-qual",
    "-Wswitch-default",
    "-Wswitch-enum",
    "-Wconversion",
    "-Wunreachable-code",
    "-Wformat=2",
    "-I.",
    "-I./src",
    "-I/usr/include",
    "-I/usr/local/include",
]

# Function called by YCM. Simply append include folders relative to this file to flags.
def FlagsForFile(filename, **kwargs):
    path = os.path.dirname(os.path.abspath(filename))
    flags.append("-I%s" % path)
    flags.append("-I%s/.." % path)
    return {
        'flags': flags,
        'do_cache': True
    }

