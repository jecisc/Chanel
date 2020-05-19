"
Description
--------------------

I am a cleaner trying to extract returns from conditions.
"
Class {
	#name : #ChanelExtractReturnFromAllBranchesCleaner,
	#superclass : #ChanelAbstractCleaner,
	#category : #Chanel
}

{ #category : #cleaning }
ChanelExtractReturnFromAllBranchesCleaner >> clean [
  (self cleanASTs: (self configuration localMethods collect: #ast)) do: #install
]

{ #category : #cleaning }
ChanelExtractReturnFromAllBranchesCleaner >> cleanASTs: aCollectionOfMethods [
	"In the end we run again the cleaning on ASTs because we can have case of nested conditionals each of the having returns in their branches."

	^ (aCollectionOfMethods iterator
		| #allChildren flatCollectIt
		| #isMessage selectIt
		| #isCascaded rejectIt
		| [ :node | node parent isLast: node ] selectIt
		| #isConditionNecessarilyExecutingABranch selectIt
		| [ :node | node arguments allSatisfy: #isBlock ] selectIt
		| [ :node | node arguments allSatisfy: #lastStatementIsReturn ] selectIt
		| [ :node | node arguments do: #inlineLastStatement ] doIt
		| #wrapsInReturn doIt
		| #methodNode collectIt
		> Set) ifNotEmpty: [ :updatedASTs | self cleanASTs: updatedASTs. updatedASTs ]
]
