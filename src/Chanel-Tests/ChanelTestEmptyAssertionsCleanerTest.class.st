"
A ChanelTestEmptyAssertionsCleanerTest is a test class for testing the behavior of ChanelTestEmptyAssertionsCleaner
"
Class {
	#name : #ChanelTestEmptyAssertionsCleanerTest,
	#superclass : #ChanelMethodRewriterCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #helpers }
ChanelTestEmptyAssertionsCleanerTest >> replacementPair [
	^ 'self assert: #() isEmpty' -> 'self assertEmpty: #()'
]

{ #category : #running }
ChanelTestEmptyAssertionsCleanerTest >> setUp [
	super setUp.
	class := self createDefaultTestClass
]

{ #category : #tests }
ChanelTestEmptyAssertionsCleanerTest >> testAssertEmpty [
	self assert: 'self assert: #() isEmpty' isRewrittenAs: 'self assertEmpty: #()'
]

{ #category : #tests }
ChanelTestEmptyAssertionsCleanerTest >> testAssertEmpty2 [
	self assert: 'self deny: #() isNotEmpty' isRewrittenAs: 'self assertEmpty: #()'
]

{ #category : #tests }
ChanelTestEmptyAssertionsCleanerTest >> testAssertEmpty2NotReplacedForPharo7 [
	self deny: 'self deny: #() isNotEmpty' isRewrittenForPharo: 7
]

{ #category : #tests }
ChanelTestEmptyAssertionsCleanerTest >> testAssertEmptyNotReplacedForPharo7 [
	self deny: 'self assert: #() isEmpty' isRewrittenForPharo: 7
]

{ #category : #tests }
ChanelTestEmptyAssertionsCleanerTest >> testDenyEmpty [
	self assert: 'self deny: #() isEmpty' isRewrittenAs: 'self denyEmpty: #()'
]

{ #category : #tests }
ChanelTestEmptyAssertionsCleanerTest >> testDenyEmpty2 [
	self assert: 'self assert: #() isNotEmpty' isRewrittenAs: 'self denyEmpty: #()'
]

{ #category : #tests }
ChanelTestEmptyAssertionsCleanerTest >> testDenyEmpty2NotReplacedForPharo7 [
	self deny: 'self assert: #() isNotEmpty' isRewrittenForPharo: 7
]

{ #category : #tests }
ChanelTestEmptyAssertionsCleanerTest >> testDenyEmptyNotReplacedForPharo7 [
	self deny: 'self deny: #() isEmpty' isRewrittenForPharo: 7
]

{ #category : #tests }
ChanelTestEmptyAssertionsCleanerTest >> testDoesNotReplaceInTraits [
	| trait |
	trait := self createDefaultTrait.

	class setTraitComposition: trait.

	trait
		compile:
			('{1}
  {2}' format: {self selector . 'self assert: #() isEmpty'}).

	self runCleaner.

	self
		assert: (trait >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . 'self assert: #() isEmpty'}).

	self assert: (trait localSelectors includes: self selector).
	self deny: (class localSelectors includes: self selector)
]

{ #category : #tests }
ChanelTestEmptyAssertionsCleanerTest >> testShouldNotReplaceIfNotATestCase [
	"We only replace the assertion of TestCase because other objects are much poorer in term of assertions."

	class := self createDefaultClass.

	self denyIsRewritten: 'self assert: #() isEmpty'
]

{ #category : #tests }
ChanelTestEmptyAssertionsCleanerTest >> testWithNothingToReplace [
	self denyIsRewritten: 'self assert: 3 equals: 2'
]
