//===========================================================
// xmltv.js:
// Author: Timothy Alosi (timalosi.com)
// Revision 0.1.B
// Revision Date: October 10, 2007
//
// This opensource project is hosted at http://xmltvtools.sourceforge.net
// Please contribute any improvements back to the project.
//
//Copyright (c) 2007 Timothy Alosi
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
//
//===========================================================

function SetUpPage() {
    document.all['message1'].style.display = "none";
    document.all['message2'].style.display = "none";
    document.all['message3'].style.display = "none";
    document.all['message4'].style.display = "none";
    document.all['message5'].style.display = "none";
    dt = new Date();
    hours = dt.getHours();
    if (hours >= 0 && hours < 6) {
        document.all['chkEarlyMorning'].checked = true;
    }
    else if (hours >= 6 && hours < 12) {
        document.all['chkLateMorning'].checked = true;
    }
    else if (hours >= 12 && hours < 18) {
        document.all['chkAfternoon'].checked = true;
    }
    else if (hours >= 18 ) {
        document.all['chkEvening'].checked = true;
    }
    showClock();
    MenuDiv();
}

function ExpandCollapseText(srcObject, targetDivId)
{
    // This function will expand or collapse a DIV whose Name or ID
    // is passed as the argument

    if (document.all(targetDivId).style.display == "none")
    {
        srcObject.innerText = 'Less';
        document.all(targetDivId).style.display = "";
    }
    else
    {
        srcObject.innerText = 'More...';
        document.all(targetDivId).style.display = "none";
    }

}

function ToolTip(targetDivId)
{
    // This function pop up a div like a Windows Tool Tip
    // The DIV ID is passed as the argument

    if (document.all['AboutDiv'].style.display == "none")
    {

        if (document.all(targetDivId).style.display == "none")
        {
            popTop = 0;
            popLeft = 0;

            document.all(targetDivId).style.display = "";

            if ((event.clientX + document.all(targetDivId).clientWidth) > document.body.clientWidth) {
                popLeft = event.clientX + document.body.scrollLeft - document.all(targetDivId).clientWidth;
            }
            else {
                popLeft= event.clientX + document.body.scrollLeft;
            }

            if ((event.clientY + document.all(targetDivId).clientHeight) > document.body.clientHeight) {
                popTop = event.clientY + document.body.scrollTop - document.all(targetDivId).clientHeight - 10;
            }
            else {
                popTop= event.clientY + document.body.scrollTop;
            }

            document.all(targetDivId).style.posTop =  popTop;
            document.all(targetDivId).style.posLeft = popLeft;

            //document.all(targetDivId).style.top =  event.offsetY + objSource.offsetParent.offsetTop + document.all('listings').offsetTop;
            //document.all(targetDivId).style.left = event.offsetX + objSource.offsetParent.offsetLeft + document.all('listings').offsetLeft;
            //document.all(targetDivId).style.top = event.clientY;
            //document.all(targetDivId).style.left = event.clientX;

        }
        else
        {
            document.all(targetDivId).style.display = "none";
        }
    }
}

function MenuDiv () {
    if (document.layers) {
        document.layers['MenuDiv'].pageY = window.pageYOffset + 10;
        document.layers['MenuDiv'].pageX = window.pageXOffset + 10;
    }
    else if (document.all) {
        document.all['MenuDiv'].style.posTop = document.body.scrollTop + 10;
        document.all['MenuDiv'].style.posLeft = document.body.scrollLeft + 10;
    }
    setTimeout('MenuDiv()',100);
}

function showListings() {
    divTop = 10;
    divLeft = 25 + document.all['MenuDiv'].clientWidth;
    //sStatus = '>';
    if (document.all['chkEarlyMorning'].checked) {
        document.all['EarlyMorning'].style.display = "";
        document.all['EarlyMorning'].style.top = divTop;
        document.all['EarlyMorning'].style.left = divLeft;
        divLeft += document.all['EarlyMorning'].clientWidth;
        //sStatus = 'em.cw=' + document.all['EarlyMorning'].clientWidth;
    }
    else {
        //Hide the EarlyMorning Div
        document.all['EarlyMorning'].style.display = "none";
    }
    if (document.all['chkLateMorning'].checked) {
        document.all['LateMorning'].style.display = "";
        document.all['LateMorning'].style.top = divTop;
        document.all['LateMorning'].style.left = divLeft;
        divLeft += document.all['LateMorning'].clientWidth;
        //sStatus = sStatus + ' lm.cw=' + document.all['LateMorning'].clientWidth;
    }
    else {
        //Hide the LateMorning Div
        document.all['LateMorning'].style.display = "none";
    }
    if (document.all['chkAfternoon'].checked) {
        document.all['Afternoon'].style.display = "";
        document.all['Afternoon'].style.top = divTop;
        document.all['Afternoon'].style.left = divLeft;
        divLeft += document.all['Afternoon'].clientWidth;
        //sStatus = sStatus + ' af.cw=' + document.all['LateMorning'].clientWidth;
    }
    else {
        //Hide the Afternoon Div
        document.all['Afternoon'].style.display = "none";
    }
    if (document.all['chkEvening'].checked) {
        document.all['Evening'].style.display = "";
        document.all['Evening'].style.top = divTop;
        document.all['Evening'].style.left = divLeft;
        divLeft += document.all['Evening'].clientWidth;
        //sStatus = sStatus + ' ev.cw=' + document.all['Evening'].clientWidth;
    }
    else {
        //Hide the Evening Div
        document.all['Evening'].style.display = "none";
    }
    //window.status = sStatus;
    //Now Display the final Channel_Col Div
    document.all['Channel_Col'].style.display = "";
    document.all['Channel_Col'].style.top = divTop;
    document.all['Channel_Col'].style.left = divLeft;
}

//function ChangeStyle(srcObject) {
//  if (srcObject.className == 'child' {
//      srcObject.className = 'child_hidden';
//  }
//  else {
//      srcObject.className = 'child';
//  }
//}

function showClock(){
    // This function actually displays the time.
    dt = new Date();
    hours = dt.getHours();
    minutes = dt.getMinutes();
    seconds = dt.getSeconds();
    document.all('CurrentTime').innerText = "Current Time " + hours + ":" + minutes + ":" + seconds;
    timerID = window.setTimeout("showClock()", 1000); // repeat call
}

function About(){

    if (document.all['AboutDiv'].style.display == "")
    {
        //Hide the About Dialog Box
        document.all['AboutDiv'].style.display = "none";
    }
    else
    {
        //Show the About Dialog Box
        document.all['AboutDiv'].style.display = "";
        document.all['AboutDiv'].style.posTop = document.body.scrollTop + (document.body.clientHeight / 2) - (document.all['AboutDiv'].clientHeight / 2);
        document.all['AboutDiv'].style.posLeft = document.body.scrollLeft + (document.body.clientWidth / 2) - (document.all['AboutDiv'].clientWidth / 2);
    }
}


function Test(){
    window.status ='No Test Function';
}

