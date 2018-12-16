function lfxmlBodyStart( strAdditionalAttribute ) {
   document.write('<body background="');
   lfxmlFilepath();
   document.write('bg.gif"');
   if(strAdditionalAttribute) document.write(' ' + strAdditionalAttribute);
   document.write('>');
}

function lfxmlBodyEnd() {
   document.write('</body>');
}

function lfxmlFilepath() {
   document.write('.\\stam_1002_files\\');
}

function lfxmlInsertImage( img, alt ) {
   document.write('<img src="');
   lfxmlFilepath();
   document.write(img + '" alt="'+alt+'"/>');
}

function lfxmlInsertHr() {
   document.write('<img src="');
   lfxmlFilepath();
   document.write('Hr.gif" height="2" width="100%"/>');
}