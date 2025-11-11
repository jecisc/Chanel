"
A ChanelRemoveMethodsWithEquivalentInSuperClassCleanerTest is a test class for testing the behavior of ChanelRemoveMethodsWithEquivalentInSuperClassCleaner
"
Class {
	#name : 'ChanelRemoveMethodsWithEquivalentInSuperClassCleanerTest',
	#superclass : 'ChanelAbstractCleanerTest',
	#instVars : [
		'superClass'
	],
	#category : 'Chanel-Tests',
	#package : 'Chanel-Tests'
}

{ #category : 'running' }
ChanelRemoveMethodsWithEquivalentInSuperClassCleanerTest >> setUp [
	super setUp.
	superClass := self createDefaultClass.
	class := self createSubclassOf: superClass named: #ChanelRemoveMethodssWithSuperEquavalentSubClassFake
]

{ #category : 'tests' }
ChanelRemoveMethodsWithEquivalentInSuperClassCleanerTest >> testClassRemoveMethodWithEquivalentInSuperClass [
	superClass class compile: 'methodTest
	^2'.

	class class compile: 'methodTest
	^2'.

	self runCleaner.

	self assert: (superClass class localSelectors includes: #methodTest).
	self deny: (class class localSelectors includes: #methodTest)
]

{ #category : 'tests' }
ChanelRemoveMethodsWithEquivalentInSuperClassCleanerTest >> testDoesNotRemoveMethodIfNotPresentInSuperClass [
	class compile: 'method
	^3'.

	self runCleaner.

	self deny: (superClass localSelectors includes: #method).
	self assert: (class localSelectors includes: #method)
]

{ #category : 'tests' }
ChanelRemoveMethodsWithEquivalentInSuperClassCleanerTest >> testDoesNotRemoveMethodsFromTrait [
	| trait |
	trait := self createDefaultTrait.

	class setTraitComposition: trait.

	superClass compile: 'method
	^2'.

	trait compile: 'method
	^3'.

	self runCleaner.

	self assert: (superClass localSelectors includes: #method).
	self deny: (class localSelectors includes: #method).
	self assert: (trait localSelectors includes: #method)
]

{ #category : 'tests' }
ChanelRemoveMethodsWithEquivalentInSuperClassCleanerTest >> testDoesNotRemoveNotEquivalentMethod [
	superClass compile: 'method
	^2'.

	class compile: 'method
	^3'.

	self runCleaner.

	self assert: (superClass localSelectors includes: #method).
	self assert: (class localSelectors includes: #method)
]

{ #category : 'tests' }
ChanelRemoveMethodsWithEquivalentInSuperClassCleanerTest >> testDoesNotRemoveNotEquivalentMethodWithPragma [
	superClass compile: 'method
	^2'.

	class compile: 'method
	<pragma>
	^2'.

	self runCleaner.

	self assert: (superClass localSelectors includes: #method).
	self assert: (class localSelectors includes: #method)
]

{ #category : 'tests' }
ChanelRemoveMethodsWithEquivalentInSuperClassCleanerTest >> testRemoveMethodWithEquivalentInSuperClass [
	superClass compile: 'method
	^2'.

	class compile: 'method
	^2'.

	self runCleaner.

	self assert: (superClass localSelectors includes: #method).
	self deny: (class localSelectors includes: #method)
]

{ #category : 'tests' }
ChanelRemoveMethodsWithEquivalentInSuperClassCleanerTest >> testRemoveMethodWithEquivalentInSuperClassWithComment [
	superClass compile: 'method
	^2'.

	class compile: 'method
	"I don''t care about comments."
	^2'.

	self runCleaner.

	self assert: (superClass localSelectors includes: #method).
	self deny: (class localSelectors includes: #method)
]

{ #category : 'tests' }
ChanelRemoveMethodsWithEquivalentInSuperClassCleanerTest >> testRemoveMethodWithEquivalentInSuperClassWithJustCommentDifference [
	superClass compile: 'method
	^2'.

	class compile: 'method
	"I don''t care about comments."
	^2'.

	self runCleaner.

	self assert: (superClass localSelectors includes: #method).
	self deny: (class localSelectors includes: #method)
]
