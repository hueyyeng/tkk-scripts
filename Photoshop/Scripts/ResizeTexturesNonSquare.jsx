#target Photoshop

// Taken from https://stackoverflow.com/questions/17580923/photoshop-javascript-to-resize-image-and-canvas-to-specific-not-square-sizes

// get a reference to the current (active) document and store it in a variable named "doc"
doc = app.activeDocument;  

// change the color mode to RGB.  Important for resizing GIFs with indexed colors, to get better results
doc.changeMode(ChangeMode.RGB);  

// these are our values for the END RESULT width and height (in pixels) of our image
// TODO: Create popup dialog for input?
var fWidth = 1024;
var fHeight = 512;

// do the resizing.  if height > width (portrait-mode) resize based on height.  otherwise, resize based on width
if (doc.height > doc.width) {
    doc.resizeImage(null,UnitValue(fHeight,"px"),null,ResampleMethod.BICUBIC);
}
else {
    doc.resizeImage(UnitValue(fWidth,"px"),null,null,ResampleMethod.BICUBIC);
}

// Makes the default background white
var white = new SolidColor(); 
white.rgb.hexValue = "FFFFFF";
app.backgroundColor = white;

// Convert the canvas size as informed above for the END RESULT
app.activeDocument.resizeCanvas(UnitValue(fWidth,"px"),UnitValue(fHeight,"px"));

// our web export options
var options = new ExportOptionsSaveForWeb();
options.quality = 70;
options.format = SaveDocumentType.JPEG;
options.optimized = true;

var newName = 'web-'+doc.name+'.jpg';

doc.exportDocument(File(doc.path+'/'+newName),ExportType.SAVEFORWEB,options);
