Red []
unless value? '_dbg [_dbg: true]
unless _dbg [
  console: system/view/screens/1/pane/-1
  if console [console/visible?: false]
]
++: func ['a][ set (get-word! a) 1 + get a ]
--: func ['a][ set (get-word! a) -1 + get a]

;------------------------------
_get-config: func ["set word to corresponding value in config file"
;------------------------------
  fi [file!] 
  blk [block!]
][
foreach line read/lines fi [
  if #";" = first head line  [continue]
  unless (arr:  split line "=") [continue]
  foreach ele blk [
        if (form ele) = ( trim  arr/1)  [set ele trim arr/2
        ]
  ]

]

]
;;---------------------------------
_myread: func ["convert latin to utf-8 "
;;---------------------------------
  fi [file!]
   /lines ;; return as array
][
s: copy ""
foreach b read/binary fi [  append s to-char b]

if lines [return split s newline]
return s 
]

;;-----------------------------
_make-rule: func ["converts file mask with * and ? to parse rule" 
;;-----------------------------
  str [string!] "file mask as string"
  /local start ind len pos rule rule2
][
start: 1
rule: copy []
;; find each '*'
while [pos: find at str start "*" ][
  ind: index? pos   ;; index of '*'
  len: ind - start  ;; length of string before '*'
  if ind > 1 [        ;; exists string before '*' ?
    append rule copy/part skip str (start - 1) len
  ]
  either ind = length? str [  ;; '*' is at end of string ??
    append rule reduce ['to 'end] 
  ][
    append rule 'thru     ;; otherwise append 'thru
  ]
  if pos [start: 1 + index? pos ] ;; set next search start position
]
;; append last string if not at end ...
if start <= length? str  [append rule  copy skip str (start - 1)]
rule2: copy []

collect/into [
  foreach ele rule [
    if word! = type? ele [keep ele continue]
    start: 1
    while [pos: find at ele start "?" ][
        ind: index? pos   ;; index of '?'
        len: ind - start  ;; length of string before '?'
        ;; exists string before '?' ?
        if ind > 1 [ keep copy/part skip ele (start - 1) len  ]
        keep 'skip ;; replace '?' with skip 
        if pos [start: 1 + index? pos ] ;; set next  start position for search
    ]
    if start <= length? ele  [keep copy skip ele (start - 1)]
  ]
] rule2 ;; collect into 
return  rule2
]



