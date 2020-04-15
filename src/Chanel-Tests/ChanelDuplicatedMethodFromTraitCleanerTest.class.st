"
A ChanelDuplicatedMethodFromTraitCleanerTest is a test class for testing the behavior of ChanelDuplicatedMethodFromTraitCleaner
"
Class {
	#name : #ChanelDuplicatedMethodFromTraitCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#instVars : [
		'trait'
	],
	#category : #'Chanel-Tests'
}

{ #category : #running }
ChanelDuplicatedMethodFromTraitCleanerTest >> setUp [
	super setUp.
	class := self createDefaultClass.
	trait := self createDefaultTrait
]

{ #category : #tests }
ChanelDuplicatedMethodFromTraitCleanerTest >> testDoesNotRemoveDuplicatedMethodFromTraitIfASTDifferent [
	class setTraitComposition: trait.

	trait
		compile:
			'one
	^ #one'.

	class
		compile:
			'one
	^ #two'.

	self runCleaner.

	self assert: (trait localSelectors includes: #one).
	self assert: (class localSelectors includes: #one)
]

{ #category : #tests }
ChanelDuplicatedMethodFromTraitCleanerTest >> testDoesNotRemoveDuplicatedMethodFromTraitIfEquivalentIsInSuperclasse [
	| subClass |
	subClass := self createSubclassOf: class named: #ChanelDuplicatedMethodFromTraitFake.

	subClass setTraitComposition: trait.

	trait
		compile:
			'one
	^ #one'.

	class
		compile:
			'one
			<pragma>
	^ #one'.

	self runCleaner.

	self assert: (trait localSelectors includes: #one).
	self assert: (class localSelectors includes: #one).
	self deny: (subClass localSelectors includes: #one)
]

{ #category : #tests }
ChanelDuplicatedMethodFromTraitCleanerTest >> testDoesNotRemoveDuplicatedMethodFromTraitIfPragmaIsPresent [
	class setTraitComposition: trait.

	trait
		compile:
			'one
	^ #one'.

	class
		compile:
			'one
			<pragma>
	^ #one'.

	self runCleaner.

	self assert: (trait localSelectors includes: #one).
	self assert: (class localSelectors includes: #one)
]

{ #category : #tests }
ChanelDuplicatedMethodFromTraitCleanerTest >> testDoesNothingToClassWithoutTraitComposition [
	trait
		compile:
			'one
	^ #one'.

	class
		compile:
			'one
	^ #two'.

	self runCleaner.

	self assert: (trait localSelectors includes: #one).
	self assert: (class localSelectors includes: #one)
]

{ #category : #tests }
ChanelDuplicatedMethodFromTraitCleanerTest >> testRemoveDuplicatedMethodFromTrait [
	class setTraitComposition: trait.

	trait
		compile:
			'one
	^ #one'.

	class
		compile:
			'one
	^ #one'.

	self runCleaner.

	self assert: (trait localSelectors includes: #one).
	self deny: (class localSelectors includes: #one)
]

{ #category : #tests }
ChanelDuplicatedMethodFromTraitCleanerTest >> testRemoveDuplicatedMethodFromTraitIfFormattingDifferent [
	class setTraitComposition: trait.

	trait
		compile:
			'one
	^ #one'.

	class
		compile:
			'one
			"test"
	^ #one'.

	self runCleaner.

	self assert: (trait localSelectors includes: #one).
	self deny: (class localSelectors includes: #one)
]

{ #category : #tests }
ChanelDuplicatedMethodFromTraitCleanerTest >> testRemoveDuplicatedMethodFromTraitOnClassSide [
	class setTraitComposition: trait.

	trait class
		compile:
			'one
	^ #one'.

	class class
		compile:
			'one
	^ #one'.

	self runCleaner.

	self assert: (trait class localSelectors includes: #one).
	self deny: (class class localSelectors includes: #one)
]
