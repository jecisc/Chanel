Class {
	#name : #ChanelRemoveUnusedNodesFromASTCleaner,
	#superclass : #ChanelAbstractCleaner,
	#category : #Chanel
}

{ #category : #accessing }
ChanelRemoveUnusedNodesFromASTCleaner class >> priority [
	^ 7500
]

{ #category : #cleaning }
ChanelRemoveUnusedNodesFromASTCleaner >> clean [
	(self configuration localMethods iterator
		| #ast collectIt
		| #allChildren flatCollectIt
		| [ :node | node isImmediateNode and: [ (node isArgument or: [ node isTemp ]) not] ] selectIt
		| [ :node | node parents noneSatisfy: [ :p | p isPragma or: [ p isReturn or: [ p isMessage or: [ p isAssignment or: [ p isDynamicArray or: [ p isLiteralArray ] ] ] ] ] ] ] selectIt
		| [ :node | node removeFromTree ] doIt
		| #methodNode collectIt
		> Set) do: #install
]
