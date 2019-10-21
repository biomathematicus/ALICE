<!--
// Eliza
// All input must be in uper case
// No punctuation except apostrophies
// As in don`t you`re i`m i`ve you`ve
//
// Adds ElizaClientName, ElizaSessionCount, ElizaQuestionCount and ElizaLastSaid to directory Cookie.
//
var count;
var start=true;
var name;

// Preload images
imgCasual1 = new Image();
imgCasual1.src = "../images/interactive/Eliza_Casual_1.gif"; // Animated GIF
imgCasual2 = new Image();
imgCasual2.src = "../images/interactive/Eliza_Casual_2.gif"; // Animated GIF
imgHiBye = new Image();
imgHiBye.src = "../images/interactive/Eliza_Hi_Bye.jpg";  // Static image
imgLaugh = new Image();
imgLaugh.src = "../images/interactive/Eliza_Laugh.jpg";  // Static image
imgHowKnows = new Image();
imgHowKnows.src = "../images/interactive/Eliza_WhoKnows.jpg";  // Static image
imgAstonished = new Image();
imgAstonished.src = "../images/interactive/Eliza_Astonished.jpg";  // Static image

function Initialise() {
	//--- Initialize Eliza's databank---
	// Fill with key words and aReply .
	var input = window.document.frmChat.txtQuestion;
	var output = document.getElementById("divAnswer");
	var counter = window.document.frmChat.txtCounter;
	var now = new Date();
	aKeyWord = new Array(65);
	aReply = new Array(65);	
	aMood = new Array(65);
	aKeyWord [0] = " PUEDE USTED";
	aReply   [0] = "TAL VEZ A USTED LE GUSTARÍA SER CAPAZ DE";
	aMood    [0] = "WHOKNOWS"; 
	
	aKeyWord [1] = " USTED HACE";
	aReply   [1] = "SÍ, YO";
	aMood    [1] = "CASUAL"; 
	
	aKeyWord [2] = " PUEDO";
	aReply   [2] = "TAL VEZ NO QUIERA SER CAPAZ DE";
	aMood    [2] = "WHOKNOWS"; 
	
	aKeyWord [3] = " USTED ES";
	aReply   [3] = "QUÉ LE HACE PENSAR QUE YO SOY";
	aMood    [3] = "LAUGH"; 
	
	aKeyWord [4] = " USTED ES";
	aReply   [4] = "CUÁL ES SU REACCIÓN A QUE YO SEA";
	aMood    [4] = "ASTONISHED"; 
	
	aKeyWord [5] = " YO NO";
	aReply   [5] = "POR QUE NO";
	aMood    [5] = "WHOKNOWS"; 
	
	aKeyWord [6] = " SIENTO";
	aReply   [6] = "DÍGAME MÁS ACERCA DE SUS SENTIMIENTOS";
	aMood    [6] = "CASUAL"; 
	
	aKeyWord [7] = " POR QUE NO HACE";
	aReply   [7] = "POR QUÉ LE GUSTARÍA QUE YO HICIERA";
	aMood    [7] = "LAUGH"; 
	
	aKeyWord [8] = " POR QUÉ NO PUEDO";
	aReply   [8] = "QUÉ LE HACE PENSAR QUE USTED DEBERÍA SER CAPAZ DE";
	aMood    [8] = "ASTONISHED"; 
	
	aKeyWord [9] = " USTED ES";
	aReply   [9] = "POR QUÉ ESE INTERÉS EN QUE YO SEA";
	aMood    [9] = "WHOKNOWS"; 
	
	aKeyWord [10]= " NO PUEDO";
	aReply   [10]= "CÓMO SABE QUE NO PUEDE";
	aMood    [10]= "CASUAL"; 
	
	aKeyWord [11]= " SEXO";
	aReply   [11]= "REALMENTE QUIERE HABLAR DE SEXO?";
	aMood    [11]= "ASTONISHED"; 
	
	aKeyWord [12]= " YO SOY";
	aReply   [12]= "HACE CUÁNTO TIEMPO QUE ES";
	aMood    [12]= "LAUGH"; 
	
	aKeyWord [13]= " YO SOY";
	aReply   [13]= "POR QUÉ ME DICE QU USTED ES";
	aMood    [13]= "WHOKNOWS"; 
	
	aKeyWord [14]= " YO QUIERO";
	aReply   [14]= "POR QUÉ QUIERE";
	aMood    [14]= "CASUAL"; 
	
	aKeyWord [15]= " QUE";
	aReply   [15]= "QUÉ CREE?";
	aMood    [15]= "LAUGH"; 
	
	aKeyWord [16]= " CÓMO";
	aReply   [16]= "QUÉ REPUESTA LE PLACERÍA MÁS?";
	aMood    [16]= "ASTONISHED"; 
	
	aKeyWord [17]= " QUIEN";
	aReply   [17]= "QUÉ TAN FRECUENTEMENTE SE LE OCURREN ESOS COMETARIOS?";
	aMood    [17]= "WHOKNOWS"; 
	
	aKeyWord [18]= " DONDE";
	aReply   [18]= "POR QUÉ PIENSA EN ESO?";
	aMood    [18]= "CASUAL"; 
	
	aKeyWord [19]= " CUANDO";
	aReply   [19]= "QUÉ DIRÍA SU MEJOR AMIGO ANTE ESA PREGUNTA?";
	aMood    [19]= "LAUGH"; 
	
	aKeyWord [20]= " POR QUE";
	aReply   [20]= "QUÉ ES LO QUE REALMENTE QUIERE SABER?";
	aMood    [20]= "ASTONISHED"; 
	
	aKeyWord [21]= " TAL VEZ";
	aReply   [21]= "USTED NO ESTÁ MUY FIRME EN ESO";
	aMood    [21]= "WHOKNOWS"; 
	
	aKeyWord [22]= " QUIZÁS";
	aReply   [22]= "NO ESTÁ SIENDO UN POCO TENTATIVO?";
	aMood    [22]= "CASUAL"; 
	
	aKeyWord [23]= " POSIBLEMENTE";
	aReply   [23]= "USTED NO ESTÁ MUY FIRME EN ESO";
	aMood    [23]= "LAUGH";
	 
	aKeyWord [24]= " TOMAR";
	aReply   [24]= "MODERACIÓN DEBE SER LA REGLA.";
	aMood    [24]= "ASTONISHED"; 
	
	aKeyWord [25]= " BORRACHO";
	aReply   [25]= "MODERACIÓN DEBE SER LA REGLA.";
	aMood    [25]= "WHOKNOWS"; 
	
	aKeyWord [26]= " ALCOHOL";
	aReply   [26]= "MODERACIÓN DEBE SER LA REGLA.";
	aMood    [26]= "CASUAL"; 
	
	aKeyWord [27]= " PERDON";
	aReply   [27]= "POR QUÉ SE ESTÁ DISCULPANDO?";
	aMood    [27]= "LAUGH"; 
	
	aKeyWord [28]= " SUEÑOS";
	aReply   [28]= "POR QUÉ TRE EL TEMA DE LOS SUEÑOS?";
	aMood    [28]= "ASTONISHED";
	 
	aKeyWord [29]= " ME GUSTA";
	aReply   [29]= "ES BUENO QUE LE GUSTE";
	aMood    [29]= "WHOKNOWS"; 
	
	aKeyWord [30]= " ME ENCANTA";
	aReply   [30]= "QUE ES TAN BUENO QUE LE GUSTA";
	aMood    [30]= "CASUAL"; 
	
	aKeyWord [31]= " NO";
	aReply   [31]= "POR QUÉ ESTÁ SIENDO NEGATIVO?";
	aMood    [31]= "LAUGH"; 
	
	aKeyWord [32]= " SU";
	aReply   [32]= "PORQUÉ ESTÁ PREOCUPADO POR";
	aMood    [32]= "ASTONISHED"; 
	
	aKeyWord [33]= " SIEMPRE";
	aReply   [33]= "PUEDE PENSAR EN UN EJEMPLO ESPECÍFICO?";
	aMood    [33]= "WHOKNOWS"; 
	
	aKeyWord [34]= " CONSTANTEMENTE";
	aReply   [34]= "PUEDE PENSAR EN UN EJEMPLO ESPECÍFICO?";
	aMood    [34]= "CASUAL"; 
	
	aKeyWord [35]= " CADA VEZ";
	aReply   [35]= "PUEDE PENSAR EN UN EJEMPLO ESPECÍFICO?";
	aMood    [35]= "LAUGH"; 
	
	aKeyWord [36]= " CONTINUAMENTE";
	aReply   [36]= "PUEDE PENSAR EN UN EJEMPLO ESPECÍFICO?";
	aMood    [36]= "ASTONISHED"; 
	
	aKeyWord [37]= "PIENSA";
	aReply   [37]= "USTED DUDA";
	aMood    [37]= "WHOKNOWS"; 
	
	aKeyWord [38]= " SÍ";
	aReply   [38]= "PARECE MUY SEGURO, PORQUÉ ES ESO";
	aMood    [38]= "CASUAL"; 
	
	aKeyWord [39]= " SI ";
	aReply   [39]= "PARECE MUY SEGURO, PORQUÉ ES ESO?";
	aMood    [39]= "LAUGH"; 
	
	aKeyWord [40]= " AMIGO";
	aReply   [40]= "POR QUÉ TRAE EL TEMITA DE LA AMISTAD?";
	aMood    [40]= "ASTONISHED"; 
	
	aKeyWord [41]= " AMIGA";
	aReply   [41]= "POR QUÉ TRAE EL TEMITA DE LA AMISTAD?";
	aMood    [41]= "CASUAL"; 
	
	aKeyWord [42]= " COMPUTA";
	aReply   [42]= "POR QUÉ MENCIONA COMPUTADORAS?";
	aMood    [42]= "WHOKNOWS"; 
	
	aKeyWord [43]= " YO SOY";
	aReply   [43]= "USTED ES";
	aMood    [43]= "CASUAL"; 
	
	aKeyWord [44]= " ODIO";
	aReply   [44]= "POR QUÉ ODIA";
	aMood    [44]= "LAUGH"; 
	
	aKeyWord [45]= " APUESTA ";
	aReply   [45]= "PORQUÉ SIENTE LA NECESIDAD DE APOSTAR?";
	aMood    [45]= "ASTONISHED"; 
	
	aKeyWord [46]= " AZAR";
	aReply   [46]= "PORQUÉ SIENTE LA NECESIDAD DE APOSTAR?";
	aMood    [46]= "WHOKNOWS"; 
	
	aKeyWord [47]= " DEBERÍA";
	aReply   [47]= "PIENSA USTED QUE DEBERÍA";
	aMood    [47]= "CASUAL"; 
	
	aKeyWord [48]= " YOP ERA";
	aReply   [48]= "POR QUÉ ERA";
	aMood    [48]= "LAUGH";
	 
	aKeyWord [49]= " ADMIRO";
	aReply   [49]= "POR QUÉ ADMIRA";
	aMood    [49]= "ASTONISHED";
	 
	aKeyWord [50]= " BONIT";
	aReply   [50]= "LO QUE ESTÁ ADENTRO ES LO QUE CUENTA.";
	aMood    [50]= "WHOKNOWS"; 
	
	aKeyWord [51]= " LIND";
	aReply   [51]= "LO QUE ESTÁ ADENTRO ES LO QUE CUENTA.";
	aMood    [51]= "CASUAL"; 
	
	aKeyWord [52]= " PAP";
	aReply   [52]= "HÁBLEME ACERCA DE SU PAPITO?";
	aMood    [52]= "LAUGH"; 
	
	aKeyWord [53]= " MAM";
	aReply   [53]= "HÁBLEME ACERCA DE SU MAMITA?";
	aMood    [53]= "ASTONISHED"; 
	
	aKeyWord [54]= " ELLA ";
	aReply   [54]= "Y USTED?";
	aMood    [54]= "WHOKNOWS"; 
	
	aKeyWord [55]= " EL ";
	aReply   [55]= "Y USTED?";
	aMood    [55]= "CASUAL"; 
	
	aKeyWord [56]= " TETA ";
	aReply   [56]= "REALMENTE QUIERE HABLAR SOBRE TETAS?";
	aMood    [56]= "LAUGH"; 
	
	aKeyWord [57]= " CULO ";
	aReply   [57]= "REALMENTE QUIERE HABLAR SOBRE CULOS?";
	aMood    [57]= "ASTONISHED";
	 
	aKeyWord [58]= " PIPI ";
	aReply   [58]= "REALMENTE QUIERE HABLAR SOBRE PIPÍS?";
	aMood    [58]= "ASTONISHED";
	 
	aKeyWord [59]= " MIERDA ";
	aReply   [59]= "REALMENTE QUIERE HABLAR MIERDA?";
	aMood    [59]= "ASTONISHED"; 
	
	aKeyWord [60]= " PUTA ";
	aReply   [60]= "REALMENTE QUIERE HABLAR SOBRE PUTAS?";
	aMood    [60]= "ASTONISHED"; 
	
	aKeyWord [61]= " CHAO ";
	aReply   [61]= "CHAO, CHAO. ";
	aMood    [61]= "HIBYE"; 	
	
	
	// Fill aConjugate array.
	aConjugate = new Array(11);
	aInvConjgt = new Array(11);
	aConjugate [1] = " YO ";
	aInvConjgt [1] = "#USTED ";
	aConjugate [2] = " ES ";
	aInvConjgt [2] = "#SOY ";
	aConjugate [3] = " ERA ";
	aInvConjgt [3] = "#ERA ";
	aConjugate [4] = " USTED ";
	aInvConjgt [4] = "#YO ";
	aConjugate [5] = " SU ";
	aInvConjgt [5] = "#MI ";
	aConjugate [6] = " YO HE ";
	aInvConjgt [6] = "#USTED HA ";
	aConjugate [7] = " YO SOY ";
	aInvConjgt [7] = "#USTED ES ";
	aConjugate [8] = " MI ";
	aInvConjgt [8] = "#SU ";
	aConjugate [9] = " SOY YO ";
	aInvConjgt [9] = "#ES USTED ";
	aConjugate [10]= " SEA ";
	aInvConjgt [10]= "#SEA ";
	aConjugate [11]= " SERE ";
	aInvConjgt [11]= "#SERA ";

	// Fill book recommendations
	aBook = new Array(10);
	aBook [0] = "PERO POR LO QUE ENTIENDO USTED ES EL TIPO DE PERSONA PARA LEER <A HREF=../src/Pagina.aspx?lng=HISPANIA&opus=1&pagina=1> ESTE LIBRO</A>";
	aBook [1] = "OBVIAMENTE, SU PERSONALIDAD ENCAJA CON <A HREF=../src/Pagina.aspx?lng=HISPANIA&opus=1&pagina=1> ESTE PERSONAJE</A>";
	aBook [2] = "CREO QUE NI USTED SE ENTIENDE A SÍ MISMO. ESO LE PASABA A UN PERSONAJE <A HREF=../src/Pagina.aspx?lng=HISPANIA&opus=1&pagina=1> EN ESTE LIBRO</A>";
	aBook [3] = "SU MODO DE EXPRESIÓN ES PECULIAR. ESO LE PASABA A UN PERSONAJE <A HREF=../src/Pagina.aspx?lng=HISPANIA&opus=1&pagina=1> EN ESTE LIBRO</A>";
	aBook [4] = "PARA CONOCERSE UN POCO MÁS ASÍ MISMO, PODRÍA LEER <A HREF=../src/Pagina.aspx?lng=HISPANIA&opus=1&pagina=1> ESTE LIBRO </A>";
	aBook [5] = "SI NO QUIERE ELABORAR MÁS, PODRÍA LEER <A HREF=../src/Pagina.aspx?lng=HISPANIA&opus=1&pagina=1> ESTO</A>";
	aBook [6] = "SI TIENE PEREZA DE CONTINUAR, PODRÍA LEER <A HREF=../src/Pagina.aspx?lng=HISPANIA&opus=1&pagina=1> ESTO</A>";
	aBook [7] = "PARA ENTENDERLO, PODRÍA LEER <A HREF=../src/Pagina.aspx?lng=HISPANIA&opus=1&pagina=1> ESTO</A>";
	aBook [8] = "DETÉNGASE PARA LEER <A HREF=../src/Pagina.aspx?lng=HISPANIA&opus=2&pagina=1> ESTE LIBRO</A>";
	aBook [9] = "HÁBLEME COMO SI YO FUERA SU SIQUIATRA. UN EJEMPLO LO ENCONTRARÁ <A HREF=../src/Pagina.aspx?lng=HISPANIA&opus=2&pagina=1> AQUÍ</A>";
	aBook[10] = "CREO QUE UNA EXPLICACIÓN PARA SUCOMPORTAMIENTO LA PUEDE ENCONTRAR <A HREF=../src/Pagina.aspx?lng=HISPANIA&opus=2&pagina=1> EN ESTE LIBRO</A>";
	
	// Fill random reply array
	aRandomReply = new Array(10);
	aRandomReply [0] = "NO ESTOY SEGURO DE SEGUIR SUS IDEAS... "; // + aBook [0];
	aRandomReply [1] = "ESO QUÉ LE SUGIERE A USTED? "; // + aBook [1];
	aRandomReply [2] = "PODRÍA SER MÁS EXPLÍCITO? " + aBook [2];
	aRandomReply [3] = "NO ESTOY SEGURO DE ENTENDER LO QUE QUIERE DECIR... " + aBook [3];
	aRandomReply [4] = "PUEDE ELABORAR MÁS SOBRE ESO? "; // + aBook [4];
	aRandomReply [5] = "ESO ES MUY INTERESANTE! "; // + aBook [5];
	aRandomReply [6] = "NO TIENE MUCHO SENTIDO... CONTINUE, POR FAVOR... "; // + aBook [6];
	aRandomReply [7] = "PODRÍA DECIR LO MISMO DE  OTRA FORMA? "; // + aBook [7];
	aRandomReply [8] = "POR FAVOR INTENTE DECIR ALGO DE OTRA FORMA... SIGA... " + aBook [8];
	aRandomReply [9] = "PORQUÉ ESTA DICIENDO ESO?";// + aBook [9];
	aRandomReply[10] = "EXPLIQUE, POR FAVOR, EL BAGAJE DE ESA AFIRMACIÓN... ";// + aBook [10];

	//--- Personalize ---
	// Get cookie data.
	name=getCookie("ElizaClientName");
	var num_sessions=getCookie("ElizaSessionCount");
	count=getCookie("ElizaQuestionCount");

	var intro="";
	if((name==null)||(name=="")||(name=="undefined"))
	{
		num_sessions=1;
		count=0;
		intro+="HOLA. SOY EL AUTOR. \nCUÁL ES SU NOMBRE?";
	}
	else
	{
		if(Math.random()<0.5)
			intro+="BIENVENIDO "+name+", A LA SESIÓN "+num_sessions+" CON EL AUTOR.\nCREO QUE LO ÚLTIMO QUE DIJE FUE `"+getCookie("ElizaLastSaid")+"`";
		else
			intro+="BIENVENIDO "+name+", A LA SESIÓN "+num_sessions+", A ESTE PASO VOY A TENER QUE EMPEZAR A COBRAR!\nCREO QUE LO ÚLTIMNO QUE DIJE FUE `"+getCookie("ElizaLastSaid")+"`";
		start=false;
	}
	output.innerHTML = intro;
	counter.value=count;
	input.focus();
	num_sessions++;
	setCookie("ElizaSessionCount",num_sessions);
	setCookie("ElizaClientName",name);	//Refresh name expiry date.
}

