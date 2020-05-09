"
Description
--------------------

I remove each methods only doing a super call. Does not remove methods with pragmas.
"
Class {
	#name : #ChanelMethodsOnlyCallingSuperCleaner,
	#superclass : #ChanelAbstractCleaner,
	#category : #Chanel
}

{ #category : #accessing }
ChanelMethodsOnlyCallingSuperCleaner class >> requirements [
	^ { ChanelRemoveUnusedNodesFromASTCleaner. ChanelNilAssignationInInitializeCleaner . ChanelRemoveAssigmentWithoutEffectCleaner }
]

{ #category : #cleaning }
ChanelMethodsOnlyCallingSuperCleaner >> clean [
	| matcher |
	matcher := RBParseTreeSearcher justSendsSuper.
	self configuration localMethods iterator
		| #hasPragma rejectIt
		| [ :method | matcher executeMethod: method ast initialAnswer: false ] selectIt
		> #removeMethod doIt
]
