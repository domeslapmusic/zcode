import tv.zarate.Utils.TextfieldUtils;
import tv.zarate.Utils.MovieclipUtils;
import tv.zarate.Utils.Delegate;
import tv.zarate.Utils.ArrayUtils;
import tv.zarate.Utils.StyleSheetObject;

import tv.zarate.effects.Image;

import tv.zarate.Application.View;

import tv.zarate.Projects.webv3.WebConfig;
import tv.zarate.Projects.webv3.WebModel;
import tv.zarate.Projects.webv3.Section;
import tv.zarate.Projects.webv3.Option;
import tv.zarate.Projects.webv3.Language;
import tv.zarate.Projects.webv3.Literals;

class tv.zarate.Projects.webv3.WebView extends View{
	
	private var model:WebModel;
	private var conf:WebConfig;
	
	private var header_mc:MovieClip;
	private var letters_mc:MovieClip;
	private var blocker_mc:MovieClip;
	private var explanation_mc:MovieClip;
	private var separator1_mc:MovieClip;
	private var separator2_mc:MovieClip;
	private var footer_mc:MovieClip;
	private var explanationField:TextField;
	private var contactField:TextField;
	
	private var textFormat:TextFormat;
	private var textCSS:TextField.StyleSheet;
	private var letterWidth:Number;
	private var letterHeight:Number;
	private var totalLetters:Number = 0;
	private var minimumWidth:Number = 1000;
	private var minimumHeight:Number = 500;
	private var optionsToRandomize:Array;
	private var MIN_ALPHA:Number = 25;
	private var MAX_ALPHA:Number = 100;
	//private var disabling:Boolean = false;
	private var sendingEmail:Boolean = false;
	
	public function WebView(){
		
		super();
		
		textFormat = new TextFormat("ZFONT",20,0xffffff);
		textFormat.align = "justify";
		
		var p:StyleSheetObject = new StyleSheetObject();
		p.color = "#FFFFFF";
		
		var a:StyleSheetObject = new StyleSheetObject();
		a.color = "#FFFF00";
		a.textDecoration = StyleSheetObject.DECORATION_UNDERLINE;
		
		p.fontFamily = a.fontFamily = "ZFONT";
		p.fontSize = a.fontSize = 20;
		
		textCSS = new TextField.StyleSheet();
		textCSS.setStyle("p",p);
		textCSS.setStyle("a",a);
		
		Key.addListener(this);
		
	}
	
	public function setSize(w:Number,h:Number):Void{
		
		if(w < minimumWidth || h < minimumHeight){
			
			disable();
			
		} else {
			
			enable();
			
		}
		
		super.setSize(w,h);
		
	}
	
	public function enable():Void{
		
		super.enable();
		
		//Image.Blur(view_mc,0);
		/*
		disabling = false;
		view_mc.filters = new Array();
		*/
		//blocker_mc._visible = false;
		
		view_mc._alpha = MIN_ALPHA;
		
	}
	
	public function disable():Void{
		
		super.disable();
		/*
		if(!disabling){
			
			disabling = true;
			Image.Blur(view_mc,10);
			
		}
		*/
		
		/*
		blocker_mc._visible = true;
		
		blocker_mc.clear();
		MovieclipUtils.DrawSquare(blocker_mc,0xff00ff,100,width,height);
		*/
		
		view_mc._alpha = MAX_ALPHA;
		
	}
	
	// ******************** PRIVATE METHODS ********************
	
