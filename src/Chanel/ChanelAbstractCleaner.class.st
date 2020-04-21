"
Description
--------------------

I am an abstract class to define the basice behavior of a cleaner. 

Each of my subclasses represents a kind of cleaning to apply on the project to clean.

I am configured with an instance of Chanel to get the elements to clean.

You can find the full list of cleaners running `ChanelAbstractCleaner cleaners`.

Public API and Key Messages
--------------------

- #clean 		Method executed to launch the specific cleaning of a cleaner.
	 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	configuration:		<aChanel>		An instance of Chanel representing the configuration of the cleaning.

"
Class {
	#name : #ChanelAbstractCleaner,
	#superclass : #Object,
	#instVars : [
		'configuration'
	],
	#category : #Chanel
}

{ #category : #'instance creation' }
ChanelAbstractCleaner class >> cleaners [
	^ (self allSubclasses reject: #isAbstract) sort: #priority ascending
]

{ #category : #accessing }
ChanelAbstractCleaner class >> configuration: aChanel [
	^ self new
		configuration: aChanel;
		yourself
]

{ #category : #testing }
ChanelAbstractCleaner class >> isAbstract [
	^ self = ChanelAbstractCleaner
]

{ #category : #accessing }
ChanelAbstractCleaner class >> priority [
	^ self subclassResponsibility
]

{ #category : #cleaning }
ChanelAbstractCleaner >> clean [
	self subclassResponsibility
]

{ #category : #accessing }
ChanelAbstractCleaner >> configuration [
	^ configuration
]

{ #category : #accessing }
ChanelAbstractCleaner >> configuration: anObject [
	configuration := anObject
]

{ #category : #rewriting }
ChanelAbstractCleaner >> rewriteMethodsOf: classes with: rewriter [
	(classes flatCollect: [ :class | class localMethods , class class localMethods ])
		do: [ :method | (rewriter executeTree: method ast) ifTrue: [ method installAST ] ]
]
