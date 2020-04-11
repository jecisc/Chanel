"
A ChanelUnreadTemporaryCleanerTest is a test class for testing the behavior of ChanelUnreadTemporaryCleaner
"
Class {
	#name : #ChanelUnreadTemporaryCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #running }
ChanelUnreadTemporaryCleanerTest >> setUp [
	super setUp.
	class := self createTestCaseNamed: #ChanelUnreadTemporaryFake
]

{ #category : #tests }
ChanelUnreadTemporaryCleanerTest >> testDoesNotRemoveTemporaryReadFromDeeperScope [
	| oldMethod |
	class
		compile:
			'testMethod
  true ifTrue: [ | test |
  test := self toto.
  ^test ].
  ^#one'.

	oldMethod := class >> #testMethod.
	self runCleaner.

	self
		assert: (class >> #testMethod) sourceCode
		equals:
			'testMethod
  true ifTrue: [ | test |
  test := self toto.
  ^test ].
  ^#one'.

	"We should not have recompiled the method if we do not clean it."
	self assert: class >> #testMethod identicalTo: oldMethod
]

{ #category : #tests }
ChanelUnreadTemporaryCleanerTest >> testDontRemoveTemporaryRead [
		| oldMethod |
	class
		compile:
			'testMethod
  | test |
  test := self toto.
  ^test'.

	oldMethod := class >> #testMethod.

	self runCleaner.

	self
		assert: (class >> #testMethod) sourceCode
		equals:
			'testMethod
  | test |
  test := self toto.
  ^test'.

	"We should not have recompiled the method if we do not clean it."
	self assert: (class >> #testMethod) identicalTo: oldMethod
]

{ #category : #tests }
ChanelUnreadTemporaryCleanerTest >> testRemoveTemporaries [
		class
		compile:
			'testMethod
  | test test2 |
  test := self toto.
  test2 := self toto2.
  ^#one'.

	self runCleaner.

	self
		assert: (class >> #testMethod) sourceCode
		equals:
			'testMethod
  self toto.
  self toto2.
  ^#one'
]

{ #category : #tests }
ChanelUnreadTemporaryCleanerTest >> testRemoveTemporary [
		class
		compile:
			'testMethod
  | test |
  test := self toto.
  ^#one'.

	self runCleaner.

	self
		assert: (class >> #testMethod) sourceCode
		equals:
			'testMethod
  self toto.
  ^#one'
]

{ #category : #tests }
ChanelUnreadTemporaryCleanerTest >> testRemoveTemporaryFromDeeperScope [
		class
		compile:
			'testMethod
  true ifTrue: [ | test |
  test := self toto
  ].
  ^#one'.

	self runCleaner.

	self
		assert: (class >> #testMethod) sourceCode
		equals:
			'testMethod
  true ifTrue: [ self toto ].
  ^#one'
]

{ #category : #tests }
ChanelUnreadTemporaryCleanerTest >> testRemoveTemporaryFromDeeperScopes [
		class
		compile:
			'testMethod
  true ifTrue: [ | test |
  test := self toto
  ] ifFalse: [ | test |
  test := self tata
  ].
  ^#one'.

	self runCleaner.

	self
		assert: (class >> #testMethod) sourceCode
		equals:
			'testMethod
  true ifTrue: [ self toto ] ifFalse: [ self tata ].
  ^#one'
]

{ #category : #tests }
ChanelUnreadTemporaryCleanerTest >> testRemoveTemporaryFromDeeperScopesWithOneRead [
		class
		compile:
			'testMethod
  true ifTrue: [ | test |
  test := self toto
  ] ifFalse: [ | test |
  test := self tata.
  ^test ].
  ^#one'.

	self runCleaner.

	self
		assert: (class >> #testMethod) sourceCode
		equals:
			'testMethod
  true ifTrue: [ self toto ] ifFalse: [ | test |
        test := self tata.
        ^test ].
  ^#one'
]
