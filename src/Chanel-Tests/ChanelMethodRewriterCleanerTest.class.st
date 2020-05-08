"
A ChanelMethodRewriterCleanerTest is a test class for testing the behavior of ChanelMethodRewriterCleaner
"
Class {
	#name : #ChanelMethodRewriterCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #testing }
ChanelMethodRewriterCleanerTest class >> isAbstract [
	^ self = ChanelMethodRewriterCleanerTest
]

{ #category : #helpers }
ChanelMethodRewriterCleanerTest >> assert: original isRewrittenAs: expected [
	class ifNil: [ self error: 'To use this method you need to setup the class variable' ].

	class
		compile:
			('{1}
  {2}' format: {self selector . original}).

	self runCleaner.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . expected})
]

{ #category : #helpers }
ChanelMethodRewriterCleanerTest >> deny: original isRewrittenForPharo: anInteger [
	| oldMethod |
	class ifNil: [ self error: 'To use this method you need to setup the class variable' ].

	class
		compile:
			('{1}
  {2}' format: {self selector . original}).

	oldMethod := class >> self selector.

	self runCleanerForPharo: anInteger.

	self assert: class >> self selector identicalTo: oldMethod
]

{ #category : #helpers }
ChanelMethodRewriterCleanerTest >> denyIsRewritten: aString [
	| oldMethod |
	class ifNil: [ self error: 'To use this method you need to setup the class variable' ].

	class
		compile:
			('{1}
	{2}' format: {self selector . aString}).

	oldMethod := class >> self selector.
	self runCleaner.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
	{2}' format: {self selector . aString}).

	self assert: class >> self selector identicalTo: oldMethod
]
