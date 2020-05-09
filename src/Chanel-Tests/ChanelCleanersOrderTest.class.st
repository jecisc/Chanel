Class {
	#name : #ChanelCleanersOrderTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #tests }
ChanelCleanersOrderTest >> assert: original isRewrittenAs: expected using: cleaners [
	class compile: (self methodBodyFor: original).

	Chanel perfume: {package} using: cleaners.

	self assert: (class >> self selector) sourceCode equals: (self methodBodyFor: expected)
]

{ #category : #running }
ChanelCleanersOrderTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeEmptyAssertions [
	"The alias cleaner needs to run before the empty assertions cleaner."

	class := self createDefaultTestClass.

	self assert: 'self assert: #() notEmpty' isRewrittenAs: 'self denyEmpty: #()' using: {ChanelTestEmptyAssertionsCleaner . ChanelMethodAliasesCleaner}
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeEmptyConditionals [
	"The alias cleaner needs to run before the empty conditionals cleaner."

	self assert: '#() notEmpty ifTrue: [ 1 ]' isRewrittenAs: '#() ifNotEmpty: [ 1 ]' using: {ChanelEmptyConditionalSimplifierCleaner . ChanelMethodAliasesCleaner}
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeExtractReturnBeforeNilConditionalsBeforeCutConditionalBranches [
	self
		assert: 'self patate notNil ifFalse: [ ^ nil ] ifTrue: [ ^ 3 ].'
		isRewrittenAs: '^self patate ifNotNil: [ 3 ]'
		using:
			{ChanelExtractReturnFromAllBranchesCleaner . ChanelNilConditionalSimplifierCleaner . ChanelCutConditionalBranchesCleaner.
			ChanelMethodAliasesCleaner}
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeNilConditionals [
	"The alias cleaner needs to run before the nil conditionals cleaner."

	self assert: '10 notNil ifTrue: [ 1 ]' isRewrittenAs: '10 ifNotNil: [ 1 ]' using: {ChanelNilConditionalSimplifierCleaner . ChanelMethodAliasesCleaner}
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeNilConditionalsBeforeCutConditionalBranches [
	"The alias cleaner needs to run before the nil conditionals cleaner which need to run before the cut conditional branches."

	self assert: '10 notNil ifFalse: [ nil ]' isRewrittenAs: '10' using: {ChanelNilConditionalSimplifierCleaner . ChanelCutConditionalBranchesCleaner . ChanelMethodAliasesCleaner}
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeNilConditionalsBeforeCutConditionalBranches2 [
	"The alias cleaner needs to run before the nil conditionals cleaner which need to run before the cut conditional branches."

	self assert: '10 notNil ifFalse: nil' isRewrittenAs: '10' using: {ChanelNilConditionalSimplifierCleaner . ChanelCutConditionalBranchesCleaner . ChanelMethodAliasesCleaner}
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeNilConditionalsBeforeCutConditionalBranchesBeforeUnreadTemporaries [
	"The alias cleaner needs to run before the nil conditionals cleaner which need to run before the cut conditional branches which needs to run before the remove unused temporaries."

	self
		assert:
			'| x |
  x := self patate.
  x notNil ifFalse: [ nil ].
  ^3'
		isRewrittenAs:
			'self patate.
  ^3'
		using: {ChanelNilConditionalSimplifierCleaner . ChanelUnreadTemporaryCleaner . ChanelCutConditionalBranchesCleaner . ChanelMethodAliasesCleaner}
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeUnecessaryNot [
	self assert: 'self toto notEmpty not' isRewrittenAs: 'self toto isEmpty' using: {ChanelRemoveUnecesaryNotCleaner . ChanelMethodAliasesCleaner}
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeUnecessaryNotBeforeEmptyAssertions [
	class := self createDefaultTestClass.
	self assert: 'self assert: #() notEmpty not' isRewrittenAs: 'self assertEmpty: #()' using: {ChanelRemoveUnecesaryNotCleaner . ChanelMethodAliasesCleaner. ChanelTestEmptyAssertionsCleaner}
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeUnecessaryNotBeforeEmptySimplifier [
	self assert: 'self toto notEmpty not ifTrue: [ 1 ]' isRewrittenAs: 'self toto ifEmpty: [ 1 ]' using: {ChanelRemoveUnecesaryNotCleaner . ChanelMethodAliasesCleaner . ChanelEmptyConditionalSimplifierCleaner}
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeUnecessaryNotBeforeNilSimplifier [
	self assert: 'self toto notNil not ifTrue: [ 1 ]' isRewrittenAs: 'self toto ifNil: [ 1 ]' using: {ChanelRemoveUnecesaryNotCleaner . ChanelMethodAliasesCleaner . ChanelNilConditionalSimplifierCleaner}
]

{ #category : #tests }
ChanelCleanersOrderTest >> testExtractReturnBeforeCutConditionals [
	self
		assert: 'self toto ifNil: [ ^ 1 ] ifNotNil: [ :e | ^ e ]'
		isRewrittenAs: '^self toto ifNil: [ 1 ]'
		using: {ChanelCutConditionalBranchesCleaner . ChanelExtractReturnFromAllBranchesCleaner}
]

{ #category : #tests }
ChanelCleanersOrderTest >> testNilEqualityBeforeNilConditionals [
	"The alias cleaner needs to run before the nil conditionals cleaner."

	self assert: '(10 ~= nil) ifTrue: [ 1 ]' isRewrittenAs: '10 ifNotNil: [ 1 ]' using: {ChanelNilConditionalSimplifierCleaner . ChanelNilEqualitySimplifierCleaner}
]

{ #category : #tests }
ChanelCleanersOrderTest >> testNilEqualityBeforeNilConditionalsBeforeCutConditionalBranches [
	"The nil equality cleaner needs to run before the nil conditionals cleaner which need to run before the cut conditional branches."

	self assert: '(10 ~= nil) ifFalse: [ nil ]' isRewrittenAs: '10' using: {ChanelNilConditionalSimplifierCleaner . ChanelCutConditionalBranchesCleaner . ChanelNilEqualitySimplifierCleaner}
]

{ #category : #tests }
ChanelCleanersOrderTest >> testUnreadTemporariesBeforeUselessASTNodes [
	"The cleaner removing the useless AST nodes need to run after the cleaner removing unread temporaries because it will remove more nodes that way."

	self
		assert:
			'| test |
  test := #toto.
  ^#one'
		isRewrittenAs: '^#one'
		using: {ChanelRemoveUnusedNodesFromASTCleaner . ChanelUnreadTemporaryCleaner}
]
