# textsearch
rekursive textsearch in RED, lists matching lines, opens file in editor, opens directory, with GUI

needs to be run interpreted with Red.exe (download latest version from www.red-lang.org ) "red.exe textsearch.red"

or compile to exe : "red.exe -c -t windows textsearch.red"

runs on windows / mac (not tested) / linux - under wine ( not tested )

after writing lots of scripts i often had the problem to locate scripts i've done before  ...
often the naming of short testscripts ( t1.red , t2.red,... ) isn't really helpful :- )

this little program helps to find text files (programs) containing the string you are searching. open it in editor ( specify path in config file)
with a double click or open containing folder ( button ) 
specify starting directory for your files in config file. Search is done recursive.

Text files should be in latin encoding ( will be converted to utf-8 for processing after reading )
