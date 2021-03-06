

	.FUNCT	DINER-F
	EQUAL?	PRSA,V?WALK-TO \FALSE
	EQUAL?	CAR-HERE,DINER-CAR \?ELS10
	CALL1	HAR-HAR
	RSTACK	
?ELS10:	ZERO?	DINER-TOUCHED /FALSE
	SET	'CLOCK-WAIT,TRUE-VALUE
	PRINTR	"(You'll have to get there on your own.)"


	.FUNCT	GENERIC-BOOTH-F,X
	EQUAL?	HERE,HALL-1-DINER,BOOTH-1 \?ELS5
	RETURN	BOOTH-1
?ELS5:	EQUAL?	HERE,HALL-2-DINER,BOOTH-2 \?ELS7
	RETURN	BOOTH-2
?ELS7:	EQUAL?	HERE,HALL-3-DINER,BOOTH-3 \?ELS9
	RETURN	BOOTH-3
?ELS9:	CALL1	REMOTE-VERB?
	ZERO?	STACK \FALSE
	SET	'CLOCK-WAIT,TRUE-VALUE
	PRINTI	"(You can't see any booth here.)"
	CRLF	
	RETURN	NOT-HERE-OBJECT


	.FUNCT	PANTRY-F,RARG=0
	EQUAL?	RARG,M-LOOK \?ELS5
	CALL2	ROOM-IS-CROWDED,PANTRY
	RSTACK	
?ELS5:	EQUAL?	RARG,M-END \FALSE
	IN?	WAITER,PANTRY \FALSE
	CALL2	INVASION?,WAITER
	RFALSE	


	.FUNCT	INVASION?,PER
	GETP	PER,P?SOUTH
	LESS?	0,STACK /FALSE
	EQUAL?	PRSA,V?SMILE /FALSE
	EQUAL?	PRSA,V?KISS,V?GIVE,V?$CALL /FALSE
	EQUAL?	INVASION-TIME,PRESENT-TIME /FALSE
	ZERO?	CLOCK-WAIT \FALSE
	SET	'INVASION-TIME,PRESENT-TIME
	CALL	HE-SHE-IT,PER,TRUE-VALUE,STR?154
	PRINTI	" a pushing motion with one hand and points forward with the other. "
	CALL	HE-SHE-IT,PER,TRUE-VALUE,STR?194
	PRINTI	" angry that you're invading"
	CALL	HIM-HER-IT,PER,FALSE-VALUE,TRUE-VALUE
	PRINTR	" space."


	.FUNCT	GALLEY-F,RARG=0
	EQUAL?	RARG,M-LOOK \?ELS5
	CALL2	ROOM-IS-CROWDED,GALLEY
	RSTACK	
?ELS5:	EQUAL?	RARG,M-END \FALSE
	IN?	COOK,GALLEY \FALSE
	CALL2	INVASION?,COOK
	RFALSE	


	.FUNCT	COUNTER-GALLEY-F
	EQUAL?	PRSA,V?LOOK-ON,V?EXAMINE \FALSE
	PRINTR	"The counter is crowded with kitchen hardware and software."


	.FUNCT	ROOM-IS-CROWDED,RM
	CALL2	START-SENTENCE,RM
	PRINTI	" is crowded with supplies and equipment. The locked cabinets are probably filled with "
	EQUAL?	RM,PANTRY \?ELS5
	PRINTI	"dishes, tableware, and napkins"
	JUMP	?CND3
?ELS5:	EQUAL?	RM,GALLEY \?CND3
	PRINTI	"food, kettles, and kitchen tools. There's a crowded counter for preparing food"
?CND3:	PRINTR	". If you want to find something, you'll have to search for it."


	.FUNCT	BOOTH-F,RARG=0,?TMP1
	EQUAL?	RARG,M-ENTER \?ELS5
	ZERO?	DEBUG /?CND6
	PRINTI	"[booth entry routine]"
	CRLF	
?CND6:	IN?	WAITER,HERE \?ELS16
	PUTP	WAITER,P?LDESC,25
	RFALSE	
