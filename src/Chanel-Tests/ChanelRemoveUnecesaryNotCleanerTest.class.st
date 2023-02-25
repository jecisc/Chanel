"
A ChanelRemoveUnecesaryNotCleanerTest is a test class for testing the behavior of ChanelRemoveUnecesaryNotCleaner
"
Class {
	#name : #ChanelRemoveUnecesaryNotCleanerTest,
	#superclass : #ChanelMethodRewriterCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #helpers }
ChanelRemoveUnecesaryNotCleanerTest >> expressionWithNoReplacement [
	^ 'self toto not'
]

{ #category : #helpers }
ChanelRemoveUnecesaryNotCleanerTest >> replacementPair [
	^ 'true not' -> 'false'
]

{ #category : #running }
ChanelRemoveUnecesaryNotCleanerTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testAssertEquals2NotNotReplacedForPharo6 [
	self deny: 'self assert: self toto not equals: self tata' isRewrittenForPharo: 6
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testAssertEqualsNot [
	self assert: 'self assert: self toto equals: self tata not' isRewrittenAs: 'self deny: self toto equals: self tata'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testAssertEqualsNot2 [
	self assert: 'self assert: self toto not equals: self tata' isRewrittenAs: 'self deny: self toto equals: self tata'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testAssertEqualsNotNotReplacedForPharo6 [
	self deny: 'self assert: self toto equals: self tata not' isRewrittenForPharo: 6
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testAssertNot [
	self assert: 'self assert: self toto not' isRewrittenAs: 'self deny: self toto'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testDenyEqualsNot [
	self assert: 'self deny: self toto equals: self tata not' isRewrittenAs: 'self assert: self toto equals: self tata'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testDenyEqualsNot2 [
	self assert: 'self deny: self toto not equals: self tata' isRewrittenAs: 'self assert: self toto equals: self tata'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testDenyNot [
	self assert: 'self deny: self toto not' isRewrittenAs: 'self assert: self toto'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testDifferent2Not [
	self assert: '(self toto ~~ self tata) not' isRewrittenAs: 'self toto == self tata'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testDifferentNot [
	self assert: '(self toto ~= self tata) not' isRewrittenAs: 'self toto = self tata'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testDoesNotReplaceIfItIntroduceAnInfinitLoop [
	| oldMethod |
	class
		compile:
			'>= arg
  ^(self < arg) not'.

	oldMethod := class >> #>=.

	self runCleaner.

	self
		assert: (class >> #>=) sourceCode
		equals:
			'>= arg
  ^(self < arg) not'.

	self assert: class >> #>= identicalTo: oldMethod
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testEqualNot [
	self assert: '(self toto = self tata) not' isRewrittenAs: 'self toto ~= self tata'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testFalseNot [
	self assert: 'false not' isRewrittenAs: 'true'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testIdenticalNot [
	self assert: '(self toto == self tata) not' isRewrittenAs: 'self toto ~~ self tata'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testInferiorNot [
	self assert: '(self toto < self tata) not' isRewrittenAs: 'self toto >= self tata'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testInferiorOrEqualNot [
	self assert: '(self toto <= self tata) not' isRewrittenAs: 'self toto > self tata'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testIsEmptyNot [
	self assert: '#() isEmpty not' isRewrittenAs: '#() isNotEmpty'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testIsNilNot [
	self assert: 'nil isNil not' isRewrittenAs: 'nil isNotNil'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testIsNotEmptyNot [
	self assert: '#() isNotEmpty not' isRewrittenAs: '#() isEmpty'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testIsNotNilNot [
	self assert: 'nil isNotNil not' isRewrittenAs: 'nil isNil'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testNotIfFalse [
	self assert: 'self test not ifFalse: [ 1 ]' isRewrittenAs: 'self test ifTrue: [ 1 ]'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testNotIfFalseIfTrue [
	self assert: 'self test not ifFalse: [ 1 ] ifTrue: [ 2 ]' isRewrittenAs: 'self test ifTrue: [ 1 ] ifFalse: [ 2 ]'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testNotIfTrue [
	self assert: 'self test not ifTrue: [ 1 ]' isRewrittenAs: 'self test ifFalse: [ 1 ]'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testNotIfTrueIfFalse [
	self assert: 'self test not ifTrue: [ 2 ] ifFalse: [ 1 ]' isRewrittenAs: 'self test ifTrue: [ 1 ] ifFalse: [ 2 ]'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testNotNot [
	self assert: 'self test not not' isRewrittenAs: 'self test'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testRegression1 [
	self denyIsRewritten: '| rewriter |
	rewriter := self rewriter.
	(self scope flatCollect: [ :class | class localMethods , class class localMethods ])
		do: [ :method | (rewriter executeTree: method ast) ifTrue: [ method installAST ] ]'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testRejectNot [
	self assert: '#() reject: [:e | e odd not ]' isRewrittenAs: '#() select: [:e |  e odd ]'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testRejectNotDoesNotRemoveIntermediateStatementsAndTemporaries [
	self
		assert:
			'#() reject: [:e | | test |
        test := self toto.
        e odd not ]'
		isRewrittenAs:
			'#() select: [:e |  | test |
        test := self toto.
        e odd ]'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testSelectNot [
	self assert: '#() select: [:e | e odd not ]' isRewrittenAs: '#() reject: [:e |  e odd ]'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testSuperiorNot [
	self assert: '(self toto > self tata) not' isRewrittenAs: 'self toto <= self tata'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testSuperiorOrEqualNot [
	self assert: '(self toto >= self tata) not' isRewrittenAs: 'self toto < self tata'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testTrueNot [
	self assert: 'true not' isRewrittenAs: 'false'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testWhileFalseNot [
	self assert: '[ self toto not ] whileFalse: [ self tata ]' isRewrittenAs: '[ self toto ] whileTrue: [ self tata ]'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testWhileFalseNot2 [
	self assert: '[ self toto not ] whileFalse' isRewrittenAs: '[ self toto ] whileTrue'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testWhileTrueNot [
	self assert: '[ self toto not ] whileTrue: [ self tata ]' isRewrittenAs: '[ self toto ] whileFalse: [ self tata ]'
]

{ #category : #tests }
ChanelRemoveUnecesaryNotCleanerTest >> testWhileTrueNot2 [
	self assert: '[ self toto not ] whileTrue' isRewrittenAs: '[ self toto ] whileFalse'
]
