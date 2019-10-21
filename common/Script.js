/*********************************************************
Ensure that no site is presenting Literatronic within frames
********************************************************
/*if (top != self) {
  top.location = self.location;
}*/
        
/*********************************************************
Load the appropriate style sheet for different browsers
*********************************************************/
//if(navigator.appName == "Netscape") {
    document.write('<link rel="stylesheet" type="text/css" href="../common/styles_ns.css" />');
//} else {
//    document.write('<link rel="stylesheet" type="text/css" href="../common/styles.css" />');
//}

    /*********************************************************
    Function	: LoadTab(sDiv)
    Purpose		: Replaces the inner HTML of a DIV element
    Parameters	: sDiv: name of the DIV to be loaded into the default DIV named "container"
    Returns		: null
    JBG - 08/2001
    *********************************************************/
    function LoadTab_v(sDiv) {

        if (sDiv == 'Intro') {
            document.getElementById("Intro").style.visibility = "visible";
            document.getElementById("Intro").style.display = "inline";
            document.getElementById("mynetwork").style.display = "none";
            document.getElementById("mynetwork").style.visibility = "hidden";
            document.getElementById("personalize_net").style.visibility = "hidden";
            document.getElementById("personalize_net").style.display = "none";
        }
        if (sDiv == 'mynet') {

            document.getElementById("mynetwork").style.display = "block";
            document.getElementById("mynetwork").style.visibility = "visible";
            document.getElementById("Intro").style.display = "none";
            document.getElementById("Intro").style.visibility = "hidden";
            document.getElementById("personalize_net").style.visibility = "hidden";
            document.getElementById("personalize_net").style.display = "none";
        }

        if (sDiv == 'Syllabus') {
            
            document.getElementById("personalize_net").style.visibility = "visible";
            document.getElementById("personalize_net").style.display = "inline";
            document.getElementById("mynetwork").style.display = "none";
            document.getElementById("mynetwork").style.visibility = "hidden";
            document.getElementById("Intro").style.visibility = "hidden";
            document.getElementById("Intro").style.display = "none";

        }


        p = document.getElementById("tblTab");
        o = p.rows[0].cells;
        for (var i = 0; i < o.length; i++) {
            if (o[i].id == "tab" + sDiv) {
                o[i].className = "TabOn";
            } else {
                o[i].className = "TabOff";
            }
        }

    }


/*********************************************************
Function	: LoadTab(sDiv)
Purpose		: Replaces the inner HTML of a DIV element
Parameters	: sDiv: name of the DIV to be loaded into the default DIV named "container"
Returns		: null
JBG - 08/2001
*********************************************************/
function LoadTab(sDiv) {
    oOrigin = document.getElementById(sDiv);
    oDestination = document.getElementById("container");
    oDestination.innerHTML = oOrigin.innerHTML;
    if (sDiv == 'PDF') { 
       document.getElementById("PDF1").style.display = "";      
    }
    else {     
       document.getElementById("PDF1").style.display = "none";        
    }

    p = document.getElementById("tblTab");
    o = p.rows[0].cells;
    for (var i = 0; i < o.length; i++) {
        if (o[i].id == "tab" + sDiv) {
            o[i].className = "TabOn";
        } else {
            o[i].className = "TabOff";
        }
    }
    
}

/*********************************************************
Function	: LoadWiki(topic)
Purpose		: Retrieves an article from the ALICE wiki
Parameters	: topic: string that matches the name of the article in the wiki
Returns		: null
JBG - 08/2014
*********************************************************/
function xLoadWiki(topic) {
    oDiv = document.getElementById('Wiki')
    oDiv.innerHTML = $("#Wiki").load("/wiki/index.php?title=" + topic + " #mw-content-text");

    p = document.getElementById("tblTab");
    o = p.rows[0].cells;
    o[1].style = "visibility:visible; display:inline";
    return;
}

/*********************************************************
Function	: LoadWiki(topic)
Purpose		: Retrieves an article from the ALICE wiki
Parameters	: topic: string that matches the name of the article in the wiki
Returns		: null
JBG - 08/2014
*********************************************************/
function LoadWiki(topic) {
    oDiv = document.getElementById('Wiki')
    oDiv.innerHTML = $("#Wiki").load("/wiki/index.php?title=" + topic + " #mw-content-text");
    DisplayTab(1);
    return;
}