?ELS16:	EQUAL?	SCENERY-OBJ,STATION-GRNZ /FALSE
	CALL	ESTABLISH-GOAL,WAITER,HERE
	RFALSE	
?ELS5:	EQUAL?	RARG,M-END \?ELS22
	CALL1	EXIT-VERB?
	ZERO?	STACK /FALSE
	CALL2	META-LOC,FOOD
	EQUAL?	HERE,STACK /?THN30
	CALL2	META-LOC,CUP-A >?TMP1
	CALL2	META-LOC,CUP-B
	EQUAL?	HERE,?TMP1,STACK \FALSE
?THN30:	CALL	ESTABLISH-GOAL,WAITER,HERE
	RFALSE	
?ELS22:	EQUAL?	RARG,M-LOOK \?ELS33
	FSET	BOOTH-1,TOUCHBIT
	FSET	BOOTH-2,TOUCHBIT
	FSET	BOOTH-3,TOUCHBIT
	CALL1	BOOTH-DESC
	CALL1	MOTION-PREFIX
	RTRUE	
?ELS33:	EQUAL?	RARG,M-BEG \FALSE
	CALL1	PERSON-TAKES-GUN?
	RSTACK	


	.FUNCT	BOOTH-DESC
	PRINTI	"This is a diner booth on the "
	PRINT	TRAIN-NAME
	PRINTR	". In fact, it looks as if the railway company just converted a first-class coach into a diner by removing the door and adding a table to each compartment."


	.FUNCT	FROY-F
	EQUAL?	PRSA,V?READ,V?EXAMINE,V?ANALYZE \FALSE
	FSET?	FROY,TOUCHBIT /?ELS10
	FSET	FROY,TOUCHBIT
	FSET	FROY,NDESCBIT
	PRINTR	"It's hard to read in this light, but the writing seems to say ""FROY."""
?ELS10:	PRINTR	"Hmmm... The writing seems to have vanished."


	.FUNCT	REST-ROOM-REAR-DINER-DOOR-F
	CALL	REST-ROOM-DOOR-F,REST-ROOM-REAR-DINER-DOOR,REST-ROOM-REAR-DINER
	RSTACK	


	.FUNCT	REST-ROOM-FWD-DINER-DOOR-F
	CALL	REST-ROOM-DOOR-F,REST-ROOM-FWD-DINER-DOOR,REST-ROOM-FWD-DINER
	RSTACK	


	.FUNCT	MACHINE-F,P
	EQUAL?	PRSO,MACHINE \?ELS5
	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS5
	CALL1	YOU-CANT
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?LOOK-THROUGH /?THN10
	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE,V?ANALYZE \?ELS9
?THN10:	PRINTR	"The plastic panel is so scratched and grimy that you can barely see the display of cigarette packs inside."
?ELS9:	EQUAL?	PRSA,V?MUNG \?ELS15
	PRINTR	"It seems that someone else beat you to it."
?ELS15:	EQUAL?	PRSA,V?SHAKE,V?SLAP,V?ATTACK \?ELS19
	FSET?	MACHINE,MUNGBIT /?ELS19
	FSET?	CIGARETTE,TOUCHBIT /?ELS19
	LOC	CIGARETTE >P
	FSET?	P,PERSONBIT \?CND22
	GETP	P,P?LDESC
	EQUAL?	5,STACK \?CND22
	FCLEAR	P,TOUCHBIT
	PUTP	P,P?LDESC,4
?CND22:	FSET	CIGARETTE,TOUCHBIT
	FSET	CIGARETTE,TAKEBIT
	MOVE	CIGARETTE,HERE
	CALL2	THIS-IS-IT,CIGARETTE
	PRINTR	"The machine shudders and disgorges a single cigarette onto the floor."
?ELS19:	EQUAL?	PRSA,V?PUT-IN /?THN31
	EQUAL?	PRSA,V?SHAKE,V?SLAP,V?ATTACK \FALSE
