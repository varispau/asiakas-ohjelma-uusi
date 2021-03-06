<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/main.css">
<script src="scripts/main.js"></script>
<title>Asiakkaat</title>
</head>
<body onkeydown="tutkiKey(event)">
<table id="listaus">
	<thead>
	<tr>
		<tr>
			<th colspan="4" class="oikealle" id="ilmo"></th>
			<th colspan="2" class="oikealle"><a id="uusiAsiakas" href="lisaaasiakas.jsp">Lis?? uusi asiakas</a></th>
		</tr>
		<tr>
			<th class="oikealle" colspan="3">Hakusana:</th>
			<th class="vasemmalletumma" colspan="2"><input type="text" id="hakusana"></th>
			<th class="vasemmalletumma"><input type="button" value="Hae" id="hakunappi" onclick="haeTiedot()"></th>
		</tr>			
		<tr>
			<th class="vasemmalle">Asiakas id</th>
			<th class="vasemmalle">Etunimi</th>
			<th class="vasemmalle">Sukunimi</th>
			<th class="vasemmalle">Puhelinnumero</th>
			<th class="vasemmalle">S?hk?postiosoite</th>
			<th class="vasemmalle"></th>						
		</tr>
	</thead>
	<tbody id="tbody">
	</tbody>
</table>
<script>
haeTiedot();	
document.getElementById("hakusana").focus();//vied??n kursori hakusana-kentt??n sivun latauksen yhteydess?

function tutkiKey(event){
	if(event.keyCode==13){//Enter
		haeTiedot();
	}		
}
//Funktio tietojen hakemista varten
//GET 
function haeTiedot(){	
	document.getElementById("tbody").innerHTML = "";
	fetch("asiakkaat/" + document.getElementById("hakusana").value,{//L?hetet??n kutsu backendiin
	      method: 'GET'
	    })
	.then(function (response) {//Odotetaan vastausta ja muutetaan JSON-vastaus objektiksi
		return response.json()	
	})
	.then(function (responseJson) {//Otetaan vastaan objekti responseJson-parametriss?		
		var asiakkaat = responseJson.asiakkaat;	
		var htmlStr="";
		for(var i=0;i<asiakkaat.length;i++){			
        	htmlStr+="<tr>";
        	htmlStr+="<td>"+asiakkaat[i].asiakasid+"</td>";
        	htmlStr+="<td>"+asiakkaat[i].etunimi+"</td>";
        	htmlStr+="<td>"+asiakkaat[i].sukunimi+"</td>";
        	htmlStr+="<td>"+asiakkaat[i].puhelin+"</td>"; 
        	htmlStr+="<td>"+asiakkaat[i].sposti+"</td>"; 
        	htmlStr+="<td><a href='muutaasiakas.jsp?asiakasid="+asiakkaat[i].asiakasid+"'>Muuta</a>&nbsp;";
        	htmlStr+="<span class='poista' onclick=poista('"+asiakkaat[i].asiakasid+"')>Poista</span></td>";
        	htmlStr+="</tr>";        	
		}
		document.getElementById("tbody").innerHTML = htmlStr;	
	})	
}

//Funktio tietojen poistamista varten. Kutsutaan backin DELETE-metodia ja v?litet??n poistettavan tiedon id. 
//DELETE
function poista(asiakasid){
	if(confirm("Poista asiakas " + asiakasid +"?")){	
		fetch("asiakkaat/"+ asiakasid,{//L?hetet??n kutsu backendiin
		      method: 'DELETE'		      	      
		    })
		.then(function (response) {//Odotetaan vastausta ja muutetaan JSON-vastaus objektiksi
			return response.json()
		})
		.then(function (responseJson) {//Otetaan vastaan objekti responseJson-parametriss?		
			var vastaus = responseJson.response;		
			if(vastaus==0){
				document.getElementById("ilmo").innerHTML= "Asiakkaan poisto ep?onnistui.";
	        }else if(vastaus==1){	        	
	        	document.getElementById("ilmo").innerHTML="Asiakkaan " + asiakasid +" poisto onnistui.";
				haeTiedot();        	
			}	
			setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
		})		
	}	
}
</script>
</body>
</html>