	private function initialLayout():Void{
		
		model.currentSection = conf.initialSection;
		
		// blocker
		blocker_mc = view_mc.createEmptyMovieClip("blocker_mc",5000);
		
		// header with sections first
		var headerNextX:Number = 0;
		var headerFormat:TextFormat = new TextFormat("ZFONT",10,0xffffff);
		
		header_mc.removeMovieClip();
		header_mc = view_mc.createEmptyMovieClip("header_mc",100);
		
		optionsToRandomize = new Array();
		
		for(var x:Number=0;x<conf.sections.length;x++){
			
			var section_mc:MovieClip = header_mc.createEmptyMovieClip("section_"+x,100+x);
			
			var s:Section = conf.sections[x];
			s.clip_mc = section_mc;
			
			var field:TextField = TextfieldUtils.createField(section_mc);
			field.embedFonts = true;
			field.text = s.title.toUpperCase();
			field.setTextFormat(headerFormat);
			
			section_mc._x = headerNextX;
			headerNextX += section_mc._width;
			
			totalLetters += s.totalLetters;
			
			section_mc.onRollOver = Delegate.create(this,manageSection,s);
			
			for(var i:Number=0;i<s.options.length;i++){
				
				var o:Option = s.options[i];
				optionsToRandomize.push(o);
				
			}
			
		}
		
		// separator 1
		separator1_mc = view_mc.createEmptyMovieClip("separator1_mc",200);
		
		// text
		explanation_mc = view_mc.createEmptyMovieClip("explanation_mc",300);
		
		explanationField = TextfieldUtils.createMultiline(explanation_mc,minimumWidth,100);
		explanationField.autoSize = "none";
		explanationField.html = true;
		explanationField.styleSheet = textCSS;
		explanationField.htmlText = "<p>" + model.currentSection.text  + "</p>";
		explanationField.embedFonts = true;
		
		separator2_mc = view_mc.createEmptyMovieClip("separator2_mc",400);
		
		textFormat.size = 23;
		
		createFooter();
		
		layout();
		
		manageSection(model.currentSection);
		
	}
	
	private function createLetters():Void{
		
		ArrayUtils.randomizeArray(optionsToRandomize);
		
		letters_mc.removeMovieClip();
		letters_mc = view_mc.createEmptyMovieClip("letters_mc",500);
		
		var nextLetterX:Number = 0;
		var nextLetterY:Number = 0;
		var letterCounter:Number = 0;
		var wordCounter:Number = 0;
		
		for(var i:Number=0;i<optionsToRandomize.length;i++){
			
			var word_mc:MovieClip = letters_mc.createEmptyMovieClip("word_"+wordCounter,100+wordCounter);
			
			var o:Option = optionsToRandomize[i];
			o.clip_mc = word_mc;
			
			word_mc.onRollOver = Delegate.create(this,manageOption,o);
			word_mc._alpha = (o.section_id == model.currentSection.section_id)? MAX_ALPHA:MIN_ALPHA;
			
			for(var j:Number=0;j<o.title.length;j++){
				
				var letter:String = o.title.charAt(j);
				
				if(letter == " "){ continue; }
				
				var letter_mc:MovieClip = word_mc.createEmptyMovieClip("letter_"+letterCounter,100+letterCounter);
				
				var bg_mc:MovieClip = letter_mc.createEmptyMovieClip("bg_mc",50);
				
				var field:TextField = TextfieldUtils.createField(letter_mc);
				field.embedFonts = true;
				field.text = letter.toUpperCase();
				field.setTextFormat(textFormat);
				
				MovieclipUtils.DrawSquare(bg_mc,0x0000ff,0,letter_mc._width,letter_mc._height);
				
				letter_mc._x = nextLetterX;
				letter_mc._y = nextLetterY;
				
				if(letter_mc._x + letter_mc._width > minimumWidth){
					
					var t:Number = letter_mc._height;
					
					nextLetterX = 0;
					nextLetterY += letter_mc._height;
					
					letter_mc._x = nextLetterX;
					letter_mc._y = nextLetterY;
					
					nextLetterX += letter_mc._width;
					
				} else {
					
					nextLetterX += letter_mc._width;
					
				}
				
				letterCounter++;
				
			}
			
			nextLetterX += 20;
			wordCounter++;
			
		}
		
	}
	
	private function layout():Void{
		
		header_mc._width = width;
		header_mc._yscale = header_mc._xscale;
		
		separator1_mc.clear();
		MovieclipUtils.DrawSquare(separator1_mc,0xffffff,100,width,1);
		separator1_mc._y = Math.ceil(header_mc._height);
		
		explanation_mc._x = Math.round((width-minimumWidth)/2);
		explanation_mc._y = Math.round(separator1_mc._y + 10);
		
		separator2_mc.clear();
		MovieclipUtils.DrawSquare(separator2_mc,0xffffff,100,width,1);
		separator2_mc._y = Math.ceil(explanation_mc._y + explanation_mc._height + 10);
		
		createLetters();
		
		letters_mc._x = explanation_mc._x;
		letters_mc._y = Math.round(separator2_mc._y) + 8;
		
		footer_mc._x = Math.round((width-minimumWidth)/2);
		footer_mc._y = height - footer_mc._height;
		
	}
	
