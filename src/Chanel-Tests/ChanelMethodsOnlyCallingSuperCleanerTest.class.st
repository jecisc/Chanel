"
A ChanelMethodsOnlyCallingSuperCleanerTest is a test class for testing the behavior of ChanelMethodsOnlyCallingSuperCleaner
"
Class {
	#name : #ChanelMethodsOnlyCallingSuperCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #running }
ChanelMethodsOnlyCallingSuperCleanerTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : #tests }
ChanelMethodsOnlyCallingSuperCleanerTest >> testDoesNotFailOnEmptyMethods [
	| oldMethod |
	class compile: 'initialize'.

	oldMethod := class >> #initialize.
	self runCleaner.

	self assert: (class localSelectors includes: #initialize).

	"We should not have recompiled the method if we do not clean it."
	self assert: class >> #initialize identicalTo: oldMethod
]

{ #category : #tests }
ChanelMethodsOnlyCallingSuperCleanerTest >> testDoesNotRemoveMethodCallingOtherSuper [
	| oldMethod |
	class
		compile:
			'new
  super basicNew'.

	oldMethod := class>>#new.
	self runCleaner.

	self assert: (class localSelectors includes: #new).

	"We should not have recompiled the method if we do not clean it."
	self assert: (class >> #new) identicalTo: oldMethod
]

{ #category : #tests }
ChanelMethodsOnlyCallingSuperCleanerTest >> testDoesNotRemoveMethodWithOtherStatements [
	| oldMethod |
	class
		compile:
			'initialize
  super initialize.
  ^ #test'.

	oldMethod := class>>#initialize.
	self runCleaner.

	self assert: (class localSelectors includes: #initialize).

	"We should not have recompiled the method if we do not clean it."
	self assert: (class >> #initialize) identicalTo: oldMethod
]

{ #category : #tests }
ChanelMethodsOnlyCallingSuperCleanerTest >> testDoesNotRemoveMethodWithPragma [
	| oldMethod |
	class
		compile:
			'initialize
  <pragma>
  super initialize'.

	oldMethod := class>>#initialize.
	self runCleaner.

	self assert: (class localSelectors includes: #initialize).

	"We should not have recompiled the method if we do not clean it."
	self assert: (class >> #initialize) identicalTo: oldMethod
]

{ #category : #tests }
ChanelMethodsOnlyCallingSuperCleanerTest >> testRemoveBinaryMethodOnlyCallingSuper [
	class
		compile:
			'= aString
  ^ super = aString'.

	self runCleaner.

	self deny: (class localSelectors includes: #=)
]

{ #category : #tests }
ChanelMethodsOnlyCallingSuperCleanerTest >> testRemoveKeywordMethodOnlyCallingSuper [
	class
		compile:
			'initialize: aString
  super initialize: aString'.

	self runCleaner.

	self deny: (class localSelectors includes: #initialize:)
]

{ #category : #tests }
ChanelMethodsOnlyCallingSuperCleanerTest >> testRemoveMethodOnlyCallingSuper [
	class
		compile:
			'initialize
  super initialize'.

	self runCleaner.

	self deny: (class localSelectors includes: #initialize)
]

{ #category : #tests }
ChanelMethodsOnlyCallingSuperCleanerTest >> testRemoveMethodOnlyCallingSuper2 [
	class
		compile:
			'initialize
  "I don''t care about comments. If you need them, put them in the class comment."
  super initialize'.

	self runCleaner.

	self deny: (class localSelectors includes: #initialize)
]

{ #category : #tests }
ChanelMethodsOnlyCallingSuperCleanerTest >> testRemoveMethodOnlyCallingSuperEvenIfThereIsAReturn [
	class
		compile:
			'initialize
  ^super initialize'.

	self runCleaner.

	self deny: (class localSelectors includes: #initialize)
]

{ #category : #tests }
ChanelMethodsOnlyCallingSuperCleanerTest >> testRemoveMethodOnlyCallingSuperInTrait [
	| trait |
	trait := self createDefaultTrait.

	class setTraitComposition: trait.

	trait
		compile:
			'initialize
  super initialize'.

	self runCleaner.

	self deny: (class localSelectors includes: #initialize).
	self deny: (trait localSelectors includes: #initialize)
]

{ #category : #tests }
ChanelMethodsOnlyCallingSuperCleanerTest >> testRemoveMethodOnlyCallingSuperOnClassSide [
	class class
		compile:
			'initialize
  super initialize'.

	self runCleaner.

	self deny: (class class localSelectors includes: #initialize)
]
