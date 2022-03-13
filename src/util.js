/**
 * $File: util.js $
 * $Date: 2022-03-13 22:04:21 $
 * $Revision: $
 * $Creator: Jen-Chieh Shen $
 * $Notice: See LICENSE.txt for modification and distribution information
 *                   Copyright © 2022 by Shen, Jen-Chieh $
 */

"use strict";

const path = require('path');
const { exec } = require("child_process");

/*
 * Remove `undefined` item from the array
 * @param { Array } arr - target array
 */
function _remove_undefined(arr) {
  return arr.filter(elm => { return elm !== undefined; });
}

/**
 *
 * @param { ellipsis } ...arr - an array to insert space between each item.
 */
function _join_spc(...arr) {
  arr = _remove_undefined(arr);
  let _result = [];
  for (let index = 0; index < arr.length; ++index) {
    let _item = arr[index];
    if (Array.isArray(_item)) {
      _result.push(_join_spc(..._item));
    } else {
      _result.push(_item);
    }
  }
  return _result.join(' ');
}

/* Return plugin directory */
function _plugin_dir() { return path.join(__dirname, '..'); }

/**
 * Call emacs process
 * @param { string } script - name of the script from `../lisp`
 * @param { string } args - the rest of the arguments
 */
async function call(script, ...args) {
  let _script = 'lisp/' + script + '.el';
  let _path = path.join(_plugin_dir(), _script);
  let cmd = _join_spc('emacs', '--script', _path, args);
  await exec(cmd, (error, stdout, stderr) => {
    if (stdout) console.log(stdout);
    if (error) console.log(error);
    if (stderr) console.log(stderr);
  });
}

/*
 * Module Exports
 */
module.exports.call = call;
