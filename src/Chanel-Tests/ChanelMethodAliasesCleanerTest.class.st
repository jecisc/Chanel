Class {
	#name : #ChanelMethodAliasesCleanerTest,
	#superclass : #ChanelMethodRewriterCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #helpers }
ChanelMethodAliasesCleanerTest >> replacementPair [
	^ '#() notEmpty' -> '#() isNotEmpty'
]

{ #category : #running }
ChanelMethodAliasesCleanerTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : #tests }
ChanelMethodAliasesCleanerTest >> testDoesNotReplaceIfItIntroduceAnInfinitLoop [
	| oldMethod |
	class
		compile:
			'isNotEmpty
  ^self notEmpty'.

	oldMethod := class >> #isNotEmpty.

	self runCleaner.

	self
		assert: (class >> #isNotEmpty) sourceCode
		equals:
			'isNotEmpty
  ^self notEmpty'.

	self assert: class >> #isNotEmpty identicalTo: oldMethod
]

{ #category : #tests }
ChanelMethodAliasesCleanerTest >> testDoesNotReplaceIfItIntroduceAnInfinitLoop2 [
	| oldMethod |
	class
		compile:
			'isNotEmpty
  self notEmpty'.

	oldMethod := class >> #isNotEmpty.

	self runCleaner.

	self
		assert: (class >> #isNotEmpty) sourceCode
		equals:
			'isNotEmpty
  self notEmpty'.

	self assert: class >> #isNotEmpty identicalTo: oldMethod
]

{ #category : #tests }
ChanelMethodAliasesCleanerTest >> testIfNilIfNotNilDo [
	self assert: 'nil ifNil: [ false ] ifNotNilDo: [ true ]' isRewrittenAs: 'nil ifNil: [ false ] ifNotNil: [ true ]'
]

{ #category : #tests }
ChanelMethodAliasesCleanerTest >> testIfNotNilDo [
	self assert: 'nil ifNotNilDo: [ true ]' isRewrittenAs: 'nil ifNotNil: [ true ]'
]

{ #category : #tests }
ChanelMethodAliasesCleanerTest >> testIfNotNilDoIfNil [
	self assert: 'nil ifNotNilDo: [ true ] ifNil: [ false ]' isRewrittenAs: 'nil ifNotNil: [ true ] ifNil: [ false ]'
]

{ #category : #tests }
ChanelMethodAliasesCleanerTest >> testNotEmpty [
	self assert: '#() notEmpty' isRewrittenAs: '#() isNotEmpty'
]

{ #category : #tests }
ChanelMethodAliasesCleanerTest >> testNotNil [
	self assert: 'nil notNil' isRewrittenAs: 'nil isNotNil'
]

{ #category : #tests }
ChanelMethodAliasesCleanerTest >> testReplacementInTraits [
	| trait |
	trait := self createDefaultTrait.

	class setTraitComposition: trait.

	trait
		compile:
			('{1}
  {2}' format: {self selector . '#() notEmpty'}).

	self runCleaner.

	self
		assert: (trait >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '#() isNotEmpty'}).

	self assert: (trait localSelectors includes: self selector).
	self deny: (class localSelectors includes: self selector)
]

{ #category : #tests }
ChanelMethodAliasesCleanerTest >> testReplacementOnClassSide [
	self assertClassSide: '#() notEmpty' isRewrittenAs: '#() isNotEmpty'
]

{ #category : #tests }
ChanelMethodAliasesCleanerTest >> testWithNothingToReplace [
	self denyIsRewritten: '#() isNotEmpty'
]

{ #category : #tests }
ChanelMethodAliasesCleanerTest >> testincludesAllOf [
	self assert: '#() includesAllOf: #()' isRewrittenAs: '#() includesAll: #()'
]

{ #category : #tests }
ChanelMethodAliasesCleanerTest >> testincludesAnyOf [
	self assert: '#() includesAnyOf: #()' isRewrittenAs: '#() includesAny: #()'
]
