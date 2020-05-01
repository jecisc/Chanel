"
Description
--------------------

I am a cleaner removing some useless nodes from methods asts.
"
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
		| #canBeUselessNode selectIt
		| [ :node | node allParents allSatisfy: #canHaveUselessChildren ] selectIt
		| #removeFromTree doIt
		| #methodNode collectIt
		> Set) do: #install
]
