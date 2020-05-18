"
Description
--------------------

I am a cleaner trying to extract assignations from conditions.
"
Class {
	#name : #ChanelExtractAssignationsFromConditionals,
	#superclass : #ChanelAbstractCleaner,
	#category : #Chanel
}

{ #category : #cleaning }
ChanelExtractAssignationsFromConditionals >> clean [
  (self cleanASTs: (self configuration localMethods collect: #ast)) do: #install
]

{ #category : #cleaning }
ChanelExtractAssignationsFromConditionals >> cleanASTs: aCollectionOfMethods [
	"In the end we run again the cleaning on ASTs because we can have case of nested conditionals each of the having assignations in their branches."

	^ (aCollectionOfMethods iterator
		| #allChildren flatCollectIt
		| #isMessage selectIt
		| #isCascaded rejectIt
		| [ :node | node parent isLast: node ] selectIt
		| #isConditionNecessarilyExecutingABranch selectIt
		| [ :node | node arguments allSatisfy: #isBlock ] selectIt
		| [ :node | node arguments allSatisfy: #lastStatementIsAssignment ] selectIt
		| [ :node | (node arguments collect: #lastAssignmentVariable as: Set) size = 1  ] selectIt
		| #inlineAssignationFromArguments doIt
		| #methodNode collectIt
		> Set) ifNotEmpty: [ :updatedASTs | self cleanASTs: updatedASTs. updatedASTs ]
]
