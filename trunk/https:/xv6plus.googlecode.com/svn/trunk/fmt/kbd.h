7150 // PC keyboard interface constants
7151 
7152 #define KBSTATP         0x64    // kbd controller status port(I)
7153 #define KBS_DIB         0x01    // kbd data in buffer
7154 #define KBDATAP         0x60    // kbd data port(I)
7155 
7156 #define NO              0
7157 
7158 #define SHIFT           (1<<0)
7159 #define CTL             (1<<1)
7160 #define ALT             (1<<2)
7161 
7162 #define CAPSLOCK        (1<<3)
7163 #define NUMLOCK         (1<<4)
7164 #define SCROLLLOCK      (1<<5)
7165 
7166 #define E0ESC           (1<<6)
7167 
7168 // Special keycodes
7169 #define KEY_HOME        0xE0
7170 #define KEY_END         0xE1
7171 #define KEY_UP          0xE2
7172 #define KEY_DN          0xE3
7173 #define KEY_LF          0xE4
7174 #define KEY_RT          0xE5
7175 #define KEY_PGUP        0xE6
7176 #define KEY_PGDN        0xE7
7177 #define KEY_INS         0xE8
7178 #define KEY_DEL         0xE9
7179 
7180 // C('A') == Control-A
7181 #define C(x) (x - '@')
7182 
7183 static uchar shiftcode[256] =
7184 {
7185   [0x1D] CTL,
7186   [0x2A] SHIFT,
7187   [0x36] SHIFT,
7188   [0x38] ALT,
7189   [0x9D] CTL,
7190   [0xB8] ALT
7191 };
7192 
7193 static uchar togglecode[256] =
7194 {
7195   [0x3A] CAPSLOCK,
7196   [0x45] NUMLOCK,
7197   [0x46] SCROLLLOCK
7198 };
7199 
7200 static uchar normalmap[256] =
7201 {
7202   NO,   0x1B, '1',  '2',  '3',  '4',  '5',  '6',  // 0x00
7203   '7',  '8',  '9',  '0',  '-',  '=',  '\b', '\t',
7204   'q',  'w',  'e',  'r',  't',  'y',  'u',  'i',  // 0x10
7205   'o',  'p',  '[',  ']',  '\n', NO,   'a',  's',
7206   'd',  'f',  'g',  'h',  'j',  'k',  'l',  ';',  // 0x20
7207   '\'', '`',  NO,   '\\', 'z',  'x',  'c',  'v',
7208   'b',  'n',  'm',  ',',  '.',  '/',  NO,   '*',  // 0x30
7209   NO,   ' ',  NO,   NO,   NO,   NO,   NO,   NO,
7210   NO,   NO,   NO,   NO,   NO,   NO,   NO,   '7',  // 0x40
7211   '8',  '9',  '-',  '4',  '5',  '6',  '+',  '1',
7212   '2',  '3',  '0',  '.',  NO,   NO,   NO,   NO,   // 0x50
7213   [0x9C] '\n',      // KP_Enter
7214   [0xB5] '/',       // KP_Div
7215   [0xC8] KEY_UP,    [0xD0] KEY_DN,
7216   [0xC9] KEY_PGUP,  [0xD1] KEY_PGDN,
7217   [0xCB] KEY_LF,    [0xCD] KEY_RT,
7218   [0x97] KEY_HOME,  [0xCF] KEY_END,
7219   [0xD2] KEY_INS,   [0xD3] KEY_DEL
7220 };
7221 
7222 static uchar shiftmap[256] =
7223 {
7224   NO,   033,  '!',  '@',  '#',  '$',  '%',  '^',  // 0x00
7225   '&',  '*',  '(',  ')',  '_',  '+',  '\b', '\t',
7226   'Q',  'W',  'E',  'R',  'T',  'Y',  'U',  'I',  // 0x10
7227   'O',  'P',  '{',  '}',  '\n', NO,   'A',  'S',
7228   'D',  'F',  'G',  'H',  'J',  'K',  'L',  ':',  // 0x20
7229   '"',  '~',  NO,   '|',  'Z',  'X',  'C',  'V',
7230   'B',  'N',  'M',  '<',  '>',  '?',  NO,   '*',  // 0x30
7231   NO,   ' ',  NO,   NO,   NO,   NO,   NO,   NO,
7232   NO,   NO,   NO,   NO,   NO,   NO,   NO,   '7',  // 0x40
7233   '8',  '9',  '-',  '4',  '5',  '6',  '+',  '1',
7234   '2',  '3',  '0',  '.',  NO,   NO,   NO,   NO,   // 0x50
7235   [0x9C] '\n',      // KP_Enter
7236   [0xB5] '/',       // KP_Div
7237   [0xC8] KEY_UP,    [0xD0] KEY_DN,
7238   [0xC9] KEY_PGUP,  [0xD1] KEY_PGDN,
7239   [0xCB] KEY_LF,    [0xCD] KEY_RT,
7240   [0x97] KEY_HOME,  [0xCF] KEY_END,
7241   [0xD2] KEY_INS,   [0xD3] KEY_DEL
7242 };
7243 
7244 
7245 
7246 
7247 
7248 
7249 
7250 static uchar ctlmap[256] =
7251 {
7252   NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
7253   NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
7254   C('Q'),  C('W'),  C('E'),  C('R'),  C('T'),  C('Y'),  C('U'),  C('I'),
7255   C('O'),  C('P'),  NO,      NO,      '\r',    NO,      C('A'),  C('S'),
7256   C('D'),  C('F'),  C('G'),  C('H'),  C('J'),  C('K'),  C('L'),  NO,
7257   NO,      NO,      NO,      C('\\'), C('Z'),  C('X'),  C('C'),  C('V'),
7258   C('B'),  C('N'),  C('M'),  NO,      NO,      C('/'),  NO,      NO,
7259   [0x9C] '\r',      // KP_Enter
7260   [0xB5] C('/'),    // KP_Div
7261   [0xC8] KEY_UP,    [0xD0] KEY_DN,
7262   [0xC9] KEY_PGUP,  [0xD1] KEY_PGDN,
7263   [0xCB] KEY_LF,    [0xCD] KEY_RT,
7264   [0x97] KEY_HOME,  [0xCF] KEY_END,
7265   [0xD2] KEY_INS,   [0xD3] KEY_DEL
7266 };
7267 
7268 
7269 
7270 
7271 
7272 
7273 
7274 
7275 
7276 
7277 
7278 
7279 
7280 
7281 
7282 
7283 
7284 
7285 
7286 
7287 
7288 
7289 
7290 
7291 
7292 
7293 
7294 
7295 
7296 
7297 
7298 
7299 
