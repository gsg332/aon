/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
/*	config.toolbar = [['Source','-','Save','NewPage','Preview','-','Templates'],
			           ['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
			           ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
			           ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],
			           '/',
			           ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
			           ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
			           ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
			           ['Link','Unlink','Anchor'],
			           ['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
			           '/',
			           ['Styles','Format','Font','FontSize'],
			           ['TextColor','BGColor'],
			           ['Maximize', 'ShowBlocks','-','About']];*/
	config.toolbar = [['Source','-','Preview','-','Paste','Image'],
	                  ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','NumberedList','BulletedList','-','Table','-','Link','Unlink'],
	                  ['TextColor','BGColor'],
			          ['Font','FontSize'],
			          ['Bold','Italic','Underline','Strike']
			         ];
	config.removePlugins = 'elementspath';
	config.contentsCss = jcontext.getLocationPath('/resources/css/contents.css');
};
