// Slate config

slate.configAll({
  'defaultToCurrentScreen': true,
  'nudgePercentOf': 'screenSize',
  'resizePercentOf': 'screenSize',

  // Hints
  'windowHintsShowIcons': true,
  'windowHintsIgnoreHiddenWindows': false,
  'windowHintsSpread': true
});

// Hint Operation
var hint = slate.operation('hint', {
  'characters': "QWERTYUIOP"
});
slate.bind("tab:alt", hint);

// Push & Move Binding
var key_chord = "ctrl;alt";

// Reload Slate
var relaunch = slate.operation('relaunch');
slate.bind("home:" + key_chord, relaunch);

// Push
var push = function(dir) {
  return slate.operation('push', {
    'direction': dir,
    'style': "bar-resize:screenSizeX/2"
  });
};
var push_right = push("right");
var push_left = push("left");
slate.bind("right:" + key_chord, push_right);
slate.bind("left:" + key_chord, push_left);

// Move
var move = function(y) {
  return slate.operation('move', {
    'x': "windowTopLeftX",
    'y': y,
    'width': "windowSizeX",
    'height': "screenSizeY/2"
  });
};
var move_up = move('0');
var move_down = move("windowTopLeftY+(screenSizeY/2)");
slate.bind("up:" + key_chord, move_up);
slate.bind("down:" + key_chord, move_down);

// Resize to full screen
var fullscreen = slate.operation('move', {
  'x': "screenOriginX",
  'y': "screenOriginY",
  'width': "screenSizeX",
  'height': "screenSizeY"
});
slate.bind("backslash:" + key_chord, fullscreen);

// Undo
slate.bind("z:" + key_chord, slate.operation('undo'));

// Corners
var corner = function(dir) {
  return slate.operation('corner', {
    'direction': dir,
    'width': "screenSizeX/2",
    'height': "screenSizeY/2"
  });
};
var corner_right = slate.operation('chain', {
  'operations': [
    corner("top-right"),
    corner("bottom-right")
  ]
});
var corner_left = slate.operation('chain', {
  'operations': [
    corner("top-left"),
    corner("bottom-left")
  ]
});
slate.bind("]:" + key_chord, corner_right);
slate.bind("[:" + key_chord, corner_left);

// App shortcuts
var focus = function(app) {
  return slate.operation('focus', {'app': app});
};
var chrome = focus("Google Chrome");
var macvim = focus("MacVim");
var iterm = focus("iTerm2");
var hipchat = focus("HipChat");
var finder = focus("Finder");
var preview = focus("Preview");
slate.bind('h:' + key_chord, chrome);
slate.bind('j:' + key_chord, macvim);
slate.bind('k:' + key_chord, iterm);
slate.bind('l:' + key_chord, hipchat);
slate.bind('o:' + key_chord, finder);
slate.bind('p:' + key_chord, preview);
