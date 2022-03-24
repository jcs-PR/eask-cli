/**
 * Copyright (C) 2022 Jen-Chieh Shen
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GNU Emacs; see the file COPYING.  If not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */

"use strict";

const util = require("../src/util");

exports.command = 'load [files..]';
exports.desc = 'load files';
exports.builder = {
  files: {
    description: 'files to load',
    requiresArg: false,
    type: 'array',
  },
  global: {
    description: 'install packages from default `.emacs.d`',
    alias: 'g',
    requiresArg: false,
    type: 'boolean',
  },
};

exports.handler = async ({ files, global }) => {
  await util.e_call('load', files
                    , util.def_flag(global, '-g'));
};
