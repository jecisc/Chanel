Class {
	#name : #ChanelCleanersOrderTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #running }
ChanelCleanersOrderTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeEmptyAssertions [
	"The alias cleaner needs to run before the empty assertions cleaner."
	
	class := self createDefaultTestClass.

	class
		compile:
			('{1}
  {2}' format: {self selector . 'self assert: #() notEmpty'}).

	Chanel perfume: {package} using: {ChanelTestEmptyAssertionsCleaner . ChanelMethodAliasesCleaner}.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . 'self denyEmpty: #()'})
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeEmptyConditionals [
	"The alias cleaner needs to run before the empty conditionals cleaner."

	class
		compile:
			('{1}
  {2}' format: {self selector . '#() notEmpty ifTrue: [ 1 ]'}).

	Chanel perfume: {package} using: {ChanelEmptyConditionalSimplifierCleaner . ChanelMethodAliasesCleaner}.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '#() ifNotEmpty: [ 1 ]'})
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeNilConditionals [
	"The alias cleaner needs to run before the nil conditionals cleaner."

	class
		compile:
			('{1}
  {2}' format: {self selector . '10 notNil ifTrue: [ 1 ]'}).

	Chanel perfume: {package} using: {ChanelNilConditionalSimplifierCleaner . ChanelMethodAliasesCleaner}.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '10 ifNotNil: [ 1 ]'})
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeNilConditionalsBeforeCutConditionalBranches [
	"The alias cleaner needs to run before the nil conditionals cleaner which need to run before the cut conditional branches."

	class
		compile:
			('{1}
  {2}' format: {self selector . '10 notNil ifFalse: [ nil ]'}).

	Chanel perfume: {package} using: {ChanelNilConditionalSimplifierCleaner . ChanelCutConditionalBranchesCleaner . ChanelMethodAliasesCleaner}.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '10'})
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeNilConditionalsBeforeCutConditionalBranches2 [
	"The alias cleaner needs to run before the nil conditionals cleaner which need to run before the cut conditional branches."

	class
		compile:
			('{1}
  {2}' format: {self selector . '10 notNil ifFalse: nil'}).

	Chanel perfume: {package} using: {ChanelNilConditionalSimplifierCleaner . ChanelCutConditionalBranchesCleaner . ChanelMethodAliasesCleaner}.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '10'})
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeNilConditionalsBeforeCutConditionalBranchesBeforeUnreadTemporaries [
	"The alias cleaner needs to run before the nil conditionals cleaner which need to run before the cut conditional branches which needs to run before the remove unused temporaries."

	class
		compile:
			('{1}
  {2}' format: {self selector . '| x |
  x := self patate.
  x notNil ifFalse: [ nil ].
  ^3'}).

	Chanel perfume: {package} using: {ChanelNilConditionalSimplifierCleaner . ChanelUnreadTemporaryCleaner .ChanelCutConditionalBranchesCleaner . ChanelMethodAliasesCleaner}.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . 'self patate.
  ^3'})
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeUnecessaryNot [
	class
		compile:
			('{1}
  {2}' format: {self selector . 'self toto notEmpty not'}).

	Chanel perfume: {package} using: {ChanelRemoveUnecesaryNotCleaner . ChanelMethodAliasesCleaner}.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . 'self toto isEmpty'})
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeUnecessaryNotBeforeEmptySimplifier [
	class
		compile:
			('{1}
  {2}' format: {self selector . 'self toto notEmpty not ifTrue: [ 1 ]'}).

	Chanel perfume: {package} using: {ChanelRemoveUnecesaryNotCleaner . ChanelMethodAliasesCleaner. ChanelEmptyConditionalSimplifierCleaner }.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . 'self toto ifEmpty: [ 1 ]'})
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeUnecessaryNotBeforeNilSimplifier [
	class
		compile:
			('{1}
  {2}' format: {self selector . 'self toto notNil not ifTrue: [ 1 ]'}).

	Chanel perfume: {package} using: {ChanelRemoveUnecesaryNotCleaner . ChanelMethodAliasesCleaner. ChanelNilConditionalSimplifierCleaner }.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . 'self toto ifNil: [ 1 ]'})
]

{ #category : #tests }
ChanelCleanersOrderTest >> testNilEqualityBeforeNilConditionals [
	"The alias cleaner needs to run before the nil conditionals cleaner."

	class
		compile:
			('{1}
  {2}' format: {self selector . '(10 ~= nil) ifTrue: [ 1 ]'}).

	Chanel perfume: {package} using: {ChanelNilConditionalSimplifierCleaner . ChanelNilEqualitySimplifierCleaner}.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '10 ifNotNil: [ 1 ]'})
]

{ #category : #tests }
ChanelCleanersOrderTest >> testNilEqualityBeforeNilConditionalsBeforeCutConditionalBranches [
	"The nil equality cleaner needs to run before the nil conditionals cleaner which need to run before the cut conditional branches."

	class
		compile:
			('{1}
  {2}' format: {self selector . '(10 ~= nil) ifFalse: [ nil ]'}).

	Chanel perfume: {package} using: {ChanelNilConditionalSimplifierCleaner . ChanelCutConditionalBranchesCleaner . ChanelNilEqualitySimplifierCleaner}.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '10'})
]

{ #category : #tests }
ChanelCleanersOrderTest >> testUnreadTemporariesBeforeUselessASTNodes [
	"The cleaner removing the useless AST nodes need to run after the cleaner removing unread temporaries because it will remove more nodes that way."

	class
		compile:
			'testMethod
  | test |
  test := #toto.
  ^#one'.

	Chanel perfume: {package} using: {ChanelRemoveUnusedNodesFromASTCleaner . ChanelUnreadTemporaryCleaner}.

	self
		assert: (class >> #testMethod) sourceCode
		equals:
			'testMethod
  ^#one'
]
