"
A ChanelDuplicatedMethodFromTraitCleanerTest is a test class for testing the behavior of ChanelDuplicatedMethodFromTraitCleaner
"
Class {
	#name : #ChanelDuplicatedMethodFromTraitCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #tests }
ChanelDuplicatedMethodFromTraitCleanerTest >> testDoesNotRemoveDuplicatedMethodFromTraitIfASTDifferent [
	| trait |
	class := self createClassNamed: #ChanelDuplicatedMethodFromTraitFake.
	trait := self createTraitNamed: #TChanelDuplicatedMethodFromTraitFake.

	class addToComposition: trait.

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
	| trait superclass |
	superclass := self createClassNamed: #ChanelSupDuplicatedMethodFromTraitFake.
	class := self createSubclassOf: superclass named: #ChanelDuplicatedMethodFromTraitFake.
	trait := self createTraitNamed: #TChanelDuplicatedMethodFromTraitFake.

	class addToComposition: trait.

	trait
		compile:
			'one
	^ #one'.

	superclass
		compile:
			'one
			<pragma>
	^ #one'.

	self runCleaner.

	self assert: (trait localSelectors includes: #one).
	self assert: (superclass localSelectors includes: #one).
	self deny: (class localSelectors includes: #one)
]

{ #category : #tests }
ChanelDuplicatedMethodFromTraitCleanerTest >> testDoesNotRemoveDuplicatedMethodFromTraitIfPragmaIsPresent [
	| trait |
	class := self createClassNamed: #ChanelDuplicatedMethodFromTraitFake.
	trait := self createTraitNamed: #TChanelDuplicatedMethodFromTraitFake.

	class addToComposition: trait.

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
	| trait |
	class := self createClassNamed: #ChanelDuplicatedMethodFromTraitFake.
	trait := self createTraitNamed: #TChanelDuplicatedMethodFromTraitFake.

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
	| trait |
	class := self createClassNamed: #ChanelDuplicatedMethodFromTraitFake.
	trait := self createTraitNamed: #TChanelDuplicatedMethodFromTraitFake.

	class addToComposition: trait.

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
	| trait |
	class := self createClassNamed: #ChanelDuplicatedMethodFromTraitFake.
	trait := self createTraitNamed: #TChanelDuplicatedMethodFromTraitFake.

	class addToComposition: trait.

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
