require([
  'base/js/namespace',
  'base/js/events',
], function (IPython, events) {

  function to(mode) {
    function to_mode(c) {
      c.code_mirror.setOption('keyMap', mode);
      var extraKeys = c.code_mirror.getOption('extraKeys');
      if (extraKeys['Ctrl-/']) {
        extraKeys['Ctrl-;'] = extraKeys['Ctrl-/'];
        delete extraKeys['Ctrl-/'];
        c.code_mirror.setOption('extraKeys', extraKeys);
      }
    };

    function update_extra_keys(klass) {
      var extraKeys = klass.options_default.cm_config.extraKeys;
      if (extraKeys['Ctrl-/']) {
        extraKeys['Ctrl-;'] = extraKeys['Ctrl-/'];
        delete extraKeys['Ctrl-/'];
        klass.options_default.cm_config.extraKeys =  extraKeys;
      }

    }
    IPython.notebook.get_cells().map(to_mode);
    require("notebook/js/cell").Cell.options_default.cm_config.keyMap = mode;
    update_extra_keys(require("notebook/js/cell").Cell);
    update_extra_keys(require("notebook/js/codecell").CodeCell);
  };

  events.on('notebook_loaded.Notebook', function () {
    require(["codemirror/keymap/emacs"], function () {
      to('emacs')
      console.log('emacs.js loaded')
    });
  });
});
