Class {
	#name : #ChanelMethodAliasesCleanerTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

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
ChanelMethodAliasesCleanerTest >> testReplacementDoesNotRemoveExtensions [
	class
		compile:
			('{1}
  {2}' format: {self selector . '#() notEmpty'})
		classified: self extensionProtocol.

	self runCleaner.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '#() isNotEmpty'}).

	self assert: (class >> self selector) protocol equals: self extensionProtocol
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
	class class
		compile:
			('{1}
  {2}' format: {self selector . '#() notEmpty'}).

	self runCleaner.

	self
		assert: (class class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '#() isNotEmpty'})
]

{ #category : #tests }
ChanelMethodAliasesCleanerTest >> testWithNothingToReplace [
	| oldMethod |
	class
		compile:
			('{1}
	{2}' format: {self selector . '#() isNotEmpty'}).

	oldMethod := class >> self selector.
	self runCleaner.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
	{2}' format: {self selector . '#() isNotEmpty'}).
	
	self assert: class >> self selector identicalTo: oldMethod
]

{ #category : #tests }
ChanelMethodAliasesCleanerTest >> testincludesAllOf [
	self assert: '#() includesAllOf: #()' isRewrittenAs: '#() includesAll: #()'
]

{ #category : #tests }
ChanelMethodAliasesCleanerTest >> testincludesAnyOf [
	self assert: '#() includesAnyOf: #()' isRewrittenAs: '#() includesAny: #()'
]