/*********************************************************
Function	: LoadPDF(pdf)
Purpose		: Loads the PDF tab
Parameters	: pdf: name of the PDF file to be loaded. 
              If it contains the substring HTTP, it loads an external file, 
              otherwise, it loads fiels from the folder alice/docs
Returns		: null
JBG - 08/2014
*********************************************************/
function LoadPDF(pdf) {

    var str =pdf;
    var temp = new Array();
    temp = str.split(" ");
    for (a in temp) {
        var s = '', sURL = '';
        pdf=temp[a] ;
        if (pdf.indexOf('http') > -1) {
            sURL = pdf;
        } else {
            sURL = 'http://euler.math.uga.edu/alice/docs/' + pdf;
        }
        temp[a] = sURL;
    }
    if (iOS()) {
        s += '<p><span class="box">You are using a browser that does not support embedded PDFs. You can download the PDF from <a href="' + sURL + '">this link</a></span></p>';
    } else {
        for (a in temp) {
            s += '<iframe width="600" height="800"   src="' + temp[a] + '#view=FitH&scrollbar=1"></iframe><p> Next</p>';
        }
    }
    
  // oDiv = document.getElementById('PDF');
   oDiv = document.getElementById('PDF1');
   oDiv.innerHTML = s;
   DisplayTab(2);
   return;
}

/*********************************************************
Function	: LoadLivescribe(pdf)
Purpose		: Loads the LiveScribe tab
Parameters	: None
Returns		: null
JBG - 01/2016
*********************************************************/
function LoadLivescribe(pdf) {    
    var str =pdf;
    var temp = new Array();
    temp = str.split(" ");
    for (a in temp) {
        var s = '', sURL = '';
        pdf=temp[a] ;
        if (pdf.indexOf('http') > -1) {
            sURL = pdf;
        } else {
            sURL = 'http://euler.math.uga.edu/alice/docs/' + pdf;
        }
        temp[a] = sURL;
    }
    if (iOS()) {
        s += '<p><span class="box">You are using a browser that does not support embedded PDFs. You can download the PDF from <a href="' + sURL + '">this link</a></span></p>';
    } else {
        for (a in temp) {
            s += '<iframe width="600" height="800" src="http://www.livescribe.com/player?' +  temp[a] + '#view=FitH&scrollbar=1" frameborder="0" allowfullscreen></iframe></p><p> Next</p>';
        }
    }
    oDiv = document.getElementById('LiveScribe')
    oDiv.innerHTML = s;
    DisplayTab(3);
    return;
}

/*********************************************************
Function	: LoadMedia(sVideo)
Purpose		: Loads the media tab
Parameters	: pdf: name of the PDF file to be loaded. 
              If it contains the substring HTTP, it loads an external file, 
              otherwise, it loads fiels from the folder alice/docs
Returns		: null
JBG - 08/2014
*********************************************************/
function LoadMedia(sVideo) {
    oDiv = document.getElementById('Media');
    var str =sVideo;
    var temp = new Array();
    temp = str.split(" ");
    var s = '';
    for (a in temp) {
        var  sURL = '', sVideo='';
        sVideo = temp[a];
        s = s+'<iframe width="560" height="315" src="https://www.youtube.com/embed/' + sVideo + '" frameborder="0" allowfullscreen></iframe><p>  </p>';
    }
    oDiv.innerHTML = s;
    DisplayTab(4);
    return;
}

/*********************************************************
Function	: LoadSource(topic)
Purpose		: Retrieves an article from the ALICE wiki
Parameters	: topic: string that matches the name of the article in the wiki
Returns		: null
JBG - 08/2014
*********************************************************/
function LoadSource(topic) {
    oDiv = document.getElementById('Wiki')
    oDiv.innerHTML = $("#Source").load("/wiki/index.php?title=" + topic + " #mw-content-text");
    DisplayTab(5);
    return;
}

