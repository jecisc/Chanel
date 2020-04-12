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
			| ast |
			ast := method ast.
			(ast allSequenceNodes flatCollect: [ :sequence | sequence temporaries select: #isReadAtLeastOnce ])
				ifNotEmpty: [ :temporariesToRemove | 
					temporariesToRemove
						do: [ :temp | 
							temp declaringScope
								nodesDo: [ :node | (node isTemp and: [ node name = temp name ]) ifTrue: [ node parent replaceWith: node parent value ] ];
								removeTemporaryNamed: temp name ].
					ast install ] ]
]
