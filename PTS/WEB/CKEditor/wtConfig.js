/*
Copyright (c) 2003-2009, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
config.skin = 'office2003';
config.toolbar = 'editor';
config.toolbarCanCollapse = false;

config.filebrowserBrowseUrl =      'include/CKBrowseImage.html';
config.filebrowserImageBrowseUrl = 'include/CKBrowseImage.html';
config.filebrowserUploadUrl =      '';  

config.toolbar_editor =
[
    ['Cut','Copy','Paste','PasteText','-','SpellChecker', 'Scayt'],
    ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
    ['Link','Unlink','Anchor'],
    ['Maximize','-','Source'],
    '/',
    ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
    ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
    ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
    ['Image','Table','HorizontalRule','Smiley','SpecialChar'],
    '/',
    ['Styles','Format','Font','FontSize'],
    ['TextColor','BGColor'],
    ['ShowBlocks','-','About']
];

config.toolbar_simple =
[
    ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
    ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
    ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
    ['Image','HorizontalRule'],
    ['Source'],
    '/',
    ['Styles','Format','Font','FontSize'],
    ['TextColor','BGColor'],
    ['ShowBlocks','-','About']
];

config.toolbar_basic =
[
    ['Bold', 'Italic', 'Underline', '-', 'TextColor'],
    '/',
    ['Font', 'FontSize']
];

};
