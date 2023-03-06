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
	class := self createDefaultClass
]

{ #category : #tests }
ChanelUnreadTemporaryCleanerTest >> testDoesNotRemoveTemporaryReadFromDeeperScope [
	self denyIsRewritten: 'true ifTrue: [ | test |
  test := self toto.
  ^test ].
  ^#one'
]

{ #category : #tests }
ChanelUnreadTemporaryCleanerTest >> testDontRemoveTemporaryRead [
	self denyIsRewritten: '| test |
  test := self toto.
  ^test'
]

{ #category : #tests }
ChanelUnreadTemporaryCleanerTest >> testRemoveTemporaries [
	self
		assert:
			'| test test2 |
  test := self toto.
  test2 := self toto2.
  ^#one'
		isRewrittenAs:
			'self toto.
  self toto2.
  ^#one'
]

{ #category : #tests }
ChanelUnreadTemporaryCleanerTest >> testRemoveTemporariesOnClassSide [
	self
		assert:
			'| test test2 |
  test := self toto.
  test2 := self toto2.
  ^#one'
		isRewrittenAs:
			'self toto.
  self toto2.
  ^#one'
]

{ #category : #tests }
ChanelUnreadTemporaryCleanerTest >> testRemoveTemporary [
	self
		assert:
			'| test |
  test := self toto.
  ^#one'
		isRewrittenAs:
			'self toto.
  ^#one'
]

{ #category : #tests }
ChanelUnreadTemporaryCleanerTest >> testRemoveTemporary2 [
	self
		assert:
			'| test |
  test := self toto.
  test.
  ^#one'
		isRewrittenAs:
			'self toto.
  ^#one'
]

{ #category : #tests }
ChanelUnreadTemporaryCleanerTest >> testRemoveTemporaryFromDeeperScope [
	self
		assert:
			'true ifTrue: [ | test |
  test := self toto
  ].
  ^#one'
		isRewrittenAs:
			'true ifTrue: [ self toto ].
  ^#one'
]

{ #category : #tests }
ChanelUnreadTemporaryCleanerTest >> testRemoveTemporaryFromDeeperScopes [
	self
		assert:
			'true ifTrue: [ | test |
  test := self toto
  ] ifFalse: [ | test |
  test := self tata
  ].
  ^#one'
		isRewrittenAs:
			'true ifTrue: [ self toto ] ifFalse: [ self tata ].
  ^#one'
]

{ #category : #tests }
ChanelUnreadTemporaryCleanerTest >> testRemoveTemporaryFromDeeperScopesWithOneRead [
	self
		assert:
			'true ifTrue: [ | test |
  test := self toto
  ] ifFalse: [ | test |
  test := self tata.
  ^test ].
  ^#one'
		isRewrittenAs:
			'true ifTrue: [ self toto ] ifFalse: [ | test |
        test := self tata.
        ^test ].
  ^#one'
]

{ #category : #tests }
ChanelUnreadTemporaryCleanerTest >> testRemoveTemporaryInTrait [
	| trait |
	trait := self createDefaultTrait.

	class setTraitComposition: trait.

	trait
		compile:
			'testMethod
  | test |
  test := self toto.
  ^#one'.

	self runCleaner.

	self
		assert: (trait >> #testMethod) sourceCode
		equals:
			'testMethod
  self toto.
  ^#one'.

	self deny: (class localSelectors includes: #testMethod).
	self assert: (trait localSelectors includes: #testMethod)
]
