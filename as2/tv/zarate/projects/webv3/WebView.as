/*
* 
* Copyright (c) 2008, Juan Delgado - Zarate
* 
* Visit http://zarate.tv/proyectos/zcode/ for more info
* 
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
* 
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Lesser General Public License for more details.

* You should have received a copy of the GNU Lesser General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*
*/

import tv.zarate.utils.TextfieldUtils;
import tv.zarate.utils.MovieclipUtils;
import tv.zarate.utils.Delegate;
import tv.zarate.utils.ArrayUtils;
import tv.zarate.utils.StyleSheetObject;

import tv.zarate.effects.Image;

import tv.zarate.application.View;

import tv.zarate.projects.webv3.WebConfig;
import tv.zarate.projects.webv3.WebModel;
import tv.zarate.projects.webv3.Section;
import tv.zarate.projects.webv3.Option;
import tv.zarate.projects.webv3.Language;
import tv.zarate.projects.webv3.Literals;

class tv.zarate.projects.webv3.WebView extends View{
	
	private var model:WebModel;
	private var conf:WebConfig;
	
	private var header_mc:MovieClip;
	private var letters_mc:MovieClip;
	private var explanation_mc:MovieClip;
	private var separator1_mc:MovieClip;
	private var separator2_mc:MovieClip;
	private var footer_mc:MovieClip;
	private var content_mc:MovieClip;
	private var spaceWarning_mc:MovieClip;
	private var warningTextHTML_mc:MovieClip;
	private var warningText_mc:MovieClip;
	private var explanationField:TextField;
	private var contactField:TextField;
	
	private var textFormat:TextFormat;
	private var textCSS:TextField.StyleSheet;
	private var letterWidth:Number;
	private var letterHeight:Number;
	private var totalLetters:Number = 0;
	private var minimumWidth:Number = 900;
	private var minimumHeight:Number = 500;
	private var optionsToRandomize:Array;
	private var MIN_ALPHA:Number = 15;
	private var MED_ALPHA:Number = 65;
	private var MAX_ALPHA:Number = 100;
	private var NICE_COLOR:Number = 0xef7513;
	private var WARNING_PERCENT:Number = 0.8;
	private var FONT_SIZE:Number = 20;
	
	private var enabling:Boolean = false;
	private var disabling:Boolean = false;
	private var sendingEmail:Boolean = false;
	
	private var OVER:String = "rollover";
	private var OUT:String = "rollout";
	private var PRESS:String = "press";
	
	public function WebView(){
		
		super();
		
		textFormat = new TextFormat("ZFONT",FONT_SIZE,0xffffff);
		textFormat.align = "justify";
		
		var p:StyleSheetObject = new StyleSheetObject();
		p.color = "#FFFFFF";
		
		var a:StyleSheetObject = new StyleSheetObject();
		a.color = "#ef7513";
		
		var forceHTML:StyleSheetObject = new StyleSheetObject();
		forceHTML.color = "#ffffff";
		
		a.textDecoration = forceHTML.textDecoration = StyleSheetObject.DECORATION_UNDERLINE;
		p.fontFamily = a.fontFamily = forceHTML.fontFamily = "ZFONT";
		p.fontSize = a.fontSize = forceHTML.fontSize = FONT_SIZE;
		
		textCSS = new TextField.StyleSheet();
		textCSS.setStyle("p",p);
		textCSS.setStyle("a",a);
		textCSS.setStyle(".forceHTML",forceHTML);
		
		Key.addListener(this);
		
	}
	
	// ******************** PRIVATE METHODS ********************
	
