Class {
	#name : #ChanelMethodAliasesCleanerTest,
	#superclass : #ChanelMethodRewriterCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #helpers }
ChanelMethodAliasesCleanerTest >> expressionWithNoReplacement [
	^ '#() isNotEmpty'
]

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
ChanelMethodAliasesCleanerTest >> testincludesAllOf [
	self assert: '#() includesAllOf: #()' isRewrittenAs: '#() includesAll: #()'
]

{ #category : #tests }
ChanelMethodAliasesCleanerTest >> testincludesAnyOf [
	self assert: '#() includesAnyOf: #()' isRewrittenAs: '#() includesAny: #()'
]
