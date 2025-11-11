"
A ChanelExtractReturnFromAllBranchesCleanerTest is a test class for testing the behavior of ChanelExtractReturnFromAllBranchesCleaner
"
Class {
	#name : 'ChanelExtractReturnFromAllBranchesCleanerTest',
	#superclass : 'ChanelAbstractCleanerTest',
	#category : 'Chanel-Tests',
	#package : 'Chanel-Tests'
}

{ #category : 'running' }
ChanelExtractReturnFromAllBranchesCleanerTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testDoesNotExtractReturnIfABranchIsASymbol [
	self denyIsRewritten: 'self toto ifNil: [ ^ 1 ] ifNotNil: #yourself'
]

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testDoesNotExtractReturnIfAlreadyOutside [
	self denyIsRewritten: '^ self toto ifTrue: [ 1 ] ifFalse: [ 2 ]'
]

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testDoesNotExtractReturnIfInACascade [
	self denyIsRewritten: 'self toto ifTrue: [ ^ 1 ] ifFalse: [ ^ 2 ]; bar'
]

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testDoesNotExtractReturnIfMessageIsNotTheLastStatement [
	self denyIsRewritten: 'self toto ifTrue: [ ^ 1 ] ifFalse: [ ^ 2 ].
  self bar'
]

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testDoesNotExtractReturnIfOnBranchDoesNotHaveOne [
	self denyIsRewritten: 'self toto ifTrue: [ ^ 1 ] ifFalse: [ 2 ]'
]

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testDoesNotExtractReturnIfReturnIsNotTheLastStatement [
	self denyIsRewritten: 'self toto ifTrue: [ ^ 1 ] ifFalse: [ self foo ifTrue: [ ^ 2 ] ]'
]

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testDoesNotFailIfWeHaveEmptyBlocks [
	self denyIsRewritten: 'self toto ifNil: [ ] ifNotNil: [ ^ 1 ]'
]

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnDoesNotFailForConditonsInConditions [
	self
		assert: 'self toto1 ifTrue: [ self toto2 ifTrue: [ ^ 1 ] ifFalse: [ ^ 2 ] ] ifFalse: [ 3 ]'
		isRewrittenAs: 'self toto1 ifTrue: [ ^self toto2 ifTrue: [ 1 ] ifFalse: [ 2 ] ] ifFalse: [ 3 ]'
]

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnDoesNotFailIfThereIsAlreadyAReturn [
	self assert: '^self toto ifTrue: [ ^ 1 ] ifFalse: [ ^ 2 ]' isRewrittenAs: '^self toto ifTrue: [ 1 ] ifFalse: [ 2 ]'
]

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnFromIfEmptyIfNotEmpty [
	self assert: 'self toto ifEmpty: [ ^ 2 ] ifNotEmpty: [ ^ 1 ]' isRewrittenAs: '^self toto ifEmpty: [ 2 ] ifNotEmpty: [ 1 ]'
]

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnFromIfExistsIfAbsent [
	self assert: 'self toto ifExists: [ ^ 2 ] ifAbsent: [ ^ 1 ]' isRewrittenAs: '^self toto ifExists: [ 2 ] ifAbsent: [ 1 ]'
]

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnFromIfFalseIfTrue [
	self assert: 'self toto ifFalse: [ ^ 2 ] ifTrue: [ ^ 1 ]' isRewrittenAs: '^self toto ifFalse: [ 2 ] ifTrue: [ 1 ]'
]

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnFromIfNilIfNotNil [
	self assert: 'self toto ifNil: [ ^ 2 ] ifNotNil: [ ^ 1 ]' isRewrittenAs: '^self toto ifNil: [ 2 ] ifNotNil: [ 1 ]'
]

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnFromIfNotEmptyIfEmpty [
	self assert: 'self toto ifNotEmpty: [ ^ 2 ] ifEmpty: [ ^ 1 ]' isRewrittenAs: '^self toto ifNotEmpty: [ 2 ] ifEmpty: [ 1 ]'
]

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnFromIfNotNilIfNil [
	self assert: 'self toto ifNotNil: [ ^ 2 ] ifNil: [ ^ 1 ]' isRewrittenAs: '^self toto ifNotNil: [ 2 ] ifNil: [ 1 ]'
]

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnFromIfTrueIfFalse [
	self assert: 'self toto ifTrue: [ ^ 1 ] ifFalse: [ ^ 2 ]' isRewrittenAs: '^self toto ifTrue: [ 1 ] ifFalse: [ 2 ]'
]

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnFromIfTrueIfFalseWithOtherStatements [
	self assert: 'self toto ifTrue: [ self foo. ^ 1 ] ifFalse: [ ^ self bar ]' isRewrittenAs: '^self toto ifTrue: [ self foo.
        1 ] ifFalse: [ self bar ]'
]

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnIfTheLastStatementOfABlock [
	self
		assert:
			'self foo ifTrue: [ self toto ifTrue: [ ^ 1 ] ifFalse: [ ^ 2 ] ].
  self bar'
		isRewrittenAs:
			'self foo ifTrue: [ ^self toto ifTrue: [ 1 ] ifFalse: [ 2 ] ].
  self bar'
]

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnInNestedConditions [
	self
		assert: 'self toto1 ifTrue: [ self toto2 ifTrue: [ ^1 ] ifFalse: [ ^2 ] ] ifFalse: [ ^3 ]'
		isRewrittenAs: '^self toto1 ifTrue: [ self toto2 ifTrue: [ 1 ] ifFalse: [ 2 ] ] ifFalse: [ 3 ]'
]

{ #category : 'tests' }
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

{ #category : 'tests' }
ChanelExtractReturnFromAllBranchesCleanerTest >> testExtractReturnOnClassSide [
	self assert: 'self toto ifTrue: [ ^ 1 ] ifFalse: [ ^ 2 ]' isRewrittenAs: '^self toto ifTrue: [ 1 ] ifFalse: [ 2 ]' in: class class
]
