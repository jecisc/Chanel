"
I am a baseline to define the structure and dependencies of the Chanel project.
"
Class {
	#name : #BaselineOfChanel,
	#superclass : #BaselineOf,
	#category : #BaselineOfChanel
}

{ #category : #baselines }
BaselineOfChanel >> baseline: spec [

	<baseline>
	spec for: #common do: [
		self
			iterators: spec;
			tinyLogger: spec.

		spec
			package: 'Chanel' with: [ spec requires: #( 'Iterators' 'TinyLogger' ) ];
			package: 'Chanel-Tests' with: [ spec requires: #( 'Chanel' ) ].

		spec
			group: 'Core' with: #( 'Chanel' );
			group: 'Tests' with: #( 'Chanel-Tests' ) ].

	spec for: (self pharoVersionsFrom: 11) do: [
		spec
			package: 'Chanel-Pharo11Plus' with: [ spec requires: #( 'Chanel' ) ];
			package: 'Chanel-Pharo11Plus-Tests' with: [ spec requires: #( 'Chanel-Tests' 'Chanel-Pharo11Plus' ) ].


		spec
			group: 'Core' with: #( 'Chanel-Pharo11Plus' );
			group: 'Tests' with: #( 'Chanel-Pharo11Plus-Tests' ) ].

	spec for: #( #'pharo7.x' ) do: [
		self pharoBackwardCompatibility: spec.
		spec
			package: 'Chanel-Pharo7';
			package: 'Chanel-Tests' with: [ spec requires: #( 'Chanel-Pharo7' 'PharoBackwardCompatibility' ) ] ].

	spec for: #( #'pharo7.x' #'pharo8.x' ) do: [
		spec
			package: 'Chanel-Pharo8';
			package: 'Chanel' with: [ spec requires: #( 'Chanel-Pharo8' ) ] ].

	spec for: #( #'pharo7.x' #'pharo8.x' #'pharo9.x' ) do: [
		spec
			package: 'Chanel-Pharo9';
			package: 'Chanel' with: [ spec requires: #( 'Chanel-Pharo9' ) ] ]
]

{ #category : #dependencies }
BaselineOfChanel >> iterators: spec [
	spec
		baseline: 'Iterators'
		with: [ spec
				loads: #('core' 'collections' 'shell-dsl' 'inspector-extensions');
				repository: 'github://juliendelplanque/Iterators:v1.x.x/src' ]
]

{ #category : #dependencies }
BaselineOfChanel >> pharoBackwardCompatibility: spec [
   spec
    	baseline: 'PharoBackwardCompatibility'
    	with: [ spec repository: 'github://jecisc/PharoBackwardCompatibility:v1.x.x/src' ]
]

{ #category : #baselines }
BaselineOfChanel >> pharoVersionsFrom: aVersion [
	^ (aVersion to: SystemVersion current major) collect: [ :v | ('pharo' , v asString , '.x') asSymbol ]
]

{ #category : #accessing }
BaselineOfChanel >> projectClass [
	^ MetacelloCypressBaselineProject
]

{ #category : #dependencies }
BaselineOfChanel >> tinyLogger: spec [
	spec
		baseline: 'TinyLogger'
		with: [ spec
				loads: 'Core';
				repository: 'github://jecisc/TinyLogger:v1.x.x/src' ]
]
