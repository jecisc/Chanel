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

{ #category : #accessing }
ChanelExtractReturnFromAllBranchesCleaner class >> priority [
	^ 15000
]

{ #category : #cleaning }
ChanelExtractReturnFromAllBranchesCleaner >> clean [
	(self configuration localMethods iterator
		| #ast collectIt
		| #allChildren flatCollectIt
		| #isMessage selectIt
		| #isCascaded rejectIt
		| [ :node | node parent isLast: node ] selectIt
		| #isConditionNecessarilyExecutingABranch selectIt
		| [ :node | node arguments allSatisfy: #isBlock ] selectIt
		| [ :node | node arguments allSatisfy: #hasBlockReturn ] selectIt
		| [ :node | node arguments do: #inlineLastReturn ] doIt
		| #wrapsInReturn doIt
		| #methodNode collectIt
		> Set) do: #install
]
