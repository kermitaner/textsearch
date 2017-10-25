Red [
	Author: "Oliver Sapauschke"
	Date: 21-10-2017
	Description: {rekursive text search in text files with gui}
	Last-update: 21-10-2017
	Uses: %myfunc.red %textsearch.cfg
  File:   %textsearch.red
  Needs: 'view
]
_dbg: false ;; set to true to show console / errors
#include %myfunc.red

hits: 0
idir: ieditor: "" 
gfrule: []  ;; global file parse rule

;; init values from config 
if exists? %textsearch.cfg [
  _get-config %textsearch.cfg [idir ieditor ifilter]
]
;; override invalid entries with default 
unless (exists? to-red-file ieditor) [ieditor: "notepad.exe"]
unless (exists? to-red-file idir) [idir: "c:\"]
unless (value? 'ifilter) [ifilter: "*.r"]

kfound: "  ===>found"

;;---------------------------
getDir: does [
;;---------------------------
d: request-dir
unless d [return 0]
fdir/data: to-local-file d
]
;;----------------------
fsuch: func ["search in text file each line for string"
  fi  [file!]
][
;;----------------------
bfirst: true
foreach line _myread/lines fi [
  if find line ftext/data [
    if bfirst [
       append tl1/data ""
      append tl1/data append to-local-file clean-path ele kfound
      bfirst: false
    ]
    append tl1/data rejoin ["==> " trim line]
    ++ hits
  ]
]

]
;----------------------
suchdir: func ["search directory for files"
  dir
][
;----------------------
change-dir dir
foreach ele read %. [
  either dir? ele [  suchdir clean-path ele  ][
      if parse to-string ele gfrule [ fsuch clean-path ele]
  ]
]
change-dir %..
]
;;----------------------
fstart: func ["Start textsearch"
;;----------------------
       ][
if (empty? form ftext/data) [return 0]
d: to-red-file form fdir/data
unless (dir? d) [print "nee" return 0]
hits: 0
clear tl1/data 
meld/data: "searching..." 
gfrule: _make-rule ffilt/text
suchdir d
either hits > 0 [
 meld/data: reduce [hits " Hits found (Dbl-Click to open editor)"]
][
 meld/data: reduce ["nothing found"]
]

]
;;-------------------------------------
get-file: func ["extract file name from selected line"
;;-------------------------------------
 ][

unless 0 < tl1/selected [return none]
s: tl1/data/(tl1/selected)

all [pos: find  s kfound pos: index? pos ]
unless pos [meld/data: " no file selected!" return none]
f: copy/part s pos - 1
unless (exists?  to-red-file f) [return none]
return f
]
;;-------------------------------------
open-dir: func ["open explorer in directory of selected file"
;;-------------------------------------
][
unless (f: get-file ) [return 0]
d: first split-path to-red-file f   ;; get path only
call/show rejoin ["explorer.exe " to-local-file d]
]
;;-------------------------------------
open-ed: func ["open file in editor"
;;-------------------------------------
][
unless (f: get-file ) [return 0]
call/show  rejoin [ieditor space f ]
]

screen: layout [
title "textsearch"
backdrop silver

style btn: button 60x25 
style fld:  field 250x25 font-size 12 sky
style txt: text 70x25 font-size 12 

btn "Directory" [getdir] pad 7x1 fdir: fld idir 
   txt "file-filter:" pad 40x1 ffilt: fld 100x25  ifilter return 
txt "searchfor:" ftext: fld "asdf" on-enter [fstart]  btn "Search" [fstart  ] 
  pad 50x1 btn "==> Dir" [open-dir] return
tl1: text-list 800x500 data [] font-size 12 beige on-dbl-click [open-ed ] return
meld: text 700x25 font-size 12  bold btn "Quit" [unview quit]
]

view screen