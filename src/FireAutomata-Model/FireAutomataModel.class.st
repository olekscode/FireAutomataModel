Class {
	#name : #FireAutomataModel,
	#superclass : #CMAbstractModel,
	#instVars : [
		'theCells'
	],
	#classInstVars : [
		'defaultInit'
	],
	#category : #'FireAutomata-Model'
}

{ #category : #accessing }
FireAutomataModel class >> aboutThisModel [

	^ 'This is a simple cellular automata (CA) that simulate the diffusion of fire in a forest.
A cell can take one of the 3 following states: forest, fire or empty.
In one step, the CA uses 2 loops in order to 

1) calculate the next state of each cell (stored in the bufferState attribute), 

then 2) to update the state of all the cells.

For more information, see: http://cormas.cirad.fr/fr/applica/fireautomata.htm 
'
]

{ #category : #default }
FireAutomataModel class >> defaultControl [

	^ #step:
]

{ #category : #accessing }
FireAutomataModel class >> defaultInit [

	^ defaultInit ifNil: [ defaultInit := #init58WithFireWithFiremen ]
]

{ #category : #accessing }
FireAutomataModel class >> defaultInit: anObject [

	defaultInit := anObject 
]

{ #category : #default }
FireAutomataModel class >> defaultNumberOfColumns [

	^ 100
]

{ #category : #default }
FireAutomataModel class >> defaultNumberOfRows [

	^ 100
]

{ #category : #default }
FireAutomataModel class >> defaultProbes [

	^ #( #numberOfTreeCells )
]

{ #category : #description }
FireAutomataModel class >> howToRunIt [

	^ '1. Prepare the visualisation of the spatial grid. 

1.1 Click on the first icon of the Visualisation area to open the standard spatial grid.

1.2 In the Topology menu, clicking on the Grid size item opens a window allowing you to choose the number of lines and columns. For example, choose 30 * 30.

1.3 Check the border condition: Topology -> Grid boundaries -> closed.

1.4 Right-click within the spatial grid window to select the pov view for FireAutomata_Cell .

1.5 To display the legend of this viewpoint: Tools -> Display legends.


2. Prepare the initial spatial grid

2.1 Click on the Initialize button of the Simulation area.

2.2 Select the init53 and stepSynchronously: methods, then validate by clicking on Apply and close.

2.3 From the spatial grid menu, use Tools -> Click to... -> Change attribute... -> state, enter fire and validate. The cursor takes a new shape. Click on a cell to change manually its state to fire, then switch back to the mouse select mode with Tools -> Click to... -> Select 


3. Run the model

3.1 Enter 50 in the Final time input field of the Simulation area.

3.2 Click on the Run button of the Simulation area.


4. Have a look at the charts

4.1 Click on the third icon of the Visualisation area to open the charts window.



5. Run alternative versions of the model

5.1 Select the init58 and stepSynchronously: methods, then run the model again.

5.2 Select the init53 and stepAsynchronously: methods, then run the model again.'
]

{ #category : #init }
FireAutomataModel >> init53 [

	self initCommon.
	self theCells do: [ :cell | cell generateTreeWithProbability: 0.53 ].
]

{ #category : #init }
FireAutomataModel >> init53WithFire [

	self init53.
	self pickCell setOnFire
]

{ #category : #init }
FireAutomataModel >> init58 [

	self initCommon.
	self theCells do: [ :cell | cell generateTreeWithProbability: 0.58 ].
]

{ #category : #init }
FireAutomataModel >> init58WithColumnOfFire [
	
	self init58.
	self setFirstColumnOnFire.
]

{ #category : #init }
FireAutomataModel >> init58WithFire [

	self init58.
	self pickCell setOnFire.
]

{ #category : #init }
FireAutomataModel >> init58WithMultipleFires [

	| numberOfFires |
	numberOfFires := 3.

	self init58.
	self theCells do: #init58WithMultipleFires.
	
	numberOfFires timesRepeat: [ self pickCell setOnFire ]
]

{ #category : #initialization }
FireAutomataModel >> initCommon [

	self
		createGridLines: self class defaultNumberOfRows
		columns: self class defaultNumberOfColumns
		neighbourhood: 4
		closed: true.
	
	self displayPov: #pov of: FireAutomataCell. 
]

{ #category : #initialization }
FireAutomataModel >> initialize [

	super initialize.
	theCells := OrderedCollection new.
]

{ #category : #probes }
FireAutomataModel >> numberOfAshCells [

	<probe>
	^ self theCells count: [ :cell | cell isAshCell ]
]

{ #category : #probes }
FireAutomataModel >> numberOfEmptyCells [

	<probe>
	^ self theCells count: [ :cell | cell isEmptyCell ]
]

{ #category : #probes }
FireAutomataModel >> numberOfFireCells [

	<probe>
	^ self theCells count: [ :cell | cell isFireCell ]
]

{ #category : #probes }
FireAutomataModel >> numberOfTreeCells [

	<probe>
	^ self theCells count: [ :cell | cell isTreeCell ]
]

{ #category : #initialization }
FireAutomataModel >> setFirstColumnOnFire [

	| numberOfRows numberOfColumns firstCellInRow |
	
	numberOfRows := self spaceModel line.
	numberOfColumns := self spaceModel column.
	
	1 to: numberOfRows do: [ :rowIndex |
		firstCellInRow := self theCells at: (rowIndex - 1) * numberOfColumns + 1.
		firstCellInRow setOnFire ].
]

{ #category : #control }
FireAutomataModel >> step: anObject [

	self stepSynchronously: anObject
]

{ #category : #accessing }
FireAutomataModel >> theCells [

	^ theCells
]

{ #category : #accessing }
FireAutomataModel >> theCells: anObject [

	theCells := anObject
]