	private function initialLayout():Void{
		
		model.currentSection = conf.initialSection;
		
		content_mc = view_mc.createEmptyMovieClip("content_mc",100);
		
		// header with sections first
		var headerNextX:Number = 0;
		var headerFormat:TextFormat = new TextFormat("ZFONT",10,0xffffff);
		
		header_mc.removeMovieClip();
		header_mc = content_mc.createEmptyMovieClip("header_mc",100);
		
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
		separator1_mc = content_mc.createEmptyMovieClip("separator1_mc",200);
		
		// text
		explanation_mc = content_mc.createEmptyMovieClip("explanation_mc",300);
		
		explanationField = TextfieldUtils.createMultiline(explanation_mc,minimumWidth,120);
		explanationField.autoSize = "none";
		explanationField.html = true;
		explanationField.styleSheet = textCSS;
		explanationField.htmlText = "<p>" + model.currentSection.text  + "</p>";
		explanationField.embedFonts = true;
		
		separator2_mc = content_mc.createEmptyMovieClip("separator2_mc",400);
		
		createFooter();
		layout();
		
		manageSection(model.currentSection);
		
	}
	
	private function createLetters():Void{
		
		ArrayUtils.randomizeArray(optionsToRandomize);
		
		letters_mc.removeMovieClip();
		letters_mc = content_mc.createEmptyMovieClip("letters_mc",500);
		
		var nextLetterX:Number = 0;
		var nextLetterY:Number = 0;
		var letterCounter:Number = 0;
		var wordCounter:Number = 0;
		
		for(var i:Number=0;i<optionsToRandomize.length;i++){
			
			var word_mc:MovieClip = letters_mc.createEmptyMovieClip("word_"+wordCounter,100+wordCounter);
			
			var o:Option = optionsToRandomize[i];
			o.clip_mc = word_mc;
			
			word_mc.onPress = Delegate.create(this,manageOption,PRESS,o);
			word_mc.onRollOver = Delegate.create(this,manageOption,OVER,o);
			word_mc.onRollOut = Delegate.create(this,manageOption,OUT,o);
			
			word_mc._alpha = (o.section_id == model.currentSection.section_id)? MED_ALPHA:MIN_ALPHA;
			
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
		
		checkSpace();
		
		var separatorMargin:Number = 15;
		
		header_mc._width = width;
		header_mc._yscale = header_mc._xscale;
		
		separator1_mc.clear();
		MovieclipUtils.DrawSquare(separator1_mc,NICE_COLOR,100,width,1);
		separator1_mc._y = Math.ceil(header_mc._height);
		
		explanation_mc._x = Math.round((width-minimumWidth)/2);
		explanation_mc._y = Math.round(separator1_mc._y + separatorMargin);
		
		separator2_mc.clear();
		MovieclipUtils.DrawSquare(separator2_mc,NICE_COLOR,100,width,1);
		separator2_mc._y = Math.ceil(explanation_mc._y + explanation_mc._height + separatorMargin);
		
		createLetters();
		
		letters_mc._x = explanation_mc._x;
		letters_mc._y = Math.round(separator2_mc._y) + 8;
		
		footer_mc._x = Math.round((width-minimumWidth)/2);
		footer_mc._y = height - footer_mc._height - 10;
		
		if(spaceWarning_mc != null){ centreWarning(); }
		
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
	
	private function manageOption(action:String,option:Option):Void{
		
		var to:Number = (action == OVER)? MAX_ALPHA:MED_ALPHA;
		
		Image.Fade(option.clip_mc,to);
		
		if(action == PRESS){
			
			showExplanation(true,option.title,option.text,option.link);
			
		}
		
	}
	
	private function showExplanation(action:Boolean,title:String,text:String,link:String):Void{
		explanationField.htmlText = "<p>" + text + "</p>";
	}
	
	private function createFooter():Void{
		
		footer_mc = content_mc.createEmptyMovieClip("footer_mc",600);
		
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
		
		var contactFieldBg_mc:MovieClip = footer_mc.createEmptyMovieClip("contactFieldBg_mc",150);
		contactFieldBg_mc._alpha = 0;
		
		var contact_mc:MovieClip = footer_mc.createEmptyMovieClip("contact_mc",200);
		
		contactField = TextfieldUtils.createInputField(contact_mc,minimumWidth-languages_mc._width - 10,33);
		contactField.text = conf.literals.getLiteral(Literals.WANT_TO_SEND_EMAIL);
		contactField.embedFonts = true;
		contactField.maxChars = 400;
		contactField.setTextFormat(textFormat);
		contactField.setNewTextFormat(textFormat);
		
		contactField.onSetFocus = Delegate.create(this,checkSendField,true,null,contactFieldBg_mc);
		contactField.onKillFocus = Delegate.create(this,checkSendField,false,contactField.text,contactFieldBg_mc);
		
		var leftLimit_mc:MovieClip = contactFieldBg_mc.createEmptyMovieClip("leftLimit_mc",100);
		MovieclipUtils.DrawSquare(leftLimit_mc,NICE_COLOR,100,1,contactField._height);
		
		var rightLimit_mc:MovieClip = contactFieldBg_mc.createEmptyMovieClip("rightLimit_mc",200);
		MovieclipUtils.DrawSquare(rightLimit_mc,NICE_COLOR,100,1,contactField._height);
		
		rightLimit_mc._x = contactField._width;
		
	}
	
	private function checkSendField(obj:Object,hasFocus:Boolean,txt:String,bg_mc:MovieClip):Void{
		
		var to:Number = (hasFocus)? 100:0;
		Image.Fade(bg_mc,to,null,6)
		
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
	
	private function checkSpace():Void{
		
		var enable:Boolean = true;
		
		if(width < minimumWidth || height < minimumHeight){
			
			enable = false;
			
			if(!disabling){
				
				disabling = true;
				enabling = false;
				
				Image.Fade(content_mc,0);
				showSpaceWarning(true);
				
			}
			
		} else {
			
			if(!enabling){
				
				enabling = true;
				disabling = false;
				
				Image.Fade(content_mc,100);
				showSpaceWarning(false);
				
			}
			
		}
		
		content_mc.tabChildren = content_mc.enabled = enable;
		
	}
	
	private function showSpaceWarning(action:Boolean):Void{
		
		if(action){
			
			spaceWarning_mc = view_mc.createEmptyMovieClip("spaceWarning_mc",200);
			spaceWarning_mc._alpha = 0;
			
			var bg_mc:MovieClip = spaceWarning_mc.createEmptyMovieClip("bg_mc",100);
			
			bg_mc.useHandCursor = bg_mc.tabEnabled = false;
			bg_mc.onPress = function():Void{}; // good ol' blocker
			
			warningText_mc = spaceWarning_mc.createEmptyMovieClip("warningText_mc",200);
			
			var field:TextField = TextfieldUtils.createField(warningText_mc);
			field.text = conf.literals.getLiteral(Literals.SPACE_WARNING);
			field.selectable = false;
			field.embedFonts = true;
			field.setTextFormat(textFormat);
			
			warningTextHTML_mc = spaceWarning_mc.createEmptyMovieClip("warningTextHTML_mc",300);
			
			field = TextfieldUtils.createField(warningTextHTML_mc);
			field.html = true;
			field.styleSheet = textCSS;
			field.htmlText = "<p>" + conf.literals.getLiteral(Literals.SPACE_WARNING_HTML) + "</p>";
			field.selectable = false;
			field.embedFonts = true;
			
			warningTextHTML_mc.onPress = Delegate.create(model,model.forceHTMLVersion);
			
			centreWarning();
			
			Image.Fade(spaceWarning_mc,100);
			
		} else {
			
			spaceWarning_mc.removeMovieClip();
			spaceWarning_mc = null;
			
		}
		
	}
	
	private function centreWarning():Void{
		
		spaceWarning_mc.bg_mc.clear();
		MovieclipUtils.DrawSquare(spaceWarning_mc.bg_mc,0xff0000,100,width,height);
		
		warningText_mc._width = width * WARNING_PERCENT;
		warningText_mc._yscale = warningText_mc._xscale;
		
		warningText_mc._x = Math.round((width-warningText_mc._width)/2);
		warningText_mc._y = Math.round((height-warningText_mc._height)/2);
		
		warningTextHTML_mc._width = warningText_mc._width * 0.4;
		warningTextHTML_mc._yscale = warningTextHTML_mc._xscale;
		
		warningTextHTML_mc._x = Math.round((width-warningTextHTML_mc._width)/2);
		warningTextHTML_mc._y = Math.round(warningText_mc._y + warningText_mc._height);
		
	}
	
}