"
A ChanelNilAssignationInInitializeCleanerTest is a test class for testing the behavior of ChanelNilAssignationInInitializeCleaner
"
Class {
	#name : #ChanelNilAssignationInInitializeCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #running }
ChanelNilAssignationInInitializeCleanerTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : #tests }
ChanelNilAssignationInInitializeCleanerTest >> testDoesNothingIfNoNilAssigment [
	| oldMethod |
	class
		compile:
			'initialize
  super initialize.
  test := 1'.

	oldMethod := (class >> #initialize).

	self runCleaner.

	self
		assert: (class >> #initialize) sourceCode
		equals:
			'initialize
  super initialize.
  test := 1'.

	"We should not have recompiled the method if we do not clean it."
	self assert: (class >> #initialize) identicalTo: oldMethod
]

{ #category : #tests }
ChanelNilAssignationInInitializeCleanerTest >> testDoesNothingOnEmptyMethod [
	| oldMethod |
	class compile: 'initialize'.

	oldMethod := class >> #initialize.

	self runCleaner.

	self assert: (class >> #initialize) sourceCode equals: 'initialize'.

	"We should not have recompiled the method if we do not clean it."
	self assert: class >> #initialize identicalTo: oldMethod
]

{ #category : #tests }
ChanelNilAssignationInInitializeCleanerTest >> testRemoveNilAssigment [
	class
		compile:
			'initialize
  super initialize.
  test := nil'.

	self runCleaner.

	self
		assert: (class >> #initialize) sourceCode
		equals:
			'initialize
  super initialize'
]

{ #category : #tests }
ChanelNilAssignationInInitializeCleanerTest >> testRemoveNilAssigmentInTrait [
	| trait |
	trait := self createDefaultTrait.

	class setTraitComposition: trait.

	trait
		compile:
			'initialize
  super initialize.
  test := nil'.

	self runCleaner.

	self
		assert: (trait >> #initialize) sourceCode
		equals:
			'initialize
  super initialize'.

	self deny: (class localSelectors includes: #initialize).
	self assert: (trait localSelectors includes: #initialize)
]

{ #category : #tests }
ChanelNilAssignationInInitializeCleanerTest >> testRemoveNilAssigmentOnClassSide [
	class class
		compile:
			'initialize
  test := nil'.

	self runCleaner.

	self assert: (class class >> #initialize) sourceCode equals: 'initialize
  '
]

{ #category : #tests }
ChanelNilAssignationInInitializeCleanerTest >> testRemoveNilAssigments [
	class
		compile:
			'initialize
  super initialize.
  test := nil.
  test2 := nil'.

	self runCleaner.

	self
		assert: (class >> #initialize) sourceCode
		equals:
			'initialize
  super initialize'
]

{ #category : #tests }
ChanelNilAssignationInInitializeCleanerTest >> testRemoveNilAssigmentsAroundRealAssigments [
	class
		compile:
			'initialize
  super initialize.
  test := nil.
  notTest := 1.
  test2 := nil'.

	self runCleaner.

	self
		assert: (class >> #initialize) sourceCode
		equals:
			'initialize
  super initialize.
  notTest := 1'
]

{ #category : #tests }
ChanelNilAssignationInInitializeCleanerTest >> testRemoveNilChainedAssigments [
	class
		compile:
			'initialize
  super initialize.
  test := test2 := test3 := test4 := nil'.

	self runCleaner.

	self
		assert: (class >> #initialize) sourceCode
		equals:
			'initialize
  super initialize'
]
