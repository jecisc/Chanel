"
Description
--------------------

I remove each methods only doing a super call. Does not remove methods with pragmas.
"
Class {
	#name : #ChanelMethodsOnlyCallingSuperCleaner,
	#superclass : #ChanelAbstractCleaner,
	#category : #Chanel
}

{ #category : #accessing }
ChanelMethodsOnlyCallingSuperCleaner class >> priority [
	^ 8000
]

{ #category : #cleaning }
ChanelMethodsOnlyCallingSuperCleaner >> clean [
	| matcher |
	matcher := RBParseTreeSearcher justSendsSuper.
	self configuration localMethods
		do: [ :method | (method pragmas isEmpty and: [ matcher executeMethod: method ast initialAnswer: false ]) ifTrue: [ method removeFromSystem ] ]
]
