Red []
unless value? '_dbg [_dbg: true]
unless _dbg [
  console: system/view/screens/1/pane/-1
  console/visible?: false
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