/*********************************************************
Function	: DisplayTab(n)
Purpose		: Makes a tab visible on each page
Parameters	: n: string that matches the name of the article in the wiki
Returns		: null
JBG - 08/2014
*********************************************************/
function DisplayTab(n) {
    p = document.getElementById("tblTab");
    o = p.rows[0].cells;
    //o[n].style.visibility = "visible";
    //o[n].style.display = "inline";
    o[n].background = "../images/system/bgd_tab_80x20.gif";
    o[n].class = "TabOff";
    o[n].style = "visibility:visible; display:inline";
    //alert(o[n].style.visibility + " " + o[n].style.display);
    //return;
}

/*********************************************************
Function	: iOS()
Purpose		: Detects browsers incapable of embedding a PDF
Parameters	: None
Returns		: null
StackExchange by username Pierre http://stackoverflow.com/questions/9038625/detect-if-device-is-ios
Downloaded on 02/2016
*********************************************************/
function iOS() {
    var iDevices = [
      'iPad Simulator',
      'iPhone Simulator',
      'iPod Simulator',
      'iPad',
      'iPhone',
      'iPod'
    ];
    if (!!navigator.platform) {
        while (iDevices.length) {
            if (navigator.platform === iDevices.pop()) { return true; }
        }
    }
    return false;
}

/*********************************************************
Function	: Map(sLanguage,nBook)
Purpose		: Redirects to the book's map
Parameters	: Language, Book ID
Returns		: None
JBG - 03/2004
*********************************************************/
function Map(sLanguage,nBook) {
    var f = document.frmSession;
    f.action='../src/Tractus.aspx?lng=' + sLanguage + '&opus=' + nBook;
    f.submit();
}
        
/*********************************************************
Function	: About(sLanguage,sMsg)
Purpose		: Redirects to the book's map
Parameters	: Language, Book's message ID
Returns		: None
JBG - 03/2004
*********************************************************/
function About(sLanguage,nBook) {
    var f = document.frmSession;
    f.action='../src/Nuntius.aspx?lng=' + sLanguage + '&nuntius=OPUS_ABOUT_' + nBook + '&opus=' + nBook;
    f.submit();
}
        
/*********************************************************
Function	: Page(sLanguage,nBook,nPage)
Purpose		: Redirects to the page selected
Parameters	: Language, Book's message ID
Returns		: None
JBG - 03/2004
*********************************************************/
function Page(sLanguage,nBook,nPage) {
    var f = document.frmSession;
    f.action='../src/Pagina.aspx?lng=' + sLanguage + '&opus=' + nBook + '&pagina=' + nPage;
    f.submit();
}


/*********************************************************
Function	: 
Purpose		: 
Parameters	: 
Returns		: None
saeid safaei - 03/2016
*********************************************************/

function send(pagina__id, user_name, opus, pagina, userid, opusid, newid) {
    var pagina_id = pagina__id;
    var user_id = userid;
    var opus_id = opusid;
    var user1 = user_name;
    var opus1 = opus;
    var pagina1 = pagina;
    var new_id = newid;
    $.post("h2.ashx", { user1: user1, opus1: opus1, pagina1: pagina1, user_id: user_id, pagina_id: pagina_id, opus_id: opus_id, new_id: new_id }, function (data) { });



}

/*********************************************************
Function	: 
Purpose		: 
Parameters	: 
Returns		: None
saeid safaei - 03/2016
*********************************************************/

function produce_add(e) {
    
    e = e.replace("~/", "");
    //   window.location.href = '../' + e;
    var url = '../' + e;
    window.open(url, '_blank');

}


/*********************************************************
Function	: 
Purpose		: 
Parameters	: 
Returns		: None
saeid safaei - 03/2016
*********************************************************/
function show(pagina__id, user_name, opus, pagina, userid, opusid, newid) {
    send(pagina__id, user_name, opus, pagina, userid, opusid, newid);

    var i = 0;
    var k = "#" + pagina__id;
    var fileUpload = $(k).get(0);
    var files = fileUpload.files;

  

    var test = new FormData();
    var path = user_name + opus + pagina;
    if (files[0] !=null) {

        if (files[0].size > 0) {
            //  test.append(files[0].name, files[0]);
            test.append(path, files[0]);
            $.ajax({
                url: "h1.ashx",
                type: "POST",
                contentType: false,
                processData: false,
                data: test,
                // dataType: "json",
                success: function (result) {
                    alert(result);
                },
                error: function (err) {
                    alert(err.statusText);
                }
            });
            alert("finish");
            window.location.reload();
        }
        else {
            alert("You file size should be bigger than 0");

        }
    }
    else {
        alert("You must choose a file");

    }


}
//****************************************************************************************************

   
//******************************************************************************************************************************-->
function blank() {
    var user_val = document.forms["myForm"]["username1"].value;
    if (user_val == "") {

        document.getElementById("username_alert").innerHTML = "Error: Username cannot be blank!";
        return 1;
    }

}

