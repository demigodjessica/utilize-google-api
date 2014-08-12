<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
  <head>
    <title>Search for Music</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
	
   <style type="text/css">
		div.ex
		{
			width:100%;
			padding:10px;
			border:2px solid #3090C7; 
			margin:0px;
		}
		body {
			margin: 0;
			padding: 0,0,0,20px;
			line-height: 1.4em;
			font-family: tahoma, arial, sans-serif;
			background-repeat:no-repeat;
			background-attachment:background;
			fixed-position:right bottom; 
		}

		h1 {
			background: #3090C7;
			font-size:xx-large;
		}

		table {
			width: 100%;
			margin: 0;
			background: #FFFFFF;
			border: 1px solid #333333;
			border-collapse: collapse;
			text-align: center;
			margin-left: auto;
   			margin-right: auto;
		}

		td, th {
			padding: 6px 16px;
			text-align:left; 
		}

		th {
			background: #EEEEEE;
			text-align:left; 
		}

		tr:hover {
		    background-color: #F0F0F0;
		}

		caption {
			background: #E0E0E0;
			margin: 0;
			border: 1px solid #333333;
			border-bottom: none;
			padding: 6px 16px;
			font-weight: bold;
		}

		footer {
			display: table;
			padding-top: 2em;
			 text-align: center;
   			 margin-left: auto;
   			 margin-right: auto;
		}

		.footercontainer
		{
		  background-color: rgb(245,245,245);
		  width: 100%;
		  height:135px;
		 border:2px solid #3090C7; 
		  left:0;
		  position: fixed;
		  bottom: 0;
		}

	</style>

<script>

var service_url = 'https://www.googleapis.com/freebase/v1/mqlread';
var url;
var artist = getUrlVars()["artist"]; // Musician
var song = getUrlVars()["song"];     // Song
var condition = getUrlVars()["condition"]; 

 //alert("You picked the artist[noun] " + artist +  "& condition is " + condition); 


 function getUrlVars() {
          var vars = {};
          var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
              // This will fix problems with spaces. 
              key = decodeURIComponent(key);
              value = decodeURIComponent(value);
              vars[key] = value;
          });
          return vars;
      }

if (artist && condition > 10 && condition < 17)
{
 	 alert("You picked the artist[noun] " + artist +  "& condition is " + condition); 
 	 artistSearch(1, condition, artist); 
} 

if (song && condition > 0 && condition < 11)
{
 	 alert("You picked the song[noun] " + song + "& condition is " + condition); 
 	 songSearch(1, condition, song); 
} 

/* Song Search Function */	
function songSearch(urlOrWeb, urlID, urlNoun){
	try { 
		//alert("urlorWeb " + urlOrWeb + " urlID " + urlID + " urlNoun " + urlNoun); 

		var data;
		var parsethis;	// used to parse the selection
		url = '?query=[{"type":"';
		
		var id;
		var nounSong;
		var description; 

		switch (urlOrWeb) {
			case 1: 
				id = urlID; 
				nounSong = urlNoun; 
			break;
			case 2: 
				id = document.getElementById('music-type').value;
				nounSong = document.getElementById('music-field').value;
			break;

			default: document.write('Error');
		}
		 
		if(id == 0)
			pass;
		else if(id == 1){ // Artist
			description = "artist";
			url += encodeURIComponent('/music/recording", "name":"') + nounSong + encodeURIComponent('", "/music/recording/artist":[]}]');
			parsethis='/music/recording/artist';
		}
		else if(id == 2){ // Featured Artists
			description = "featured artist";
			url += encodeURIComponent('/music/recording", "name":"') + nounSong + encodeURIComponent('", "/music/recording/featured_artists":[]}]');
			parsethis='/music/recording/featured_artists';
		}
		else if(id == 3){ // Length
			description = "length";
			url += encodeURIComponent('/music/recording", "name":"') + nounSong + encodeURIComponent('", "/music/recording/length":[]}]');
			parsethis='/music/recording/length';
		}
		else if(id == 4){ // Recording of Composition
			description = "recording of composition";	
			url += encodeURIComponent('/music/recording", "name":"') + nounSong + encodeURIComponent('", "/music/recording/song":[]}]');
			parsethis='/music/recording/song';
		}
		else if(id == 5){ // Contributions
			description = "contribution";
			url += encodeURIComponent('/music/recording", "name":"') + nounSong + encodeURIComponent('", "/music/recording/contributions":[]}]');
			parsethis='/music/recording/contributions';
		}
		else if(id == 6){ // Date Recorded
			description = "date recorded";
			url += encodeURIComponent('/music/recording", "name":"') + nounSong + encodeURIComponent('", "/music/recording/date":[]}]');
			parsethis='/music/recording/date';
		}
		else if(id == 7){ // Place Recorded
			description = "place recorded";
			url += encodeURIComponent('/music/recording", "name":"') + nounSong + encodeURIComponent('", "/music/recording/place":[]}]');
			parsethis='/music/recording/place';
		}
		else if(id == 8){ // Producer
			description = "producer";
			url += encodeURIComponent('/music/recording", "name":"') + nounSong + encodeURIComponent('", "/music/recording/producer":[]}]');
			parsethis='/music/recording/producer';
			}
		else if(id == 9){ // Engineer
			description = "engineer";
			url += encodeURIComponent('/music/recording", "name":"') + nounSong + encodeURIComponent('", "/music/recording/engineer":[]}]');
			parsethis='/music/recording/engineer';
			}
		else if(id == 10){ // Genre
			description = "genre";
			url += encodeURIComponent('/music/recording", "name":"') + nounSong + encodeURIComponent('", "/music/recording/genre":[]}]');
			parsethis='/music/recording/genre';
			}
		$.getJSON(service_url + url, function(response){
			console.log(response);
			$("#txt").empty();
			$("#txt").append("<center><table>")
			$("#txt").append("<tr><th>Results of finding the <i>" + description + "</i> of song <i>" + nounSong + "</i> </th> </tr> <tr>"); 
			$.each(response.result, function(i, result) {
				
				//$("#txt").append(JSON.stringify(result, null, 2) + " ");
					 //$("#txt").append(result['name'] + " ");
					 if(!jQuery.isEmptyObject(result[parsethis])){ // if the object is empty it will skip printing empty lines
					$("#txt").append(" <td>" +result[parsethis] + " ");
					$("#txt").append('</td><br> ');
					}
			});
		   $("#txt").append("</table></tr></center>");
		});
	}
    catch (err) {
        var txt = "There was an error on this page.\n\n";
        txt += "Error description: " + err.message + "\n\n";
        txt += "Click OK to continue.\n\n";
        alert(txt);
    }
	
}	

