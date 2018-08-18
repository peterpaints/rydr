const $ = jQuery;

$(document).ready(() => {
  if (!RegExp.escape) {
    RegExp.escape = (s) => {
      return String(s).replace(/[\\^$*+?.()|[\]{}]/g, '\\$&');
    }
  }
});
