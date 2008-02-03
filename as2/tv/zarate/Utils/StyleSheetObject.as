class tv.zarate.Utils.StyleSheetObject{
	
	// Full reference here:
	// http://livedocs.adobe.com/flash/8/main/00002714.html#wp453576
	//
	// To be used like this:
	// 
	// var p:StyleSheetObject = new StyleSheetObject(); // default values
	//
	// Or
	//
	// var p:StyleSheetObject = new StyleSheetObject("Arial",12,null,StyleSheetObject.WEIGHT_BOLD);
	//
	// Then add to a TextField.StyleSheet object
	// 
	// var css:TextField.StyleSheet = new TextField.StyleSheet();
	// css.setStyle("p",p);
	
	
	public static var STYLE_NORMAL:String = "normal";
	public static var STYLE_ITALIC:String = "italic";
	public static var WEIGHT_NORMAL:String = "normal";
	public static var WEIGHT_BOLD:String = "bold";
	public static var ALIGN_LEFT:String = "left";
	public static var ALIGN_CENTER:String = "center";
	public static var ALIGN_RIGHT:String = "right";
	public static var ALIGN_JUSTIFY:String = "justify";
	public static var DECORATION_NONE:String = "none";
	public static var DECORATION_UNDERLINE:String = "underline";
	public static var DISPLAY_INLINE:String = "inline";
	public static var DISPLAY_BLOCK:String = "block";
	public static var DISPLAY_NONE:String = "none";
	
	public var fontFamily:String = "Verdana";
	public var fontSize:Number = 10;
	public var color:String = "#000000"; // colour MUST be string, css format
	public var fontWeight:String = WEIGHT_NORMAL;
	public var fontStyle:String = STYLE_NORMAL;
	public var textDecoration:String = DECORATION_NONE;
	public var textAlign:String = ALIGN_LEFT;
	public var display:String;
	public var kerning:Boolean; // true, false
	public var letterSpacing:Number; // in pixels, negative values accepted
	public var marginLeft:Number; // in pixels
	public var marginRight:Number; // in pixels
	public var textIndent:Number; // in pixels

	public function StyleSheetObject(_fontFamily:String,_fontSize:Number,_color:String,_fontWeight:String,_fontStyle:String,_textDecoration:String,_textAlign:String){
		
		if(_fontFamily != null){ fontFamily = _fontFamily; }
		if(_fontSize != null){ fontSize = _fontSize; }
		if(_color != null){ color = _color; }
		if(_fontWeight != null){ fontWeight = _fontWeight; }
		if(_fontStyle != null){ fontStyle = _fontStyle; }
		if(_textDecoration != null){ textDecoration = _textDecoration; }
		if(_textAlign != null){ textAlign = _textAlign; }
		
	}

}