"
A ChanelTestEmptyAssertionsCleanerTest is a test class for testing the behavior of ChanelTestEmptyAssertionsCleaner
"
Class {
	#name : #ChanelTestEmptyAssertionsCleanerTest,
	#superclass : #ChanelMethodRewriterCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #helpers }
ChanelTestEmptyAssertionsCleanerTest >> expressionWithNoReplacement [
	^ 'self assert: 3 equals: 2'
]

{ #category : #helpers }
ChanelTestEmptyAssertionsCleanerTest >> replaceInTraits [
	^ false
]

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
ChanelTestEmptyAssertionsCleanerTest >> testShouldNotReplaceIfNotATestCase [
	"We only replace the assertion of TestCase because other objects are much poorer in term of assertions."

	class := self createDefaultClass.

	self denyIsRewritten: 'self assert: #() isEmpty'
]
