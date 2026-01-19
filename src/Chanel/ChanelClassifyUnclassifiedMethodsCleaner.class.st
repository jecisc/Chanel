"
Description
--------------------

I am a cleaner that tries to categorize via the method categorizer of the system unclassified methods.
"
Class {
	#name : 'ChanelClassifyUnclassifiedMethodsCleaner',
	#superclass : 'ChanelAbstractCleaner',
	#category : 'Chanel',
	#package : 'Chanel'
}

{ #category : 'accessing' }
ChanelClassifyUnclassifiedMethodsCleaner class >> requirements [
	^ { ChanelProtocolsCleaner }
]

{ #category : 'cleaning' }
ChanelClassifyUnclassifiedMethodsCleaner >> clean [
	self configuration definedClasses iterator
		| [ :class | { class . class class }  ] flatCollectIt
		| [ :class | class uncategorizedSelectors collect: [ :selector | class >> selector ] ] flatCollectIt
		| [ :method | MethodClassifier classify: method ] doIt
		| [ :method | method protocolName ~= #'as yet unclassified' ] selectIt
		> [ :method |  ('Method ' , method printString , ' was categorized in ' , method protocolName) record ] doIt
]
