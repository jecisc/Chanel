"
A ChanelRemoveUnusedNodesFromASTCleanerTest is a test class for testing the behavior of ChanelRemoveUnusedNodesFromASTCleaner
"
Class {
	#name : 'ChanelRemoveUnusedNodesFromASTCleanerTest',
	#superclass : 'ChanelAbstractCleanerTest',
	#category : 'Chanel-Tests',
	#package : 'Chanel-Tests'
}

{ #category : 'running' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testDoesNotRemoveNodesInAssignation [
	self denyIsRewritten: '|test|
	test := 1'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testDoesNotRemoveNodesInByteArray [
	self denyIsRewritten: '^#[1]'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testDoesNotRemoveNodesInDynamicArray [
	self denyIsRewritten: '^{ 1 }'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testDoesNotRemoveNodesInLiteralArray [
	self denyIsRewritten: '^#(1)'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testDoesNotRemoveNodesInPragma [
	self denyIsRewritten: '<test: 1>'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testDoesNotRemoveNodesInReturn [
	self denyIsRewritten: '^1'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testDoesNotRemoveNodesReceivingMessages [
	self denyIsRewritten: '1 asString'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemove2UselessNodes [
	self
		assert:
			'''test''.
  #test2.
  ^1'
		isRewrittenAs: '^1'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessArgumentRead [
	self
		assert:
			'test.
  ^test'
		isRewrittenAs: '^test'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessBlock [
	self
		assert:
			'[ ^ 2 ].
  ^1'
		isRewrittenAs: '^1'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessBoolean [
	self
		assert:
			'true.
  ^1'
		isRewrittenAs: '^1'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessByteArray [
	self
		assert:
			'#[1].
  ^1'
		isRewrittenAs: '^1'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessDynamicArray [
	self
		assert:
			'{ 1 . 2 }.
  ^1'
		isRewrittenAs: '^1'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessGlobal [
	self
		assert:
			'Object.
  ^1'
		isRewrittenAs: '^1'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessInstanceVariableRead [
	self
		assert:
			'test.
  ^1'
		isRewrittenAs: '^1'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessLiteralArray [
	self
		assert:
			'#(1 2).
  ^1'
		isRewrittenAs: '^1'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessNil [
	self
		assert:
			'nil.
  ^1'
		isRewrittenAs: '^1'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessNodeInAnUnselessNode [
	self
		assert:
			'[''test''].
  ^1'
		isRewrittenAs: '^1'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessNodeInTrait [
	| trait |
	trait := self createDefaultTrait.
	class setTraitComposition: trait.

	trait compile: 'method
  ''test''.
  ^1'.

	self runCleaner.

	self assert: (trait >> #method) sourceCode equals: 'method
  ^1'.

	self assert: (trait localSelectors includes: #method).
	self deny: (class localSelectors includes: #method)
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessNodeOnClassSide [
	self
		assert:
			'''test''.
  ^1'
		isRewrittenAs: '^1'
		in: class class
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessNumber [
	self
		assert:
			'10.
  ^1'
		isRewrittenAs: '^1'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessSelf [
	self
		assert:
			'self.
  ^1'
		isRewrittenAs: '^1'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessString [
	self
		assert:
			'''test''.
  ^1'
		isRewrittenAs: '^1'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessSuper [
	self
		assert:
			'super.
  ^1'
		isRewrittenAs: '^1'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessSymbol [
	self
		assert:
			'#test.
  ^1'
		isRewrittenAs: '^1'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessTemporaryRead [
	self
		assert:
			'| test |
  test := 2.
  test.
  ^test'
		isRewrittenAs:
			'| test |
  test := 2.
  ^test'
]

{ #category : 'tests' }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessThisContext [
	self
		assert:
			'thisContext.
  ^1'
		isRewrittenAs: '^1'
]
