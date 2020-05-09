"
A ChanelExtractReturnFromAllBranchesCleanerTest is a test class for testing the behavior of ChanelExtractReturnFromAllBranchesCleaner
"
Class {
	#name : #ChanelExtractReturnFromAllBranchesCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #running }
ChanelExtractReturnFromAllBranchesCleanerTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : #tests }
ChanelExtractReturnFromAllBranchesCleanerTest >> testDoesNotExtractReturnIfABranchIsASymbol [
	| oldMethod |
	class
		compile:
			'method
  self toto ifNil: [ ^ 1 ] ifNotNil: #yourself'.

	oldMethod := class >> #method.

	self runCleaner.

	self
		assert: (class >> #method) sourceCode
		equals:
			'method
  self toto ifNil: [ ^ 1 ] ifNotNil: #yourself'.

	self assert: oldMethod identicalTo: class >> #method
]

{ #category : #tests }
ChanelExtractReturnFromAllBranchesCleanerTest >> testDoesNotExtractReturnIfAlreadyOutside [
	| oldMethod |
	class
		compile:
			'method
  ^ self toto ifTrue: [ 1 ] ifFalse: [ 2 ]'.

	oldMethod := class >> #method.

	self runCleaner.

	self
		assert: (class >> #method) sourceCode
		equals:
			'method
  ^ self toto ifTrue: [ 1 ] ifFalse: [ 2 ]'.

	self assert: oldMethod identicalTo: class >> #method
]

{ #category : #tests }
ChanelExtractReturnFromAllBranchesCleanerTest >> testDoesNotExtractReturnIfInACascade [
	| oldMethod |
	class compile: 'method
  self toto ifTrue: [ ^ 1 ] ifFalse: [ ^ 2 ]; bar'.

	oldMethod := class >> #method.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  self toto ifTrue: [ ^ 1 ] ifFalse: [ ^ 2 ]; bar'.

	self assert: oldMethod identicalTo: class >> #method
]

{ #category : #tests }
ChanelExtractReturnFromAllBranchesCleanerTest >> testDoesNotExtractReturnIfMessageIsNotTheLastStatement [
	| oldMethod |
	class
		compile:
			'method
  self toto ifTrue: [ ^ 1 ] ifFalse: [ ^ 2 ].
  self bar'.

	oldMethod := class >> #method.

	self runCleaner.

	self
		assert: (class >> #method) sourceCode
		equals:
			'method
  self toto ifTrue: [ ^ 1 ] ifFalse: [ ^ 2 ].
  self bar'.

	self assert: oldMethod identicalTo: class >> #method
]

{ #category : #tests }
ChanelExtractReturnFromAllBranchesCleanerTest >> testDoesNotExtractReturnIfOnBranchDoesNotHaveOne [
	| oldMethod |
	class
		compile:
			'method
  self toto ifTrue: [ ^ 1 ] ifFalse: [ 2 ]'.

	oldMethod := class >> #method.

	self runCleaner.

	self
		assert: (class >> #method) sourceCode
		equals:
			'method
  self toto ifTrue: [ ^ 1 ] ifFalse: [ 2 ]'.

	self assert: oldMethod identicalTo: class >> #method
]

{ #category : #tests }
ChanelExtractReturnFromAllBranchesCleanerTest >> testDoesNotExtractReturnIfReturnIsNotTheLastStatement [
	| oldMethod |
	class
		compile:
			'method
  self toto ifTrue: [ ^ 1 ] ifFalse: [ self foo ifTrue: [ ^ 2 ] ]'.

	oldMethod := class >> #method.

	self runCleaner.

	self
		assert: (class >> #method) sourceCode
		equals:
			'method
  self toto ifTrue: [ ^ 1 ] ifFalse: [ self foo ifTrue: [ ^ 2 ] ]'.

	self assert: oldMethod identicalTo: class >> #method
]

{ #category : #tests }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnDoesNotFailIfThereIsAlreadyAReturn [
	class compile: 'method
  ^self toto ifTrue: [ ^ 1 ] ifFalse: [ ^ 2 ]'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^self toto ifTrue: [ 1 ] ifFalse: [ 2 ]'
]

{ #category : #tests }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnFromIfEmptyIfNotEmpty [
	class compile: 'method
  self toto ifEmpty: [ ^ 2 ] ifNotEmpty: [ ^ 1 ]'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^self toto ifEmpty: [ 2 ] ifNotEmpty: [ 1 ]'
]

{ #category : #tests }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnFromIfExistsIfAbsent [
	class compile: 'method
  self toto ifExists: [ ^ 2 ] ifAbsent: [ ^ 1 ]'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^self toto ifExists: [ 2 ] ifAbsent: [ 1 ]'
]

{ #category : #tests }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnFromIfFalseIfTrue [
	class compile: 'method
  self toto ifFalse: [ ^ 2 ] ifTrue: [ ^ 1 ]'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^self toto ifFalse: [ 2 ] ifTrue: [ 1 ]'
]

{ #category : #tests }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnFromIfNilIfNotNil [
	class compile: 'method
  self toto ifNil: [ ^ 2 ] ifNotNil: [ ^ 1 ]'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^self toto ifNil: [ 2 ] ifNotNil: [ 1 ]'
]

{ #category : #tests }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnFromIfNotEmptyIfEmpty [
	class compile: 'method
  self toto ifNotEmpty: [ ^ 2 ] ifEmpty: [ ^ 1 ]'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^self toto ifNotEmpty: [ 2 ] ifEmpty: [ 1 ]'
]

{ #category : #tests }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnFromIfNotNilIfNil [
	class compile: 'method
  self toto ifNotNil: [ ^ 2 ] ifNil: [ ^ 1 ]'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^self toto ifNotNil: [ 2 ] ifNil: [ 1 ]'
]

{ #category : #tests }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnFromIfTrueIfFalse [
	class compile: 'method
  self toto ifTrue: [ ^ 1 ] ifFalse: [ ^ 2 ]'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^self toto ifTrue: [ 1 ] ifFalse: [ 2 ]'
]

{ #category : #tests }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnFromIfTrueIfFalseWithOtherStatements [
	class compile: 'method
  self toto ifTrue: [ self foo. ^ 1 ] ifFalse: [ ^ self bar ]'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^self toto ifTrue: [ self foo.
        1 ] ifFalse: [ self bar ]'
]

{ #category : #tests }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnIfTheLastStatementOfABlock [
	class compile: 'method
  self foo ifTrue: [ self toto ifTrue: [ ^ 1 ] ifFalse: [ ^ 2 ] ].
  self bar'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  self foo ifTrue: [ ^self toto ifTrue: [ 1 ] ifFalse: [ 2 ] ].
  self bar'
]

{ #category : #tests }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnInTrait [
	| trait |
	trait := self createDefaultTrait.

	class setTraitComposition: trait.

	trait
		compile:
			'method
  self toto ifTrue: [ ^ 1 ] ifFalse: [ ^ 2 ]'.

	self runCleaner.

	self
		assert: (trait >> #method) sourceCode
		equals:
			'method
  ^self toto ifTrue: [ 1 ] ifFalse: [ 2 ]'.

	self assert: (trait localSelectors includes: #method).
	self deny: (class localSelectors includes: #method)
]

{ #category : #tests }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnOnClassSide [
	class class compile: 'method
  self toto ifTrue: [ ^ 1 ] ifFalse: [ ^ 2 ]'.

	self runCleaner.
	
	self assert: (class class >> #method) sourceCode equals: 'method
  ^self toto ifTrue: [ 1 ] ifFalse: [ 2 ]'
]
