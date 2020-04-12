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
ChanelUnreadTemporaryCleaner class >> priority [
	^ 7000
]

{ #category : #cleaning }
ChanelUnreadTemporaryCleaner >> clean [
	self configuration localMethods
		do: [ :method | 
			(method ast allTemporaries select: #isReadAtLeastOnce)
				ifNotEmpty: [ :temporariesToRemove | 
					temporariesToRemove do: #inlineTemporary.
					method ast install ] ]
]
