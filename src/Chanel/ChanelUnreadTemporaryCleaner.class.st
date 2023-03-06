"
Description
--------------------

I remove all temporaries that are defined but not read.
"
Class {
	#name : #ChanelUnreadTemporaryCleaner,
	#superclass : #ChanelAbstractCleaner,
	#category : #Chanel
}

{ #category : #accessing }
ChanelUnreadTemporaryCleaner class >> requirements [
	^ { ChanelCutConditionalBranchesCleaner . ChanelNilAssignationInInitializeCleaner . ChanelRemoveAssigmentWithoutEffectCleaner }
]

{ #category : #cleaning }
ChanelUnreadTemporaryCleaner >> clean [
	self configuration localMethods
		do: [ :method |
			(method ast allTemporaries select: #isNotReadOnce)
				ifNotEmpty: [ :temporariesToRemove |
					temporariesToRemove do: #inlineTemporary.
					method installAST ] ]
]