//*******************************************************************************************************************************-->
function letter_num() {
    var user = document.getElementById("username1");       
    re = /^\w+$/;
    if(!re.test(user.value)) {
        document.getElementById("username_alert").innerHTML = "Error: Username may contain only letters, numbers and underscores!";
        user.focus();
        return 1;
    }
}

//********************************************************************************************************************************-->
function pass_length () {
    var pass = document.forms["myForm"]["password1"];
    if(pass.value.length < 6) {
         
        document.getElementById("password1_alert").innerHTML = "Error: Password must contain at least six characters!";
        pass.focus();
        return 1;
    }
          
}
//********************************************************************************************************************************-->
function password_format1 () {
    var pass = document.forms["myForm"]["password1"];
    var user = document.forms["myForm"]["username1"];

    if(pass.value==user.value) {
        document.getElementById("password1_alert").innerHTML = "Error: Password must be different from Username!";
        pass.focus();
        return 1;
    }

}

//********************************************************************************************************************************-->

//********************************************************************************************************************************-->
function password_format2 () {
    var pass = document.forms["myForm"]["password1"];
    var user = document.forms["myForm"]["username1"];
    re = /[0-9]/;
    if(!re.test(pass.value)) {
        document.getElementById("password1_alert").innerHTML = "Error: password must contain at least one number (0-9)!";
        pass.focus();
        return 1;
    }

}

//********************************************************************************************************************************-->
function password_format3 () {
    var pass = document.forms["myForm"]["password1"];
    var user = document.forms["myForm"]["username1"];
    re = /[a-z]/;
    if(!re.test(pass.value)) {
        document.getElementById("password1_alert").innerHTML = "Error: password must contain at least one lowercase letter (a-z)!";
        pass.focus();
        return 1;
    }

}
//********************************************************************************************************************************-->

function password_format4 () {
    var pass = document.forms["myForm"]["password1"];
    var user = document.forms["myForm"]["username1"];
    re =  /[A-Z]/;
    if(!re.test(pass.value)) {
        document.getElementById("password1_alert").innerHTML = "Error: password must contain at least one uppercase letter (A-Z)!";
        pass.focus();
        return 1;
    }

}

//********************************************************************************************************************************-->

function password_format5 () {
    var pass = document.forms["myForm"]["password1"];
    var pass2 = document.forms["myForm"]["password2"];
    if(pass.value!=pass2.value) {
        document.getElementById("password1_alert").innerHTML = "Error: check your password again.both passwords shuld be the same!";
        pass.focus();
        return 1;
    }

}

//********************************************************************************************************************************-->
function validateForm() {
    k=blank();
    if (k=='1'){  return false;}
    k=letter_num();
    if (k=='1'){  return false;}
    k=pass_length();
    if (k=='1'){  return false;}
    k=password_format1();
    if (k=='1'){  return false;}
    k=password_format2();
    if (k=='1'){  return false;}
    k=password_format3();
    if (k=='1'){  return false;}
    k=password_format4();
    if (k=='1'){  return false;}
    k=password_format5();
    if (k=='1'){  return false;}

}


/*********************************************************
Function	: 
Purpose		: 
Parameters	: 
Returns		: None
saeid safaei - 03/2016
*********************************************************/

function send_comments(userid, opusid, pagina_id) {
    var pagina_id = pagina_id;
    var user_id = userid;
    var opus_id = opusid;
    var i = 0;
    var k = "#txt" + pagina_id;
    var comment = $(k).val();

    var k1 = "#" + pagina_id;
    var grad = $(k1).val();
    $.post("../src/Comment_handler.ashx", { grad: grad, comment: comment, user_id: user_id, pagina_id: pagina_id, opus_id: opus_id }, function (data) { });



}


