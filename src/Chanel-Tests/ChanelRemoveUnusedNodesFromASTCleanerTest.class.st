"
A ChanelRemoveUnusedNodesFromASTCleanerTest is a test class for testing the behavior of ChanelRemoveUnusedNodesFromASTCleaner
"
Class {
	#name : #ChanelRemoveUnusedNodesFromASTCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #running }
ChanelRemoveUnusedNodesFromASTCleanerTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testDoesNotRemoveNodesInAssignation [
	| oldMethod |
	class compile: 'method
  test := 1'.

	oldMethod := class >> #method.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  test := 1'.

	self assert: (class >> #method) equals: oldMethod
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testDoesNotRemoveNodesInByteArray [
	| oldMethod |
	class compile: 'method
  ^#[1]'.

	oldMethod := class >> #method.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^#[1]'.

	self assert: (class >> #method) equals: oldMethod
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testDoesNotRemoveNodesInDynamicArray [
	| oldMethod |
	class compile: 'method
  ^{ 1 }'.

	oldMethod := class >> #method.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^{ 1 }'.

	self assert: (class >> #method) equals: oldMethod
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testDoesNotRemoveNodesInLiteralArray [
	| oldMethod |
	class compile: 'method
  ^#(1)'.

	oldMethod := class >> #method.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^#(1)'.

	self assert: (class >> #method) equals: oldMethod
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testDoesNotRemoveNodesInPragma [
	| oldMethod |
	class compile: 'method
  <test: 1>'.

	oldMethod := class >> #method.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  <test: 1>'.

	self assert: (class >> #method) equals: oldMethod
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testDoesNotRemoveNodesInReturn [
	| oldMethod |
	class compile: 'method
  ^1'.

	oldMethod := class >> #method.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^1'.

	self assert: (class >> #method) equals: oldMethod
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testDoesNotRemoveNodesReceivingMessages [
	| oldMethod |
	class compile: 'method
  1 asString'.

	oldMethod := class >> #method.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  1 asString'.

	self assert: (class >> #method) equals: oldMethod
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemove2UselessNodes [
	class compile: 'method
  ''test''.
  #test2.
  ^1'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^1'
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessArgumentRead [
	class compile: 'method: test
  test.
  ^test'.

	self runCleaner.
	
	self assert: (class >> #method:) sourceCode equals: 'method: test
  ^test'
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessBlock [
	class compile: 'method
  [ ^ 2 ].
  ^1'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^1'
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessBoolean [
	class compile: 'method
  true.
  ^1'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^1'
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessByteArray [
	class compile: 'method
  #[1].
  ^1'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^1'
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessDynamicArray [
	class compile: 'method
  { 1 . 2 }.
  ^1'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^1'
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessGlobal [
	class compile: 'method
  Object.
  ^1'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^1'
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessInstanceVariableRead [
	class compile: 'method
  test.
  ^1'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^1'
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessLiteralArray [
	class compile: 'method
  #(1 2).
  ^1'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^1'
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessNil [
	class compile: 'method
  nil.
  ^1'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^1'
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessNodeInAnUnselessNode [
	class compile: 'method
  [''test''].
  ^1'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^1'
]

{ #category : #tests }
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

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessNodeOnClassSide [
	class class compile: 'method
  ''test''.
  ^1'.

	self runCleaner.
	
	self assert: (class class >> #method) sourceCode equals: 'method
  ^1'
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessNumber [
	class compile: 'method
  10.
  ^1'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^1'
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessSelf [
	class compile: 'method
  self.
  ^1'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^1'
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessString [
	class compile: 'method
  ''test''.
  ^1'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^1'
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessSuper [
	class compile: 'method
  super.
  ^1'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^1'
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessSymbol [
	class compile: 'method
  #test.
  ^1'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^1'
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessTemporaryRead [
	class compile: 'method
  | test |
  test := 2.
  test.
  ^test'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  | test |
  test := 2.
  ^test'
]

{ #category : #tests }
ChanelRemoveUnusedNodesFromASTCleanerTest >> testRemoveUselessThisContext [
	class compile: 'method
  thisContext.
  ^1'.

	self runCleaner.
	
	self assert: (class >> #method) sourceCode equals: 'method
  ^1'
]