?THN31:	EQUAL?	PRSA,V?PUT-IN \?CND33
	ZERO?	P-DOLLAR-FLAG /?ELS38
	EQUAL?	PRSO,GLOBAL-MONEY,INTNUM \?ELS38
	GETP	PLAYER,P?SOUTH
	LESS?	STACK,P-AMOUNT /?ELS38
	EQUAL?	VARIATION,2,4 \?CND41
	FSET	MACHINE,MUNGBIT
?CND41:	GETP	PLAYER,P?SOUTH
	SUB	STACK,P-AMOUNT
	PUTP	PLAYER,P?SOUTH,STACK
	JUMP	?CND33
?ELS38:	CALL1	YOU-CANT
	RTRUE	
?CND33:	RANDOM	100
	LESS?	50,STACK /?ELS48
	PRINTI	"""Whirr, buzz"
	JUMP	?CND46
?ELS48:	PRINTI	"""Whizz, burr"
?CND46:	PRINTR	", click!"" Nothing else happens."


	.FUNCT	PICK-ONE-BOOTH,X
	RANDOM	3 >X
	EQUAL?	X,1 \?ELS5
	RETURN	BOOTH-1
?ELS5:	EQUAL?	X,2 \?ELS7
	RETURN	BOOTH-2
?ELS7:	EQUAL?	X,3 \FALSE
	RETURN	BOOTH-3


	.FUNCT	SUITE-1-DOOR-F
	CALL2	COMPARTMENT-DOOR-F,SUITE-1-DOOR
	RSTACK	


	.FUNCT	SUITE-2-DOOR-F
	CALL2	COMPARTMENT-DOOR-F,SUITE-2-DOOR
	RSTACK	


	.FUNCT	SUITE-3-DOOR-F
	CALL2	COMPARTMENT-DOOR-F,SUITE-3-DOOR
	RSTACK	


	.FUNCT	SUITE-F,RARG=0,N
	ZERO?	RARG /FALSE
	CALL1	V-FOO
	RTRUE	


	.FUNCT	HALL-FANCY-F,RARG=0,X,TOUCHED=0,VAL=0
	FSET?	HALL-1-FANCY,TOUCHBIT /?THN4
	FSET?	HALL-1-FANCY,TOUCHBIT /?THN4
	FSET?	HALL-1-FANCY,TOUCHBIT \?CND1
?THN4:	SET	'TOUCHED,TRUE-VALUE
?CND1:	EQUAL?	RARG,M-LOOK /?THN11
	ZERO?	RARG \?ELS10
	EQUAL?	PRSA,V?LOOK \?ELS10
?THN11:	FSET	HERE,TOUCHBIT
	PRINTI	"This is the "
	PRINTD	HERE
	PRINTI	" of the corridor."
	EQUAL?	PRSA,V?LOOK /?THN20
	ZERO?	TOUCHED \?CND17
?THN20:	PRINTI	" The floor and walls are covered with grey carpet, worn thin in spots but intact. A long series of windows, framed by polished wood, runs along the corridor on the right-hand side of the train."
?CND17:	EQUAL?	PLAYER-NOT-FACING,P?WEST \?ELS26
	CRLF	
	RTRUE	
?ELS26:	GETPT	HERE,P?IN
	GET	STACK,REXIT >X
	CALL2	THIS-IS-IT,X
	PRINTI	" On the left side of the train, behind a locked door, lies the "
	PRINTD	X
	PRINTR	"."
?ELS10:	EQUAL?	RARG,M-ENTER \FALSE
	CALL2	NOISY?,LAST-PLAYER-LOC
	ZERO?	STACK /?CND33
	SET	'VAL,TRUE-VALUE
	PRINTI	"The relative quiet here is welcome. "
?CND33:	ZERO?	TOUCHED \?CND41
	SET	'VAL,TRUE-VALUE
	PRINTI	"The feel of luxury here is unmistakable."
?CND41:	ZERO?	VAL /FALSE
	CRLF	
	RFALSE	

	.ENDI
