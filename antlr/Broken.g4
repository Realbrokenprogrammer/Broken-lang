/**
 * MIT License
 *
 * Copyright (c) 2017 TeamBreak
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
 
grammar Broken;

// Starting point for parsing a broken file.
compilationUnit :
	packageDeclaration? importDeclaration* typeDeclaration* EOF
	;

packageDeclaration :
	annotaion* 'package' qualifiedName ';'
	;

importDeclaration :
	'import' 'static'? qualifiedName ('.' '*')? ';'
	;

typeDeclaration :
	classOrInterfaceModifier* classDeclaration
	| classOrInterfaceModifier* enumDeclaration
	| classOrInterfaceModifier* interfaceDeclaration
	| classOrInterfaceModifier* annotationTypeDeclaration
	| ';'
	;
	
// modifier.

//TODO: Make classOrInterfaceModifier optional and add public if not specified.
classOrInterfaceModifier :
	annotation
	| ( 'public'		
	  | 'protected'
	  | 'private'
	  | 'static'
	  | 'abstract'
	  | 'final'			// Not applicable on interfaces.
	  | 'strictfp'
	  )
	;

// variable modifier.

classDeclaration :
	'class' Identifier typeParameters?
	('extends' typeType)?
	('implements' typeList)?
	classBody
	;

typeParameters :
	'<' typeParameter (',' typeParameter)* '>'
	;

typeParameter :
	Identifier ('extends' typeBound)?
	;

typeBound :
	typeType ('&' typeType)*
	;

enumDeclaration :
	ENUM Identifier ('implements' typeList)?
	'{' enumConstants? ','? enumBodyDeclarations? '}'
	;

enumConstants :
	enumConstant (',' enumConstant)*
	;

enumConstant :
	annotation* Identifier arguments? classBody?
	;

enumBodyDeclarations :
	';' classBodyDeclaration*
	;

typeType :
	classOrInterfaceType ('[' ']')*
	| primitiveType ('[' ']')*
	;

primitiveType :
	'boolean'
	| 'char'
	| 'byte'
	| 'short'
	| 'int'
	| 'long'
	| 'float'
	| 'double'
	;

qualifiedName :
	Identifier ('.' Identifier)*
	;