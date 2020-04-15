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
	class := self createClassNamed: #ChanelNilAssignationInIntializeFake
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