function Run_Eliza() {
	var input = window.document.frmChat.txtQuestion;
	var output = document.getElementById("divAnswer");
	var counter = window.document.frmChat.txtCounter;
	var reply = input.value.toString();		
	var my_reply = "";
	var my_mood = "CASUAL";	
	var random_number = Math.round(Math.random()*10);
	input.value="";
	reply.replace("'","`");
	if(start)
	{
		name=reply;	
		my_reply = "HOLA, "+name+" ME ALEGRO QUE SE HAYA ANIMADO A CHATEAR. HAY ALGO ACERCA DE LO CUAL QUIERA HABLAR?";
		my_mood = "HIBYE"
		ShowDelay(my_mood, my_reply);
		setCookie("ElizaClientName",name);
		start=false;		
	}
	else
	{
		// Accept user input 		
		if(reply.indexOf("BECAUSE")!=-1)
			reply=reply.slice(reply.indexOf("BECAUSE")+7);
		if(reply.indexOf("SINCE")!=-1)
			reply=reply.slice(reply.indexOf("SINCE")+5);
		var end_char=reply.slice(reply.length-1);
		if(end_char=="?" || end_char==".")
		{
			// Remove end punctuation
			reply=reply.slice(0,reply.length-1);
		}
		reply=" "+reply+" ";
		if(Math.random()<0.2)
			my_reply+=name+", ";
		// Find keyword, phrase.
		var aKeyWord_index=-1;	
		var reply_index;			
		do
		{
			aKeyWord_index++;
			reply_index=reply.indexOf(aKeyWord[aKeyWord_index]);
		}while(reply_index==-1 && aKeyWord_index<aKeyWord.length);
		if(reply_index==-1)
		{
			// Random reply, no keyword found.
			my_reply+=aRandomReply[random_number];			
			switch (random_number) { 
				case 0,2,7 : 
					my_mood = "ASTONISHED";
					break; 
				case 1,3,8 : 
					my_mood = "LAUGH";
					break; 
				case 6,4,9 : 
					my_mood = "WHOKNOWS";
					break; 
				case 5,10 : 
					my_mood = "CASUAL";
			} 
		}
		else
		{
			// Process aKeyWord
			my_reply+=aReply [aKeyWord_index];
			my_mood = aMood[aKeyWord_index]
			var end_char=aReply [aKeyWord_index].slice(aReply [aKeyWord_index].length-1);
			if(end_char!="?" && end_char!=".")
			{
				// Remove text left of keyword
				reply=reply.slice(reply_index+aKeyWord[aKeyWord_index].length);
				// Find and replace aConjugates
				for(var i=0;i<aConjugate.length;i++)
				{
					reply=reply.replace(aConjugate[i],aInvConjgt[i]);
				}	
				my_reply+=reply.replace(/#/g," ");
			}
		}	
		ShowDelay(my_mood, my_reply);
		count++;
	}
	counter.value=count;
	setCookie("ElizaQuestionCount",count);
	setCookie("ElizaLastSaid",my_reply);
	input.focus();
}

function ChangePicture(sMood, sReply) {
	var nTimeToChange = 3000;
	var dtNow =  new Date();
	var output = document.getElementById("divAnswer");
	var image = window.document.frmChat.imgVideo;
	var button = window.document.frmChat.cmdChat;
	// Select semi-randomly one of the two videos for casual mood
	var sCasualSrc = "";
	if (dtNow.getSeconds()%2==1) {
		sCasualSrc = imgCasual1.src;
	} else {
		sCasualSrc = imgCasual2.src;
	}

	switch (sMood) { 
		case "HIBYE" : 
			image.src = imgHiBye.src;
			setTimeout("window.document.frmChat.imgVideo.src='" + sCasualSrc + "';" , nTimeToChange);
			break; 
		case "ASTONISHED" : 
			image.src = imgAstonished.src;
			setTimeout("window.document.frmChat.imgVideo.src='" + sCasualSrc + "';" , nTimeToChange);
			break; 
		case "LAUGH" : 
			image.src = imgLaugh.src;
			setTimeout("window.document.frmChat.imgVideo.src='" + sCasualSrc + "';" , nTimeToChange);
			break; 
		case "WHOKNOWS" : 
			image.src = imgHowKnows.src;
			setTimeout("window.document.frmChat.imgVideo.src='" + sCasualSrc + "';" , nTimeToChange);
			break; 
		case "CASUAL" : 
			image.src = sCasualSrc;			
	} 
	output.innerHTML = sReply;
	button.value = "Enviar"
}

function ShowDelay(sMood, sReply) {
	var sFunction = "ChangePicture('" + sMood + "', '" + sReply + "');"
	var output = document.getElementById("divAnswer");
	output.innerHTML = "...<br>Enviándole su mensaje al autor...<br>..."
	setTimeout(sFunction, 4000);
	return;	
}

function getCookie(Name) {
	var search=Name+"=";
	// If there are any cookies
   if(document.cookie.length>0) 
	{ 
		offset=document.cookie.indexOf(search);
		// if cookie exists
      if (offset!=-1)
 		{ 
			// Set index of beginning of value
      	offset+=search.length;
         end=document.cookie.indexOf(";",offset);
         // Set index of end of cookie value
         if (end==-1)
             end=document.cookie.length;
         return unescape(document.cookie.substring(offset,end));
		}
	}
}

function setCookie(Name,Value) {
	var today=new Date();
   var expires=new Date();
	// Set cookie to expire after 1 month
   expires.setTime(today.getTime()+1000*60*60*24*31);
	document.cookie=Name+"="+escape(Value)+";expires="+expires.toUTCString();
}

function ResetName() {
	setCookie("ElizaClientName","");	// Erase name.
	setCookie("ElizaLastSaid","");	// Erase last question.
	setCookie("ElizaSessionCount",0);
	setCookie("ElizaQuestionCount",0);
	history.go(0);
}

// -->