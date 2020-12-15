var req = new XMLHttpRequest();
req.setRequestHeader
req.addEventListener("load", function x(){
    if(this.status == 200) {console.log(this.response)}
});
req.open("GET", `http://blahblahwhatever:port`);
req.send();