function getAPicture(pictureTopic)
{
	
	try { 
		//alert("pic " + pictureTopic); 
		var pictureTopicModded = pictureTopic.toLowerCase(); 
		pictureTopicModded = pictureTopicModded.replace(/ /g,"_");
		queryurl = "https://www.googleapis.com/freebase/v1/topic/en/"+pictureTopicModded+"?filter=/common/topic/image&limit=1"; 
		$.getJSON(queryurl, function(response){
			console.log(response);
			//alert("getapicture " + response); 
			$("#pic").empty();
			$.each(response.id, function(i, result) {
				//alert("getapicture response.result " + response.id); 
				//$("#txt").append(JSON.stringify(result, null, 2) + " ");
					 //$("#txt").append(result['name'] + " ");
					 var imageURL = "https://usercontent.googleapis.com/freebase/v1/image"+response.id+"?mode=fit&maxwidth=700";
					 if(imageURL)
					 {
					 	// alert("try " + imageURL); 
						$("#pic").append("<img src='"+imageURL+"'>"); 
					  } 
					 if(!jQuery.isEmptyObject(result[parsethis])){ // if the object is empty it will skip printing empty lines
					//$("#txt").append(" <td>" +result[parsethis] + " ");
					//$("#txt").append('</td><br> ');
					}
			});
		}); 
		//console.log(response);

	} 
	catch(err) { 
		var txt = "There was an error on this page.\n\n";
        txt += "Error description: " + err.message + "\n\n";
        txt += "Click OK to continue.\n\n";
        alert(txt);
	}
}

