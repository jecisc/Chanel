"
Description
--------------------

I am an abstract cleaner for cleanings using Pharo's parse tree rewriter to update the contents of some methods.

Public API and Key Messages
--------------------

- #
- #
- #

Examples
--------------------

	
 
Internal Representation and Key Implementation Points.
--------------------

"
Class {
	#name : #ChanelMethodRewriterCleaner,
	#superclass : #ChanelAbstractCleaner,
	#category : #Chanel
}

{ #category : #testing }
ChanelMethodRewriterCleaner class >> isAbstract [
	^ self = ChanelMethodRewriterCleaner
]

{ #category : #cleaning }
ChanelMethodRewriterCleaner >> clean [
	| rewriter |
	rewriter := self rewriter.
	(self scope flatCollect: [ :class | class localMethods , class class localMethods ])
		do: [ :method | (rewriter executeTree: method ast) ifTrue: [ method installAST ] ]
]

{ #category : #cleaning }
ChanelMethodRewriterCleaner >> rewriter [
	"Return the rewriter to use to clean the methods."
	
	^ self subclassResponsibility
]

{ #category : #cleaning }
ChanelMethodRewriterCleaner >> scope [
	"Return all the classes whose methods needs to be cleaned. By default, all of them."

	^ self configuration definedClasses
]
