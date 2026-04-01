
mkdir -p ~/.config/micro/colorschemes

cat <<EOF > ~/.config/micro/settings.json
{
  "colorscheme": "my",
  "wordwrap": true,
  "tabsize": 2,
  "tabstospaces": true
}
EOF


cat <<EOF > ~/.config/micro/bindings.json
{
  "Tab": "IndentSelection",
  "Ctrl-o": "StartOfLine",
  "Ctrl-p": "StartOfText",
  "Ctrl-c": "Copy",
  "Ctrl-v": "Paste",
  "Ctrl-l": "SelectLine",
  "Ctrl-x": "Save,Quit",
  "Ctrl-Z": "Redo",
  "\u001b[122;6u": "Redo",
  "Ctrl-z": "Undo",
  "Backspace": "Backspace",
  "OldBackspace": "DeleteWordLeft",
  "Ctrl-Left": "WordLeft",
  "Ctrl-Right": "WordRight",
  "CtrlShiftLeft": "SelectWordLeft",
  "CtrlShiftRight": "SelectWordRight",
}
EOF

cat <<EOF > ~/.config/micro/colorschemes/my-theme.micro
color-link default "#ffffff,#00000000"
color-link comment "#75715E"
color-link identifier "#66D9EF"
color-link constant "#AE81FF"
color-link constant.string "#E6DB74"
color-link constant.string.char "#BDE6AD"
color-link statement "#F92672"
color-link preproc "#CB4B16"
color-link type "#66D9EF"
color-link special "#A6E22E"
color-link underlined "#D33682"
color-link error "bold #CB4B16"
color-link todo "bold #D33682"
color-link statusline "#282828,#F8F8F2"
color-link indent-char "#505050,#282828"
color-link line-number "#505050,#000000"
color-link current-line-number "#AAAAAA,#282828"
color-link gutter-error "#CB4B16"
color-link gutter-warning "#E6DB74"
color-link cursor-line "#202020"
color-link color-column "#323232"
EOF

echo "Finished, ~/.config/micro/ :"
ls ~/.config/micro/