	private function manageSection(section:Section):Void{
		
		model.currentSection = section;
		model.updateTitle(section.title);
		
		for(var x:Number=0;x<conf.sections.length;x++){
			
			var s:Section = conf.sections[x];
			
			var to:Number = (s == section)? MAX_ALPHA:MIN_ALPHA;
			var enable:Boolean = (s == section)? true:false;
			
			Image.Fade(s.clip_mc,to);
			
			for(var i:Number=0;i<s.options.length;i++){
				
				var o:Option = s.options[i];
				Image.Fade(o.clip_mc,to);
				o.clip_mc.enabled = enable;
				
			}
			
		}
		
		showExplanation(true,section.title,section.text);
		
	}
	
	private function manageOption(option:Option):Void{
		
		//Image.Fade(option.clip_mc,100);
		showExplanation(true,option.title,option.text,option.link);
		
	}
	
	private function showExplanation(action:Boolean,title:String,text:String,link:String):Void{
		explanationField.htmlText = "<p>" + text + "</p>";
	}
	
	private function createFooter():Void{
		
		footer_mc = view_mc.createEmptyMovieClip("footer_mc",600);
		
		// languages
		var languages_mc:MovieClip = footer_mc.createEmptyMovieClip("languages_mc",100);
		var nextLanguageX:Number = 0;
		
		for(var x:Number=0;x<conf.languages.length;x++){
			
			var l:Language = conf.languages[x];
			
			var language_mc:MovieClip = languages_mc.createEmptyMovieClip("language_"+x,100+x);
			
			var field:TextField = TextfieldUtils.createField(language_mc);
			field.text = l.title.toUpperCase();
			field.embedFonts = true;
			field.setTextFormat(textFormat);
			
			if(!l.selected){
				
				language_mc.onPress = Delegate.create(this,languageSelected,l.language_id);
				
			} else {
				
				language_mc._alpha = MIN_ALPHA;
				
			}
			
			language_mc._x = nextLanguageX;
			nextLanguageX += language_mc._width;
			
		}
		
		languages_mc._x = minimumWidth - languages_mc._width;
		
		// contact
		var contact_mc:MovieClip = footer_mc.createEmptyMovieClip("contact_mc",200);
		
		contactField = TextfieldUtils.createInputField(contact_mc,minimumWidth-languages_mc._width,40);
		contactField.text = conf.literals.getLiteral(Literals.WANT_TO_SEND_EMAIL);
		contactField.embedFonts = true;
		contactField.setTextFormat(textFormat);
		contactField.setNewTextFormat(textFormat);
		
		contactField.onSetFocus = Delegate.create(this,checkSendField,true);
		contactField.onKillFocus = Delegate.create(this,checkSendField,false,contactField.text);
		
	}
	
	private function checkSendField(obj:Object,hasFocus:Boolean,txt:String):Void{
		contactField.text = (hasFocus)? "":txt;
	}
	
	private function onKeyDown():Void{
		
		if(Key.isDown(Key.ENTER) && !sendingEmail && contactField.text != "" && contactField.text != " "){
			
			if(MovieclipUtils.getFocusObject() == contactField){
				
				sendingEmail = true;
				
				var callback:Function = Delegate.create(this,sendEmailCallback);
				
				var currentText:String = contactField.text;
				
				contactField.text = conf.literals.getLiteral(Literals.SENDING_EMAIL);
				model.sendMail(currentText,callback);
				
			}
			
		}
		
	}
	
	private function sendEmailCallback(success:Boolean):Void{
		
		var txt:String = (success)? conf.literals.getLiteral(Literals.MAIL_SENT_OK):conf.literals.getLiteral(Literals.MAIL_SENT_PROBLEM);
		contactField.text = txt;
		
		sendingEmail = false;
		
	}
	
	private function languageSelected(language_id:String):Void{
		
		disable();
		model.changeLanguage(language_id);
		
	}
	
}