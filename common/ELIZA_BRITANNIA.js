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
    aKeyWord = new Array(65);
    aReply = new Array(65);
    aMood = new Array(65);
    aKeyWord [0] = " CAN YOU";
    aReply   [0] = "PERHAPS YOU WOULD LIKE TO BE ABLE TO";
    aMood    [0] = "WHOKNOWS";

    aKeyWord [1] = " DO YOU";
    aReply   [1] = "YES, I";
    aMood    [1] = "CASUAL";

    aKeyWord [2] = " CAN I";
    aReply   [2] = "PERHAPS YOU DON`T WANT TO BE ABLE TO";
    aMood    [2] = "WHOKNOWS";

    aKeyWord [3] = " YOU ARE";
    aReply   [3] = "WHAT MAKES YOU THINK I AM";
    aMood    [3] = "LAUGH";

    aKeyWord [4] = " YOU`RE";
    aReply   [4] = "WHAT IS YOUR REACTION TO ME BEING";
    aMood    [4] = "ASTONISHED";

    aKeyWord [5] = " I DON`T";
    aReply   [5] = "WHY DON`T YOU";
    aMood    [5] = "WHOKNOWS";

    aKeyWord [6] = " I FEEL";
    aReply   [6] = "TELL ME MORE ABOUT FEELING";
    aMood    [6] = "CASUAL";

    aKeyWord [7] = " WHY DON`T YOU";
    aReply   [7] = "WHY WOULD YOU WANT ME TO";
    aMood    [7] = "LAUGH";

    aKeyWord [8] = " WHY CAN`T I";
    aReply   [8] = "WHAT MAKES YOU THINK YOU SHOULD BE ABLE TO";
    aMood    [8] = "ASTONISHED";

    aKeyWord [9] = " ARE YOU";
    aReply   [9] = "WHY ARE YOU INTERESTED IN WHETHER OR NOT I AM";
    aMood    [9] = "WHOKNOWS";

    aKeyWord [10]= " I CAN`T";
    aReply   [10]= "HOW DO YOU KNOW YOU CAN`T";
    aMood    [10] = "CASUAL";

    aKeyWord [11]= " SEX";
    aReply   [11]= "DO YOU REALLY WANT TO TALK ABOUT SEX?";
    aMood    [11] = "ASTONISHED";

    aKeyWord [12]= " I AM";
    aReply   [12]= "HOW LONG HAVE YOU BEEN";
    aMood    [12] = "LAUGH";

    aKeyWord [13]= " I`M";
    aReply   [13]= "WHY ARE YOU TELLING ME YOU`RE";
    aMood    [13] = "WHOKNOWS";

    aKeyWord [14]= " I WANT";
    aReply   [14]= "WHY DO YOU WANT";
    aMood    [14] = "CASUAL";

    aKeyWord [15]= " WHAT";
    aReply   [15]= "WHAT DO YOU THINK?";
    aMood    [15] = "LAUGH";

    aKeyWord [16]= " HOW";
    aReply   [16]= "WHAT ANSWER WOULD PLEASE YOU THE MOST?";
    aMood    [16] = "ASTONISHED";

    aKeyWord [17]= " WHO";
    aReply   [17]= "HOW OFTEN DO YOU THINK OF SUCH QUESTIONS?";
    aMood    [17] = "WHOKNOWS";

    aKeyWord [18]= " WHERE";
    aReply   [18]= "WHY DID YOU THINK OF THAT?";
    aMood    [18] = "CASUAL";

    aKeyWord [19]= " WHEN";
    aReply   [19]= "WHAT WOULD YOUR BEST FRIEND SAY TO THAT QUESTION?";
    aMood    [19] = "LAUGH";

    aKeyWord [20]= " WHY";
    aReply   [20]= "WHAT IS IT THAT YOU REALLY WANT TO KNOW?";
    aMood    [20] = "ASTONISHED";

    aKeyWord [21]= " PERHAPS";
    aReply   [21]= "YOU`RE NOT VERY FIRM ON THAT.";
    aMood    [21] = "WHOKNOWS";

    aKeyWord [22]= " MAYBE";
    aReply   [22]= "AREN`T YOU BEING A BIT TENTATIVE?";
    aMood    [22] = "CASUAL";

    aKeyWord [23]= " POSSIBLY";
    aReply   [23]= "YOU`RE NOT BEING VERY FIRM ON THAT.";
    aMood    [23] = "LAUGH";

    aKeyWord [24]= " DRINK";
    aReply   [24]= "MODERATION IN ALL THINGS SHOULD BE THE RULE.";
    aMood    [24] = "ASTONISHED";

    aKeyWord [25]= " DRUNK";
    aReply   [25]= "MODERATION IN ALL THINGS SHOULD BE THE RULE.";
    aMood    [25] = "WHOKNOWS";

    aKeyWord [26]= " ALCOHOL";
    aReply   [26]= "MODERATION IN ALL THINGS SHOULD BE THE RULE.";
    aMood    [26] = "CASUAL";

    aKeyWord [27]= " SORRY";
    aReply   [27]= "WHY ARE YOU APOLOGIZING?";
    aMood    [27] = "LAUGH";

    aKeyWord [28]= " DREAMS";
    aReply   [28]= "WHY DID YOU BRING UP THE SUBJECT OF DREAMS?";
    aMood    [28] = "ASTONISHED";

    aKeyWord [29]= " I LIKE";
    aReply   [29]= "IS IT GOOD THAT YOU LIKE";
    aMood    [29] = "WHOKNOWS";

    aKeyWord [30]= " I LOVE";
    aReply   [30]= "IS IT GOOD THAT YOU LOVE";
    aMood    [30] = "CASUAL";

    aKeyWord [31]= " NO";
    aReply   [31]= "WHY ARE YOU BEING NEGATIVE?";
    aMood    [31] = "LAUGH";

    aKeyWord [32]= " YOUR";
    aReply   [32]= "WHY ARE YOU CONCERNED ABOUT MY";
    aMood    [32] = "ASTONISHED";

    aKeyWord [33]= " ALWAYS";
    aReply   [33]= "CAN YOU THINK OF A SPECIFIC EXAMPLE?";
    aMood    [33] = "WHOKNOWS";

    aKeyWord [34]= " CONSTANTLY";
    aReply   [34]= "CAN YOU THINK OF A SPECIFIC EXAMPLE?";
    aMood    [34] = "CASUAL";

    aKeyWord [35]= " FOREVER";
    aReply   [35]= "CAN YOU THINK OF A SPECIFIC EXAMPLE?";
    aMood    [35] = "LAUGH";

    aKeyWord [36]= " CONTINUALLY";
    aReply   [36]= "CAN YOU THINK OF A SPECIFIC EXAMPLE?";
    aMood    [36] = "ASTONISHED";

    aKeyWord [37]= "THINKS";
    aReply   [37]= "DO YOU DOUBT";
    aMood    [37] = "WHOKNOWS";

    aKeyWord [38]= " THINK";
    aReply   [38]= "DO YOU DOUBT";
    aMood    [38] = "CASUAL";

    aKeyWord [39]= " YES ";
    aReply   [39]= "YOU SEEM QUITE CERTAIN. WHY IS THIS SO?";
    aMood    [39] = "LAUGH";

    aKeyWord [40]= " FRIEND";
    aReply   [40]= "WHY DO YOU BRING UP THE SUBJECT OF FRIENDS?";
    aMood    [40] = "ASTONISHED";

    aKeyWord [41]= " MATE";
    aReply   [41]= "WHY DO YOU BRING UP THE SUBJECT OF FRIENDS?";
    aMood    [41] = "CASUAL";

    aKeyWord [42]= " COMPUTER";
    aReply   [42]= "WHY DO YOU MENTION COMPUTERS?";
    aMood    [42] = "WHOKNOWS";

    aKeyWord [43]= " AM I";
    aReply   [43]= "YOU ARE";
    aMood    [43] = "CASUAL";

    aKeyWord [44]= " I HATE";
    aReply   [44]= "WHY DO YOU HATE";
    aMood    [44] = "LAUGH";

    aKeyWord [45]= " BET ";
    aReply   [45]= "WHY DO YOU FEEL THE NEED TO GAMBLE?";
    aMood    [45] = "ASTONISHED";

    aKeyWord [46]= " WAGER";
    aReply   [46]= "WHY DO YOU FEEL THE NEED TO GAMBLE?";
    aMood    [46] = "WHOKNOWS";

    aKeyWord [47]= " SHOULD I";
    aReply   [47]= "DO YOU BELIEVE YOU SHOULD";
    aMood    [47] = "CASUAL";

    aKeyWord [48]= " I WAS";
    aReply   [48]= "WHY WERE YOU";
    aMood    [48] = "LAUGH";

    aKeyWord [49]= " I ADMIRE";
    aReply   [49]= "WHY DO YOU ADMIRE";
    aMood    [49] = "ASTONISHED";

    aKeyWord [50]= " BEAUTIFUL";
    aReply   [50]= "IT`S WHATS ON THE INSIDE THAT COUNTS.";
    aMood    [50] = "WHOKNOWS";

    aKeyWord [51]= " HANDSOME";
    aReply   [51]= "IT`S WHATS ON THE INSIDE THAT COUNTS.";
    aMood    [51] = "CASUAL";

    aKeyWord [52]= " DAD";
    aReply   [52]= "TELL ME ABOUT YOUR DAD?";
    aMood    [52] = "LAUGH";

    aKeyWord [53]= " MUM";
    aReply   [53]= "TELL ME ABOUT YOUR MUM?";
    aMood    [53] = "ASTONISHED";

    aKeyWord [54]= " SHE ";
    aReply   [54]= "WHAT ABOUT YOU?";
    aMood    [54] = "WHOKNOWS";

    aKeyWord [55]= " HE ";
    aReply   [55]= "WHAT ABOUT YOU?";
    aMood    [55] = "CASUAL";

    aKeyWord [56]= " FUCK ";
    aReply   [56]= "DO YOU REALLY WANT TO TALK ABOUT FUCKING?";
    aMood    [56] = "LAUGH";

    aKeyWord [57]= " SHIT ";
    aReply   [57]= "DO YOU REALLY WANT TO TALK ABOUT SHIT?";
    aMood    [57] = "ASTONISHED";

    aKeyWord [58]= " DICK ";
    aReply   [58]= "DO YOU REALLY WANT TO TALK ABOUT DICKS?";
    aMood    [58]= "ASTONISHED";

    aKeyWord [59]= " TIT ";
    aReply   [59]= "DO YOU REALLY WANT TO TALK ABOUT TITS?";
    aMood    [59]= "ASTONISHED";

    aKeyWord [60]= " WHORE ";
    aReply   [60]= "DO YOU REALLY WANT TO TALK ABOUT WHORES?";
    aMood    [60]= "ASTONISHED";

    aKeyWord [61]= " BYE ";
    aReply   [61]= "BYE, BYE. ";
    aMood    [61] = "HIBYE";

    aKeyWord [56]= " ERECTION ";
    aReply   [56]= "DO YOU REALLY WANT TO TALK ABOUT ERECTIONS?";
    aMood    [56] = "ASTONISHED";

    // Fill aConjugate array.
    aConjugate = new Array(11);
    aInvConjgt = new Array(11);

    aConjugate [1] = " I ";
    aInvConjgt [1] = "#YOU ";

    aConjugate [2] = " ARE ";
    aInvConjgt [2] = "#AM ";

    aConjugate [3] = " WERE ";
    aInvConjgt [3] = "#WAS ";

    aConjugate [4] = " YOU ";
    aInvConjgt [4] = "#ME ";

    aConjugate [5] = " YOUR ";
    aInvConjgt [5] = "#MY ";

    aConjugate [6] = " I`VE ";
    aInvConjgt [6] = "#YOU`VE ";

    aConjugate [7] = " I`M ";
    aInvConjgt [7] = "#YOU`RE ";

    aConjugate [8] = " ME ";
    aInvConjgt [8] = "#YOU ";

    aConjugate [9] = " AM I ";
    aInvConjgt [9] = "#YOU ARE ";

    aConjugate [10]= " AM ";
    aInvConjgt [10]= "#ARE ";

    aConjugate [11]= " MY ";
    aInvConjgt [11]= "#YOUR ";

    // Fill book recommendations
    aBook = new Array(10);
    aBook [0] = "YOU SEEM TO BE THE TYPE OF PERSON TO READ <A HREF=../src/Pagina.aspx?lng=BRITANNIA&opus=1&pagina=1> THIS BOOK</A>";
    aBook [1] = "IT SEEMS OBVIOUS TO ME THAT YOU ARE THE TYPE OF PERSON TO READ <A HREF=../src/Pagina.aspx?lng=BRITANNIA&opus=1&pagina=1> THIS BOOK</A>";
    aBook [2] = "I DON`T FOLLOW WHAT YOU SAY. I THINK NOT EVEN YOU UNDERTAND YOURSELF"; //. THAT HAPPENED TO SOMEONE <A HREF=../src/Pagina.aspx?lng=BRITANNIA&opus=1&pagina=1> HERE</A>";
    aBook [3] = "YOU DON`T MAKE MUCH SENSE. THAT HAPPENED TO SOMEONE <A HREF=../src/Pagina.aspx?lng=BRITANNIA&opus=1&pagina=1> IN THIS BOOK</A>";
    aBook [4] = "SAY THAT AGAIN, PLEASE"; // <A HREF=../src/Pagina.aspx?lng=BRITANNIA&opus=1&pagina=1> THIS</A>";
    aBook [5] = "DO YOU WANT TO READ SOMETHING RELATED TO THAT? GO  <A HREF=../src/Pagina.aspx?lng=BRITANNIA&opus=1&pagina=1> TO THIS BOOK</A>";
    aBook [6] = "YOU COULD FIND SOMETHING INTERESTING <A HREF=../src/Pagina.aspx?lng=BRITANNIA&opus=1&pagina=1> HERE</A>";
    aBook [7] = "WHY DO YOU SAY THAT? IF YOU DON`T WANT TO CONTINUE CHATING, YOU COULD FIND SOMETHING INTERESTING <A HREF=../src/Pagina.aspx?lng=BRITANNIA&opus=1&pagina=1> HERE</A>";
    aBook [8] = "YOUR CHOICE OF WORDS REMINDS ME OF THE MAIN CHARACTER IN <A HREF=../src/Pagina.aspx?lng=BRITANNIA&opus=2&pagina=1> THIS BOOK</A>";
    aBook [9] = "WAIT... YOU SHOULD READ <A HREF=../src/Pagina.aspx?lng=BRITANNIA&opus=2&pagina=1> THIS</A>";
    aBook[10] = "ONE POSSIBLE EXPLANATION TO YOUR BEHAVIOR COULD BE FOUND <A HREF=../src/Pagina.aspx?lng=BRITANNIA&opus=2&pagina=1> HERE</A>";

    // Fill random reply array
    aRandomReply = new Array(10);
    aRandomReply [0] = "I AM NOT SURE I AM FOLLOWING YOU... " + aBook [0];
    aRandomReply [1] = "WHAT DOES THAT SUGGEST TO YOU? " ;//+ aBook [1]
    aRandomReply [2] = "I SEE...   " + aBook [2];
    aRandomReply [3] = "I AM NOT SURE I FULLY UNDERSTAND WHAT YOU MEAN. "; // + aBook [3];
    aRandomReply [4] = "CAN YOU ELABORATE ON THAT? " ;//+ aBook [4]
    aRandomReply [5] = "THAT IS QUITE INTERESTING! " + aBook [5];
    aRandomReply [6] = "THAT IS SO... PLEASE CONTINUE. "; // + aBook [6];
    aRandomReply [7] = "COULD YOU SAY THAT AGAIN, IN A DIFFERENT WAY? "; //+ aBook [7]
    aRandomReply [8] = "WELL, WELL... GO ON.  "; // + aBook [8];
    aRandomReply [9] = "WHY ARE YOU SAYING THAT? " ;//+ aBook [9]
    aRandomReply[10] = "PLESE EXPLAIN THE BACKGROUND TO THAT REMARK... "; // + aBook [10];

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
        intro+="HELLO. I AM THE AUTHOR. \n \n WHAT IS YOUR FIRST NAME?";
    }
    else
    {
        if(Math.random()<0.5)
            intro+="WELCOME "+name+", TO SESSION NUMBER "+num_sessions+" WITH THE AUTHOR.\nI BELEIVE I LAST SAID `"+getCookie("ElizaLastSaid")+"`";
        else
            intro+="WELCOME "+name+", TO SESSION NUMBER "+num_sessions+", AT THIS RATE I MAY HAVE TO START CHARGING!\nI THINK I LAST SAID `"+getCookie("ElizaLastSaid")+"`";
        start=false;
    }
    output.innerHTML = intro;
    counter.value = count;
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
        my_reply = "WELL, HI THERE "+name+" IT IS NICE TO HAVE YOU DROP BY. IS THERE SOMETHING YOU`D LIKE TO TALK ABOUT?";
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
            //Remove end punctuation
            reply=reply.slice(0,reply.length-1);
        }
        reply=" "+reply+" ";
        if(Math.random()<0.2)
            my_reply+=name+", ";
        //Find keyword, phrase.
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
                //Remove text left of keyword
                reply=reply.slice(reply_index+aKeyWord[aKeyWord_index].length);
                //Find and replace aConjugates
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
    button.value = "Send"
}

function ShowDelay(sMood, sReply) {
    var sFunction = "ChangePicture('" + sMood + "', '" + sReply + "');"
    var output = document.getElementById("divAnswer");
    output.innerHTML  = "...<BR>Sending message to author...<BR>..."
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
    setCookie("ElizaClientName","");	//Erase name.
    setCookie("ElizaLastSaid","");	//Erase last question.
    setCookie("ElizaSessionCount",0);
    setCookie("ElizaQuestionCount",0);
    history.go(0);
}

// -->