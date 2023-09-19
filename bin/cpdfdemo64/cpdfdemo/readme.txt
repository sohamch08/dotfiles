INSTALLING COMMAND LINE TOOLS

The executable 'cpdf' should be copied to a location somewhere on your path. It
can then be used from the command prompt.  (You can see your path by typing echo
$PATH at the command prompt).


LINEARIZATION

If you wish to use linearization, you must also install the executable and
dynamic library in the 'linearize' folder. Either

a) Put cpdflin in /usr/local/bin, or somewhere else on your path, and put
libqpdf.so.13 in /usr/local/lib, or

b) Put them somewhere else, and use -cpdflin to direct cpdf to find it in
another location. See section 1.11 of the manual for full details.

cpdflin also depends upon libpcre and libz, though they are often already
installed on your system. If not, they can be found through your package
manager. In case of problems, email contact@coherentgraphics.co.uk