/* Artist Search Function */
function artistSearch(urlOrWeb, urlID, urlNoun){

	try { 
		var data;
		var parsethis; 
		url = '?query=[{"type":"';
		
		var id2;
		var nounArtist;

		var description; 

		//alert("urlorWeb " + urlOrWeb + " urlID " + urlID + " urlNoun " + urlNoun); 

		switch (urlOrWeb) {
			case 1: 
				id2 = urlID; 
				nounArtist = urlNoun; 
			break;
			case 2: 
				id2 = document.getElementById('artist-type').value;
				nounArtist = document.getElementById('artist-field').value; 
			break;

			default: document.write('Error');
		}

		getAPicture(nounArtist); 
		
		if(id2 == 0)
			pass;
		else if(id2 == 11){ // Musical Genre
			description = "musical genre";
			url += encodeURIComponent('/music/artist", "name":"') + nounArtist+ encodeURIComponent('", "/music/artist/genre":[]}]');
			parsethis='/music/artist/genre';
		}
		else if(id2 == 12){ // Place Musical Career Began
			description = "place musical career began"
			url += encodeURIComponent('/music/artist", "name":"') +nounArtist+ encodeURIComponent('", "/music/artist/origin":[]}]');
			parsethis='/music/artist/origin';
		}
		else if(id2 == 13){ // Albums 
			description = "albums";
			//url += encodeURIComponent('/music/artist", "name":"') + document.getElementById('artist-field').value + encodeURIComponent('", "/music/artist/album":[{name:null, sort:%22release_date%22,%22release_type!=%22:%22single%22}]}]');
			url += encodeURIComponent('/music/artist", "name":"') + nounArtist + encodeURIComponent('", "/music/artist/album":[{"name":null, "release_date": null, "sort":"release_date", "release_type!=":"single"}]}]');
			//url += encodeURIComponent('/music/artist", "name":"') + document.getElementById('artist-field').value + encodeURIComponent('", "/music/artist/album":[]}]');
			// url += encodeURIComponent('/music/artist", "name":"') + document.getElementById('artist-field').value + encodeURIComponent('", "/music/artist/album":[{"limit":2:[]}]');
			parsethis='/music/artist/album';
			
		}
		if(id2 == 14){ // Record Labels
			description = "record labels"
			url += encodeURIComponent('/music/artist", "name":"') + nounArtist + encodeURIComponent('", "/music/artist/label":[]}]');
			parsethis='/music/artist/label';
			}
		else if(id2 == 15){ // Recordings
			description = "recordings"
			url += encodeURIComponent('/music/artist", "name":"') + nounArtist + encodeURIComponent('", "/music/artist/track":[]}]');
			parsethis='/music/artist/track';
		}
		else if(id2 == 16){ // Concerts
			description = "concerts"
			url += encodeURIComponent('/music/artist", "name":"') + nounArtist + encodeURIComponent('", "/music/artist/concerts":[]}]');
			parsethis='/music/artist/concerts';
		}
		
		$.getJSON(service_url + url, function(response){
			console.log(response);
			$("#txt").empty();
			$("#txt").append("<center><table>")
			$("#txt").append("<tr><th>Results of finding the <i>" + description + "</i> of artist <i>" + nounArtist + "</i> </th> </tr>"); 
			$.each(response.result, function(i, result) {
				//$("#txt").append(JSON.stringify(result, null, 2) + " ");
					 //$("#txt").append(result['name'] + " ");
					if(!jQuery.isEmptyObject(result[parsethis]))
						{
						if(id2==13)
							{
							for(var i=0; i<result[parsethis].length; i++)
								{
								$("#txt").append(result[parsethis][i]['name']+"  "); //if want to add release date do result[parsethis][i]['release_date']
								$("#txt").append('<br>');
								}
							}
						else
							{
							for(var i=0; i<result[parsethis].length; i++)
								{
								$("#txt").append("<tr><td>" + result[parsethis][i]+"  ");
								$("#txt").append('</td></tr> <br>');
								}
								 $("#txt").append("</table></tr></center>")
							// $("#txt").append(result[parsethis]+"  ");
							// $("#txt").append('<br>');
							}
						}
			});
		
		});
	}
    catch (err) {
        var txt = "There was an error on this page.\n\n";
        txt += "Error description: " + err.message + "\n\n";
        txt += "Click OK to continue.\n\n";
        alert(txt);
    }
}	

</script>

</head>
	<body>
	<h1><img src="mteambannerr.png" width="900" height="150"></h1> 
	<br>
	<br> 
	<center>Select One Search or the Other (Not Both)!</center><br><br>
	<div id="searchDiv2" align="center">
		Find 
			<select name="artist-type" id="artist-type" type="text">
			<option value="0">Conditions</option>
			<option value="11">Musical Genres</option>
			<option value="12">Place Musical Career Began</option>
			<option value="13">Albums</option>
			<option value="14">Record Labels</option>
			<option value="15">Recordings</option>
			<option value="16">Concerts</option>
		</select> of &nbsp;
		<input id="artist-field" placeholder="Artist Name" type="text">
		<input type="submit" id="button2" value="Search" onClick="artistSearch(2)">
		<br> 
	</div>
	
	<div id="searchDiv" align="center">
		Find 
			<select name="music-type" id="music-type" type="text">
			<option value="0">Conditions</option>
			<option value="1">Artist</option>
			<option value="2">Featured Artists</option>
			<option value="3">Length</option>
			<option value="4">Recording of Composition</option>
			<option value="5">Contributions</option>
			<option value="6">Date Recorded</option>
			<option value="7">Place Recorded</option>
			<option value="8">Producer</option>
			<option value="9">Engineer</option>
			<option value="10">Genre</option>
		</select> of &nbsp;
		<input id="music-field" placeholder="Song Name" type="text">
		<input type="submit" id="button" value="Search" onClick="songSearch(2)">	<br><br>
	</div>

	<div id="txt" align="center"> 

	</div> 

	<div id="pic" align="center"> 

	</div> 


	<div class = 'footercontainer'>
		Instructions: <br> If you want to query from URL the format would be something like this "?artist=Rihanna&condition=12" for artists. If you want to find some information on a song you would type out your url like "?song=Stay the Night&condition=1<br> 
    	Artist conditions: 11=Musical Genre, 12=Place Musical Career Began, 13=Albums, 14=Record Labels, 15=Recordings, 16=Concerts<br>
   		 Song conditions: 1=Artist, 2=Featured Artists, 3=Length, 4=Recording of Composition, 5=Contributions, 6=Date Recorded, 7=Place Recorded, 8=Producer, 9=Engineer, 10=Genre   
		<br><center> &copy; The Music Team - created for EECS118  - 2014</center> 
	</div>
</body>


</html>